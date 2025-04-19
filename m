Return-Path: <stable+bounces-134701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5DA94345
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F67B02E5
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399611D63D8;
	Sat, 19 Apr 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd7VEQ78"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6F1A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063438; cv=none; b=HNUhoAfNwTuFHj/VdrU0VX8FPwzY+c5VqH+AAf1iK1DKnikK7XF3x/M7/8JAA3iK/9n5ucBnea3sux7mEy5YN2vaopxbUqLzFBIIozrFgOGlPtZMv8NQqpMCQKUvDbh/BKUysPa6dAHzquKmw9c8IMBuln8zNPxT4KbDIPwy1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063438; c=relaxed/simple;
	bh=HvLi0vevKusOrSoVtymL/wNr5Z6kVkDV8iCBdcontpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEZ9dWjPPwn0NJZ8ZiaSi9xUW4N2dNLiml70S/ioCQLgjKGQldlVSZUNjJIGMbv0LoURJ9Q1Zn89cSyCx7RHT3oaulLYfWvuN+i5601L7kaf10ERbdLpg2/99rTeRUfdW/Nkyy/2BEtJTavlb5S7bLLnHGc7chSfvGh7TDSHlj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd7VEQ78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE6CC4CEE7;
	Sat, 19 Apr 2025 11:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063437;
	bh=HvLi0vevKusOrSoVtymL/wNr5Z6kVkDV8iCBdcontpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gd7VEQ78ZHy8uHkJ8CtZB7jDut0vVdiD7p/GYth6XScH09MCRVAvFgBwpFHK4k8sk
	 J49bMU3ZKUuwJiY8fDJNbf5QoWPIl32YXpInTwK0pJBs/BBir3L6gwMlWZ3sc3Vizh
	 B1dwQ/7o3C3uyuhA8BDwrWoIP437bBBaLuJnMqPzOVBVk7FNZ2FukybFDzca39G4sJ
	 9YpRQaU2L6CyBkFaWmuNmjc7JK9aCI4i72hhPDBEbUzilKOo+P/Ptqu0yQ+nOlgwYA
	 wcm421NR3Ft6LKQUQSUvefl8+S/3Y/ItbKk6LbEw0xcRFWmD/x/dR3GefcC4gtdZpa
	 z/StBUdJP+qpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
Date: Sat, 19 Apr 2025 07:50:35 -0400
Message-Id: <20250418193109-b91a1c7387b83887@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418122458.2031627-1-hayashi.kunihiko@socionext.com>
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

Note: The patch differs from the upstream commit:
---
1:  919d14603dab6 < -:  ------------- misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
-:  ------------- > 1:  4ec8d7b9b57d0 misc: pci_endpoint_test: Fix displaying 'irq_type' after 'request_irq' error
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

