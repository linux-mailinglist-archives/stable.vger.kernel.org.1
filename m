Return-Path: <stable+bounces-124711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A5A658FC
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F017D19A2C69
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E761209F5E;
	Mon, 17 Mar 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgZYsCTM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB03209F54
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229613; cv=none; b=daMSHY40Eggn+HbWMQ1U4AAQbwBgJM1dmcEE7PDkea3rS1qhsncRKGoU1HbF06e+d23uEdUYJwYozVVWJXdrRyBSph663UlfO+HSwlsEDMHkjs9D65M9r6h7iAKqzyT+3hhFfuXIywIgNgHONFDhJvh233+gIXIQlUR5alVXaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229613; c=relaxed/simple;
	bh=cUhGBkfoCQaIfARUmuImbJz0OPf0IQdxiFSD+iJFi6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKYmOj6LUt9wT7az204htMNvvxZ3ljjQ2NPjgoR5ZBshLwU2dN2aFNuRT+pJx3x//9zORFua/7VCYxq1UqhjKkY61g7AJGsV4AwRIug5QhFKavxdkNDZkY4LNp5P6DjytIEeJBvDxWvnv2xKU1pN/lh7vTo3yZQ43jiFC5fQ+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgZYsCTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A8C4CEEC;
	Mon, 17 Mar 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229612;
	bh=cUhGBkfoCQaIfARUmuImbJz0OPf0IQdxiFSD+iJFi6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgZYsCTM9yIDRr10ZcVamXZNydCOAMleAb6zkNZvuDsKfzBMKtp1JMDWX4/fqSbsi
	 mJhhrb6utOxg51pADwButodK3lffPn18ILIZmO4XLt+4mcBUJzGYPl+Eeq3DwCZPJp
	 Dtf9RfkvmjyMsAHVm/u6txnB4mmT8s6WnI65XqyR5s6mW/3qUyR64O9l3BifEm4f03
	 eB+LYOj5dof6ziHhTtjqirUFMLbH1m0Pf8Wxa2GlUeOhbHiBtgSgq832T8iKIItqox
	 dxq/s1/JzkyA75T9jNYYmmvcom036ud5nSd/usGbdFrAIV6+LYgajRurtQ/h5lu77I
	 xTecI1bVKQUMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	songmuchun@bytedance.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] block: fix missing dispatching request when queue is started or unquiesced
Date: Mon, 17 Mar 2025 12:40:10 -0400
Message-Id: <20250317093129-b12d4b529eda4b6a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317071821.22449-1-songmuchun@bytedance.com>
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

Found matching upstream commit: 2003ee8a9aa14d766b06088156978d53c2e9be3d

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 8b25c0a165dd)
6.6.y | Present (different SHA1: fe0d9800ead6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2003ee8a9aa14 < -:  ------------- block: fix missing dispatching request when queue is started or unquiesced
-:  ------------- > 1:  78009b03feb87 block: fix missing dispatching request when queue is started or unquiesced
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

