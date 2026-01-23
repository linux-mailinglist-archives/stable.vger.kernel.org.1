Return-Path: <stable+bounces-211390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD3oIKOCc2kDxAAAu9opvQ
	(envelope-from <stable+bounces-211390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:16:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC576D79
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A63C3301E9AC
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABEF2E8B75;
	Fri, 23 Jan 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lR4UJeYQ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAFE29617D
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177756; cv=none; b=mU1A/pDQLOcwVeN8d8QD4kv8t4GgfZfTon8bguTU3diyC3pfMTjc2VA2mQRziRBbeoNJZDZ2wr48yNMI7sahv6ytuZRFUslx6voEhf2vY5a9oHYqr2TgU5xb0bxgBmPzPjAhBoH8u6Wd4d1IUDFzTuPJV+JfpF13UNuwSIyDHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177756; c=relaxed/simple;
	bh=7+fq7CJT6C0vfmlZ3+r73bmb7F1S+EPaMbBDQlsEI1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Am8C6roPzU/J++ZiQWbLIkCKeh2qMYEP7I6umfSrFrnlGzILAYBjKyp+s+/eyWjs8QkcgXBard/jn0QpejFDHYomDAXiIGuuPtxy45/uzKa/b5y2eRacsRzdHvsCUuzBjEjISF5tpQlC5abJNHCogCbfdJ8XuEM0T8YzzhNvo1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lR4UJeYQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fb49Dt8p/6xXhPsZoM6WvTUAvHPfrma6obVZtWY6YE0=; b=lR4UJeYQxhEkw6KqO2l3U1KcAu
	t6EFjhpEjtwpVmXtl51LzDIRlVGzP6V2WScmabgu6OGTK8FIMP4479eqVW+iyKRoH4BX0hP0wgRQT
	ZpLchY7jfCy0PSDI84FlSTqYVsQkNfOQ/tSt+2kwAwsseh96EakUk1TLbe5bScj9HCLlzzKxJ27vV
	3aM8HSKYz7mqBY+VE4hMSb2ZPqE+3ZsdBKgXneHxET6OK1STT21gXrJtxtXxRSDUqXz7J0MmQxhR4
	bByQgK6TfmvhkxkladRAZMoPOv5nxvjX2JSKq7gCOi/87eofolw+AqtoYhWztL4g3Mi0T4VHLNH6Q
	tQiLHi7g==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjHws-008vKz-Ge; Fri, 23 Jan 2026 15:15:42 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Zhi Wang <wangzhi@stu.xidian.edu.cn>,
	David Francis <David.Francis@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm: Do not allow userspace to trigger kernel warnings in drm_gem_change_handle_ioctl()
Date: Fri, 23 Jan 2026 14:15:40 +0000
Message-ID: <20260123141540.76540-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <9bde8c39-ba4c-49c5-a0bc-4e78338f055a@amd.com>
References: <9bde8c39-ba4c-49c5-a0bc-4e78338f055a@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211390-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xidian.edu.cn:email]
X-Rspamd-Queue-Id: 51DC576D79
X-Rspamd-Action: no action

Since GEM bo handles are u32 in the uapi and the internal implementation
uses idr_alloc() which uses int ranges, passing a new handle larger than
INT_MAX trivially triggers a kernel warning:

idr_alloc():
...
	if (WARN_ON_ONCE(start < 0))
		return -EINVAL;
...

Fix it by rejecting new handles above INT_MAX and at the same time make
the end limit calculation more obvious by moving into int domain.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reported-by: Zhi Wang <wangzhi@stu.xidian.edu.cn>
Fixes: 53096728b891 ("drm: Add DRM prime interface to reassign GEM handle")
Cc: David Francis <David.Francis@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org> # v6.18+
---
v2:
 * Rename local variable, re-position comment, drop the else block. (Christian)
 * Use local at more places.
---
 drivers/gpu/drm/drm_gem.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 7ff6b7bbeb73..ffa7852c8f6c 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1001,16 +1001,21 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_gem_change_handle *args = data;
 	struct drm_gem_object *obj;
-	int ret;
+	int handle, ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
 
+	/* idr_alloc() limitation. */
+	if (args->new_handle > INT_MAX)
+		return -EINVAL;
+	handle = args->new_handle;
+
 	obj = drm_gem_object_lookup(file_priv, args->handle);
 	if (!obj)
 		return -ENOENT;
 
-	if (args->handle == args->new_handle) {
+	if (args->handle == handle) {
 		ret = 0;
 		goto out;
 	}
@@ -1018,18 +1023,19 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	mutex_lock(&file_priv->prime.lock);
 
 	spin_lock(&file_priv->table_lock);
-	ret = idr_alloc(&file_priv->object_idr, obj,
-		args->new_handle, args->new_handle + 1, GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
+			GFP_NOWAIT);
 	spin_unlock(&file_priv->table_lock);
 
 	if (ret < 0)
 		goto out_unlock;
 
 	if (obj->dma_buf) {
-		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf, args->new_handle);
+		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
+					       handle);
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
-			idr_remove(&file_priv->object_idr, args->new_handle);
+			idr_remove(&file_priv->object_idr, handle);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}
-- 
2.52.0


