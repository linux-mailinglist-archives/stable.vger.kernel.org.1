Return-Path: <stable+bounces-176902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515CB3EEB7
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 21:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C33F7A268A
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12303346A10;
	Mon,  1 Sep 2025 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLZF+n7C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B960C3469E6;
	Mon,  1 Sep 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755981; cv=none; b=bavijzFZeIk9YTc0e9k3R/hnHMzROz0BRwEOurDFsGvWkXAVYliFoRiyT21tNa2JtpcOqL5r2PPC14zCDnLQQUN5p6p8uiYspWJZINGOXKol5ZVOdA1WKpCdIuPsmcOZlBAsOnTUbx4BAy3ZZv71kEufuRekt2rlGPdcBy5mROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755981; c=relaxed/simple;
	bh=2awFtP0PzxgFMhDbHt3jZY6mUexrKUzkpk8M2DfS96k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TES12gIDZIayaAyRMaRnrCyBZ7rn/sfs7SnBrKqw2GD5Ed58SUmjgkWBKWgxS4VgYn6prYKHy33B9PDz343WRQk+haC0m9p8gbncsxEno27gaHPgNcZqBKIIs42Dvvz/c8lbFZyLNweKjW/FdGvpOzPv/LFtBUNbtvpKeEKu91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLZF+n7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5805C4CEF5;
	Mon,  1 Sep 2025 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755981;
	bh=2awFtP0PzxgFMhDbHt3jZY6mUexrKUzkpk8M2DfS96k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLZF+n7CjiOmC0Cu80UdelWB2wXti9udvJgrg2Oqqx2OCaWi5ztJIbUAfKQBDccj9
	 OyQ/M2u3BISMLAKPU2qKmG8+RUwr9QsibE7T0rVYzhpmD2kQc7G4k3vbOJsysBCasy
	 Il3GJGojUa//r0nVRYnxfF6t+yXTwwu30NLVM5/UNeZXlNfSkBb0Aed7W7ag1WmoHb
	 //EHpaV0e+aHAWiRzdh8Uf3mMc0Z/4FQUecNnvT3TAJHliURwCEVg4paw0uGMR+kiA
	 E5Cb6gQOS4nlR9kfUSlRzGxZAp8itknRFtfgndBVOKLK0L7vaubOsOf7d90wXZD7S5
	 81TdokMHGUtpQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8450: Fix address for usb controller node
Date: Mon,  1 Sep 2025 14:46:02 -0500
Message-ID: <175675595925.1796591.17289391273276681977.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813160914.2258033-1-krishna.kurapati@oss.qualcomm.com>
References: <20250813160914.2258033-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Aug 2025 21:39:14 +0530, Krishna Kurapati wrote:
> Correct the address in usb controller node to fix the following warning:
> 
> Warning (simple_bus_reg): /soc@0/usb@a6f8800: simple-bus unit address
> format error, expected "a600000"
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: Fix address for usb controller node
      commit: 036505842076eb8d2d39575628d6e7f7982e8c87

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

