Return-Path: <stable+bounces-150753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB5ACCD25
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDAD3A696D
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934D11E7C10;
	Tue,  3 Jun 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiV4gB+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FEEBA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975763; cv=none; b=UYN4wd/OPd0m/2urA//hqXyVy9fsxq1sHnZG3FRH4KOUa6una7RjSmj7m1Ye3nv+2P3PMaMJbJXKOT3HAyzmx4QWHSIlu47GbXaCAtr3jRLxK87ZoUMSOGtBor3m6BGtVn88j5m2fKWxsKyxcLnjA26SMJ7lAW4hBZQzaTYtWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975763; c=relaxed/simple;
	bh=gooi+2JdSwugxxU4EVTFjnHZaq36YmlG84fviMGBzPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+cCJjZgWj8SY4CA2reWXWCFvME7DujZ35PB2NluFaQNq90nQ5wAJogB4J+JkTVHiOv+KARevMXdoSCuR1bFYkShpFyrmTF65ZQAPfLusKWMaEiMphrmW3zOkWNdkTvro8kKiqksFrq86LuAsXrHWhvFnvzkXPYR508Wn9rJQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiV4gB+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC612C4CEED;
	Tue,  3 Jun 2025 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975763;
	bh=gooi+2JdSwugxxU4EVTFjnHZaq36YmlG84fviMGBzPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiV4gB+Tgtpo0BRJ2NAr8DJtC5GiYaEkM3KF0ge2vmoyp2Xi4wbAzdRoE4DbvEgWK
	 WsB20+O6qI3+De9XAuiLpgVWEHlARYpJ7/DJYCKgnlWSC/PEE9KeniqAwhl7f8cTrC
	 5xz0dvCqlwMU1YMdau5gVx9wUu5ttp0LkBetsAMmuK6DxgsXARVTMUFQy7OQA4dSbD
	 Q7SmaLu+62x3RTqZCo8RrnkV6VK/bqmSOUA4Egrc/2DASGhjH/3T9wWkjxwllIokWq
	 z1LbRf4pjdvcqsqCzHcXvFOML42sDbVzARtSoWmVKgvcjJGTRuc1XfsjQs/g7pHhgU
	 xl/svUaMvvUwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: dts: imx8mm: Drop sd-vsel-gpios from i.MX8M Mini Verdin SoM
Date: Tue,  3 Jun 2025 14:36:01 -0400
Message-Id: <20250603134959-1f578cd8b4bcb4c2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602155845.227354-1-francesco@dolcini.it>
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

The upstream commit SHA1 provided is correct: 8bad8c923f217d238ba4f1a6d19d761e53bfbd26

WARNING: Author mismatch between patch and upstream commit:
Backport author: Francesco Dolcini<francesco@dolcini.it>
Commit author: Marek Vasut<marex@denx.de>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8bad8c923f217 ! 1:  a0da60f537dd7 arm64: dts: imx8mm: Drop sd-vsel-gpios from i.MX8M Mini Verdin SoM
    @@ Metadata
      ## Commit message ##
         arm64: dts: imx8mm: Drop sd-vsel-gpios from i.MX8M Mini Verdin SoM
     
    +    [ Upstream commit 8bad8c923f217d238ba4f1a6d19d761e53bfbd26 ]
    +
         The VSELECT pin is configured as MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT
         and not as a GPIO, drop the bogus sd-vsel-gpios property as the eSDHC
         block handles the VSELECT pin on its own.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

