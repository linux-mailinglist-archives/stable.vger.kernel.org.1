Return-Path: <stable+bounces-110057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC3FA185D6
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8149A188B528
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6F1EB2F;
	Tue, 21 Jan 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km0i4XrR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85501F5433
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 19:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737489168; cv=none; b=T1gMaUdHhvo8Sr2MF1qn1ixPbNXntNqMXxXqzXJH/UjTb95Q2hT+G0aKFPWEg18xqOFuFh5X0xDCe8RYWaK4ibTWd+bofMKdrJXWAcdE114uPMx3VTsvT/V83HMRypKWw0WPxQpgrTKu4p2i6pLN0tTnvj2yGXqCFA3uxC2kTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737489168; c=relaxed/simple;
	bh=+C66HndbRXK1xTML5OjhcsYbFYOECk6/raWQvrf+jk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ko5Y/eYoYDRCSslEiicgEBEq2Xxu5D8ZDxyMhclrMQLTVFwslJSutfhjhB0RUFNylUq10f9v9wqQvgRwmuQm3g9myPyeQIx6NBNVgAdPAkDSJplc2QpBjVE4Khw3gcj2ki1Bm8amrno/Hic0DVNxf/WtVbdSzzDS4d7eV5L7wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km0i4XrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A07CC4CEDF;
	Tue, 21 Jan 2025 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737489168;
	bh=+C66HndbRXK1xTML5OjhcsYbFYOECk6/raWQvrf+jk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=km0i4XrR8zD01YQOUcIee4j+J4QoacetVtsUVK8RZWGUF+nU4nQcMLwlc3lZNTk6W
	 kWSUSpYF9vzryAL2NLSnmKtNucRTgtGffCxc5TKo+jAlZBU55rdKhhxsrkBqywoPma
	 GwsYemKzb7AKrji4ZykQTpcOg07u/E8p5NCQq00g1QL+Nec7BCNrPykD/9V7q/foZU
	 pFH0sD9SMPAVKuhQxn9EulcApG+2zKDL39Aw3cjjol5pm0a4Gnt+SEuLcERMuA/Zp3
	 FQwjYEABbYa4vEofVl+ztjPEPrxxlaaD7KwzdfElsYL6VWGR4skRqGXpk02md/Rarq
	 fVuhJUWD6Sh6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: hsimeliere.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Tue, 21 Jan 2025 14:52:46 -0500
Message-Id: <20250121133855-c1edccd951a9d2e3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250121154117.205334-1-hsimeliere.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 28ead3eaabc16ecc907cfb71876da028080f6356

WARNING: Author mismatch between patch and upstream commit:
Backport author: hsimeliere.opensource@witekio.com
Commit author: Xu Kuohai<xukuohai@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 5d5e3b4cbe8e)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  28ead3eaabc16 ! 1:  d2cd989f36650 bpf: Prevent tail call between progs attached to different hooks
    @@ Metadata
      ## Commit message ##
         bpf: Prevent tail call between progs attached to different hooks
     
    +    [ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]
    +
         bpf progs can be attached to kernel functions, and the attached functions
         can take different parameters or return different return values. If
         prog attached to one kernel function tail calls prog attached to another
    @@ Commit message
         Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
    +    [ Deletion of the patch line on the condition using bpf_prog_is_dev_bound as
    +     it was added by commit 3d76a4d3d4e591af3e789698affaad88a5a8e8ab which is not
    +     present in version 6.1 ]
    +    Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
    +    Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
     
      ## include/linux/bpf.h ##
     @@ include/linux/bpf.h: struct bpf_map {
    @@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
      
      	if (fp->kprobe_override)
      		return false;
    -@@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
    - 	 * in the case of devmap and cpumap). Until device checks
    - 	 * are implemented, prohibit adding dev-bound programs to program maps.
    - 	 */
    --	if (bpf_prog_is_dev_bound(fp->aux))
    -+	if (bpf_prog_is_dev_bound(aux))
    - 		return false;
    - 
    - 	spin_lock(&map->owner.lock);
     @@ kernel/bpf/core.c: bool bpf_prog_map_compatible(struct bpf_map *map,
      		 */
      		map->owner.type  = prog_type;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

