Return-Path: <stable+bounces-189995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7101C0E42B
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F013419A2F01
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA533101B6;
	Mon, 27 Oct 2025 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjvchMdj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CF30FF20;
	Mon, 27 Oct 2025 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574005; cv=none; b=DcvGKG1Uz5C4hJRAcoPBK0gB2GGv9FSfNq02pKJXT3B6EwLCggIXV0V5vy9I9VpKgcBM2PSiq8R9wuYWu2a9EGpWvl2ZNAxGPVX1EiCIkq2e6QkfLjVMfGSwv9uoZyYCObV7Ktc5IZ3PnPcEWelqJXAzyme1fyM2ZZziOP8S/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574005; c=relaxed/simple;
	bh=GzpiT56KBSBWsUtFmdMudRRj8LdJ2oSQeEs0Kv5Wqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOS90cthnUpzzf0M71CFO1p1PZe4V/mDaKRW7tUaAvnG/m0D62GxYxPLiGDJoSsCWmtM+7gLcC5hiGdDgvM0PHbLhf1uVzx3vz/MYaeU5vXGF9Ofo6uzPUtX4QIE/+kjHmsVgjIh/UMrcp1LCRkzMMVFOmZ1u8fZAnQlTlHm3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjvchMdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821C4C113D0;
	Mon, 27 Oct 2025 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574005;
	bh=GzpiT56KBSBWsUtFmdMudRRj8LdJ2oSQeEs0Kv5Wqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjvchMdjV0/NhVM6waJAAI0tG7qolGqH7YLhBIFbLZPQsso66EU66+h7/KsMfHv/R
	 sQmhnJZmK4xXF9PbeY33iusG2+VjUb1cEvX2JvnRtT0CVmtowOHp9AM7loPa+nTGr8
	 ZU6HzkDc41vaQD98NIsTJSejtZPpFJDQB91azQYrft3VRusnyx7mVdIcaEGIdRfLqz
	 nlCsToxznHTNakqtJVmyyFjzJ0btmX6ktSTVqDDS43NlYJe5m5FPfS+1A2sKROoNTv
	 l3rmfBiSp2iorrcZzJlLHOA+DZDv/bgqQvoD3knj9lUSfWlYRKKFQ0pyJ20T2y4D1C
	 uXYGPOojSRYeA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: gsbi: fix double disable caused by devm
Date: Mon, 27 Oct 2025 09:09:18 -0500
Message-ID: <176157405469.8818.1747544601110229644.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020160215.523-1-vulab@iscas.ac.cn>
References: <20251020160215.523-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 21 Oct 2025 00:02:15 +0800, Haotian Zhang wrote:
> In the commit referenced by the Fixes tag, devm_clk_get_enabled() was
> introduced to replace devm_clk_get() and clk_prepare_enable(). While
> the clk_disable_unprepare() call in the error path was correctly
> removed, the one in the remove function was overlooked, leading to a
> double disable issue.
> 
> Remove the redundant clk_disable_unprepare() call from gsbi_remove()
> to fix this issue. Since all resources are now managed by devres
> and will be automatically released, the remove function serves no purpose
> and can be deleted entirely.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: gsbi: fix double disable caused by devm
      commit: 2286e18e3937c69cc103308a8c1d4898d8a7b04f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

