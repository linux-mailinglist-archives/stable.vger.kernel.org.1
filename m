Return-Path: <stable+bounces-145030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B22ABD1B6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C5E7A21D9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470092638A2;
	Tue, 20 May 2025 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSPxOaSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687623BD0E
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729159; cv=none; b=n8peDpJnrLYVZP+aXzVdSPM5mrOPjjBOQzZWRaw1/o8rKr3g8WN9UZ6thRyIPtwPOlBuIySX79htAL9nZdEZbuwUaNRLeyM3fn5xjG6oqZSU8dOLEeZIdfAXNjtrb+4COvIx8VWIhIEY6tFDmO0W4YMWIUGalTVcxGeVFdxSOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729159; c=relaxed/simple;
	bh=1L/Vi5D63cEpnPYCVZzcg8+gOjIhyAbo5CLXmxFqAk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/5ovpzNh5Dt9+EebRwJ4y5fU/nhuIGoNCgA+gkvqcFjaZoLBH5a/yUSpDQbOm2wbeGfexGIds2v5zsfQYdZvpnJkZzWgvwuas260HuyXvTmSvaOL1Piqf5GbzejB3qi0GFcbcXqbn96EEvEqfz7CFgPz/oAgLAYnyTGI9r3mwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSPxOaSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F2FC4CEE9;
	Tue, 20 May 2025 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729158;
	bh=1L/Vi5D63cEpnPYCVZzcg8+gOjIhyAbo5CLXmxFqAk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSPxOaSlClYLcxAKprgEVGWh1w5kMRR3TF7U6ZIzg+6tqJyP86gQN/asW7hIcCI/j
	 1THcKHpOPsOPQwkqEtaDu/wmXRZpEO7uKyQpi7Ei4Hwb2aVz1XhfwjRfz4d2YIBb6h
	 i9K0DVo/XuWTm5uD9yuAzqm/I43moPHI7QYKM+/zXdKFPGetUGznfef68VqpLeGMGo
	 2kEVhMzSpTmU6ItTOQcp+Im0fOuNZ+A2U0V6tS3Xp3O5TctWirmZhkFe6eD/Z1uBNr
	 /CoMwgo3aYkc5dx2hi+eA4GFJ8SnWIOT9eAilC3iuQbMJ4qDSHDNz8502qLCCNcurc
	 O0MNYgygmK1+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 3/3] drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()
Date: Tue, 20 May 2025 04:19:16 -0400
Message-Id: <20250519190905-be522fb073fbd75e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519163230.1303438-3-festevam@gmail.com>
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

The upstream commit SHA1 provided is correct: 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Fabio Estevam<festevam@gmail.com>
Commit author: Fabio Estevam<festevam@denx.de>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 4571715e9ba2)

Note: The patch differs from the upstream commit:
---
1:  9c1798259b942 ! 1:  3a93697d602a5 drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()
    @@ Metadata
      ## Commit message ##
         drm/tiny: panel-mipi-dbi: Use drm_client_setup_with_fourcc()
     
    +    commit 9c1798259b9420f38f1fa1b83e3d864c3eb1a83e upstream.
    +
         Since commit 559358282e5b ("drm/fb-helper: Don't use the preferred depth
         for the BPP default"), RGB565 displays such as the CFAF240320X no longer
         render correctly: colors are distorted and the content is shown twice
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

