Return-Path: <stable+bounces-228058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM4kJKZIwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:05:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 196102F3C8D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A76930C11F6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9F3AE6E6;
	Mon, 23 Mar 2026 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0poIxfEG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0413AC0C9;
	Mon, 23 Mar 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274001; cv=none; b=OhfGmU2zwv+nsfPoDqG5FSWNAasv0HuGfXYdMEAFFn9uRBXfvqB9K5zEWEAQfpccCW3/VsBIfwvgNJ2g6125qFM+7e8eqMR8nT6lTWL8skZlNNIXfmddJYX8JTb5q7tiSTX8P7XTtlId/9wxGkywCi74SmAkHHSqntznLWIuk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274001; c=relaxed/simple;
	bh=kCWwm7/OkZZfHu9AL1KN6P9A3qWER7Uj4/2FESNo0As=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbMvE6fAnInna8SDCS8q9Ni8Fke3x1+r2Zz+l8c5WkbKmXS6ZHNEUkjffQMvcUYIeycl16RfTM6i+vZMQJtxbterUj8+nZ2+u27/IsoOuEEhrIrF/Nrrds9ON6oyM5Ht/YwQa3npzveiRzQf0FujBz3kjW6UJKvLbaRB7wYjnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0poIxfEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD22C4AF09;
	Mon, 23 Mar 2026 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274001;
	bh=kCWwm7/OkZZfHu9AL1KN6P9A3qWER7Uj4/2FESNo0As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0poIxfEGkLenIz/Mmja5YL+S6NRpF9dXKuRr3SgAYCmBMvytWAcO17CyL332ae+9f
	 o8aee6l+7tcddOGwQBEpOaXS545peuVOmlUANW/00JZru4qbh/qYWbOecGonP5+sj7
	 Z2hSsnFqniDsWCeCn/RYlbk5/DGxKxGfSS21DJaU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 033/220] firmware: stratix10-svc: Delete some stray tabs
Date: Mon, 23 Mar 2026 14:43:30 +0100
Message-ID: <20260323134505.628102692@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228058-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 196102F3C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 9e51d1da5b245c9bf97fc49b06cca7e901c0fe94 ]

These lines are indented one tab too far.  Delete the extra tabs
for readability.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Stable-dep-of: 22fd7f7fed2a ("firmware: stratix10-svc: Add Multi SVC clients support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/stratix10-svc.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1317,7 +1317,7 @@ int stratix10_svc_async_send(struct stra
 		dev_dbg(ctrl->dev,
 			"Async message sent with transaction_id 0x%02x\n",
 			handle->transaction_id);
-			*handler = handle;
+		*handler = handle;
 		return 0;
 	case INTEL_SIP_SMC_STATUS_BUSY:
 		dev_warn(ctrl->dev, "Mailbox is busy, try after some time\n");
@@ -1702,12 +1702,12 @@ int stratix10_svc_send(struct stratix10_
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



