Return-Path: <stable+bounces-223476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEoPBIIvrmlrAQIAu9opvQ
	(envelope-from <stable+bounces-223476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:25:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BD2333AC
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 03:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81262301E73E
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 02:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BE26560A;
	Mon,  9 Mar 2026 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WIPK784+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970222F177;
	Mon,  9 Mar 2026 02:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022973; cv=none; b=jlqXKAHv0j7QauVYzD9ghhgWTtjXTiSD58Cj7hohJGjG1gGuxpwNk4mjjmmhFQcHP583F0jiea4GEybVhNT/zbmgULcavQKp+NhbrPlbe8kBua4HuEuF5oF+/y10PrC6QRaYNAMM+T6mvL96YDVo1oQsQdGlBK3T8w4xxnxn73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022973; c=relaxed/simple;
	bh=ek6Q3pgrbgv6btK46kxZUTvf7+ZrdMXGyeriLGTUzAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmGEERtclkfWq0hHAy9ukhgTnV9KY6XNHBAsOPLL8xvgexrydmrJjiTaVOklAQhUaNpb95S7grkCaTGgZgkBjTu+LvU/tM3VV3cl9B5pehLMziDI1m+V0Yxwlp18VPi4rhdh8SV6CdGmZ0+oPAVU/RXPTjrKJADkymP1JsRcLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WIPK784+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5v
	sqXiU7O2Yi0ZaDaTEqsKFf1lQiln2PtajqeQs2Nyc=; b=WIPK784+ChbfpAdr+A
	eQqyQsF+qh4fQjU3PzQZcy5YxlLugkrMrmVXiR3i45iDYOGCsqY8Dg94fvilvW0e
	hGuTNjPB0hHGq9dWcHQs7xeDJEgAo3m2tVkMJkcSi1+GZi8xBymPq0Ltw8sa475q
	pVR+VvRydzR2W0fHb/58FHGRE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXV5TmLq5pRMZoPg--.11725S3;
	Mon, 09 Mar 2026 10:22:33 +0800 (CST)
From: Chenyuan Mi <chenyuan_mi@163.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: Arunpravin.PaneerSelvam@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amdgpu: protect waitq access with userq_mutex in wait IOCTL
Date: Mon,  9 Mar 2026 10:22:28 +0800
Message-ID: <20260309022229.63071-2-chenyuan_mi@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309022229.63071-1-chenyuan_mi@163.com>
References: <20260309022229.63071-1-chenyuan_mi@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXV5TmLq5pRMZoPg--.11725S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF17Ww13Xw45AF45XF18Krg_yoW5XryDpr
	WrKr12kr4DXr429w1UJwnFgFWvgw4xWFWfKFn7Cry3uws8Aas09ryYkFWDXr18CrsrAFW2
	qrn7A3y8tF1qkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqD73UUUUU=
X-CM-SenderInfo: xfkh055xdqszrl6rljoofrz/xtbC1ArL3mmuLuqxEwAA3q
X-Rspamd-Queue-Id: 135BD2333AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223476-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenyuan_mi@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[163.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

amdgpu_userq_wait_ioctl() accesses the wait queue object obtained
from xa_load() without holding userq_mutex or taking a reference on
the queue. A concurrent AMDGPU_USERQ_OP_FREE call can destroy and
free the queue between the xa_load() and the subsequent
xa_alloc(&waitq->fence_drv_xa, ...), resulting in a use-after-free.

This is a regression introduced by commit 4b27406380b0
("drm/amdgpu: Add queue id support to the user queue wait IOCTL"),
which removed the indirect fence_drv_xa_ptr model and its NULL
check safety net from commit ed5fdc1fc282 ("drm/amdgpu: Fix the
use-after-free issue in wait IOCTL") and replaced it with a direct
waitq->fence_drv_xa access, but did not add any lifetime protection
around the new waitq pointer.

Fix this by holding userq_mutex across the xa_load() and the
subsequent fence_drv_xa operations, matching the locking used by
the destroy path.

Fixes: 4b27406380b0 ("drm/amdgpu: Add queue id support to the user queue wait IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Chenyuan Mi <chenyuan_mi@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 8013260e29dc..1785ea7c18fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -912,8 +912,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
+		mutex_lock(&userq_mgr->userq_mutex);
 		waitq = xa_load(&userq_mgr->userq_xa, wait_info->waitq_id);
 		if (!waitq) {
+			mutex_unlock(&userq_mgr->userq_mutex);
 			r = -EINVAL;
 			goto free_fences;
 		}
@@ -932,6 +934,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 				r = dma_fence_wait(fences[i], true);
 				if (r) {
 					dma_fence_put(fences[i]);
+					mutex_unlock(&userq_mgr->userq_mutex);
 					goto free_fences;
 				}
 
@@ -948,8 +951,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 */
 			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
 				     xa_limit_32b, GFP_KERNEL);
-			if (r)
+			if (r) {
+				mutex_unlock(&userq_mgr->userq_mutex);
 				goto free_fences;
+			}
 
 			amdgpu_userq_fence_driver_get(fence_drv);
 
@@ -961,6 +966,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			/* Increment the actual userq fence count */
 			cnt++;
 		}
+		mutex_unlock(&userq_mgr->userq_mutex);
 
 		wait_info->num_fences = cnt;
 		/* Copy userq fence info to user space */
-- 
2.53.0


