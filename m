Return-Path: <stable+bounces-115014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A1A32072
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEDA3A641D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 07:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E132046A5;
	Wed, 12 Feb 2025 07:58:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA6204694;
	Wed, 12 Feb 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347086; cv=none; b=E+6V2t1NIaU/IMO1Q4CvkYk5DKuvDJV3R+ZvB+8Kl83ys5k0KL+W+axG/PCtDapLlFcKV9bI9PiC7jYL5EF425r3ObvvRlxSEkVblk0JLmvSdFizd2+dpxHUf+qNaD+QZ1pmj4e04Z6y5RNT6QPQ6qUzA+yAkpAX5GgPr0C9wZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347086; c=relaxed/simple;
	bh=jApVUzcy8MyCArNkxM7BCn/Tj8nhvBhjS6yVZQKRLnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnd8K6LMA8qiZCwMPslgD2KBNHIvhc0hZNkrkVFVf0qF9bZcGvfEVQ/091VZ/0lNhNW/axWg4YNzOFjhRgRZItqSQWnkW+AIM1O1MjkfA6Iefh68dX0acEncsnUp6iUDsIcBIZutOIP4yhHof5PPLabovdsLgX+7kLl4g6wIzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowABXX6N+VKxnCLBmDA--.44042S2;
	Wed, 12 Feb 2025 15:57:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915: Check drm_syncobj_fence_get return value in eb_fences_add
Date: Wed, 12 Feb 2025 15:57:35 +0800
Message-ID: <20250212075736.922-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXX6N+VKxnCLBmDA--.44042S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryrArWrCrWkKw1kAry7ZFb_yoW8Gr1Upa
	1fKFyjyrs0yw40q3Z7Ar1YyFy3C3WxK3WfKw4qywn5uw4YyF1qqryFvrWjqFyUArs3K347
	Jr1qkFWSvryUArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8LA2esUh4H3AAAsS

The function drm_syncobj_fence_get() may return NULL if the syncobj
has no fence. In eb_fences_add(), this return value is not checked,
leading to a potential NULL pointer dereference in
i915_request_await_dma_fence().

This patch adds a check for the return value of drm_syncobj_fence_get
and returns an error if it is NULL, preventing the NULL pointer
dereference.

Fixes: 544460c33821 ("drm/i915: Multi-BB execbuf")
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index f151640c1d13..7da65535feb9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -3252,6 +3252,12 @@ eb_fences_add(struct i915_execbuffer *eb, struct i915_request *rq,
 		struct dma_fence *fence;
 
 		fence = drm_syncobj_fence_get(eb->gem_context->syncobj);
+		if (!fence) {
+			drm_dbg(&eb->i915->drm,
+				"Syncobj handle has no fence\n");
+			return ERR_PTR(-EINVAL);
+		}
+
 		err = i915_request_await_dma_fence(rq, fence);
 		dma_fence_put(fence);
 		if (err)
-- 
2.42.0.windows.2


