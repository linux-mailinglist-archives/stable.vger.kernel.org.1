Return-Path: <stable+bounces-124821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BCCA67760
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E313B940E
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F0D20E021;
	Tue, 18 Mar 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCdpe6Tt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1977B20A5E5
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310773; cv=none; b=cp6X3lrGUvwoLt/uFLgE+rvWS/xVjwF4Q8zi90n5gePqcstqbsoKBfeKOsiPAj5bc0XO2xR9W8Nhgu07naQbNalPReFP01U3AIuurXQAidjPSySylesTATXb1awJTk/MQM/V166uxZiHL1mTRtfxmkGYcYH1KviQSDrqIYn7UuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310773; c=relaxed/simple;
	bh=HOQUOGVdnRrMXUnP2CR4Wgau7DjpUdvs7IFOF+16LZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLm6uNdmctxckX/hrbZCvmh2/CUbNZTOe/fuDsiexhOjL/exVSpSSKOpZHFUhEgKirkBcFggF2RI8x2YuxOMTF98g0MaPHjmA3o06XmOMRW/+Rb+/SQRrZ7vdUawIP/jm3oWHK9ZVw/Imd8+B0GfLfuEMwHmgQ2rLdz/VcpiRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCdpe6Tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB5BC4CEDD;
	Tue, 18 Mar 2025 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310772;
	bh=HOQUOGVdnRrMXUnP2CR4Wgau7DjpUdvs7IFOF+16LZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aCdpe6Ttb3RvwQiQGrZahpD5vpNNVzz9W/xvP9WHTORk9KCI0Xb1zIgTm/u7wqsBu
	 LbM0eHrFMcLewYWSb87fuM5/BfWxiiPB5UxmRbwsLF2U7/zwCON1SN62T6VLnkfKui
	 bKMi3IehJ6sbhA/rqGUZLX7FbSMxSYQI0qnsM/3mw+MiNITAttAkJXeuA4pHL3tgo3
	 FD7rJ08VBEZMdw7QmvozQXWj2TaY+jWrlc/5pM8l5Ui/onFum4HakngFJmcVmq0mxp
	 AUiHyKyi1oVHN0FRTWoYrWh33iyb52UBlYNKu2ZDehWU5mdlrjuc2HmELHvM7NlyDt
	 XJ6Xb8R+/D8Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 2/3] sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
Date: Tue, 18 Mar 2025 11:12:50 -0400
Message-Id: <20250318075613-9985345a4a7f332b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318105308.2160738-3-chenhuacai@loongson.cn>
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
ℹ️ This is part 2/3 of a series
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 467d60eddf55588add232feda325da7215ddaf30

WARNING: Author mismatch between patch and found commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  467d60eddf555 ! 1:  93774cf75460f sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## certs/extract-cert.c ##
     @@ certs/extract-cert.c: int main(int argc, char **argv)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

