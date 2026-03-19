Return-Path: <stable+bounces-227287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPXKBKH3u2koqwIAu9opvQ
	(envelope-from <stable+bounces-227287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:18:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F22CBCED
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87F3730244C1
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC643BADA7;
	Thu, 19 Mar 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2V8e1mW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA93D3D0C
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926291; cv=none; b=S2Kasl6JW+znbESwc4eWYuv/9UPXY9YsSqI0T8ultDSN39nM9ll4LIrbs5YfSCsQL4wx5ayvjk10fSfmTNCBqASYLwsqL1EBlqbkPOnDS8Rz/cljrVoO0Jswz3RK5rVxG2mD/etCpuuDto44JwwBwvAlO31Ge6L+WZe1PB7Di+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926291; c=relaxed/simple;
	bh=6ZlIXUaunl9rDhR+qdxx84JHuBb9xOKVM3nb1igGQeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncg2Lb5wfnA/9tC2q15eRgObnU6RI+jOYlqYAXEgq0pPjGbUwwfsLXL4wCRH869jM/VGDw1XqL6sB2nn0LMRYlxdS43HH/giNVGbuY++bRKAbqUl0vrwY1raMfFsaf8i4+bvCdIwxtCRWNYn6hZVsQRHqPVMx2teJKuw0TT8dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2V8e1mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA142C19424;
	Thu, 19 Mar 2026 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773926291;
	bh=6ZlIXUaunl9rDhR+qdxx84JHuBb9xOKVM3nb1igGQeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2V8e1mWJSInqrrK1wBXXK6AafAw6ZPArSXsFMePqH+gd1VAJTrqSk4WsL+ZNFTAT
	 VHNy4rl1i7nvquFHk0B7UrOhsHutHa7J4/2qrFCXHrAZnW/PhlXyIqLy1XoFNKmyTb
	 2Tg5DKsU3ugR7rFZ+deen56vLA25eRkgoxCNVQ5MaqOWAUCCvQBcwY7n6cirvf5f8n
	 gFytrreTk/tIIT+1KLq91Qxq1lPK8EoA3lWEQhiJdR8XQG0Rw01oK2ijROyEnbqDSf
	 i4Iy+lM19LS4+MCVG1Dw9ObNwXsWNdf94DVjcndpqgqkAPHkiVj+xT6IrCGDwsewzP
	 7RfHmOHiMFT4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 1/2] firmware: stratix10-svc: Delete some stray tabs
Date: Thu, 19 Mar 2026 09:18:08 -0400
Message-ID: <20260319131809.2432986-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031759-humorless-railing-5f3d@gregkh>
References: <2026031759-humorless-railing-5f3d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227287-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 850F22CBCED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 9e51d1da5b245c9bf97fc49b06cca7e901c0fe94 ]

These lines are indented one tab too far.  Delete the extra tabs
for readability.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Stable-dep-of: 22fd7f7fed2a ("firmware: stratix10-svc: Add Multi SVC clients support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 515b948ff320e..dbed404a71fcf 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1317,7 +1317,7 @@ int stratix10_svc_async_send(struct stratix10_svc_chan *chan, void *msg,
 		dev_dbg(ctrl->dev,
 			"Async message sent with transaction_id 0x%02x\n",
 			handle->transaction_id);
-			*handler = handle;
+		*handler = handle;
 		return 0;
 	case INTEL_SIP_SMC_STATUS_BUSY:
 		dev_warn(ctrl->dev, "Mailbox is busy, try after some time\n");
@@ -1702,12 +1702,12 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			kthread_run_on_cpu(svc_normal_to_secure_thread,
 					   (void *)chan->ctrl,
 					   cpu, "svc_smc_hvc_thread");
-			if (IS_ERR(chan->ctrl->task)) {
-				dev_err(chan->ctrl->dev,
-					"failed to create svc_smc_hvc_thread\n");
-				kfree(p_data);
-				return -EINVAL;
-			}
+		if (IS_ERR(chan->ctrl->task)) {
+			dev_err(chan->ctrl->dev,
+				"failed to create svc_smc_hvc_thread\n");
+			kfree(p_data);
+			return -EINVAL;
+		}
 	}
 
 	pr_debug("%s: sent P-va=%p, P-com=%x, P-size=%u\n", __func__,
-- 
2.51.0


