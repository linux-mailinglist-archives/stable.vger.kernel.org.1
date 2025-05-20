Return-Path: <stable+bounces-145091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD997ABD9C7
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4868B3A9F4B
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA0C20E31B;
	Tue, 20 May 2025 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWELI5BC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0CC19F464
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748572; cv=none; b=bVePAbrBbIX51TaWU12gDXRCc0jwcTW7lPR47936vYHOAlOx79fAhfoNxbBp3VV4Rpf2OajF6AK/YGykewAKeMcxTp4X2HGhvpK/M9jPpkxZYY2Kl4UKeIEuA3YY1sao/fm96mhLgNi6SVsCGsL0YJTv8Jb5sJvwl9rPAAbDqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748572; c=relaxed/simple;
	bh=4u11MVM+UjgaSV+oNLyvxP/oQWYbi3EFecdzIy2Q/8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJVUgoqwXJOqcbSkqRBE+zQQCzpulQVdkUCH/h4C6NT3Nn1JG54sU5+/4+auWKT4YJZ6UruOFe4Vh+k4vknPnjwcWvfjeG6MhnTKzbikvenZ5D5mVw9kWav71C+N/2D7s2QnDp7qdrvKkOiFlIbd+N2J1qEPdZN3PB1eEUkdfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWELI5BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35681C4CEE9;
	Tue, 20 May 2025 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748571;
	bh=4u11MVM+UjgaSV+oNLyvxP/oQWYbi3EFecdzIy2Q/8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWELI5BCzjWNttAggVa9rYQRHEQs8T+IGkHEn27TGWY4UeRHGwfbgGMqiZ70FKlg3
	 9KjsjFmZBMchI83NKA8bxTyQzvu9YcXbfeEDoWJt/N9Om6o/57uCJF/jxNUCAfVGyP
	 qsJy5hiBl7VpX04wrHW/latqooTgGH3+RI0cMm1JOtQlgEfhuxbzo2CiD2dGjmGmTJ
	 Rc9R3Koy5vpQGj+RKr35hTWo4d9kSqkyRf/CyjWjrnEnOY77NjxK1hTRCdXueguJNF
	 NWnTAOjwnz28Cvk+eVjUgLMasuCVVddKWb4vxVDEztdDB7EqE/axUNqTU1LA4sNVfx
	 qhl/D2lgxLdXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yangtiezhu@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.14.y] perf tools: Fix build error for LoongArch
Date: Tue, 20 May 2025 09:42:49 -0400
Message-Id: <20250520053648-04702da893db7265@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520063009.23504-1-yangtiezhu@loongson.cn>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

