Return-Path: <stable+bounces-254063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNfaDhG6E2r/FAcAu9opvQ
	(envelope-from <stable+bounces-254063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:55:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D445C5782
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35BB03008D28
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D029B20A;
	Mon, 25 May 2026 02:55:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA18242D6B;
	Mon, 25 May 2026 02:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677710; cv=none; b=Ff5SNRh4bItIoU2KK6yK8FacsN18DF3zlfvNEiXT1XJEQsmxY3nKteJJOSzdsDe63P9N/LCCmRcBiIwAxgKlVxFk5M1jUaJjs3ESWZ+qNXLpvbcT4AFN7tPRN42OLDrbiSn4dPke/CAb+hHYWLGtwIfnKIf/uaXQl/5x81a3DqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677710; c=relaxed/simple;
	bh=2eqFuQ/MwI+xL9ig6/ztvqyUJ15awKTqF55lGaeA0v0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vt0TftQKsQ9KsW2e6nNZos8mCGp6OD8WkXt80AAaKOPLBzYd7xeFlIcv4lHdSWHygvIdevxRvbvBNcaN71UlmC+a5al3y2EJPZK08x6y/efRZhHQM2LLWrhzGdC+fRU6gEIfX270ozwjPdvYDL3UURwCCsN4K28wyGWqDRVtw+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACntMsDuhNqBVI_Eg--.824S2;
	Mon, 25 May 2026 10:54:59 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpu/drm/drm_syncobj: fix fence and syncobj refcount leak in drm_syncobj_import_sync_file_fence()
Date: Mon, 25 May 2026 02:54:55 +0000
Message-Id: <20260525025455.3887523-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACntMsDuhNqBVI_Eg--.824S2
X-Coremail-Antispam: 1UD129KBjvJXoWrKF4UuF47Kr4kuw4Utw47Jwb_yoW8Jry8pF
	sxGryqkrykta1FvrWfCFWqvFyfGa12qFWFgr17Cw13A3Z5tr1DJw45G392ga4DA3s7Aryf
	tr92kF4YvFn8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb8hL5
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYSA2oTok5z+AAAsF
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254063-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.883];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 95D445C5782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In drm_syncobj_import_sync_file_fence(), when point is non-zero and
dma_fence_chain_alloc() fails, the function returns -ENOMEM without
releasing the fence reference (obtained via sync_file_get_fence)
and the syncobj reference (obtained via drm_syncobj_find).

Add dma_fence_put() and drm_syncobj_put() calls on the error path
to properly release both references.

Cc: stable@vger.kernel.org
Fixes: c2d3a7300695 ("drm/syncobj: Extend EXPORT_SYNC_FILE for timeline syncobjs")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/drm_syncobj.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 0e986daa8ff9..34c87698e316 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -745,8 +745,11 @@ static int drm_syncobj_import_sync_file_fence(struct drm_file *file_private,
 	if (point) {
 		struct dma_fence_chain *chain = dma_fence_chain_alloc();
 
-		if (!chain)
+		if (!chain) {
+			dma_fence_put(fence);
+			drm_syncobj_put(syncobj);
 			return -ENOMEM;
+		}
 
 		drm_syncobj_add_point(syncobj, chain, fence, point);
 	} else {
-- 
2.34.1


