Return-Path: <stable+bounces-213668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LPmNkRhg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4881CE808E
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6016431AAB44
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE024218AC;
	Wed,  4 Feb 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2BdiQFhz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441A4218A8;
	Wed,  4 Feb 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217106; cv=none; b=CTODxfJ5ib8o4fwaVWXaEUzJFqmZldxWlHknUQh2byKyNpYoIgvDx2wruBHIPZb58BnBy4WK+qEHw3aumTRlY8RrQ82dr50+vgqda6LTpe1wYzlczP5Po93NupwveVnYjIbxrNL/sdtfxrIIr1RrP3+mAXZpjnR11AcRxGcZtCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217106; c=relaxed/simple;
	bh=2H2Mj66sMuxRRVby+p1QBSmrbM/Z9LNNvUYPN9sgoqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EL6Y1ERJ6n9+zFr8+leC7onzh0KD6hm7LTa4AbNsqCLlaSrRx+AuGQXbqTiDLoiB32W7rXdHk3zZfVU3JojfP1UFI38f46kc1emiummVsQztVwoVY8vrt+1BZ1rWZf2d3QyTjFx4JGCeUqXpS1IxREKdkUNWQwqnUe/Z6Vv6X7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2BdiQFhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28714C4CEF7;
	Wed,  4 Feb 2026 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217106;
	bh=2H2Mj66sMuxRRVby+p1QBSmrbM/Z9LNNvUYPN9sgoqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2BdiQFhz6+LoAYuOuqJWm3+5jagFhOfHWsY/vpMBG5lSpeBDW74NNqcnbZ4+Mh+kE
	 XBVgfuRrF8E5G4Kh0zWTPhGWAnShV0YJrE5x/0ailhC5EB3sW/7Psrfm2v/LFo7FQA
	 wQ+hZfYW1a7GSuVygSicFmOVuYh+L1UO8m5f0jg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenghai Huang <huangchenghai2@huawei.com>,
	Yang Shen <shenyang39@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 5.15 124/206] uacce: ensure safe queue release with state management
Date: Wed,  4 Feb 2026 15:39:15 +0100
Message-ID: <20260204143902.668464211@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-213668-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: 4881CE808E
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenghai Huang <huangchenghai2@huawei.com>

commit 26c08dabe5475d99a13f353d8dd70e518de45663 upstream.

Directly calling `put_queue` carries risks since it cannot
guarantee that resources of `uacce_queue` have been fully released
beforehand. So adding a `stop_queue` operation for the
UACCE_CMD_PUT_Q command and leaving the `put_queue` operation to
the final resource release ensures safety.

Queue states are defined as follows:
- UACCE_Q_ZOMBIE: Initial state
- UACCE_Q_INIT: After opening `uacce`
- UACCE_Q_STARTED: After `start` is issued via `ioctl`

When executing `poweroff -f` in virt while accelerator are still
working, `uacce_fops_release` and `uacce_remove` may execute
concurrently. This can cause `uacce_put_queue` within
`uacce_fops_release` to access a NULL `ops` pointer. Therefore, add
state checks to prevent accessing freed pointers.

Fixes: 015d239ac014 ("uacce: add uacce driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
Signed-off-by: Yang Shen <shenyang39@huawei.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Link: https://patch.msgid.link/20251202061256.4158641-5-huangchenghai2@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/uacce/uacce.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -37,20 +37,34 @@ static int uacce_start_queue(struct uacc
 	return 0;
 }
 
-static int uacce_put_queue(struct uacce_queue *q)
+static int uacce_stop_queue(struct uacce_queue *q)
 {
 	struct uacce_device *uacce = q->uacce;
 
-	if ((q->state == UACCE_Q_STARTED) && uacce->ops->stop_queue)
+	if (q->state != UACCE_Q_STARTED)
+		return 0;
+
+	if (uacce->ops->stop_queue)
 		uacce->ops->stop_queue(q);
 
-	if ((q->state == UACCE_Q_INIT || q->state == UACCE_Q_STARTED) &&
-	     uacce->ops->put_queue)
+	q->state = UACCE_Q_INIT;
+
+	return 0;
+}
+
+static void uacce_put_queue(struct uacce_queue *q)
+{
+	struct uacce_device *uacce = q->uacce;
+
+	uacce_stop_queue(q);
+
+	if (q->state != UACCE_Q_INIT)
+		return;
+
+	if (uacce->ops->put_queue)
 		uacce->ops->put_queue(q);
 
 	q->state = UACCE_Q_ZOMBIE;
-
-	return 0;
 }
 
 static long uacce_fops_unl_ioctl(struct file *filep,
@@ -77,7 +91,7 @@ static long uacce_fops_unl_ioctl(struct
 		ret = uacce_start_queue(q);
 		break;
 	case UACCE_CMD_PUT_Q:
-		ret = uacce_put_queue(q);
+		ret = uacce_stop_queue(q);
 		break;
 	default:
 		if (uacce->ops->ioctl)



