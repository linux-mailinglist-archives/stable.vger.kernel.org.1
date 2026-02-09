Return-Path: <stable+bounces-215335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAfeOML2iWmuFAAAu9opvQ
	(envelope-from <stable+bounces-215335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:01:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8986311165A
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFCB3031307
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973737C10E;
	Mon,  9 Feb 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCl64vbo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D94437BE8C;
	Mon,  9 Feb 2026 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648461; cv=none; b=TeOQumfOsK+wWyK3b+JbWVLa+54afsMKgIe0OuLf/s44gUewy0puMTeTJPsWa74UF3iTMUqC/zRLFE+wpnY2+lDkLtcJ04liCK/TjP/4I2hJPrZzJorIY3jrVaJXtY6S9J7lryy8X0UKGMYgf2BaMcAYAjPwhqOUnjP+URtrcS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648461; c=relaxed/simple;
	bh=ZpxH6I8P6PKxWWxnwOgP+5YdtUroaG702pHdldTUTkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWjjRL6SYJmqs47phEZ0tlgv4SA0fekRm6g7tzO8TBnQ+p77NvfvhM/KJ0ynHIbGm9KzP90U/JRRNlpYjHeBijQfD7OiNtgG1H1MPG1w08inKb5jigYyKR3T+X92F7AOIKBDHtKRimsJ5uY7Vcjv1JQlKgX+ZswYa5Gq3DfHVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCl64vbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D33C19423;
	Mon,  9 Feb 2026 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648461;
	bh=ZpxH6I8P6PKxWWxnwOgP+5YdtUroaG702pHdldTUTkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCl64vbo/KILbp9xVFT8XFqjjsKoJCRVQ7jHNgZrVT20OEUMXiVYlfvoya/Al74do
	 w0JTfP4YlTtV7YsRggp7Db5i4EdmX/eLiL5Biz25Qd4dSoEBL04Fxou+qoAr3Wan8Q
	 xOHqg5X201vwH+qjhJ6CDdiHQH4Qeu3j3CZdhZ3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 44/86] nvme-fc: release admin tagset if init fails
Date: Mon,  9 Feb 2026 15:24:07 +0100
Message-ID: <20260209142306.369524660@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215335-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[justin.tee.broadcom.com:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 8986311165A
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 4fdb62ae996bf..44de1bcd0c657 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3550,6 +3550,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = NULL;
 
+	if (ctrl->ctrl.admin_tagset)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	/* initiate nvme ctrl ref counting teardown */
 	nvme_uninit_ctrl(&ctrl->ctrl);
 
-- 
2.51.0




