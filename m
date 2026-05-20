Return-Path: <stable+bounces-253219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK0kFBgHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:10:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B32597DCF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAAE128426D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E664218BA;
	Wed, 20 May 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iQJ0gC+X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BE40F8D3;
	Wed, 20 May 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302710; cv=none; b=Q66c29bsBNJDsHwUMNYMcj3VaLnMuMR7wHY0ifa843ZbzyAYarEKanQ6/0HmUFhrlKqh3fTfyaqCz2odh+IcX2t675MTxB7kkRRJssG3wan4xfZ6xE/PHnhNvWoZvLwr2Xz/F8ACPXn2YL8DGVtk5isqp0YX8d97flKpfWRMgNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302710; c=relaxed/simple;
	bh=O8tZ6B9u6SDpNl+i9Vwp6RnYR7sF5xAHvLdKOFIi8Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqzp1aRH58DJL7x/Cq4TOg1TLBJ2kOA0BLF4AE5JbBVvxC2GyvillzGaVXhjP05f5Ve62FoGcSlBq5dztOtifwsuhMblMrVtXT7IRCwf02q0fAfIYbp6aEWNA0ANqmNDO9JBT8jr6Prnf9KWk8xWlvAyuvdAHIhdQJCqtDhcZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iQJ0gC+X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC77E1F000E9;
	Wed, 20 May 2026 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302709;
	bh=LIL9/zhkRrcJJE8Ai2kna02s+TDaQn6T1hqS3dcEPEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iQJ0gC+X3iE3e5JpNHhP9yVAi32Qro0f23ITeFr6Dj62VqwqNjGihAW5qBUdRJxIk
	 WBdJiWk69ug3yEBfDu7lcgQ93SDR1xnelednndjBnSI8QeEmQfhUTQnnnxgvSIWY+d
	 C8zy+rXNuYVOYbxlXC2/OYh6pdawYeTOOnZLByYw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 370/508] drm/amdgpu: fix AMDGPU_INFO_READ_MMR_REG
Date: Wed, 20 May 2026 18:23:13 +0200
Message-ID: <20260520162106.643090227@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253219-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D3B32597DCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 0ef196a208385b7d7da79f411c161b04e97283e2 ]

There were multiple issues in that code.

First of all the order between the reset semaphore and the mm_lock was
wrong (e.g. copy_to_user) was called while holding the lock.

Then we allocated memory while holding the reset semaphore which is also
a pretty big bug and can deadlock.

Then we used down_read_trylock() instead of waiting for the reset to
finish.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 9e823f307074 ("drm/amdgpu: Block MMR_READ IOCTL in reset")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 361b6e6b303d4b691f6c5974d3eaab67ca6dd90e)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 57 +++++++++++--------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 10730f256ae0f..4c678048be63b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -724,68 +724,59 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 				    ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_READ_MMR_REG: {
-		int ret = 0;
-		unsigned int n, alloc_size;
-		uint32_t *regs;
 		unsigned int se_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SE_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SE_INDEX_MASK;
 		unsigned int sh_num = (info->read_mmr_reg.instance >>
 				   AMDGPU_INFO_MMR_SH_INDEX_SHIFT) &
 				  AMDGPU_INFO_MMR_SH_INDEX_MASK;
-
-		if (!down_read_trylock(&adev->reset_domain->sem))
-			return -ENOENT;
+		unsigned int alloc_size;
+		uint32_t *regs;
+		int ret;
 
 		/* set full masks if the userspace set all bits
 		 * in the bitfields
 		 */
-		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK) {
+		if (se_num == AMDGPU_INFO_MMR_SE_INDEX_MASK)
 			se_num = 0xffffffff;
-		} else if (se_num >= AMDGPU_GFX_MAX_SE) {
-			ret = -EINVAL;
-			goto out;
-		}
+		else if (se_num >= AMDGPU_GFX_MAX_SE)
+			return -EINVAL;
 
-		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK) {
+		if (sh_num == AMDGPU_INFO_MMR_SH_INDEX_MASK)
 			sh_num = 0xffffffff;
-		} else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE) {
-			ret = -EINVAL;
-			goto out;
-		}
+		else if (sh_num >= AMDGPU_GFX_MAX_SH_PER_SE)
+			return -EINVAL;
 
-		if (info->read_mmr_reg.count > 128) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (info->read_mmr_reg.count > 128)
+			return -EINVAL;
 
-		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs), GFP_KERNEL);
-		if (!regs) {
-			ret = -ENOMEM;
-			goto out;
-		}
+		regs = kmalloc_array(info->read_mmr_reg.count, sizeof(*regs),
+				     GFP_KERNEL);
+		if (!regs)
+			return -ENOMEM;
 
+		down_read(&adev->reset_domain->sem);
 		alloc_size = info->read_mmr_reg.count * sizeof(*regs);
-
 		amdgpu_gfx_off_ctrl(adev, false);
+		ret = 0;
 		for (i = 0; i < info->read_mmr_reg.count; i++) {
 			if (amdgpu_asic_read_register(adev, se_num, sh_num,
 						      info->read_mmr_reg.dword_offset + i,
 						      &regs[i])) {
 				DRM_DEBUG_KMS("unallowed offset %#x\n",
 					      info->read_mmr_reg.dword_offset + i);
-				kfree(regs);
-				amdgpu_gfx_off_ctrl(adev, true);
 				ret = -EFAULT;
-				goto out;
+				break;
 			}
 		}
 		amdgpu_gfx_off_ctrl(adev, true);
-		n = copy_to_user(out, regs, min(size, alloc_size));
-		kfree(regs);
-		ret = (n ? -EFAULT : 0);
-out:
 		up_read(&adev->reset_domain->sem);
+
+		if (!ret) {
+			ret = copy_to_user(out, regs, min(size, alloc_size))
+				? -EFAULT : 0;
+		}
+		kfree(regs);
 		return ret;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
-- 
2.53.0




