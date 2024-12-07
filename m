Return-Path: <stable+bounces-100025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9269E7DF8
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B741916C6A9
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02D17758;
	Sat,  7 Dec 2024 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SynSeXrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DCF9DD
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537236; cv=none; b=reEED2+toU/lWP72DU4M3WKM+jzrPLKhhitRTM31xg2nXMob+Dn25cvVup6cRP7ByBi3+MmQROpIJrOdlvb2KwGNGjvIK7AP5EZwMXuN7Ii8dNcSxvPoB8x+RCvicxa5tsZnXHE9G1xgYQD8k6wGgEmphfvrUfVkwURuTiFDn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537236; c=relaxed/simple;
	bh=xQsXk2cEQ+38hRSclxDq0K31PjaNyYs26xWnONDJ35o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wq2t/GyWuhwdiZV0FL63Xt7DluGXs4kXo2dxcgWY8yVb6Bm0J16I9Tjjp4aO4UEVOH1uLMIysR4kwGnPqn3I/Cblma1FGQ0uzyr6IWuHMWGtECSwEfUy0PQw6lIyv8lljduxNGqI9QUTgbhNOjgV3pUpdp92QIFDtDXSJciYyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SynSeXrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB890C4CED1;
	Sat,  7 Dec 2024 02:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537235;
	bh=xQsXk2cEQ+38hRSclxDq0K31PjaNyYs26xWnONDJ35o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SynSeXrm2C1DzB46MgMgE7N1votDVk0eK7GdFwXUJEPzwjLXa8anRij8XmiatNpWV
	 oQKBzc/+ZTMZNT8V83qGCHUBM3qdW+E+whgncdapX5OU4N2JjKIQNBeNdL001EnUk1
	 Lh8GdjiPIsVsEa3682IaNxP3hIfwk8GWWP53jld6OCDIExHNl6W8q09ddJJ8kVg7HQ
	 KVP7ZYcfxxpUw24WT/EJDGZUq3E1k0ARZXAupN6k8AypjpYa+WN5y17nGrX973n7sa
	 TCqwwDjNd+Xjm+JubdoYFuKtp1H+Vgeuyc5kIZ8suEP1+3LEBo5MPCONoHkmmu6ifD
	 EK9jw6HRf44Sg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
Date: Fri,  6 Dec 2024 21:07:13 -0500
Message-ID: <20241206191536-29eef1396c970097@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206220926.2099603-1-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: d677ce521334d8f1f327cafc8b1b7854b0833158


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d677ce521334d < -:  ------------- powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
-:  ------------- > 1:  5919731e40cc5 powerpc/vdso: Drop -mstack-protector-guard flags in 32-bit files with clang
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

