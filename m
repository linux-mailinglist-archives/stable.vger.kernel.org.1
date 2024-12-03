Return-Path: <stable+bounces-97464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8C9E28CB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA0BE0395
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44835204F87;
	Tue,  3 Dec 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oMPP9ylz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF81F8930;
	Tue,  3 Dec 2024 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240596; cv=none; b=AgggAdfLPfYzf/6chdvJYM9iQqi+1LJfU+BUPQIOLDNU7GpB2ZHL5REKHbL10qum7x5BdoTSmP5cxp3vjM3CTmSypSzCu+dMk0kk692eKyKbWxagWyc+GcPQOP5klCPjJPx1Bs1HCGQJW59wJ5RFYScBA/+Vo+pHa57cvsGJa3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240596; c=relaxed/simple;
	bh=DLx2Z5G/JFYU44aJNrZeF0xVZ1bj9T9qPIGV8V96Tqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t++OMyuGXwyEX6pNa1CUXbkU7DYHX1MJgwJe160FIrN/LxkM+CfXDWNyeoMr9N1Jsj/PMB+OItY3xp6PPaxUN1xEYWLwVAYxJYptntR94B1gaOdcW24GnWuJOx8LJQ5nKZgTcSNQGkKeuxpEU+Cmcf1SP5NFXF3BHanTmiO0Z70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oMPP9ylz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CB7C4CECF;
	Tue,  3 Dec 2024 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240595;
	bh=DLx2Z5G/JFYU44aJNrZeF0xVZ1bj9T9qPIGV8V96Tqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oMPP9ylzPcNDAKAvM8iZ3DPaizXnW6q4Yo9mnCMrphNZvH+XBp21akb4+RcxuO0GY
	 PsA0Lp2bm/mnuELGtNXGFAjZ7GgS0Uw3jZWj0K9SrBSeR7S80wxCJ4pJdn92rSZtue
	 auxV5m0t0Zv8Ewq1Q/0RR40LB7Lp9aQTHSn7BbrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 182/826] drm/imagination: Use pvr_vm_context_get()
Date: Tue,  3 Dec 2024 15:38:29 +0100
Message-ID: <20241203144750.837652705@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Coster <Matt.Coster@imgtec.com>

[ Upstream commit eb4accc5234525e2cb2b720187ccaf6db99b705f ]

I missed this open-coded kref_get() while trying to debug a refcount
bug, so let's use the helper function here to avoid that waste of time
again in the future.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Reviewed-by: Frank Binns <frank.binns@imgtec.com>
Link: https://patchwork.freedesktop.org/patch/msgid/8616641d-6005-4b25-bc0a-0b53985a0e08@imgtec.com
Signed-off-by: Matt Coster <matt.coster@imgtec.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/imagination/pvr_vm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 7bd6ba4c6e8ab..363f885a70982 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -654,9 +654,7 @@ pvr_vm_context_lookup(struct pvr_file *pvr_file, u32 handle)
 
 	xa_lock(&pvr_file->vm_ctx_handles);
 	vm_ctx = xa_load(&pvr_file->vm_ctx_handles, handle);
-	if (vm_ctx)
-		kref_get(&vm_ctx->ref_count);
-
+	pvr_vm_context_get(vm_ctx);
 	xa_unlock(&pvr_file->vm_ctx_handles);
 
 	return vm_ctx;
-- 
2.43.0




