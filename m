Return-Path: <stable+bounces-135189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B33FA975DF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD9B17ABD3D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0822284B21;
	Tue, 22 Apr 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Wn1wdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E41E5713
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351168; cv=none; b=PNwG/T8irg/63Ztfjv8iuBEaFqfxem0dcI2cwkjuwZEvoP9QFgzrEIvuHvdqkO9I0sRyBXjr1zJjqBXzJQbxp/iIe3yLB5r8i5au2LAfuouKAi2Al9mzMg5DIF2z1w5zoSfoxGaSV5rNxbODbcrPlpb8fUGfAAVMsW3o08GxnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351168; c=relaxed/simple;
	bh=5Q4ehjK213ak1his9d9acSiMs9IJgPuZGorLO/3KujE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOK99pe2kGP/bZEh1o7r5VzCMPes5pOu98k464GVaaSKrDLC5JVhRR7y98rwjQOETdKeipUkndHhlPl3eqjZ7CJMr5EiRrKrLFBYQxShkh+wmekkRjPeT/HHuylBFN0FAZ9sXOcW2a0c6ltfl0wByeXkoqH8Nyk2g32CZdD1EzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Wn1wdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE44C4CEE9;
	Tue, 22 Apr 2025 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351168;
	bh=5Q4ehjK213ak1his9d9acSiMs9IJgPuZGorLO/3KujE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3Wn1wdkT5JHULR83sD7/YJoWpnwabxTWCrK2gzO1rTMwYGlUiZ2LtyK8zwVPXTOh
	 cceV9dqqH7zUCedna0o0863aN0kXZzjLRjIGOcJQOmUQCOEpID0RX556f1sKWUuiLK
	 +qbx3KCQUp5fP6CiUTg4QWaMf0b4F2+3xHksaVB/EpC/g61N466dIT9LC0sQRp6lXr
	 NDwHPGDk7KqUwx2AdkJp6spZ4kBrRAXjhZI+y/Dd3ZWAjClx2XM2GwP8GTojMioMZ8
	 dkXFQXOuv+ItaoUq2/RDrXHt+8V6XcnWEZF1ufl2gwNUhY6Rb8823g0fW9p4zOCy0o
	 I0+m5jjjVaS0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4/5.10] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 15:46:05 -0400
Message-Id: <20250422125255-a1c6fed2f6b4e83e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <E2B130726D65F768+20250422084611.103321-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1b304c006b0fb ! 1:  e6a49ace3b0d5 nvmet-fc: Remove unused functions
    @@ Metadata
      ## Commit message ##
         nvmet-fc: Remove unused functions
     
    +    [ Upstream commit 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c ]
    +
         The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
         unutilized.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

