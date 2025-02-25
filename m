Return-Path: <stable+bounces-119540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8248AA4459E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 341B27AE3D8
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501DF18F2D8;
	Tue, 25 Feb 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE/i+7f/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1092318F2FB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500038; cv=none; b=i8/YYh6qhkzVLgRWIuX9P8vopKslcNu2Ui0+kqIp4isEiLAgD0aifAKOpuI+1I16Y7yQ5zEnNL6SJDcsgR5BVHvScHqnwbE0W6VUcjVCEujxs9i/KisgY/ho6BSd2Hxy5aJnn/sH9Qf6LkwRYGml0AwG/X9QSWeq8SWwTVBvAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500038; c=relaxed/simple;
	bh=y/vA11JFb1qH/EpzmwlTMOBRSH/VeYRoaghAQKWLEso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kg7I+SAaD7nSp1aYuk7hXqwDv88I2PzuvKwE3kTFslStCs2qtUoHJ/XhOvEnZNIN6kqp5Tu2d3wDnzdYRHgldwMSRzk+Vu1zjVW0ebJfpveQYfWFvnM1j42eE58aonI99WcxhcIUhWLbVJ/X5EzRhLOrM2UbgtN86FFK4z5diZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE/i+7f/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7A1C4CEDD;
	Tue, 25 Feb 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500037;
	bh=y/vA11JFb1qH/EpzmwlTMOBRSH/VeYRoaghAQKWLEso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PE/i+7f/aleItW1kwCZCmcdKOJfWGDdVEZjWWqm/+nsC82UUcF739FCtz1cyBrLWl
	 LzZsUZfWYKwu2GUgEKaf62HWpzsynUR0wcHh7u1nFeUbxI0y2E6W7IPEWl/t+bMVkA
	 rr0Nwud19GQPnlgK9Dj7JG/R30yboScE2DieqiVI3XyOI8caKhKl06Be9MiPBfpD1n
	 MrfT/xd/TGDcZSi91AxMIpY5EMYVslyvsOD+Lo4dlGmXjRrPNc7ip9fcIzpou/uTbg
	 7ljRev/DYNbLGb/GvgJDVh9SA5h6K4275/Fp2RQdw59imJ2DvG0O3P8vSBh2A3umt8
	 YOG4R6K/OKC5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	benh@debian.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4,4.10 1/2] perf cs-etm: Add missing variable in cs_etm__process_queues()
Date: Tue, 25 Feb 2025 11:13:56 -0500
Message-Id: <20250225104336-a31fcda45dddcfb2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <Z7yW4FuPxoZyl7Ga@decadent.org.uk>
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
| stable/linux-5.4.y        |  Success    |  Success   |

