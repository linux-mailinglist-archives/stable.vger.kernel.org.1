Return-Path: <stable+bounces-247700-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mENUEY4QB2qbrAIAu9opvQ
	(envelope-from <stable+bounces-247700-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:24:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902AE54F79B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63016315CFC1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383247F2EB;
	Fri, 15 May 2026 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DL/QVNhd"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E751947DF8B
	for <Stable@vger.kernel.org>; Fri, 15 May 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845616; cv=none; b=O9YFJmMYFvRMuMoFD5viRIrmzTswBgrVYX4F4cFI4h5ffEs3kQ60yhHDYRdAILFHrgFG/I3C2sTJ+WCKY/CtouPFdnU5DgYsKTGg0bzDiv9vyupDmWVPtujzG7Cpbin6tGvEJ9gDOfQcd76O6nhfUuSXplSE6cfh4qath3baQb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845616; c=relaxed/simple;
	bh=9pY6T8rUcbbNJUOwYeoOshwL/TN0Wf5EE3EhXIX1LnE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=UU5ClW81w7a/3HYFsV+KDf4XwNh7bnRfaYa7NJI2Tl1mXvoxEGxOsHr6QGtlmxVQEdUY7CGQPQZ835vjLo581TwnHzbtCY91N9ny3mx2Wcl9/hYKONq57WQHET3yfi1fxbazitKrePzTZu/BeI/cg6yCh1bRmjg1T+xRzfeP7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DL/QVNhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6686BC2BCB7;
	Fri, 15 May 2026 11:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845615;
	bh=9pY6T8rUcbbNJUOwYeoOshwL/TN0Wf5EE3EhXIX1LnE=;
	h=Subject:To:From:Date:From;
	b=DL/QVNhdAcY4LTKSDM66HDxwS3Q+jz6jsi1UW35TLQcPcDnNbDzhYI0i2wlKO+81n
	 xuOLcSmenmrJPMBW32PoAVqXIec8rTSOJwW0zotQoWrfvxzsAGb+tXUev8xNzWm3vJ
	 jxbXyCsybAChYZTGbxDyV1Mb/pPCg1X6wdG1yqcg=
Subject: patch "iio: temperature: tsys01: fix broken PROM checksum validation" added to char-misc-linus
To: salah.triki@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 13:46:01 +0200
Message-ID: <2026051501-upriver-geriatric-5575@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 902AE54F79B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247700-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


This is a note to let you know that I've just added the patch titled

    iio: temperature: tsys01: fix broken PROM checksum validation

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 4701e471c16866e7aa8f5e6a3a6b0d31e097e2c9 Mon Sep 17 00:00:00 2001
From: Salah Triki <salah.triki@gmail.com>
Date: Tue, 5 May 2026 08:10:24 +0100
Subject: iio: temperature: tsys01: fix broken PROM checksum validation

The current implementation of tsys01_crc_valid() incorrectly sums the
first word (n_prom[0]) repeatedly instead of iterating over the 8 words
retrieved from the PROM. This leads to a checksum mismatch and probe
failure on hardware.

According to the TSYS01 datasheet, the PROM consists of 8 words. A valid
check must iterate through all 8 words to verify the integrity of the
calibration data. The current driver only checks the first word 8 times.

Note: This fix was identified during a code audit and is based on
datasheet specifications. It has not been tested on real hardware.

Fixes: 43e53407f680 ("Add tsys01 meas-spec driver support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/temperature/tsys01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 334bba6fdae6..104dd45598b0 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom)
 	u8 sum = 0;
 
 	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
-		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
+		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
 
 	return (sum == 0);
 }
-- 
2.54.0



