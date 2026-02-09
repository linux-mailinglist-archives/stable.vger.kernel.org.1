Return-Path: <stable+bounces-215286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMHQOC72iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:58:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADF1114FA
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 359E9304DC90
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FE37BE65;
	Mon,  9 Feb 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wSdEMEGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452C22301;
	Mon,  9 Feb 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648298; cv=none; b=ZPW0/nixB/ZN7d5ZSyDJXsbNjxiP0jvrjlY6YdDLfeK9IC+YLQ/yCssy64SwIKrsM9ePKrFVhxIay4YiKnMfe9sJDBaqMgmLsNTynrY7CkpXcPf7a+jcUgb5iUPDwncRGNakH9wl82XZGZEm7T+Wehdp3JzXpcNze0jpfMRYOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648298; c=relaxed/simple;
	bh=BIG8sZnZYpQBN8KLtk8TYUsJysYVJIcz7XdWRyIFVHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+GXHv2yTlC/2/fAGLVSPzt2nD1NeRUL4QAb8+N7jGZYbofRsZvYQYIywYj6NUekmHUeEs58nuJUzsfb7l/az3WRJ274s//l5qWBhG/i5vTCUkb4OZNH0lT1rOHuU7CEG7PrMVEiSksEgMQaoyLc9bzrnnqCjQ99B49XAJC4tzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wSdEMEGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FC9C19422;
	Mon,  9 Feb 2026 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648298;
	bh=BIG8sZnZYpQBN8KLtk8TYUsJysYVJIcz7XdWRyIFVHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wSdEMEGhbaGDBZcCdfrGpGGl68Q7k02ds8Gexh9K9Bck0jXxgpvqMPg5bh87fcf12
	 7n8B2Qrxo0VxVuesfAA00GnLY1aUqmy2NElDcrDg0fuf+ncZ6bkC1brEStBXs3JTdY
	 9N8H6OStSsdhdQCQkJUwIaNnq13uOsSO2BJjyL0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 38/69] nvme-fc: release admin tagset if init fails
Date: Mon,  9 Feb 2026 15:24:06 +0100
Message-ID: <20260209142303.296273241@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215286-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 5AADF1114FA
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

[ Upstream commit d1877cc7270302081a315a81a0ee8331f19f95c8 ]

nvme_fabrics creates an NVMe/FC controller in following path:

    nvmf_dev_write()
      -> nvmf_create_ctrl()
        -> nvme_fc_create_ctrl()
          -> nvme_fc_init_ctrl()

nvme_fc_init_ctrl() allocates the admin blk-mq resources right after
nvme_add_ctrl() succeeds.  If any of the subsequent steps fail (changing
the controller state, scheduling connect work, etc.), we jump to the
fail_ctrl path, which tears down the controller references but never
frees the admin queue/tag set.  The leaked blk-mq allocations match the
kmemleak report seen during blktests nvme/fc.

Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
nvme_remove_admin_tag_set() when it is set so that all admin queue
allocations are reclaimed whenever controller setup aborts.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index dc84cade703db..63bef22095b41 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3563,6 +3563,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = NULL;
 
+	if (ctrl->ctrl.admin_tagset)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
-- 
2.51.0




