Return-Path: <stable+bounces-232512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDX7JPkGzGn+NQYAu9opvQ
	(envelope-from <stable+bounces-232512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:40:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA236F19C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54AB031F7609
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC330F819;
	Tue, 31 Mar 2026 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgwSW1+Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935430B51A;
	Tue, 31 Mar 2026 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976939; cv=none; b=IBU2sn9PrBOHq7LnvBLR+xDcFGyZ8Okw7xmhr1B69HWyCyWMTKkjyT5mr+zan5QzBI9e4FXuorJ+K2CFS60A0dL1THPThllBNpyDE2F6zfIYRB6CxVjY/tIl0Meuaj83nRQcb8pgGmUvwR5G9HhBgWwlKHCrYQNl2s4afetJwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976939; c=relaxed/simple;
	bh=zxsTsOmmmP8mukgx6nMmqtTfDxl2UAS+QcbtIM0WCHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJEP+jg0fhSlvB0d8VlXQ5M6EkfO/gtY8kWCbIgdbZkf5zkzYPJorifq8WhqK81pARwJP8b4iIOVEWdx+bJGjPr1N/DSqPL5qgIqKYMDXccDKLrUOqTu5/QWrMm37GnuGpZHoMX6wt1OCgReDsAeU58jjk/KWgoRMhRgAdkuOo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgwSW1+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2734C19423;
	Tue, 31 Mar 2026 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976939;
	bh=zxsTsOmmmP8mukgx6nMmqtTfDxl2UAS+QcbtIM0WCHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgwSW1+Z25om1HZuTKpLfNT1LdmYlUcPkgld2aP9/+4YKAJBWECEbS5aHAfq2AZhj
	 HxVDS3fNBxbxB3nuDuquO2BMy3M3S666XZ9cWelagvqrk5no3YiMkU+7UgN7NlOz+7
	 a3RMvmWsWjGwwDG85umTodZ3zxScnuI8BEkOgycY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Jiang <dave.jiang@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 287/309] dmaengine: idxd: Fix freeing the allocated ida too late
Date: Tue, 31 Mar 2026 18:23:10 +0200
Message-ID: <20260331161804.132327455@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232512-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 15AA236F19C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vinicius Costa Gomes <vinicius.gomes@intel.com>

[ Upstream commit c311f5e9248471a950f0a524c2fd736414d98900 ]

It can happen that when the cdev .release() is called, the driver
already called ida_destroy(). Move ida_free() to the _del() path.

We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
unbind.

Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Link: https://patch.msgid.link/20260121-idxd-fix-flr-on-kernel-queues-v3-v3-9-7ed70658a9d1@intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f927732..4105688cf3f06 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -158,11 +158,7 @@ static const struct device_type idxd_cdev_file_type = {
 static void idxd_cdev_dev_release(struct device *dev)
 {
 	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
-	struct idxd_cdev_context *cdev_ctx;
-	struct idxd_wq *wq = idxd_cdev->wq;
 
-	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -582,11 +578,15 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
+	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
+
+	cdev_ctx = &ictx[wq->idxd->data->type];
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	put_device(cdev_dev(idxd_cdev));
 }
 
-- 
2.53.0




