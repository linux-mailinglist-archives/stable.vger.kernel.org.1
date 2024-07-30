Return-Path: <stable+bounces-63409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D473941999
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B52B2B5B0
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141CD188012;
	Tue, 30 Jul 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rlA2qEhw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524D1A6190;
	Tue, 30 Jul 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356742; cv=none; b=fqpeY89fSLohHEG/QA4hHPvsQi9+L3/CFwD09scC/dGaIAJg4pX9T1H+QMFk2OMc0BlFLs5fQQrmQKgxmOCFWbOYdMvQemDXGwdEqJblUqy/XA4OqQfEW57qnWYQbaYCr1r6PGV/bzyL9hZwdxNpOIPS1p3UcanU7/zl9C05/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356742; c=relaxed/simple;
	bh=4Khfnr7kp8pvYW8cm7dOpR5ZpqBY5LIbT7J/TJouhpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkdGVlw3d5GJzdWb+kCQUgorF1MH5iGzwM0MlQDiCDO+/hdkPz10/c4QNCtnnH0rwpb23jeTDjzA9zDRq0lMrqPhyCbJsFxN5d+CnKXw7hl8OLfQM8dRyIEwv2gXiDM110ZNCY/ouK/liIMnF/6Sq3kC3ZfbwVSA4JZwHFVlYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rlA2qEhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A54AC32782;
	Tue, 30 Jul 2024 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356742;
	bh=4Khfnr7kp8pvYW8cm7dOpR5ZpqBY5LIbT7J/TJouhpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlA2qEhwf+4BVFnzF6NPCrO4emnz5ey+4F+KXSBEbA8MBVznldzN3a8ANNNo4GM1P
	 URZ6LoTlF3TXnpn5tiBfsc9iug2h898udY6bJEJ7qq1T726BF3XKE0AQaTwc6M6NTN
	 StgrPDofcQ6wVeHHoSRvjTWDmfEqAgbgCjbZ120s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 224/440] RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
Date: Tue, 30 Jul 2024 17:47:37 +0200
Message-ID: <20240730151624.609490631@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 24c6291346d98c7ece4f4bfeb5733bec1d6c7b4f ]

A shift-out-bounds may occur, if the max_inline_data has not been set.

The related log:
UBSAN: shift-out-of-bounds in kernel/include/linux/log2.h:57:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
Call trace:
 dump_backtrace+0xb0/0x118
 show_stack+0x20/0x38
 dump_stack_lvl+0xbc/0x120
 dump_stack+0x1c/0x28
 __ubsan_handle_shift_out_of_bounds+0x104/0x240
 set_ext_sge_param+0x40c/0x420 [hns_roce_hw_v2]
 hns_roce_create_qp+0xf48/0x1c40 [hns_roce_hw_v2]
 create_qp.part.0+0x294/0x3c0
 ib_create_qp_kernel+0x7c/0x150
 create_mad_qp+0x11c/0x1e0
 ib_mad_init_device+0x834/0xc88
 add_client_context+0x248/0x318
 enable_device_and_get+0x158/0x280
 ib_register_device+0x4ac/0x610
 hns_roce_init+0x890/0xf98 [hns_roce_hw_v2]
 __hns_roce_hw_v2_init_instance+0x398/0x720 [hns_roce_hw_v2]
 hns_roce_hw_v2_init_instance+0x108/0x1e0 [hns_roce_hw_v2]
 hclge_init_roce_client_instance+0x1a0/0x358 [hclge]
 hclge_init_client_instance+0xa0/0x508 [hclge]
 hnae3_register_client+0x18c/0x210 [hnae3]
 hns_roce_hw_v2_init+0x28/0xff8 [hns_roce_hw_v2]
 do_one_initcall+0xe0/0x510
 do_init_module+0x110/0x370
 load_module+0x2c6c/0x2f20
 init_module_from_file+0xe0/0x140
 idempotent_init_module+0x24c/0x350
 __arm64_sys_finit_module+0x88/0xf8
 invoke_syscall+0x68/0x1a0
 el0_svc_common.constprop.0+0x11c/0x150
 do_el0_svc+0x38/0x50
 el0_svc+0x50/0xa0
 el0t_64_sync_handler+0xc0/0xc8
 el0t_64_sync+0x1a4/0x1a8

Fixes: 0c5e259b06a8 ("RDMA/hns: Fix incorrect sge nums calculation")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://lore.kernel.org/r/20240710133705.896445-6-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 7b79e6b3f3baa..c97b5dba17728 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -538,13 +538,15 @@ static unsigned int get_sge_num_from_max_inl_data(bool is_ud_or_gsi,
 {
 	unsigned int inline_sge;
 
-	inline_sge = roundup_pow_of_two(max_inline_data) / HNS_ROCE_SGE_SIZE;
+	if (!max_inline_data)
+		return 0;
 
 	/*
 	 * if max_inline_data less than
 	 * HNS_ROCE_SGE_IN_WQE * HNS_ROCE_SGE_SIZE,
 	 * In addition to ud's mode, no need to extend sge.
 	 */
+	inline_sge = roundup_pow_of_two(max_inline_data) / HNS_ROCE_SGE_SIZE;
 	if (!is_ud_or_gsi && inline_sge <= HNS_ROCE_SGE_IN_WQE)
 		inline_sge = 0;
 
-- 
2.43.0




