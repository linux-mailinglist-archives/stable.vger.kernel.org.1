Return-Path: <stable+bounces-264099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wIjDJqxuMWrFjAUAu9opvQ
	(envelope-from <stable+bounces-264099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:41:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BB6914B3
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:41:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264099-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264099-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF43C31AA807
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C444BC94;
	Tue, 16 Jun 2026 15:35:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA943DA2C;
	Tue, 16 Jun 2026 15:35:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624119; cv=none; b=TMA/0vSZ9b6iCVmy6LUb5tXGVGMPOYu0gxkPu75Bjg4uhEEhdPgviHW6bqqyRnfYpabG3iFnqHyUZNx0GjnKNfC1hADGMJTbKsTldQyPjxu1c7Db0ewEtI259RXq3Ms5TJPxCD9eDd47u7IlKPZ/Tz12euLWh+MZ5HcjtjVXofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624119; c=relaxed/simple;
	bh=4yAVF82rBtjl5/KYDPf/gXf+TFBoOLYlbSssuGJpaW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPuLMntZfuGs2/HRN+sEvVQJaFQVwUdkIXOO2jX8KkqR47Zz3qciA0mxseIV87onhaP3Me97xBd/EJ++U6za5bUhvK6YU50UIzPGN3bSQ3U1YEA2lIXsOGwAVcVfnJ2HwUtU5sOKzlWVgxRh3jkDF6onMC+DSqby9sQZtwlppC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3Z+subTFqAR3GEw--.19654S2;
	Tue, 16 Jun 2026 23:35:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: lijo.lazar@amd.com,
	aurabindo.pillai@amd.com,
	superm1@kernel.org,
	xiaogang.chen@amd.com,
	chongli2@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	Victor.Zhao@amd.com,
	Jesse.Zhang@amd.com,
	lang.yu@amd.com,
	vulab@iscas.ac.cn,
	Jack.Xiao@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: fix fence reference leak in amdgpu_gfx_run_cleaner_shader_job
Date: Tue, 16 Jun 2026 15:35:06 +0000
Message-Id: <20260616153506.1713376-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3Z+subTFqAR3GEw--.19654S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13AFWUur43Cr45Ar18Krg_yoW8AF4xpF
	s3Kry3tr48Za17K347A3Wjqa409w13XFy8WrnFya4I93Z8JFn8Jr15JayFqF1kurWkCa17
	Kryqg3y5X3Z0kF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUFdgAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoAA2oxZbUPKgABsg
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:lijo.lazar@amd.com,m:aurabindo.pillai@amd.com,m:superm1@kernel.org,m:xiaogang.chen@amd.com,m:chongli2@amd.com,m:pierre-eric.pelloux-prayer@amd.com,m:Victor.Zhao@amd.com,m:Jesse.Zhang@amd.com,m:lang.yu@amd.com,m:vulab@iscas.ac.cn,m:Jack.Xiao@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-264099-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 206BB6914B3

In amdgpu_gfx_run_cleaner_shader_job(), amdgpu_job_submit() returns a
dma_fence with an elevated reference count. The function correctly
releases this reference on the success path after dma_fence_wait().
However, if dma_fence_wait() fails (though with infinite timeout and
non-interruptible it never does), the code jumps to the error label
without calling dma_fence_put(), resulting in a reference leak.

Fix the potential leak by adding dma_fence_put(f) before the goto err
when dma_fence_wait() returns an error.

Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
v2: Also cleanup the scheduler entity and simplify error handling paths.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca876694ff..be13ce6ce377 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1658,7 +1658,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 				  &sched, 1, NULL);
 	if (r) {
 		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
-		goto err;
+		return r;
 	}
 
 	/*
@@ -1686,16 +1686,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	f = amdgpu_job_submit(job);
 
 	r = dma_fence_wait(f, false);
-	if (r)
-		goto err;
+	goto err;
 
 	dma_fence_put(f);
 
+err:
 	/* Clean up the scheduler entity */
 	drm_sched_entity_destroy(&entity);
-	return 0;
-
-err:
 	return r;
 }
 
-- 
2.34.1


