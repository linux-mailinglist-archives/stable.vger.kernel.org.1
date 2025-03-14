Return-Path: <stable+bounces-124476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1C2A62141
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD0462426
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CC1A23B7;
	Fri, 14 Mar 2025 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLvDtb2x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534C1F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993805; cv=none; b=EnruPxc/GHIOBNHWAhi0HlIs9XpmnbuWV5ZFjaBsN6dIj743BLuEyhFlYlWeKgiZBB9aqCBb+BtcGpABwqnzWVM7KWx00AEwCzdKo+ZAVqgqYvXgERIsRPaOGQaewX6tu9kwXnP005JlATM9Xfig53wwNA5kTS4+wgWS/R1QZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993805; c=relaxed/simple;
	bh=rOmUhQuntlWOThl20He7lwCaLqYaut1FVhctzXblNe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is8qC6iHBwypTgDkBBAN2gRaQz20bDNtK+rEK513YXp1EFTALWQof5g4zfSwiv0cgQgaLpJeKUz0DFztWsJlHBgC7GGeAUJdpeUkDf/BQYLppaIJiQH6hYD1SiwNtgee/2RarAUfw90DqFH5jMZNhteob69QUuEBVaJanqmO/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLvDtb2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4FAC4CEE3;
	Fri, 14 Mar 2025 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993804;
	bh=rOmUhQuntlWOThl20He7lwCaLqYaut1FVhctzXblNe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NLvDtb2x+nTcjleXEp2bNBcFfPmYV3rj3BMM3RNl7HSkba93w/nueyxstR1x8McWj
	 XeJPfm7JzEXoGXXuQJqO8bEoHtynkmGe6yN2zjSwFdxL4mP/fVTU6Qlna1wbV//QPM
	 wf75MsgaK3FajlTcDvyM7g1LDLxKOX09nK9ScMImmWFNBt8H+ur6312pHa+MpGrPiH
	 NHiY9GLJhLThGh0OGUvk/xbPsc0GDueDS9NAn47Yg0RYUj6up60blTTSrYi2mpX1Fc
	 A0/u62rdnRykXq5JVryn62ACpALSNkEECTI/MZlmrG1Vp9oVbiKj9bdoGrFlLShdJy
	 J0F+fcO5Iwg7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <chenlinxuan@deepin.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 19:10:02 -0400
Message-Id: <20250314082220-3ef35d0160a3876f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <E2C3ADFDB3DFD774+20250314090400.31676-2-chenlinxuan@deepin.org>
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

The upstream commit SHA1 provided is correct: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5ac9b4e935dfc < -:  ------------- lib/buildid: Handle memfd_secret() files in build_id_parse()
-:  ------------- > 1:  3c1e0975ba21f lib/buildid: Handle memfd_secret() files in build_id_parse()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

