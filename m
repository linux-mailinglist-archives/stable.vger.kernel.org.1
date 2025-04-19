Return-Path: <stable+bounces-134681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFAFA94330
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015011899E93
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6318DB29;
	Sat, 19 Apr 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZxouWoA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D31A254C
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063226; cv=none; b=cXxI2wTshzfHyq1yo8TBb61jfXnW5kKW+ixu+EFIexJv2c6abBQGKtUrHlI2eAEJIQdx+dBzqBMEiYRw1/dDe4Q+NBuuBQchvyd/F8yanlGyJ8n/4RXpKa6pLQHFNP69ud8/EJOQuAnj+vN8v1j8N4cmt1FZ1F+8alVbPwlXuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063226; c=relaxed/simple;
	bh=ADXKslISieKPdjhkUV1N8mgz6KX1e9RYK/JDoVoxafc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKSf1JIWD0nuM6RSoSDuGR2V2dZQe8d3dOdIj6YG+WSXQLJ4dBEBJyYXsy6oR2gJG1cZ/JTHf8ukATI3r2B6MojyXwIVxoZIHleF+hLMXPtuEKWr6/Ybb5sZKaKXQGoNU8d0hckZt9QcbViVtk0rUSwPHy+IFGk3iXUppWuP5/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZxouWoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AB0C4CEE7;
	Sat, 19 Apr 2025 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063226;
	bh=ADXKslISieKPdjhkUV1N8mgz6KX1e9RYK/JDoVoxafc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZZxouWoAh8tLys5YGJvORyS4X8cq4IUEY0WsC5blmpkmhY7bEKGKVbU5OLDETbhJu
	 JGRKrRuOoStiNxDDb79APzjCeMZX04M6iOiBEGBfpGlb/H+XNKoQ2DtPC4fuyUYodk
	 Xx2KmVm7BElKWk8v99Bd07ATkyEhsC9HL6KwY5YTUwyR2JdGAOVb0y0R6yK3vscKzO
	 MmfaKMsfrKtfURlXOU0WF1NZ6/07UVDEjaOtxZExBv+c002oh3JpVuMuOgpoE94bMA
	 cDnnoQ2Jvv6tYxGjbnD59+r3QdohaVJ+xWKs8iKAd2eJNeMtucxN8NtPlL+b6CONTy
	 J6SVgc4W/fAtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bvanassche@acm.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/3] block: remove rq_list_move
Date: Sat, 19 Apr 2025 07:47:04 -0400
Message-Id: <20250418190043-a62bda61bc0991d7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418175401.1936152-2-bvanassche@acm.org>
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

Found matching upstream commit: e8225ab15006fbcdb14cef426a0a54475292fbbc

WARNING: Author mismatch between patch and found commit:
Backport author: Bart Van Assche<bvanassche@acm.org>
Commit author: Christoph Hellwig<hch@lst.de>

Note: The patch differs from the upstream commit:
---
1:  e8225ab15006f < -:  ------------- block: remove rq_list_move
-:  ------------- > 1:  9bc5c94e278f7 Linux 6.14.2
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

