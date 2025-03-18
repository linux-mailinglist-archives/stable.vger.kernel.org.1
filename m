Return-Path: <stable+bounces-124826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3172A6777D
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6687919A5C9E
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6420E702;
	Tue, 18 Mar 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACjAQ428"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066D1586C8
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310783; cv=none; b=NuVRsZIkLI2csjacTcM0fqOA3D6tI0tUvc0Y7Rm+jSjTWW6RgZbqG/bGnmC0mN46gApyRrrICkm0C+h2/uoFWIrS/Uu5xIEfRwMZuyEE9ztkKZ1jczt5QZZUgVOa9qjXKEHCuj0I+/gaet+lSW8jaA0snC8eyxxo9O/ih2dqjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310783; c=relaxed/simple;
	bh=Q56vHb/ud5ItQfH9x5AgIBnLCFfHs71vkdtf1H8bXfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvHQpN8hTWw/+DoGv6Xhz01G6pKf8ggWZHU+Q4UWfHmv2/LRaYa6HG5cwRbz+LU6rSiousHNfNFvZsWWVFM4AeP+IhiE+7SFXamAQZXbBbKxKSMDV9sS1uV4j5zwmuoEoEhJpCm0pJ1yEIWQcmApj/FZXEUGQ3lIJKlTs7fkaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACjAQ428; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C734C4CEDD;
	Tue, 18 Mar 2025 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310782;
	bh=Q56vHb/ud5ItQfH9x5AgIBnLCFfHs71vkdtf1H8bXfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACjAQ4282yaWkGEZzd+4K8EWuu0WJ/i1X1O3/3EEP6brOb+mqA3Z0kapMxUUUpvFi
	 WbksW13uV9YdhPXicKWzXchCVxLniH3hBURb8XJlthFH0uhg5x7Kak1qSqIxVSjwJq
	 b++2MPowXlyw3SByk1P7iDCbPjjTdzoovr2VvNqKRV7Z7ltAJxN8XFkVRDVZvcZsIe
	 Z921huH+iZ29PWydwb5TllPtL8SL5MMJXW2UH0SjceHcW8LW6d5hKYvzWhfX02GyUT
	 f2eiz91CCa3PwQ6vKu0nOxySFZjxsFdg5XxDEQ8zwHUH5GKvfVoZhhGq9P2ssJSJ5X
	 9ro+GrTf2u/Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 1/3] sign-file,extract-cert: move common SSL helper functions to a header
Date: Tue, 18 Mar 2025 11:13:01 -0400
Message-Id: <20250318074754-5b4ba3b2d09516b3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318105308.2160738-2-chenhuacai@loongson.cn>
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

Found matching upstream commit: 300e6d4116f956b035281ec94297dc4dc8d4e1d3

WARNING: Author mismatch between patch and found commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  300e6d4116f95 ! 1:  fcefe79724945 sign-file,extract-cert: move common SSL helper functions to a header
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: S:	Maintained
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

