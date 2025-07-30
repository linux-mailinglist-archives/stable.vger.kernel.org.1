Return-Path: <stable+bounces-165557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E828B164A6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A3D4E64E4
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32F52DCC1F;
	Wed, 30 Jul 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVdqri8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2A1DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892953; cv=none; b=kIF7dm0ES/U+HAzG/xRhV28umQmR8YmuwVVl/LPTYIw30fB3k/R1mrxDufGkUejxU2TOUTa3jgwbapi7iYRbLaloTmiMTSvCuBRAvLzlIaKOrIQnzkfYh/ap/+O/Rk1ih8vzRK6/jwkPd3/Liz9v9YwYcVmQ/AaIJVJijCQN0VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892953; c=relaxed/simple;
	bh=72v2/Em8LhC8Ebc7SXn/ShHLGIlJ9EFLQiOZ0AzK1oo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXpJmhXR3X66PoKw3tOoItn/04kmXhwsVlKytgMNniMYlmf8J8YnNZY3djEFsz+jyQDItV/3nZe0XRXS44lORGGGGOe6SpPOUku8DgvTJEVlDv/aFr/9X5MNjHoEZfWGHDiyXiyaZhavbiYARRyQViqyYyuv0xO3MccNMi/kwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVdqri8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B8CC4CEE3;
	Wed, 30 Jul 2025 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892953;
	bh=72v2/Em8LhC8Ebc7SXn/ShHLGIlJ9EFLQiOZ0AzK1oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVdqri8e5Jcd/B0aKwaSoEeeKX/cpr82f7sNq05vxqTmbSriNqsIa5iTk5NUU2VNR
	 gEUHYKnGZzOPmKn6kq3KJQC8GZapqSqdV7WuLJhxA6E3fdGzftunFBI+LnJONe9uwJ
	 WK32iyEd7jS7WKBOS+1o3Jf6DTIQPydT4nwNfD1MIEWz0v1jBsUHSb8Y+p1/g/XYtp
	 XX5GJqOzVE0GHdk5hjK7idlod983voVRGqEOXn3NkXZhqpyJ0gdOHm9IEoGV3VyW/a
	 W42L4IHFIAOuBOKCeWJcyt5Lw4WKstIAxs4WaeV8vzdKEVRnCLbdE6F9nKvUem6724
	 tUWvvV3NfrqUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/4] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Wed, 30 Jul 2025 12:29:11 -0400
Message-Id: <1753871156-c15beab0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015406.32569-4-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 8ec396d05d1b737c87311fb7311f753b02c2a6b1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 464770df4609)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.10                      | Success     | Success    |

