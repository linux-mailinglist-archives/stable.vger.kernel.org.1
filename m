Return-Path: <stable+bounces-158588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D949AE85BA
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534561885C91
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170125CC72;
	Wed, 25 Jun 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP3fB8ZN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46148264A86
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860539; cv=none; b=N14YfYyh8+/wDwtuU3wfqd9qZk4zAo1WjsBb3eht5cr1QURAGJ2HM7Redz9nK1HOQEPjBjoUHJrM5a7ohvnRyXj2bC4ujJh5ofqunWt50G1U15mHPYnh66AKMAY5rT6IwRbbuUfS89/9rZe+OupvVD3tWGNOPmEQvMvY6rtBfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860539; c=relaxed/simple;
	bh=tAS3qu/f/lTeYl6/MdBhQd1UriM02U4sbnX9fVAelRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7HWi83qRI1sUbMH18fXApeROPQydhrsIfkScVKLt/VRAafQ2vPimYJ3JzNNnwEVJEPspWrGcaINTf5WLBhwB4cZfHoGwffgV91SshQcBaUSKjPIQDvPGFAB/4uweDtmYwIEUJrx9KZNdPkAuTWEOEiePGCQXM4i3cKQl9YA6Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP3fB8ZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB0C4CEEA;
	Wed, 25 Jun 2025 14:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860538;
	bh=tAS3qu/f/lTeYl6/MdBhQd1UriM02U4sbnX9fVAelRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rP3fB8ZNBmi2aYS/68Odxd+X34Z70rYygjP6xQXxTQo00p6qOqTDJ0kPNdZQoXl4n
	 l5Qsv2MnsG6skrowomQKkv9I6gX08BsMOR9ME8RDWJEnTHYOGSPpXfCA0eKZwnL0ED
	 sGhODlCR4i5admeXU++4ZOwEYTjXO55sEifc9l150PNEbXeT0T/Z1F/F4l9dGez2e/
	 5sIyMps/3kNc9gsrZO/uCKZhdXNjlYX/iz4vBBp4dkbi4AzZqedTHJSE59L8s8mmnw
	 Ya/JprXCLEndLfovJpHZm56/1RybYfaLZ58xzbvkgyT07/wcxsgwmA//+4zxwAejvp
	 Hl0x3MCowf51w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Wed, 25 Jun 2025 10:08:58 -0400
Message-Id: <20250624172131-690f0a4492fbbc1b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623105528.3173164-1-schnelle@linux.ibm.com>
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

Found matching upstream commit: c4abe6234246c75cdc43326415d9cff88b7cf06c

WARNING: Author mismatch between patch and found commit:
Backport author: Niklas Schnelle<schnelle@linux.ibm.com>
Commit author: Heiko Carstens<hca@linux.ibm.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 003d60f4f2af)
6.12.y | Present (different SHA1: 578d93d06043)
6.6.y | Present (different SHA1: cc789e07bb87)

Note: The patch differs from the upstream commit:
---
1:  c4abe6234246c < -:  ------------- s390/pci: Fix __pcilg_mio_inuser() inline assembly
-:  ------------- > 1:  8fb616a4df3c5 s390/pci: Fix __pcilg_mio_inuser() inline assembly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

