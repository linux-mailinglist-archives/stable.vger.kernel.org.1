Return-Path: <stable+bounces-109464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D64A15EA6
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A677A280F
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 19:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B1854723;
	Sat, 18 Jan 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFyM8CIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4A1F94C
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737229265; cv=none; b=oRmJ303KsVKhNjsy+kGPIuoScQTPgsdNazu7+86eoRalAogPwB6yoKRY0kJiBOvW5o98eSh2bcMI5fCC/HOy2VJuBZLwWilmWDxKHoOgQ9GrJOUIbOenOPBceTdYouJDGixOwuY2vHfHuKtGBNLf+i8CEtDzgM07pk2uVaIQ0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737229265; c=relaxed/simple;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QE0h5L30vY6RflFrCPPbnSNKOUq6qWrxtNVAGov8CYnufElqMzwSaXw00QhngJqXGMdH/RiUO0qNQ0KCc98Bywuwuzs4auw/ndEHUprW2j+mEXPFMYT/OSBgZ7Nsx475vPSUcoeFsxuHha1EQOUpCc0eBX7ctwGtcH1zg5pR2G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFyM8CIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8898C4CED1;
	Sat, 18 Jan 2025 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737229265;
	bh=URk10dDtj4ycoyhOPmzMsReyUOCJeMnpT1nzTOYY0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFyM8CIu/SJP4d/FTIWNxSJpqzXt4V8DtHyEeKNr1Btan74j0TBxpSdlnkhd7+taL
	 hvHVU+rWzyIBvtUTAXc2EqIzRS92K9TH8yhiL63PJHwdrIBez11GdMSC3Ny9ByQGU2
	 Lrl/Ttw8Ocl8sYof8A3BWUGYWtSXOp6HCK5TxoKNP9zdtwpa3iR2DzlQfmVl9Fs1Tb
	 5ZsIZ5Ltq1R1reSDn6436JR92VLDOjsq7msXiTxwMUclXaKwhtxAq0gCH0buGFVjJv
	 SRr+WR08Rzi5/BEHNWcuRzq4QOuxZ9damQ5sv8H4Mg3pk84cP0XRbiD6tPcFfm7z3E
	 6NDTYIVGbMbZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ron Economos <re@w6rz.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
Date: Sat, 18 Jan 2025 14:41:03 -0500
Message-Id: <20250118133909-b18a0be64099962e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250118122409.4052121-1-re@w6rz.net>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

