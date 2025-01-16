Return-Path: <stable+bounces-109191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7448A12FA4
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642F73A58F9
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB78C1E;
	Thu, 16 Jan 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm0CdiND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C3879EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987142; cv=none; b=qhq9Cp2EN0QGJOAJHxBesXRmHafJoAAd5Uq0/IEtBBaWGEDYlW6Sr9dgDOR2atvmTa7L1pF4t/vmuwBa1sWbHhY6IsmvGR+aQ4cfMCSHnVqNgY5LjaXnYvIHXj0xLK6uApL6JyNzo9N7nTok+E6UDOZoDaESGBaeBr+MHG9DCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987142; c=relaxed/simple;
	bh=g7FXtiw6O0iClaJodMoFC4sqrBnbHP3uA3u9b/yRxlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1/Wqq9oXN1vnMXDoRSQDNt3fDCzUJppd8vQTs8w4C5/wsWlKjmmQH46Y9a8KEut4RTsrbN+qvswDOtANTFmBB/rBt6KIcvBcgq0eBUT0BPmuo/otY7O0hPpxqYDL7qV69gpO0Z0H9SHookj1Nqt6LMNYAQHLCMGAAPU7a8IYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm0CdiND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C03C4CED1;
	Thu, 16 Jan 2025 00:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987142;
	bh=g7FXtiw6O0iClaJodMoFC4sqrBnbHP3uA3u9b/yRxlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm0CdiNDLh4ILUFBpIfeprXse+TlYqQnaXrMLiYTfnBX47bB/EH5TcPx0/N7sjBX5
	 v+B+p8q+qlZEcIhLRqyZNSGXH+oTC3zebj9epBgm3Tm/CIYIQT3Jw0BWq0HRHOsJob
	 w0M7Y7CCRGKXa1E64G+dbrbphic+TfPfI421rPYVYQDVvwfg6GYH1xxXMQ6mqZGWZD
	 k1vYBH4UkzLRKDhbKArUtS6jP/qU3a+IqPaXMpPQy7a+WXUFWlxz9bDdWkbBfbDnPY
	 +rplQp1OZoBCIZKEQAnqgAR7fU1jVccvW/+jpDUpZEI3cwrlIW1urCUtgga44+g9ys
	 fg1aiw7em2F9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 1/2] erofs: tidy up EROFS on-disk naming
Date: Wed, 15 Jan 2025 19:25:39 -0500
Message-Id: <20250115170236-e481ceed0a64fae7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115095048.2845612-1-hsiangkao@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: 1c7f49a76773bcf95d3c840cff6cd449114ddf56


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1c7f49a76773 ! 1:  d53a213aa414 erofs: tidy up EROFS on-disk naming
    @@ Metadata
      ## Commit message ##
         erofs: tidy up EROFS on-disk naming
     
    +    commit 1c7f49a76773bcf95d3c840cff6cd449114ddf56 upstream.
    +
          - Get rid of all "vle" (variable-length extents) expressions
            since they only expand overall name lengths unnecessarily;
          - Rename COMPRESSION_LEGACY to COMPRESSED_FULL;
    @@ Commit message
     
         No actual logical change.
     
    -    Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
         Reviewed-by: Yue Hu <huyue2@coolpad.com>
         Reviewed-by: Chao Yu <chao@kernel.org>
         Link: https://lore.kernel.org/r/20230331063149.25611-1-hsiangkao@linux.alibaba.com
    +    [ A backport dependency to resolve minor conflicts to fix CVE-2024-53234. ]
    +    Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
     
      ## fs/erofs/erofs_fs.h ##
     @@ fs/erofs/erofs_fs.h: struct erofs_super_block {
    @@ fs/erofs/zmap.c: static int legacy_load_cluster_from_disk(struct z_erofs_mapreco
     +		if (advise & Z_EROFS_LI_PARTIAL_REF)
      			m->partialref = true;
      		m->clusterofs = le16_to_cpu(di->di_clusterofs);
    - 		m->pblk = le32_to_cpu(di->di_u.blkaddr);
    + 		if (m->clusterofs >= 1 << vi->z_logical_clusterbits) {
     @@ fs/erofs/zmap.c: static int get_compacted_la_distance(unsigned int lclusterbits,
      		lo = decode_compactedbits(lclusterbits, lomask,
      					  in, encodebits * i, &type);
    @@ fs/erofs/zmap.c: static int z_erofs_do_map_blocks(struct inode *inode,
      			DBG_BUGON(1);
      			err = -EFSCORRUPTED;
     @@ fs/erofs/zmap.c: static int z_erofs_do_map_blocks(struct inode *inode,
    - 		else
    - 			map->m_algorithmformat =
    - 				Z_EROFS_COMPRESSION_SHIFTED;
    --	} else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
    -+	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
    - 		map->m_algorithmformat = vi->z_algorithmtype[1];
    + 			Z_EROFS_COMPRESSION_INTERLACED :
    + 			Z_EROFS_COMPRESSION_SHIFTED;
      	} else {
    - 		map->m_algorithmformat = vi->z_algorithmtype[0];
    +-		afmt = m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2 ?
    ++		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
    + 			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
    + 		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
    + 			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
     @@ fs/erofs/zmap.c: static int z_erofs_fill_inode_lazy(struct inode *inode)
      		err = -EFSCORRUPTED;
      		goto out_put_metabuf;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

