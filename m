Return-Path: <stable+bounces-221532-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLeSH9CXo2lIHwUAu9opvQ
	(envelope-from <stable+bounces-221532-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:35:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AC41CB086
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 103B53039679
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C242E2877DE;
	Sun,  1 Mar 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOlH2Oku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D59269CE6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328500; cv=none; b=Q376QoBxshBut2duTwZhPZybjQzBqHe8rA1qMmlG7zkQYEitD5g2sJzlaQl5UDk4O3cFWzgCArKp083qybHye0SOOSLBWX7ld16HXGTthQvPaLdyz+o6UnBSVCgCRMiXLs+2iLhLPsnCzCoTnET6tYvzIOjO5FhVVKUi0ziL/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328500; c=relaxed/simple;
	bh=UxpUb344zXGaVGlAx0kCSPGAY84ny44knaHftbAqZnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fD5025o2AED00WHI5zSs6XNnKsCi9PWReydi/WxevHxGzC8yn58yLI0q2QE6/dkCeJ+0NR3Arxasj7XsXTyLXn870XWQIMR2pNhnTiorS3mntgYu6meTUspkXipL1RDsYZYE3hCxAzDZGJUwaHFmb6atKX1cJfZTiiJ69L6qtcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOlH2Oku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC128C19421;
	Sun,  1 Mar 2026 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328500;
	bh=UxpUb344zXGaVGlAx0kCSPGAY84ny44knaHftbAqZnA=;
	h=From:To:Cc:Subject:Date:From;
	b=uOlH2Okuy0ich6QJq7XPV8k9eQRj+vTZDdA7+S3+8EVxT8FqfkgNzMeaA/x7X10hC
	 UNB9BYnJdu+1E6zzrDDggGJhGaxixIVxnbemrFGcIdVNw6Sxka89ppVqAKE82/oqRn
	 /dAmynf/S+1dpdyxggyQ5OQzLeajiDHtIh3RsYayxWCbW2SImouXqiw7SBOT4q+rs3
	 fAchaM/g/SH0KWf0boo3vVlDwj+LCOsgvMo/Ocsr2tRY2zOasvgAyVAlqqugb5Lpei
	 AbdFt1VmnE3QaV8h07M5cOf6eeOA83+MYBfd6uKNpYurr3LRleOTN1wQDM9jNEDQJx
	 vlIOefIcsg8qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pierre-eric.pelloux-prayer@amd.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: fix sync handling in amdgpu_dma_buf_move_notify" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:18 -0500
Message-ID: <20260301012818.1686023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221532-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: A5AC41CB086
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b18fc0ab837381c1a6ef28386602cd888f2d9edf Mon Sep 17 00:00:00 2001
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Date: Mon, 9 Feb 2026 18:54:45 +0100
Subject: [PATCH] drm/amdgpu: fix sync handling in amdgpu_dma_buf_move_notify
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Invalidating a dmabuf will impact other users of the shared BO.
In the scenario where process A moves the BO, it needs to inform
process B about the move and process B will need to update its
page table.

The commit fixes a synchronisation bug caused by the use of the
ticket: it made amdgpu_vm_handle_moved behave as if updating
the page table immediately was correct but in this case it's not.

An example is the following scenario, with 2 GPUs and glxgears
running on GPU0 and Xorg running on GPU1, on a system where P2P
PCI isn't supported:

glxgears:
  export linear buffer from GPU0 and import using GPU1
  submit frame rendering to GPU0
  submit tiled->linear blit
Xorg:
  copy of linear buffer

The sequence of jobs would be:
  drm_sched_job_run                       # GPU0, frame rendering
  drm_sched_job_queue                     # GPU0, blit
  drm_sched_job_done                      # GPU0, frame rendering
  drm_sched_job_run                       # GPU0, blit
  move linear buffer for GPU1 access      #
  amdgpu_dma_buf_move_notify -> update pt # GPU0

It this point the blit job on GPU0 is still running and would
likely produce a page fault.

Cc: stable@vger.kernel.org
Fixes: a448cb003edc ("drm/amdgpu: implement amdgpu_gem_prime_move_notify v2")
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b9c38a4fe546a..656c267dbe587 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -514,8 +514,15 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 		r = dma_resv_reserve_fences(resv, 2);
 		if (!r)
 			r = amdgpu_vm_clear_freed(adev, vm, NULL);
+
+		/* Don't pass 'ticket' to amdgpu_vm_handle_moved: we want the clear=true
+		 * path to be used otherwise we might update the PT of another process
+		 * while it's using the BO.
+		 * With clear=true, amdgpu_vm_bo_update will sync to command submission
+		 * from the same VM.
+		 */
 		if (!r)
-			r = amdgpu_vm_handle_moved(adev, vm, ticket);
+			r = amdgpu_vm_handle_moved(adev, vm, NULL);
 
 		if (r && r != -EBUSY)
 			DRM_ERROR("Failed to invalidate VM page tables (%d))\n",
-- 
2.51.0





