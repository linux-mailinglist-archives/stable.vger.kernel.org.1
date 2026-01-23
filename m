Return-Path: <stable+bounces-211366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI3sGdVFc2mHuQAAu9opvQ
	(envelope-from <stable+bounces-211366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:56:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB7473BC0
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 10:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63AC7300B5B6
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CC137FF5B;
	Fri, 23 Jan 2026 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qf9jUyJ8"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8135D5EB
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162089; cv=none; b=hMCMERsuO8ytxp8X+GgZsHVBovl69UwptYqxDn/Tc5kW4wut3MqW9IQT6jyPJ30ppGXH5udLaUpfWJMZw3YlIb8sNQjiY9IYSTmTwGSzCWxwiHLsUmm5rn0vNSdt5It5ssvk+7zDKbOv4gawiRFG9jyunDBOiL6J88Vta9dXocc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162089; c=relaxed/simple;
	bh=OKT3nW2NcTLbT0bZ7gEfeFdbPPtkLeME5w1GMI5FqxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VB0yZO3LxDYv71fLsMzcHc9wfcXObOZGBYnU4DP3RHLEm5ahQLLpMqoDRDI3wMNzw5m8quQBHwMe6e00B0fvndij8wqL7ZrN21Rm6CnZntw8RcSfSv5Bhic/PROlKWUSa/s7Y89qqj99iFEUQVeIHPIBlgRPqRPaQVvAoQ+0thQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qf9jUyJ8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M6PaY/eMHA8WP5Bby+zqUFNuTpDO4V3PN7JXSs+wEoY=; b=qf9jUyJ89O9/LqrXoiahRcdpmq
	tpw47bizJ9gZU0flv0Y1qoTbicYhHtKviJ+SQmvQmRNRbXywkCktjqtDlWBrvum1o9mdn8XIq4WqU
	e2rSDL2UREUMWiW2snSO1FG/g20OjLoPihykYFXuFc0riGg30GG4zUzUBbW88PGBNGzFeJ12hdEJw
	Gyz5PBSC5US9qOPa0DOjXfbz5LEbUnGKeRv71z+HERwrGmGml8F5yk2mrLuotpsw9I6kEToDP7ZvC
	F7hPKTSkyUYUh7iMwzo5Jz8WyyHapYR2t15wD7a5PYsABCIIlWvAliWgGw846tBNo0kLIIoOAx4yP
	Xz+Hj6ZQ==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vjDs7-008ozf-Bm; Fri, 23 Jan 2026 10:54:31 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Zhi Wang <wangzhi@stu.xidian.edu.cn>,
	David Francis <David.Francis@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm: Do not allow userspace to trigger kernel warnings in drm_gem_change_handle_ioctl()
Date: Fri, 23 Jan 2026 09:54:15 +0000
Message-ID: <20260123095415.74260-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211366-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,xidian.edu.cn:email,amd.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EB7473BC0
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
Compile tested only. Any IGTs for the new functionality?
---
 drivers/gpu/drm/drm_gem.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 7ff6b7bbeb73..c5d3ecc1f8a8 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1001,11 +1001,16 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 {
 	struct drm_gem_change_handle *args = data;
 	struct drm_gem_object *obj;
-	int ret;
+	int new, ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
 		return -EOPNOTSUPP;
 
+	if (args->new_handle <= INT_MAX) /* idr_alloc() limitation. */
+		new = args->new_handle;
+	else
+		return -EINVAL;
+
 	obj = drm_gem_object_lookup(file_priv, args->handle);
 	if (!obj)
 		return -ENOENT;
@@ -1018,8 +1023,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	mutex_lock(&file_priv->prime.lock);
 
 	spin_lock(&file_priv->table_lock);
-	ret = idr_alloc(&file_priv->object_idr, obj,
-		args->new_handle, args->new_handle + 1, GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, obj, new, new + 1, GFP_NOWAIT);
 	spin_unlock(&file_priv->table_lock);
 
 	if (ret < 0)
-- 
2.52.0


