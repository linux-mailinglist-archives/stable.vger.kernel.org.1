Return-Path: <stable+bounces-163308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA1B09931
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E04E171DAD
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5E1153BD9;
	Fri, 18 Jul 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0kWGcVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2492C187
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802462; cv=none; b=npTH6tj25dw0JhdJFDyZcIxCPxGGcrPf1wj7Z5vycJz4vRvSD9yuzjWWvZsDePtjpHTqbdUrsW2yrj3L1Y164pPAwdtYO1CC9tyWvmltsBDy/IMobxujMv8vR/EAmv36O6A7vV3NXHWK0QzmqUq2N/BHcD7liQbdTSqo8l0lRuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802462; c=relaxed/simple;
	bh=BYICcxVBmocgjMUPD0iB323R2DsCBp2MF3YO0vFj24c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSBLyZj4/bMbUGC3WwFTYJ1Qe3Kp5aiiea5YgBiUgS3EUPhzAsBzrra0zRYU7dPnYBk4obcKuvHYjvKbfHOkBZNFdshgiYNQ3fYvp00sR2jPOw+tpOH211Of3qLqUTVLM4xMO6LT8SEnPENpKqUzb1jjv5AITmHfFo7qpCZP3Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0kWGcVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ABAC4CEE3;
	Fri, 18 Jul 2025 01:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802461;
	bh=BYICcxVBmocgjMUPD0iB323R2DsCBp2MF3YO0vFj24c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0kWGcVHig4Tyrwds9UthNYVKpl4JN3/qQFRGX2Lz9vZZCJEEj8AkXpvx3V+lLXBo
	 Cv+E6ivoPbrAWq+UAqTi5CPyIgZIjXKfDjgUmZqZnmdkml5Vl8/5KEneCOEJPeX8zw
	 tVjIPKEYUYWhP4cPx/xp11qworn17mq6+ngfhTcvE/0ZFCl0I6fMR/HPeICrIiVTTQ
	 qUZgHIlyF43XSkqlpoQd0VVFXLIeZqElR31fRMc4vElD8omGmtD1rxUeSqKNQTuX7o
	 AIRLsynbU0Vzo2tuQVqhecHxqMDoXstsaMNaZVCyyEjn2gSWBuwiM9oL0dnJ4R9eXw
	 nJ9HVY4go+iJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	sumanth.gavini@yahoo.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 6.1] HID: mcp2221: Set driver data before I2C adapter add
Date: Thu, 17 Jul 2025 21:34:18 -0400
Message-Id: <1752798271-200317d7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717000151.183803-1-sumanth.gavini@yahoo.com>
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
⚠️ Provided upstream commit SHA1 does not match found commit

The claimed upstream commit SHA1 (f1228f4d4254dfad837f1a1e4c69930417798047) was not found.
However, I found a matching commit: f2d4a5834638bbc967371b9168c0b481519f7c5e

WARNING: Author mismatch between patch and found commit:
Backport author: Sumanth Gavini <sumanth.gavini@yahoo.com>
Commit author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2afe67cfe8f1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Failed      | N/A        |

