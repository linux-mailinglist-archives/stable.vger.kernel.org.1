Return-Path: <stable+bounces-144612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567AFAB9FB0
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93D339E1612
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD61A7264;
	Fri, 16 May 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iATgP8xV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5613C914
	for <stable@vger.kernel.org>; Fri, 16 May 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408391; cv=none; b=R9TvdhMJpjBK2mtHbn7E95+7+Pcuavl0v1h90dn/e2GZod199Q8t5gY+3xIBA06/ZPLpjncKIxqScv/LByKKEW+OMhJXSUunlTGHQ2nbWgM/WM2ptbtBoWZc28eCNlQRLGpBkfHyBzSUqhp3CZF7PoB45f0KuvwtayyZgii5dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408391; c=relaxed/simple;
	bh=9yBgYWd0EoYneOiWCTCsBxbED2biXmbdDdpQkyYVaKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VI1oDlEaQps+r5dbmAXboIrPj67u8poNbJ6O0lH2O5iBJsmkgJ0STRHlY0NJbZH0Mm79oQFNJs9l70q4cOTwU62YtrbytKqyCN0K8zvGT/hoUFH2IsPKq/09p4E+6g4bwx2g3e4TVQrxESS2Rwnwih8mxB5TcSZCfUZblGSE6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iATgP8xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD227C4CEE4;
	Fri, 16 May 2025 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408391;
	bh=9yBgYWd0EoYneOiWCTCsBxbED2biXmbdDdpQkyYVaKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iATgP8xVafRrVoFpoPFMqFKlppX0Rd48HziqYcJgW2xfgP+rE1VHghjj03cnKES51
	 8XiNdj18Lf5JansY2COHjQ+QW53zC6I33IS38Kw3c7Yv3LYp0MZEQviIDnrbwghqPj
	 ieX52WysxTEZGMXRvmisjLIeMJ1vOFAOnQMPPS67Z3o+xWlgBfn+JSPMJN0VGkiLoI
	 AH3D3+mrwR+UChybaURuqqIVSOy9a8IIRizld2mj0YAIIXFaAL4772dDF687Erbnt3
	 ey78rx2P+DDdBXQfkuordFjBHRQ1ltStjZShS2qo2kkkrG2dz7uBsSN5d/Sg9uih+t
	 heLi85aDkimdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] net/sched: flower: Fix chain template offload
Date: Fri, 16 May 2025 11:13:09 -0400
Message-Id: <20250515085258-9e47399a5686b651@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250515004905.3611889-1-jianqi.ren.cn@windriver.com>
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

Note: The patch differs from the upstream commit:
---
1:  32f2a0afa95fa ! 1:  a29e5c1218d0e net/sched: flower: Fix chain template offload
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
| stable/linux-5.15.y       |  Success    |  Success   |

