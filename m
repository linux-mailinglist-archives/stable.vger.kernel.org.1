Return-Path: <stable+bounces-134699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5100EA94343
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C717E925
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633A1D5CE8;
	Sat, 19 Apr 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm1L+sxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544A1A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063433; cv=none; b=i8HszD5JsEMLalLSEYMHKmRH4cSRpvZJKVQQbU13qlL/MOJHHbEl0N74hrhl3Wt90j+0a4QPc5iKYCbhaawMAT5rmetkvmkle3rSBVn9ELnOEIUQJUsZlwHOVprD/Fl1wrbPOie46hS9tfOf4I8K3Ey4TP6LB3XM0WIhrrEoO+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063433; c=relaxed/simple;
	bh=louEZ3ex7SgIh8F4Egj+jkiiBU824RIGfpFe6FtJ4rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRmFKWcrxsk9kWamkyFbwzl+qJN9i2AHclsydL58fU3UlRj28VITRp+ddRVT8Ilec5sohG9CrGn0xMxG63/JGuxz7/AgHhqAIRBD3mbtSzaTekq7VD2HnncQPDxnnCk3IGR8LCprm1OsZLmaDJuCNqZAEm8opRiP+kp7tG5CUGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm1L+sxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC82C4CEE7;
	Sat, 19 Apr 2025 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063433;
	bh=louEZ3ex7SgIh8F4Egj+jkiiBU824RIGfpFe6FtJ4rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zm1L+sxUp8CW3k6QMmqK0QH0ygc4846DcRmsrSqU+MUE1urZTBMx+GIKHbWFnTHLZ
	 Yf4UnDCmq+sjVDtzpMYTcU7qYruiNF34RpZL83KaDguRpMoeVrmqsIZPe5kYrai44l
	 xcFwfqzxFezAymPhd01TYOBbclUQ4cfdU49JrNb4TLJda+4iBSIzQL6v9FIaOnGpBG
	 He97FCgTWD8TDsqcnw5rWCnXW7F3OA62JRXC5tpNLo+oxXYE7A68UcFLsCkxRtWoF/
	 Md3Bqu4GS3gyl2GwBSAqCtf4k9Orh3x8LCn2xhwFUDfxFqYPwTBqqgLfLVk3yNUr86
	 Qeu5zsIjjDDsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:50:31 -0400
Message-Id: <20250418191747-56a9b91648f8585a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124457.2046169-1-hayashi.kunihiko@socionext.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: baaef0a274cfb75f9b50eab3ef93205e604f662c

Status in newer kernel trees:
6.14.y | Present (different SHA1: 30ade0da493e)
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  b4b5ddd897b33 misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

