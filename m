Return-Path: <stable+bounces-269526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HA8TB8ssQWq/lwkAu9opvQ
	(envelope-from <stable+bounces-269526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A3A6D4082
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 16:16:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269526-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269526-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 299B53009CFA
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871CD3A7F72;
	Sun, 28 Jun 2026 14:11:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F21D5CD1;
	Sun, 28 Jun 2026 14:11:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782655915; cv=none; b=cFgqLaD9j7JQkv8kZJPRgFKadSW/8lw0JIYmYvThVat1RUiCvKIlZZrZOAOt+Qv/T974AzeePBaWca10tfiVRS23skdAtWgyGbRKknyRZB8c7EQgeFZ/kFPVI1Yta4Lre6b7Be+CW9WErvKZCMWCBRlWAOvX+WITURQUnoYsa8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782655915; c=relaxed/simple;
	bh=00vEOmI3ht3uL3Lk5CCufgqUcEaoWM3n35LzkMOqSbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pXVChxz9WS6bmvgY1PydexghmLXEc2UMQLWCGiv6px17hxGMk9qjg1OM8oM/SWcuc665nNB+M4pPXwYb7YoQEiA31bt7laR+xs9hK36qR8nmOd8jdU4v1x9gCBSpr8yqXtKiFsUpSR+txCDli3xnBrfisA1rmmXMCLb2/ptP9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowABn8QScK0FqqtzHFQ--.34250S2;
	Sun, 28 Jun 2026 22:11:43 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: jonathan.cavitt@intel.com,
	tzimmermann@suse.de,
	kees@kernel.org,
	matthew.brost@intel.com,
	vulab@iscas.ac.cn,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/i915: fix kref leak in __live_active_setup error path
Date: Sun, 28 Jun 2026 22:03:27 +0800
Message-Id: <20260628140327.46842-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABn8QScK0FqqtzHFQ--.34250S2
X-Coremail-Antispam: 1UD129KBjvJXoWruF4kWr1xXw1rtw48Gr4DJwb_yoW8Jr4xpa
	1fJa4YkFWfA3W7tayDuF40qry3WanxGFWxC34qkwsxZw15C3W8J34F9ry3GF1DArZ3Jr1a
	ywnrtFyxJF1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOlkVUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2pBJUUIeAABs5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jani.nikula@linux.intel.com,m:joonas.lahtinen@linux.intel.com,m:rodrigo.vivi@intel.com,m:tursulin@ursulin.net,m:airlied@gmail.com,m:simona@ffwll.ch,m:jonathan.cavitt@intel.com,m:tzimmermann@suse.de,m:kees@kernel.org,m:matthew.brost@intel.com,m:vulab@iscas.ac.cn,m:intel-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269526-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52A3A6D4082

When heap_fence_create fails, the early error path calls kfree(active)
directly instead of __live_put(active), bypassing the kref_put path that
would call i915_active_fini for proper resource teardown. This skips
cleanup of the i915_active state while the initial kref from kref_init
remains unbalanced.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/gpu/drm/i915/selftests/i915_active.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..8ec7859da762 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -91,7 +91,7 @@ __live_active_setup(struct drm_i915_private *i915)
 
 	submit = heap_fence_create(GFP_KERNEL);
 	if (!submit) {
-		kfree(active);
+		__live_put(active);
 		return ERR_PTR(-ENOMEM);
 	}
 
-- 
2.39.5 (Apple Git-154)


