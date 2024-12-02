Return-Path: <stable+bounces-96044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F92A9E0801
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 17:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB64BB3C417
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09319204086;
	Mon,  2 Dec 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIdrIAGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD721FF5F9
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149594; cv=none; b=ibA2XYTMb4aj3CXMQRRD5twtWW6Jz+0vaaYKUCpdTIPG1eAIi7GbVhCeXKnIlDXCNvruO2x30zfOy0eRTKjMctjRhBAHGNEfHavwcLHIXJtu24J98ZZ9sBCGCp9xCZ73IHQv25qSooQijNlB03MlcnLKBKUbOQnRWrFFiLTfsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149594; c=relaxed/simple;
	bh=qw84Ak0Qf5IJKLX8hGf6m0SwN8ouxitQzr8wFvZUwoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paAg5mlobDByb5An/zxnNllUWUkysRpA+guBlMZHTqtdyZa+x/ogs3N9kMUv3W34OFLqLm+wDxNwysbXcCPSTdK/3fkcE/PSioEWPssUFfMd7N1GHmxmFoiAG1NvVH4MxPJxKYJhIy8F/5cwsnM/fs9ggams02s2k85aqqQnyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIdrIAGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6212C4CED1;
	Mon,  2 Dec 2024 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149594;
	bh=qw84Ak0Qf5IJKLX8hGf6m0SwN8ouxitQzr8wFvZUwoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIdrIAGSOrTBKa1P1M2VOUkYeQWU3KWDsEg2ev0H4UEwEkhB9qU2h4/s7XPTzStcx
	 wNOMO1979bsrrvcTeECLQePgsblCBCU0q6Lq7rUFCF2GJuF08OLAv0yRCZrZv1d6OT
	 0k0KZFF15FZAL0jsDcEx3XiYAdysb385THCIyBR8bKYPytaXXl3kFTcGJ0IcUA7Aq8
	 3STdHpzAY+go4VjDBaTeQ82tJ1QcDF2F6RENfpUn9byjE7/WpZwYOXXwsCXv1dflnR
	 sl2b6B04kK9ZWcasl9iGe1SWdQYI378kdGWkImIXWPO/FDwB5aTmYkINP6yvkB0q/G
	 Wt+em2seQIklA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/2] Revert "arm64: dts: mediatek: mt8195-cherry: Mark USB 3.0 on xhci1 as disabled"
Date: Mon,  2 Dec 2024 09:26:32 -0500
Message-ID: <20241202073548-b9a426c29eccbc4c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202081552.156183-1-wenst@chromium.org>
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
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |

