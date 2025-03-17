Return-Path: <stable+bounces-124717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC5A6590B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78CBB1893469
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3A20AF62;
	Mon, 17 Mar 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZMtjsM4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810B20ADF9
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229622; cv=none; b=aiwFv4tP6lQWTTifgBdX8hsHCT0lBxMd8uISTkdoALrbRuVryiS6VYDAoSyWCtX3X98oLNYJ0fDxJr2NaS9epYXJ6vTo6TKwadSFuSW3Yb4PKmIz+p2jnPNBdOlRFpnY3S50MEpAcDdH2D/Bgv12vQI1mxpXWuzExE1ueJEMDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229622; c=relaxed/simple;
	bh=sUbyPKqZR65uWfj/t6Iq6mchZWm5L/RM/jxiGwNXkQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNcMagL/PmnjlBvSFRVL6bfNZ2CAcYdBp7cg/5bLwdvNFsPN0tt7SQpXbF0cwOJqggjYnuzIFiQ3e25PmzERFIJNLCkZK4evjpDvcJxBzf73MAemeycySkN52gJD0gHLv3mMnnjix7ZTXneQxzlSFcxcVHiWGV3XyClpjq7V1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZMtjsM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AEDC4CEF3;
	Mon, 17 Mar 2025 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229621;
	bh=sUbyPKqZR65uWfj/t6Iq6mchZWm5L/RM/jxiGwNXkQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZMtjsM445eQYERttyPFGW0iKEAhCcAFkQF/fVCcuvHxQlDEArHn2Ota9fkk7l8ju
	 xdmWkNjgaxegdmKBU6TV/uVqvrdt5HEZ4HvGkhHgl3A7a11hrjXvghIj6emUHQUVk4
	 fbxPnMkJZg5cCOXZd24AtTmUNw6FU1OUH73goeQE5G1yhODrCm/5/g2TcshA13CFHe
	 3SEVClKJPmg41W5PlYq9Ym8L15BBVUfi9+DFkkWbcBbbTPNcyWg79YkiGSYyuW6q58
	 o5tIFdoFIxCFf02BZM3g6Y1aeeJzVgn+OuaiUw8oeqk1sxh1MO4QTDEgsdfeIsxYlU
	 cjFX0hBurkZgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 v2] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Mon, 17 Mar 2025 12:40:19 -0400
Message-Id: <20250317093541-108f75d914a6d87b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <C20998946B822F0F+20250317011339.119224-3-chenlinxuan@deepin.org>
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

The upstream commit SHA1 provided is correct: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a230a1bf75ae)
6.1.y | Present (different SHA1: a22c1b6f88dc)

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc ! 1:  6848f1e0a3cdb lib/buildid: Handle memfd_secret() files in build_id_parse()
    @@
      ## Metadata ##
    -Author: Andrii Nakryiko <andrii@kernel.org>
    +Author: Chen Linxuan <chenlinxuan@deepin.org>
     
      ## Commit message ##
         lib/buildid: Handle memfd_secret() files in build_id_parse()
     
    +    [ Upstream commit 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f ]
    +
         >From memfd_secret(2) manpage:
     
           The memory areas backing the file created with memfd_secret(2) are
    @@ Commit message
         Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
         Link: https://lore.kernel.org/bpf/20241017175431.6183-A-hca@linux.ibm.com
         Link: https://lore.kernel.org/bpf/20241017174713.2157873-1-andrii@kernel.org
    +    [ Chen Linxuan: backport same logic without folio-based changes ]
    +    Cc: stable@vger.kernel.org
    +    Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
    +    Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
     
      ## lib/buildid.c ##
     @@
    @@ lib/buildid.c
      
      #define BUILD_ID 3
      
    -@@ lib/buildid.c: static int freader_get_folio(struct freader *r, loff_t file_off)
    - 
    - 	freader_put_folio(r);
    +@@ lib/buildid.c: int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
    + 	if (!vma->vm_file)
    + 		return -EINVAL;
      
    -+	/* reject secretmem folios created with memfd_secret() */
    -+	if (secretmem_mapping(r->file->f_mapping))
    ++	/* reject secretmem */
    ++	if (vma_is_secretmem(vma))
     +		return -EFAULT;
     +
    - 	r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
    - 
    - 	/* if sleeping is allowed, wait for the page, if necessary */
    + 	page = find_get_page(vma->vm_file->f_mapping, 0);
    + 	if (!page)
    + 		return -EFAULT;	/* page not mapped */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

