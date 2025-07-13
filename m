Return-Path: <stable+bounces-161761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76722B0310F
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E9E17C54F
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F12472A8;
	Sun, 13 Jul 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubjorsJE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8F6FC3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752411966; cv=none; b=hUK/yKpAn9bScDktAfQgWuWgWcdp9Mdkx9XfAoEed5aD6o0lhwq0dtEL4y0QxixKn31TAIxsuYh+DPbEDhgFF/0uHFYlRtrm130vY94iNPj7nf2tNNUXR30ngcwslhzW4m1Uk3hPHJoGeeZhLfbeL0JPtbOqqLvnFDY6unnRqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752411966; c=relaxed/simple;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgI86dc8Tia/v8JDQ66WWeapTP+4w6jiFm0PCVRInBmKu1I9ppwyK8SkgBtZRl8exbmEMeGCK0B3/oN7VHHEI/vLpDwSH4+yReSrMwni6MXvesIXsYTBXYulP52Zvn9rrZctTtlaLZ3Tvhlc1ahTvvYtO+nNRfNdl6pG6u033CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubjorsJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADD4C4CEE3;
	Sun, 13 Jul 2025 13:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752411965;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubjorsJE2ualqNIwU+O8MO5S9VibO3nQuCRtFZTWlF/mzeTHGsOaN6yb3vFPrLbgT
	 p1Id03SlfXEaH4kK2pp35NYQzp5JqLFG+qn0RKvqWGNtEGHqr3Xys/1Y980DuEanaL
	 GtvgCRPlKo4UlbkZGSXLkNnOK4pvAKiurNKTQwKc4rvkYL8JouSj6nd7h4AtX3nong
	 2H6xH3WUqeCN5TXJpEMaaTCt9mHXWe8TyXUUtvnqdRRXVGIwyCp4UhbphD8ZfR3Vbh
	 lMHlQ4cbWeljcfpAAhSHIsszQPdrCo2os/Kt0vNTAhjcaFXliHwuwu/goWNXVWBK17
	 WrLDVJqsgOiEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bp@alien8.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1-stable] x86/CPU/AMD: Properly check the TSA microcode
Date: Sun, 13 Jul 2025 09:06:03 -0400
Message-Id: <20250712203342-53f56e26abacad80@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250711193039.GKaHFmX8215MRwSR_z@fat_crate.local>
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
| stable/linux-6.1.y        |  Success    |  Success   |

