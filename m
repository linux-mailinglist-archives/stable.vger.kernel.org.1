Return-Path: <stable+bounces-144610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B5AB9FA0
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4AD16F931
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAC31ACEDF;
	Fri, 16 May 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmBmvK0h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072139ACC
	for <stable@vger.kernel.org>; Fri, 16 May 2025 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408388; cv=none; b=JvlxTs1rvNVNA0Osd6PwacSoCfCgaobqhe7JzGU2Zj+jOhDPFQ6GxYTbtat2B44yS5mZIj1B6X3FkhEuCDJMAK8YPpom+dh8vSHoHEoCnJty0f46ltNNorigDum8bNcTaSpCM7/4gZ06lfI4iVr3zA40DLWjDQa1DjT7L5KnL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408388; c=relaxed/simple;
	bh=J5XeLLnnXbl3g18yVwFiV0kKRyNxf+Lv2gCiqBEaCmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twrqhDnEKl7/K8NUvSXuHel51biIrrLepD9XFJUfdr/hTfNhda3KE4Ze/ropZvzScJOw2Cq+zrbTxniivtkDd7HCwxCfoMPvff1Zxe4wMUslSg7TiX8FWIpw8t5A63eOVPHyvzBa6qIlmbRGBGqXdUlzu8+ytWlCtzav0tU+Ado=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmBmvK0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B5C4CEE4;
	Fri, 16 May 2025 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408387;
	bh=J5XeLLnnXbl3g18yVwFiV0kKRyNxf+Lv2gCiqBEaCmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tmBmvK0hgmt0Vz+kPDBXaEh6JETuw26wjKTYqhLwFCJZdNOELMtEBJpLNQvCpncHP
	 rp6gkMRXiPIlfV6G3i1pA6n5Ntfxmb339+Vj9izlPB8yTzSO8ZqGrax90uUDjC4seE
	 Y64J9as0EPgxWV0I3gHwXdgpwq5BiTd8mtMEA9ZSMBbqIlsWqP7aU7IsBPlKTf3XfF
	 T2SmkBi0XuwaqXaLVa3tBkKbP2R+uTjB+jE2TsNgjDD2Xu9FdocpyQDrYv+X8m1UAu
	 nl4UIU6JUhhFfDTarXHKFdz9e+tSy0lkdHO2C7vjdsYyjY2UOEihMs3OBPBwcOo9xR
	 No/8qZSINQv8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] net/sched: flower: Fix chain template offload
Date: Fri, 16 May 2025 11:13:05 -0400
Message-Id: <20250515083015-2d7c5760fac68030@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515004913.3611901-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 32f2a0afa95fae0d1ceec2ff06e0e816939964b8

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Ido Schimmel<idosch@nvidia.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9ed46144cff3)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  32f2a0afa95fa ! 1:  53af17da4857d net/sched: flower: Fix chain template offload
    @@ Metadata
      ## Commit message ##
         net/sched: flower: Fix chain template offload
     
    +    [ Upstream commit 32f2a0afa95fae0d1ceec2ff06e0e816939964b8 ]
    +
         When a qdisc is deleted from a net device the stack instructs the
         underlying driver to remove its flow offload callback from the
         associated filter block using the 'FLOW_BLOCK_UNBIND' command. The stack
    @@ Commit message
         Fixes: bbf73830cd48 ("net: sched: traverse chains in block with tcf_get_next_chain()")
         Signed-off-by: Ido Schimmel <idosch@nvidia.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    [Minor conflict resolved due to code context change.]
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## include/net/sch_generic.h ##
     @@ include/net/sch_generic.h: struct tcf_proto_ops {
    @@ include/net/sch_generic.h: struct tcf_proto_ops {
     +						   bool add,
     +						   flow_setup_cb_t *cb,
     +						   void *cb_priv);
    - 	struct tcf_exts *	(*get_exts)(const struct tcf_proto *tp,
    - 					    u32 handle);
      
    + 	/* rtnetlink specific */
    + 	int			(*dump)(struct net*, struct tcf_proto*, void *,
     
      ## net/sched/cls_api.c ##
     @@ net/sched/cls_api.c: tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
    @@ net/sched/cls_flower.c: static struct tcf_proto_ops cls_fl_ops __read_mostly = {
      	.tmplt_destroy	= fl_tmplt_destroy,
     +	.tmplt_reoffload = fl_tmplt_reoffload,
      	.tmplt_dump	= fl_tmplt_dump,
    - 	.get_exts	= fl_get_exts,
      	.owner		= THIS_MODULE,
    + 	.flags		= TCF_PROTO_OPS_DOIT_UNLOCKED,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

