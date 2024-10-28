Return-Path: <stable+bounces-88247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A49B2190
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 01:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4057B28131C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD002CA7;
	Mon, 28 Oct 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KJlHl3ti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989C23D2
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730075521; cv=none; b=qyc+541OTLHHIefJ6DhoC+zdBmTHjKjHv34fKPCXZO+33+3PGMJ4eWV6SExPQFoZlgMMFcxKQywWKvk3BVbRmGJQMPYD6EcaiYIahpmNc5LJiNKFdNOYgmdEag/q6vxKS7iyeWtuQt9DwgUoQX3obYRzHVtBjP3ncETN+9I9p3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730075521; c=relaxed/simple;
	bh=8BGu+8C7xg8zjcnFJ+cjYFfCda8SqnkBL7PhIYqCuoY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O4MtOn19yYWzdhetdVTvvtMSlRSsSc/5VuRc5T1HYU0xQW08lgS9044NZUaLMSKY7/YJn02ZfBlWyLsibL0L3FEfoebkFMClzQanff1QS0Ltrt9t5NWIpWlxehZdjjoPXm/0U3WkYUyWh9krTr/AkCmCsYlJyY0oM7V1ck7oNK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KJlHl3ti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24ABC4CEC3;
	Mon, 28 Oct 2024 00:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730075521;
	bh=8BGu+8C7xg8zjcnFJ+cjYFfCda8SqnkBL7PhIYqCuoY=;
	h=Subject:To:Cc:From:Date:From;
	b=KJlHl3ti5+pfzj2+lIq9DPY4o78CJImfMIWdA7Dy/r8WztNJdVNy4dZ1JMsW84dNq
	 oMj/t7WNRqP1SgOrESYPE3BniOo6YSZQ17J4avUB9twnjQmGK3lBS8ONPSJhhdagaI
	 s/0GkKkdTqXsyE2hsDXZT4IO1eQtxLZ3qOAU8QVY=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix random data corruption for sdma 7" failed to apply to 6.11-stable tree
To: Frank.Min@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Oct 2024 01:31:49 +0100
Message-ID: <2024102849-flannels-ashy-e1bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 108bc59fe817686a59d2008f217bad38a5cf4427
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102849-flannels-ashy-e1bf@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 108bc59fe817686a59d2008f217bad38a5cf4427 Mon Sep 17 00:00:00 2001
From: Frank Min <Frank.Min@amd.com>
Date: Thu, 10 Oct 2024 16:41:32 +0800
Subject: [PATCH] drm/amdgpu: fix random data corruption for sdma 7

There is random data corruption caused by const fill, this is caused by
write compression mode not correctly configured.

So correct compression mode for const fill.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 75400f8d6e36afc88d59db8a1f3e4b7d90d836ad)
Cc: stable@vger.kernel.org # 6.11.x

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index a8763496aed3..9288f37a3cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -51,6 +51,12 @@ MODULE_FIRMWARE("amdgpu/sdma_7_0_1.bin");
 #define SDMA0_HYP_DEC_REG_END 0x589a
 #define SDMA1_HYP_DEC_REG_OFFSET 0x20
 
+/*define for compression field for sdma7*/
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_offset 0
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask   0x00000001
+#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift  16
+#define SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(x) (((x) & SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask) << SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift)
+
 static const struct amdgpu_hwip_reg_entry sdma_reg_list_7_0[] = {
 	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS_REG),
 	SOC15_REG_ENTRY_STR(GC, 0, regSDMA0_STATUS1_REG),
@@ -1724,7 +1730,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 				       uint64_t dst_offset,
 				       uint32_t byte_count)
 {
-	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_CONST_FILL);
+	ib->ptr[ib->length_dw++] = SDMA_PKT_CONSTANT_FILL_HEADER_OP(SDMA_OP_CONST_FILL) |
+		SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(1);
 	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = src_data;


