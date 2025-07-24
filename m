Return-Path: <stable+bounces-164626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E59B10E65
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3057756866B
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4C2EA173;
	Thu, 24 Jul 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpGH19N4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798722EA164
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370123; cv=none; b=M+JNfG99Z5iSRmMyfOn3TsleG6hr0WIMwxGCB1qG13k5Kc3HEHa/UUfat5vDZgCWIg1WbmcqGkAOvD3KO4RK6xdaO97VUSEZHT9PrI1HoFKzBVvRk0H1wQw25YwLbMDH9rG7ypbP17GvKha/dMcCN1+WsTkfViMLU6YXPpl9OSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370123; c=relaxed/simple;
	bh=w/Ed3QO1Ij7t6YI2carfE0DTyhElfnuoledAP7RxVgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QboCO16OZj9PP8XwbbJzRvZx9DpkxHuBPtf/BWUnEhaJIQ1vz+c8k8fI4GNFZNKRZpl6Y6CMxMlpfjc85PpS4QnenpIJorYB+6S97Eg4NYmR7XYT7kg4y0A7sQf0OCRpeUxUxLYMAgrixakBJ3IB2TRr9FEVn1fHnOjLlOya58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpGH19N4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8BDC4CEFA;
	Thu, 24 Jul 2025 15:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370123;
	bh=w/Ed3QO1Ij7t6YI2carfE0DTyhElfnuoledAP7RxVgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpGH19N4gMMZRuu4NBDoMfKEOhgrylcr3XXJiYJ006glN8dltHJop0aiS3WKF+Zk2
	 Kcs3JZx7KOwjB2MaOrlT3/GiaZnOkHE3afzj7LGBAEbFm+Z1anj2Dj0WhCjs2U7ARE
	 rIBHstvDcho6hr++6r8pfURNfM12BivEdVjT9deaS/67qj6Zd0JB2KHbbmH/Z+ONxo
	 Y7Q1muAmtQV2y56Pi6MTk7kD/zRiTtHh1qqHSiWREWBJGX/G9iaOWziDQgMTzUN5n5
	 FKDyhHqHIqAvomLpsmqbrlmX+J2bOeflSwsSK5O+OntSv5xVTyiGPtKK6ZxiAauecl
	 Lfde/yFfSmsfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sumanth.gavini@yahoo.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] net: add netdev_lockdep_set_classes() to virtual drivers
Date: Thu, 24 Jul 2025 11:15:20 -0400
Message-Id: <1753367981-e2a8d101@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724043010.129297-1-sumanth.gavini@yahoo.com>
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
❌ Patch application failures detected

The upstream commit SHA1 provided is correct: 0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59

WARNING: Author mismatch between patch and upstream commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Eric Dumazet <edumazet@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Failed      | N/A        |

