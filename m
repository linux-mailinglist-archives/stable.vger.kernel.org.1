Return-Path: <stable+bounces-240340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLfzCGnj6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:04:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35E447A9A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 831353017C01
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83F31D371;
	Wed, 22 Apr 2026 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Gf8bjzbi"
X-Original-To: stable@vger.kernel.org
Received: from smtp101.iad3b.emailsrvr.com (smtp101.iad3b.emailsrvr.com [146.20.161.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FD32F764
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869825; cv=none; b=u4piRjroUJAWld0dRhv+P29mvin4BGAHiI1jNIm7Lc00dLima4KfUkKQ4w3OFvhCwQcuCxZnrqKHpjFYKsKEQEtVw9UhZgTUuMJb1HfKPg1O240ETyjTuZNn1264TGfL9dFCMu2sgFee9xscMTg/Z6dqOW0BkqRMi57CLVZjEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869825; c=relaxed/simple;
	bh=eM+OD/0dXpwLtdFc4F/5gHg4dl4fs2RycT9BAJWJCoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dumTWn/E4+SSX1ZwrFbxV/YbeIonaL6s5Z6McRpdvezLHOf/nfV+jEUeD+71h/ccmqY9Bipu/AZ1IIDQ7gZz8pQMeYqRT65DSmFJvAVVFTkZWEKwZsOPHZm01q5Gb4nYyZ7gfGVKJiYc2flYwEk0y3ly2aK3SH0ceIuSqLEKV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Gf8bjzbi; arc=none smtp.client-ip=146.20.161.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1776869220;
	bh=eM+OD/0dXpwLtdFc4F/5gHg4dl4fs2RycT9BAJWJCoQ=;
	h=From:To:Subject:Date:From;
	b=Gf8bjzbieCUr9jhZdqyhKFjKaeyutYDcUlZ5ecHwt2NtYJ+hJ/YYp88SlyEoft/QB
	 pjyRtf4D5baGV8z7hcy5MmspO4DU0KpQm3nARlOCjwFXsOBN1Pa/5xosjCrZvPwpVd
	 b7aj5pa/WcUIrpNoxBFFGvk0SQYRX7lO+Xd5TpsE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0A536601CD;
	Wed, 22 Apr 2026 10:46:59 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: comedi_test: Fix limiting of convert_arg in waveform_ai_cmdtest()
Date: Wed, 22 Apr 2026 15:46:37 +0100
Message-ID: <20260422144637.27692-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: be031df5-4b01-41b2-95f1-4b11c447344d-1-1
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240340-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:server fail];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E35E447A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The function checks and possibly modifies the description of an
asynchronous command to be run on the analog input subdevice of a comedi
device attached to the "comedi_test" driver, returning 0 if no
modifications were required, or a positive value that indicates which
step of the checking process it failed on.  Step 4 fixes up various
argument values for various trigger sources.

There are two bugs in the fixing up of the `convert_arg` value to keep
the `scan_begin_arg` value within the range of `unsigned int` when
`scan_begin_src` and `convert_src` both have the value `TRIG_TIMER`,
which indicates that the corresponding `_arg` values hold a time period
in nanoseconds.  The code also uses `scan_end_arg` which hold the number
of "conversions" within each "scan".  The goal is to end up with the
scan period being less than or equal to the convert period multiplied by
the number of conversions per scan.  It intends to do that by clamping
the `convert_arg` value to a maximum value of `UINT_MAX / scan_end_arg`
rounded down to a multiple of 1000 (`NSEC_PER_USEC`).

(The rounding from nanoseconds to microseconds is because the driver is
modelling a device that uses a 1 MHz clock for timing.  This is partly
because that is a more typical timing base for real hardware devices
driven by comedi, and partly because the driver used to use `struct
timeval` internally.)

The first bug is that the code checks if `scan_begin_arg == TRIG_TIMER`
when it should be checking if `scan_begin_src == TRIG_TIMER`.  The
bugged check will always fail because if `scan_begin_src == TRIG_TIMER`,
then `scan_begin_arg` will be at least 1000 (`NSEC_PER_USEC`), otherwise
`scan_begin_src == TRIG_FOLLOW` and `scan_begin_arg` will be 0.  (N.B
`TRIG_TIMER` is defined as `0x10`.)  The second bug is that is rounding
the maximum value down to a multiple of 1000000000 (`NSEC_PER_SEC`)
instead of 1000 (`NSEC_PER_USEC`), however this bug is not reached due
to the first bug.  This patch fixes both bugs.

Fixes: 783ddaebd397 ("staging: comedi: comedi_test: support scan_begin_src == TRIG_FOLLOW")
Fixes: 5afdcad2f818 ("staging: comedi: comedi_test: limit maximum convert_arg")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/comedi_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 01aafce20ef8..4050f66193e5 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -324,10 +324,10 @@ static int waveform_ai_cmdtest(struct comedi_device *dev,
 		arg = min(arg,
 			  rounddown(UINT_MAX, (unsigned int)NSEC_PER_USEC));
 		arg = NSEC_PER_USEC * DIV_ROUND_CLOSEST(arg, NSEC_PER_USEC);
-		if (cmd->scan_begin_arg == TRIG_TIMER) {
+		if (cmd->scan_begin_src == TRIG_TIMER) {
 			/* limit convert_arg to keep scan_begin_arg in range */
 			limit = UINT_MAX / cmd->scan_end_arg;
-			limit = rounddown(limit, (unsigned int)NSEC_PER_SEC);
+			limit = rounddown(limit, (unsigned int)NSEC_PER_USEC);
 			arg = min(arg, limit);
 		}
 		err |= comedi_check_trigger_arg_is(&cmd->convert_arg, arg);
-- 
2.53.0


