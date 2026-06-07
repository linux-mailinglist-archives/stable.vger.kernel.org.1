Return-Path: <stable+bounces-260977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R72BDZNDJWpdFQIAu9opvQ
	(envelope-from <stable+bounces-260977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:10:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A956F64F5F3
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:10:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qrImDkLl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260977-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260977-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBEC43039C95
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7B2F49FD;
	Sun,  7 Jun 2026 10:07:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDB234994;
	Sun,  7 Jun 2026 10:07:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826844; cv=none; b=SNgnfS0GqUoNAV3IMMS5FDYYwHGGnNblxwR9IXVQjAIiHTgkdOeWjD0b5At5geP7hyZlCC+o2nNxN8U7f1aKa8EiXiUubcEajd0SzPbvwfFdEtrtWX6Q5txOw1MPyNK9e9LTTP2VPDPhrHAyeC2utnVJYKTntuOzBRrW7KwpvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826844; c=relaxed/simple;
	bh=8Tl6UTu9SDVCnFNdfFH8C+TbN5I0DAd/2DAcrZxcTTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQrowuRHzUDHBoxpvJYqeU7eg8Tzw0hKmKh1vHXNJQMZlG7YZfdU/BjvuPJ19xXn0RxYuZKn1c0kQsRfMMQP9r5U5sxllWnHptaZjFOcwve+nZh50/zGbUB8ezfUv1oV14oLOuodWDFSA8q9OQlhyEE2qI1eEdlRxqtaAQO9G/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrImDkLl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B051F00893;
	Sun,  7 Jun 2026 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826843;
	bh=PVQ3qiq2Y19uSkZY/eLmqobk/8dl5DsuEmddqn+qawI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qrImDkLl42Zc7yTDMjczk/ULeBxPe65MrXIVT0OTA4UniEHOKuMZ2A3kYQH0i0EC0
	 aeeYaDTv+7uCX3mjILWn7FVD1yGxLhfi6bCwHSd0b/hKM4nywykRP/KIvKjC1xdCFh
	 /31VLihblKEfzuRkfpkfUiSpigiKN3Uk2g3UEyI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dhabaleshwar Das <dhabal123@gmail.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 014/315] accel/rocket: fix UAF via dangling GEM handle in create_bo
Date: Sun,  7 Jun 2026 11:56:41 +0200
Message-ID: <20260607095728.019743749@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260977-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dhabal123@gmail.com,m:tomeu@tomeuvizoso.net,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,tomeuvizoso.net,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tomeuvizoso.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A956F64F5F3

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dhabaleshwar Das <dhabal123@gmail.com>

[ Upstream commit f706e6a4ce75585af979aec3dcbdce68bc76306b ]

rocket_ioctl_create_bo() inserts a GEM handle into the file's IDR via
drm_gem_handle_create() early on, then performs several operations that
can fail (sgt allocation, drm_mm insert, iommu_map). If any fail after
the handle is live, the error path calls drm_gem_shmem_object_free()
which kfree's the object without removing the handle from the IDR.

This leaves a dangling handle pointing to freed slab memory. Any
subsequent ioctl using that handle (PREP_BO, FINI_BO, SUBMIT) calls
drm_gem_object_lookup() and dereferences freed memory (UAF).

Fix by moving drm_gem_handle_create() to after all fallible operations
succeed, matching the pattern used by panfrost, lima, and etnaviv.

Also fix drm_mm_insert_node_generic() whose return value was silently
overwritten by iommu_map_sgtable() on the next line. Add the missing
error check.

[tomeu: Move handle creation to the very end]

Fixes: 658ebeac3351 ("accel/rocket: Add IOCTL for BO creation")
Reported-by: Dhabaleshwar Das <dhabal123@gmail.com>
Signed-off-by: Dhabaleshwar Das <dhabal123@gmail.com>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Link: https://patch.msgid.link/20260521165720.2113571-1-tomeu@tomeuvizoso.net
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/rocket/rocket_gem.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index c3c86e1abd25a3..b1b24d60973e82 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -78,11 +78,6 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	rkt_obj->size = args->size;
 	rkt_obj->offset = 0;
 
-	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
-	drm_gem_object_put(gem_obj);
-	if (ret)
-		goto err;
-
 	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
 	if (IS_ERR(sgt)) {
 		ret = PTR_ERR(sgt);
@@ -94,6 +89,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 					 rkt_obj->size, PAGE_SIZE,
 					 0, 0);
 	mutex_unlock(&rocket_priv->mm_lock);
+	if (ret)
+		goto err;
 
 	ret = iommu_map_sgtable(rocket_priv->domain->domain,
 				rkt_obj->mm.start,
@@ -111,8 +108,18 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
 	args->dma_address = rkt_obj->mm.start;
 
+	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
+	if (ret)
+		goto err_unmap;
+
+	drm_gem_object_put(gem_obj);
+
 	return 0;
 
+err_unmap:
+	iommu_unmap(rocket_priv->domain->domain,
+		    rkt_obj->mm.start, rkt_obj->size);
+
 err_remove_node:
 	mutex_lock(&rocket_priv->mm_lock);
 	drm_mm_remove_node(&rkt_obj->mm);
-- 
2.53.0




