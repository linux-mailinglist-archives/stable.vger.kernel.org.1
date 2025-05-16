Return-Path: <stable+bounces-144613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829FDAB9FAA
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881F518848C7
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ADC1A5BAE;
	Fri, 16 May 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OguDdDcV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E84839ACC
	for <stable@vger.kernel.org>; Fri, 16 May 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408393; cv=none; b=ZbOBeO3+TH/o4xBlUxHExTXzr8gZu9h7i67Z0E5ijaYSeb5HiLNVSw35n/OTI5oE7OVCRyWuKNXqLQ0pLCqvSTxS2B7UTStSNp9pP8om+mdSkZHrxJuoU7J51x2D6/iz8B3igkI5krlesumw9XSiOIaLPFPTfegMtXdYhEdylcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408393; c=relaxed/simple;
	bh=Luql5Bc70t7G8WkEKA3NfNmKSGf8ChIKR2aidSKUjKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esU/ks6wt0qVxh/V38I5EnyLEj/IFdUdhS+9MHDFrUt9TLIAif1YYxXDKBNDN8i3DDgP+/kS0mqD8XJdl51Xbm7duVDbO5rakuVtam2qcBgXW0UIW9+F6Vr4RHiZpGc6bvtaGj38hxLk6NPV+aPlWiueZmAsxbyCGexPZavsFUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OguDdDcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C39C4CEE4;
	Fri, 16 May 2025 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408393;
	bh=Luql5Bc70t7G8WkEKA3NfNmKSGf8ChIKR2aidSKUjKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OguDdDcVfEAkF0SMuCbZy5SUb5pNXvLFqiSrcp1ztwXYDpz13EmIzSRmI4LsIERKZ
	 03xY6tt9t6MiM4XALwjSBcmXgToY/2i6G1Z82rFdE9WResPBVV9b75qQXNjkWM2t3d
	 +7PHtFXbIdDuoqjvqS5/J5o4LNQyb7pwb4AODQALlz+S2k33s5wzZHlHHpMf8BB8nI
	 PcXd9p57ScBKQQIgk5p81h2VK0QgyTUiujMEmsfiHGrFlSZS7efYFhI7D4aAGapoEE
	 Akz9jToqhrtE8QJ1glBPHGI0WD/ovuoPTF1/DGKk3GbQVKBdMmsOWLIBqC2d0f9C5W
	 OwAV89kTgrc4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net/sched: flower: Fix chain template offload
Date: Fri, 16 May 2025 11:13:11 -0400
Message-Id: <20250515091603-b5920fdd27662a9c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515004850.3611876-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  32f2a0afa95fa ! 1:  0a537109451b8 net/sched: flower: Fix chain template offload
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
| stable/linux-6.1.y        |  Success    |  Success   |

