Return-Path: <stable+bounces-261963-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfVSFiBkJmobVwIAu9opvQ
	(envelope-from <stable+bounces-261963-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 08:41:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A14FC65331D
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 08:41:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261963-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261963-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF19304C94A
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 06:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32D731E822;
	Mon,  8 Jun 2026 06:38:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF692DAFB0;
	Mon,  8 Jun 2026 06:38:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780900724; cv=none; b=knK/pZ7d+KtIf9GLVjClaY5HFlJSbWeRzCDkCu4tyF/2HReOj4X4Xc5/IbMZkMoxLb9XLAPiMV5VQr/VzGAYgurX9Hd+hw0nns9/kIRKu8DmvtKK74ktllJWsgHO9C/pQLNDFX5495G/u+qMFQMDfYAqkco+7kBHRZhjoeh+nSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780900724; c=relaxed/simple;
	bh=akshtcTLq/rNAOKhSpb1ELNWikn5FWvaaWnKweixmI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H0gQnahu2m6GYy1jL7duw3Tiuy7XksEtSsoH+gaZWfiARPBCx3HJ24sIHdnfoaBPV0PkgGV+lQn5XiViNqxe3Df8/kcGKETIgE6cYb2Rebv6VUanDnVv2X0lPrqguAG85ejW8b5bPT6LOSTw1Y+9CAqXK9OeKp44qrCd0RGv8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAB3HNVpYyZqNQDgAA--.1048S2;
	Mon, 08 Jun 2026 14:38:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: fix refcount leak in xe_range_fence_insert()
Date: Mon,  8 Jun 2026 06:15:40 +0000
Message-Id: <20260608061540.121355-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAB3HNVpYyZqNQDgAA--.1048S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr17Jr4kAF1xXr4rCFWDXFb_yoW8Gw15pw
	4rCr4UCr9xXa9Fvw17CF4YqFyjka1agrWkKr1vk39xX3y5JFy8Xr98Aa9YgF4UArs2vF13
	CrnFyw1UW34qyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUG_M-UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoMA2omIvDleAAAsB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-261963-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[intel.com,linux.intel.com,gmail.com,ffwll.ch];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:mid,iscas.ac.cn:from_mime,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A14FC65331D

xe_range_fence_insert() acquires a reference on fence via
dma_fence_get() and stores it in rfence->fence.  It then calls
dma_fence_add_callback() and handles two cases: when the callback
is successfully registered (err == 0) the fence is transferred to
the tree for later cleanup; when the fence is already signaled
(err == -ENOENT) it manually drops the extra reference with
dma_fence_put(fence).

However, dma_fence_add_callback() can fail with other errors
(e.g. -EINVAL) and in that case the code falls through to the free:
label without releasing the acquired reference, leaking it.

Fix the leak by adding an else branch that calls dma_fence_put()
before jumping to free: for any error other than -ENOENT.

Cc: stable@vger.kernel.org
Fixes: 845f64bdbfc9 ("drm/xe: Introduce a range-fence utility")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/xe/xe_range_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_range_fence.c b/drivers/gpu/drm/xe/xe_range_fence.c
index 372378e89e98..3d8fa194a7b0 100644
--- a/drivers/gpu/drm/xe/xe_range_fence.c
+++ b/drivers/gpu/drm/xe/xe_range_fence.c
@@ -77,6 +77,8 @@ int xe_range_fence_insert(struct xe_range_fence_tree *tree,
 	} else if (err == 0) {
 		xe_range_fence_tree_insert(rfence, &tree->root);
 		return 0;
+	} else {
+		dma_fence_put(fence);
 	}
 
 free:
-- 
2.34.1


