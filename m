Return-Path: <stable+bounces-139364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE11FAA637B
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12BF1BA7234
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913C224AE1;
	Thu,  1 May 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo64JNte"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD269215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126573; cv=none; b=PVJi+xhvw/znuKXH4s/vVxtzyjH9cT4j6axRyEOPUfo4R5tCj1lJMkGSCQw33s2tXPX5s4a/GHSbS1fY1//s9XeT51GwWX5U0F7pmS5fRKc4Tw4GQ/eDzDozcB82G3CZJlObycQFvV23gECzE53k3sjxX8R3i1WSGcF4zi204CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126573; c=relaxed/simple;
	bh=iTahMr5zkQOW2qCM4b+tnGfaB2uhM69cFspQFDLpDCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlejOIYbaGl1IVALtn65MVERDQfGCD2KAsN5SS671DYAN5yRKFWJ+qnd5i149yQ6eNLVQ17tmlIj2C6/5WME6BV3j/0RLklLQ9C3I2yznHOUshVWS7/qraoomVm5h2QmBwBZs8TJQvDCyMJSNkVVVg2HwNI32mxeWSQyP3UqgT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo64JNte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0719C4CEE3;
	Thu,  1 May 2025 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126573;
	bh=iTahMr5zkQOW2qCM4b+tnGfaB2uhM69cFspQFDLpDCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uo64JNteogRFI4lq+NpDjZouw0KBiwd4OmwyEk9CylWp4YsY4rULN4NKYenOBb4zW
	 NTSycp8EfwkwIM0iqcJzsq2DyWTAM1OGv3XjQeSypxgv+Z9PbcQqOL944cLsjmv1ID
	 hdSZGTjPi9ZIRSd8hgWi/8IoY/2LtGIWN6a3Gdv4y9IrKx8SB6Vyf61nf7Xx+ghyFW
	 WatrSVKBiioBQPU7+bGAS6bEa6fTora1V/jqDj7E3s8295/SQsPJLZk62VzMX1kJNU
	 mhvUPQvKdLlX/bgh1Hd5tUuqyAs8mlPZ7bQvPy4lEOV8aqqDHnAefD4FnoUy+ABKTk
	 qH31PO126IXPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 05/16] xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
Date: Thu,  1 May 2025 15:09:29 -0400
Message-Id: <20250501123725-3f7730266aefb5be@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-6-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: ad206ae50eca62836c5460ab5bbf2a6c59a268e7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0934046e3392)

Note: The patch differs from the upstream commit:
---
1:  ad206ae50eca6 ! 1:  6bab668a662e3 xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
    @@ Metadata
      ## Commit message ##
         xfs: check opcode and iovec count match in xlog_recover_attri_commit_pass2
     
    +    [ Upstream commit ad206ae50eca62836c5460ab5bbf2a6c59a268e7 ]
    +
         Check that the number of recovered log iovecs is what is expected for
         the xattri opcode is expecting.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_attr_item.c ##
     @@ fs/xfs/xfs_attr_item.c: xlog_recover_attri_commit_pass2(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

