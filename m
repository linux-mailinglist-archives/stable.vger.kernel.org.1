Return-Path: <stable+bounces-267530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9UmQBHeKN2oIOwcAu9opvQ
	(envelope-from <stable+bounces-267530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 08:53:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF26AA543
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 08:53:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=cnMcCRWV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267530-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267530-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDE803015CA0
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7454725B0B3;
	Sun, 21 Jun 2026 06:53:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E122D4D3;
	Sun, 21 Jun 2026 06:53:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782024811; cv=none; b=Wt64k4CmGKzYad4K1oT6QIu2tO7HJrujD1rhF+9okECzOtVhLhogge5fssLOAvbmiGk/FIXsGqtAdTaRHVJCEwHSEFXbgfOVVqUmiKP3+GbjsvatxbNfHXNuWxZacZtlqaACW58yTEc03fzAQfs0R8akiaCJKM07rizBbbWuzgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782024811; c=relaxed/simple;
	bh=9+HWiB09YhgxL9DCMX0RM+JRQT6WuA/wUNtuT0g3Pgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvEpeehs7y7bG2vI4HJ0X2c5DPs0mliRdZsmu406Uzu2vz/lzc54/aFHnDSaKA2DYBtNyCA9a4rvk+I3VsTYYhtbjGfiePhCEsfiHpQHORTLXOQd6si+bCcp6HgHblMlPWOPgYdwy3WtSsVp1lFwQeSapVub0k9Nq9bN+6Q6UqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cnMcCRWV; arc=none smtp.client-ip=220.197.31.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pV
	P6CQgOl6PJfaBLS29zEb/z/XnemFReUw+zufw2bGc=; b=cnMcCRWVbzoaaH1dai
	mrC1omVdo7fq995zCgYT7qBR3iKqERJXXz0mM5GeYjRwljmSG1bmctISg0dWMnq8
	3wh7HgGYyvHUuXFlfR7IahLPJ1CNakLCnz+4CkKkwUOdRjdqLKXJRWKD48bBFOxl
	Gx/IApNiDR0KCVZjsevE2rceE=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCn+rpJijdq9U88Dg--.25516S2;
	Sun, 21 Jun 2026 14:52:59 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	saleemkhan.jamadar@amd.com,
	Veerabadhran.Gopalakrishnan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu/umsch: free UMSCH resources on debug BO allocation failure
Date: Sun, 21 Jun 2026 14:52:57 +0800
Message-Id: <20260621065257.3780075-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCn+rpJijdq9U88Dg--.25516S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13Jr4xWF15uw4xCFy3Jwb_yoW8GrWfpa
	1fJF1aqryUZr17ta4DA3W8XFyfK3y2qFy8CrWYqF9Y9w15Xas5JFy5K342qryDWFZ2yFW2
	qrWDC3yxXF4qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRNyCPUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxQsdi2o3iktQcAAA3k
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267530-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:saleemkhan.jamadar@amd.com,m:Veerabadhran.Gopalakrishnan@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93CF26AA543

umsch_mm_init() allocates a writeback slot and a command buffer
BO before allocating the UMSCH debug BO. If the debug BO allocation
fails, the function returns directly without releasing the previously
allocated command buffer BO and writeback slot.

Release the command buffer BO and free the writeback slot on this
failure path to avoid leaking resources during UMSCH initialization.

Fixes: 98a2e3a0d155 ("drm/amdgpu/umsch: add support to capture fw debug log")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index cd707d70a0bf..622cc7320fa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -300,6 +300,10 @@ static int umsch_mm_init(struct amdgpu_device *adev)
 				    &adev->umsch_mm.log_cpu_addr);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to allocate umsch debug bo\n", r);
+		amdgpu_bo_free_kernel(&adev->umsch_mm.cmd_buf_obj,
+			      &adev->umsch_mm.cmd_buf_gpu_addr,
+			      (void **)&adev->umsch_mm.cmd_buf_ptr);
+		amdgpu_device_wb_free(adev, adev->umsch_mm.wb_index);
 		return r;
 	}
 
-- 
2.25.1


