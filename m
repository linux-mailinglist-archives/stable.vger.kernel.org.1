Return-Path: <stable+bounces-165125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6381CB153A5
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064727B3037
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DD4298994;
	Tue, 29 Jul 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRbdkXl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE425485F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817852; cv=none; b=NqlyNF9OqLm5OB6yC+b/F+p4FpFeU1cRUokcGtJl7U+g9cTTLK1PuZeoVBeC/K2jiiNQbkqm+o2yMo2NovDX13YfbgLdrBzpD6oMtwavO35gK28h7ciljDkblVXFlGh/09STBXBsFE43MGm9EC4RtufR7iVsroibB79guU6XzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817852; c=relaxed/simple;
	bh=2hY1qlNZGFquKJSpqKZ1VKGZyOcEYBz9wzJWevjkwlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bryuZ6LCrXXGdNtmg5umaJJp8eQJ1apCMmlTrmGGdxmFg/ZoLUwQaj9HFC1koOFHxXavJPgea7g9PmkqejLYOYsZ3dhsZHqL1IlUjMiaE+9kuOrKEQghgzpcUHU78Ma0Qxe5Be/vHER6TmsBe5EDlkSdCrHa+SNOwgBnhEfECek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRbdkXl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8439C4CEF7;
	Tue, 29 Jul 2025 19:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817851;
	bh=2hY1qlNZGFquKJSpqKZ1VKGZyOcEYBz9wzJWevjkwlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRbdkXl+uZvbTVxOWakhhRj2LTEPndELzrrF+UmGNnXz2C74LYmr+TbIEuUXMSPqC
	 J0IUPM+H3kdKPgpHsjl3sZrcsDl1hG/b61HLGdnMTCtx2KGNOg503UUM82nJnqKX0H
	 07K9qiAUBeflWwIhC6BZNbiraNFpfrMS/AmXkVJVpWgYuyIGuOTbK399Ev95MEqxG4
	 cEj8RgQavXbj7Q1fFsHGnffoHnOUJuTwbrXpBRBTtzNERjgcLjohWkiDf59SFsdoKn
	 xqFoYwoOIYGn6B7yhYe5UB1cRG9TN85WHcw2I5Wkbdu9vXOjQCls9VrEQ5E+HS2SYF
	 M/bWqLK6ihULQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tomitamoeko@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 4/4] Revert "drm/xe/forcewake: Add a helper xe_force_wake_ref_has_domain()"
Date: Tue, 29 Jul 2025 15:37:28 -0400
Message-Id: <1753809157-918c167e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729110525.49838-5-tomitamoeko@gmail.com>
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
ℹ️ This is part 4/4 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.12                      | Success     | Success    |

