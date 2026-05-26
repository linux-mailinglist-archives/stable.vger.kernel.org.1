Return-Path: <stable+bounces-254311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI8EOPCAFWoHWQcAu9opvQ
	(envelope-from <stable+bounces-254311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:16:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4095D4C12
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 256EC302A4C9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703D3DEAE0;
	Tue, 26 May 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIAZi73C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22993B4E9E;
	Tue, 26 May 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794150; cv=none; b=HVSj0FQ00UeIXR7/uGAg/5C8n07ET/rZtVJT6xGErewvuxKd3l9wkhNhmmXVgkT6Vjt4syMimXcQAU8sLSBxny6pTHKcafs4J9qeMMDEWRpfu9VLwcTCdTTHeah3EwTrg40iPPC3RtrDQMRROfQjm1jw4mWQNE8RxLzRvbWFwuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794150; c=relaxed/simple;
	bh=TOJ2MWIEQwnfhCFMAybS6R3OBbku0dwtWu85yE/Y6X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=civ8+NgPOJkMoAgmRWaYIhDuF/F+Im4H7nI/hTOedG6TEAoETrIxjR26iLKYwKUfOUQUadJbk98AoIVjAc8nIBpnLe/yXnoHsvDDv3BNEHWDsqv0VGh3J2wmL8DCBdzZX3+WhB9rIV7EhcRLHjIMzKJaR02wjV5uXYdRVFqy5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIAZi73C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AE82C2BCB3;
	Tue, 26 May 2026 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779794149;
	bh=TOJ2MWIEQwnfhCFMAybS6R3OBbku0dwtWu85yE/Y6X4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=YIAZi73CRSTyhXI87w9pKTwVZs6HnWGC3Ls3vYRY3bhqCQyf1kkolJ+7/GeU2aph6
	 kOYATrhbXi8gPwUNhVAfMyTi99RdWak7dBt55um+G2DEtbliqfewoGKsD5RLq/+5Fm
	 eatZDOxmrNYseQQSvH7X1jjBNVPHtxRG9tk5dDuDRErTKrds6tvMkjFRXr/yAp1CTy
	 uA6got0+ALFSMdJJ04Umt/KlgN3PSwFXxrt7Dn/SW9o/kuxv18yiCN9ByB6pZBakWO
	 Vrw9SqYjr+gzTzBthzC4UbTdiOk+14lchWlHc40skZj+g1I0BICO06lqud3Ka0KyZb
	 Xs0KzTCCPgvew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A13CD5BD0;
	Tue, 26 May 2026 11:15:49 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 26 May 2026 13:15:29 +0200
Subject: [PATCH] iio: light: opt3001: fix missing state reset on timeout
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-fix-early-return-v1-1-c70e886329f3@gmail.com>
X-B4-Tracking: v=1; b=H4sIANCAFWoC/x2MQQqAMAzAviI9W9gqDvEr4kG0akGmdCrK2N8dH
 gNJIgRW4QBtEUH5liC7z2DLAsZ18AujTJmBDDlTk8NZHuRBtxeVz0s9Ms12qpwj2xjI2aGcnX/
 Z9Sl9llFvmWIAAAA=
X-Change-ID: 20260526-fix-early-return-e2f1d3662180
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Jiri Valek - 2N <valek@2n.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779794147; l=1681;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=t1vAsfv7B7LZdWUZQljLoYaL7Vobksl8g4LhkH8Ck5M=;
 b=2yocHaz4/GslAVgqXwiLfzhUVXdUsmZd3OY3tNGHW2oaS7yNIUt1roT9g9QfPzimU3oczQ1yQ
 F93sH8jlbP/BAMTTjGjeAdxRFRJGGH/BPF8ahmdXgjbsmIDul1w/9hs
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254311-lists,stable=lfdr.de,joshua.crofts1.gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[joshua.crofts1@gmail.com]
X-Rspamd-Queue-Id: 5C4095D4C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Joshua Crofts <joshua.crofts1@gmail.com>

Currently in the function opt3001_get_processed(), there is a check
that directly returns -ETIMEDOUT if the conversion IRQ times out,
completely bypassing the err label, leaving ok_to_ignore_lock
permanently true, potentially breaking the device's falling threshold
interrupt detection.

Assign -ETIMEDOUT to the return variable and jump to the error label
to ensure ok_to_ignore_lock is properly reset.

Fixes: 26d90b559057 ("iio: light: opt3001: Fixed timeout error when 0 lux")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260525-opt3001-cleanup-v4-0-65b36a174f78%40gmail.com?part=1
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 03c7a87b4a8eef13bbdcf48dcaf969781aa76bd1..0743e16f2a8fa0f07acd19c7dd6b54bec9e5c7b2 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -366,8 +366,10 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		ret = wait_event_timeout(opt->result_ready_queue,
 				opt->result_ready,
 				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
-		if (ret == 0)
-			return -ETIMEDOUT;
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
+			goto err;
+		}
 	} else {
 		/* Sleep for result ready time */
 		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?

---
base-commit: 0e7dbde323808f28c5220295bfc1c5bc6f08c3f4
change-id: 20260526-fix-early-return-e2f1d3662180

Best regards,
-- 
Joshua Crofts <joshua.crofts1@gmail.com>



