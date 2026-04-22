Return-Path: <stable+bounces-240367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLbkHN/+6Gl5SgIAu9opvQ
	(envelope-from <stable+bounces-240367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A02449197
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8823D30418E8
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF24C38B7D6;
	Wed, 22 Apr 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="zT6/E1P4"
X-Original-To: stable@vger.kernel.org
Received: from smtp64.iad3b.emailsrvr.com (smtp64.iad3b.emailsrvr.com [146.20.161.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C7F38A72A
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776877020; cv=none; b=X28OEjWX0PwE8kpkPLS2r7cmEDk76IIcWIgn6K8Lu4tYSJE4bHHdNm6A/K620PQnW7R3V4PuzRGu9kS5GlyGuK6J35uRiBMIyX7hm+Ow9+f04sm8fO2DfMNWBYNWrDkisr/xGM9ncb8+zWJ0NPxpfjPYdWLsmH1clahBvxJl2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776877020; c=relaxed/simple;
	bh=S59iJjrqhOSuUnxWTcUSlTMa7Ptk+uqsO9OXA3gu1Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mq2S9plSSahGvGf9Ub1B4xVbRobGuygJgwo0B25QQT5wiNqT28lTxq78lR7QSYwYCnV6v8IeBfoly5K58lUoDrjxW4heCVprQt1Ty5XTfEdFronFo3x112rWZ6IxVhZEKinKXj9vj6xNAlfZcitST3Uuo/3B3jNyFr8xbuOVbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=zT6/E1P4; arc=none smtp.client-ip=146.20.161.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1776874908;
	bh=S59iJjrqhOSuUnxWTcUSlTMa7Ptk+uqsO9OXA3gu1Sk=;
	h=From:To:Subject:Date:From;
	b=zT6/E1P4pyyMV9id1fKEd7GE82xEckMP5doAmJutB2VH66T1fnp6Dag1aZObPP+Rf
	 /2unj7sXDYzY8lgA4Sgf1D9zl7kNITkMoVHn7YOx6aLsJPbfS/n5PkbHqT9ym9q8wI
	 sat7V7Y+ALYgNEMbENy/QXFopk5dex7hYRl6B8UI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 74FD0A03D1;
	Wed, 22 Apr 2026 12:21:47 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
Date: Wed, 22 Apr 2026 17:21:19 +0100
Message-ID: <20260422162138.36003-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422152600.32992-1-abbotti@mev.co.uk>
References: <20260422152600.32992-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 4edc342a-7b8a-4e3d-bbc9-bc4d11aab71e-1-1
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240367-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mev.co.uk:email,mev.co.uk:dkim,mev.co.uk:mid]
X-Rspamd-Queue-Id: 96A02449197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 783ddaebd397 ("staging: comedi: comedi_test: support
scan_begin_src == TRIG_FOLLOW") neglected to add a test that
`scan_begin_src` has only one bit set.  The allowed values are
`TRIG_FOLLOW` and `TRIG_TIMER`, but the code incorrectly also allows
`TRIG_FOLLOW | TRIG_TIMER`.  Add a call to
`comedi_check_trigger_is_unique()` to check that only one trigger source
bit is set.

Fixes: 783ddaebd397 ("staging: comedi: comedi_test: support scan_begin_src == TRIG_FOLLOW")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct Cc address staging@ -> stable@
---
 drivers/comedi/drivers/comedi_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 01aafce20ef8..f586441d5981 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -274,6 +274,7 @@ static int waveform_ai_cmdtest(struct comedi_device *dev,
 	/* Step 2a : make sure trigger sources are unique */
 
 	err |= comedi_check_trigger_is_unique(cmd->convert_src);
+	err |= comedi_check_trigger_is_unique(cmd->scan_begin_src);
 	err |= comedi_check_trigger_is_unique(cmd->stop_src);
 
 	/* Step 2b : and mutually compatible */
-- 
2.53.0


