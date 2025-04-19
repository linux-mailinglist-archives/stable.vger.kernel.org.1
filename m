Return-Path: <stable+bounces-134697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51245A94341
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A97F17EA71
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFEC1D6DA9;
	Sat, 19 Apr 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5ePmSjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D721A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063428; cv=none; b=af0qZWH6s6Rs6x7vYxlq5CUwRgKCys5BSw+eJVaNsmuA8ZY5m+CpMtML2HqKB3toT60tXhzBCNSVW4Wggwf4xLobhfyUv/v8MwnAYuPi5uvb+XAJ6ayAVHM5E8J4wFIKa9JUVKVOaG/dNi3cLAc0h9GP2GNUXESUNb5cx9usVew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063428; c=relaxed/simple;
	bh=jQqg6fLGKjGAXdYTZ2kLDqE8zkRjpRlTSZO4JN1PT9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGSkauY09eAXsVvnJDN8/GREZR4T/cDT4H+Vr6Gtk0+InnxpOmTygo/CTZdvdeS9Df3qSNfC9MWax/ghaxRYY/9iy38N8HIuexNGdSjZsM5XUHmcfadlMhjzCVPvpKGoT4x4M+LcP920dTIvpulwa5mtm74ZFTrl9nNvXVCfIPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5ePmSjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5892C4CEE7;
	Sat, 19 Apr 2025 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063428;
	bh=jQqg6fLGKjGAXdYTZ2kLDqE8zkRjpRlTSZO4JN1PT9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R5ePmSjfbxpoT+fTbE4ix9t/OvAKePPXHrbmIiLzaCkJzN7D+T4jfqkxbRKMzsx0t
	 b9prBTAZ41FG8jNns8Xml3d78ynIonogTUFMbNdjW0sZz0c5FLLyMG8g27TUrdYH//
	 F6FpZLOuDuBkCpucwomuZ+NOKlMh6VJHg46VnC0r+Eyo2bzYQM6UG0Ym5ZUZOh2qmg
	 q7toq5vWFXgbQgfUhw70dLmPKjE/Ny06Pb42X73UU8WcqEnYGn8suIS3sTtEt7G23k
	 K/w4m57vP2C/9kUlarwWWlEweYi8HxHFKs+XmEAIJd9Mkbl3yyDjQ2oSYmkFpRdYVu
	 VSgTtNODy/1OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
Date: Sat, 19 Apr 2025 07:50:26 -0400
Message-Id: <20250418164531-f92400ce44146921@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418122517.2031807-1-hayashi.kunihiko@socionext.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 919d14603dab6a9cf03ebbeb2cfa556df48737c8

Status in newer kernel trees:
6.14.y | Present (different SHA1: ca4415c3a46f)
6.13.y | Present (different SHA1: c52bd0b9e72b)
6.12.y | Present (different SHA1: 4616cf3fc00c)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  919d14603dab6 < -:  ------------- misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
-:  ------------- > 1:  d8da3f706c2ca misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

