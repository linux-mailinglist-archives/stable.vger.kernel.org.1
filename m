Return-Path: <stable+bounces-100469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680159EBA0D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A97283AF5
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29503226194;
	Tue, 10 Dec 2024 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFxRfuRc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70D226186
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858684; cv=none; b=YxYTpnbE8ppqOFOelpjaPkjXIeGyjzUDh33HRJ4oEFD/JkplEBV2R9alnn+rmzpz5GiqkFMkJx/5xa+wVaOHF4NB29oi6z91PXNKz1HVjqePgIfWTnDTWaozspovCKZp5IxusBk6x9ySTboRUVd8XRJ52HjrPkBeGw6wEQVrLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858684; c=relaxed/simple;
	bh=8moO6Mp6TtOnbgeda4ubOAGkhWYOJivrdYnURHytbn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUs93SbcVoBj3caovA26LPyfNgLTTTMm/Gxi5nqyY7AzWgpsAzObuNrfZRSyhUQVidGdq4YppYvWm2UuWFp4m6TrE3tY9xMkARGwRR8fDJ4N9XMqCqnBEZoamhaYRt/xKsZk9zArGU8Fhn4PNHMtCo+CNk0Wcm0nMQ+5o3YRV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFxRfuRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11C6C4CEE2;
	Tue, 10 Dec 2024 19:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858684;
	bh=8moO6Mp6TtOnbgeda4ubOAGkhWYOJivrdYnURHytbn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFxRfuRcp9CPxuXlFW1pThuUUgmI/vzS57pBL2tv7tNhHPp2iT0ikWMD6UscBuNn2
	 7RucwLwdOniYBJS7YNdjFjtwiD13Sx0bnU+N+i0Xid61xKtSWw09H7U1Jj4numW/W8
	 Yo69TX4knPjt1g4g+R7sml1eCpx1ycUKVL8hFPSB11IazNS9nFRFRR8gBWbLkGIkja
	 vHleBnDZd0y7rYI7eqxMYKS+JREEM3E8mLNvz/ZMcTURmuZL/fwVk7zwS203U0FvY3
	 N2YhL2MlSD9aZTTFWy1loSqWkYJnju4o2N/cNbW62hPG43Sy3/9un7Cc3Rfgwpf1lJ
	 pIDA8fA6Wezow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amd/display: Correct the defined value for AMDGPU_DMUB_NOTIFICATION_MAX
Date: Tue, 10 Dec 2024 14:24:42 -0500
Message-ID: <20241210085148-a58fb7b371f7d128@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210080500.1417716-1-guocai.he.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: ad28d7c3d989fc5689581664653879d664da76f0

WARNING: Author mismatch between patch and upstream commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Wayne Lin <wayne.lin@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

