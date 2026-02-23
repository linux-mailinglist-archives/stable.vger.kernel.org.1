Return-Path: <stable+bounces-217769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOyQBoBMnGnYDQQAu9opvQ
	(envelope-from <stable+bounces-217769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:48:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C11766A4
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 13:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DE2731343F0
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CB1362137;
	Mon, 23 Feb 2026 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RVLlK+FU"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D036604D
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850516; cv=none; b=aLIhhpuk5slCZy43ECGi8COnxcSCZPZi5GFMG1ncUMeSj7CakzQUfjYcR5TJsJR7Z8fakWUfhC8srKPusxzhhcOCmcyAGLrX3VwrfsYZhSq8khUwFfaItmuqNBGY3oKSWco7wFb6MwdmHSU+qCQLOTNP4goDI0K5J6MtmrziNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850516; c=relaxed/simple;
	bh=3KeKsX/TicHeGqKjb66sFc6q/MAN5AimN9tW/3tVCDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXS/qDdX0n++ajLB9fTnHLHVG/rqpO/9pjM8GgLdqgxJc2gLSRSQB+Z8t0Rnym8k3z6T8Wi/kcnvfitpTspSWuunBxKJnarTI+pXF7T770jiPwgJseP7fc1qGYLvANphRGgCJRHVqE9yNuXO7PepNZO49igLhkXywp3Gyh4/DZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RVLlK+FU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eVmCekjPBgHEFAVxRcyW3jy+HaYB2F0nv5nwT9lu+Bs=; b=RVLlK+FUOdPtbpvLwekvpxPClq
	oPV1ZC5/UFqI5IZGWEwODJ3enu/C5urSqo9/7mOnwbDXCoriouFNk7BCvnsmYGhzGrzLwThRv8iSc
	bwNSL4Mn55xQtQ3MfYxn5u89LscEepJP7MHOjvVk91JsKfq3jwWDzv246adZN8c2HS436lcDEPCib
	y144JqYxdhpBmmWeFrU6je6Z6E5Skt2gH9Aut2+WaM27QV6MOxsZ2pndPQpXVQx7ce+cr1bcaBeIj
	4sIP1tKwVdz/FxT9NLIbXd3pHuCerm8TolCTV5s8TWrxR95JvbKU8FoS0GMDbf04/NTYaGnFj75vL
	Cm2+P7Rg==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vuVFz-004EK9-LT; Mon, 23 Feb 2026 13:41:47 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/12] drm/amdgpu/userq: Fix reference leak in amdgpu_userq_wait_ioctl
Date: Mon, 23 Feb 2026 12:41:30 +0000
Message-ID: <20260223124141.10641-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
References: <20260223124141.10641-1-tvrtko.ursulin@igalia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217769-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tvrtko.ursulin@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 713C11766A4
X-Rspamd-Action: no action

Drop reference to syncobj and timeline fence when aborting the ioctl due
output array being too small.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: a292fdecd728 ("drm/amdgpu: Implement userqueue signal/wait IOCTL")
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org> # v6.16+
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8013260e29dc..9b9947b94b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -876,6 +876,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				dma_fence_unwrap_for_each(f, &iter, fence) {
 					if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 						r = -EINVAL;
+						dma_fence_put(fence);
 						goto free_fences;
 					}
 
@@ -900,6 +901,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
 				r = -EINVAL;
+				dma_fence_put(fence);
 				goto free_fences;
 			}
 
-- 
2.52.0


