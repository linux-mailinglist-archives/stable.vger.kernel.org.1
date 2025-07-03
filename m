Return-Path: <stable+bounces-160114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4AFAF8055
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 243033B99E6
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306DC2F6FB3;
	Thu,  3 Jul 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dACztcfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD32F362F
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567711; cv=none; b=jEylIu1Q+lNbqTK+uL3aPJ29sWiDOFQJ015e2RUmrz7MLN8NMzeI7NyqQyZ+03f+X5UXJihyRzkgsPCKVpFjWYiGJaHFoxWdEnbVg0XU33XxV61v64AbhDVkUKvR42sdwQcF4KnIgyQj+430JUnLHcwIKoy0o/oLqWPuRsLY704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567711; c=relaxed/simple;
	bh=tDXgLTlaf08Yo7djYL9Mxny/EJnTMndE83+RPVCvVa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRGXsUuAU2gsK7QLr2q+rHwXropO1w6KDeRLxFxAoXOUC8mxtZ1i+IyGM4NwUOfVyZ0LsZnPYx/HwlWNqKTvq9DOcGEtZDBn/Y/362a/RHOwQ7rUhjhzBripN5aFCZ6AADE8kUBuf7kcAC3+OqC/B9HSuMjRD2hGB9H4xagt/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dACztcfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACC3C4CEE3;
	Thu,  3 Jul 2025 18:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567710;
	bh=tDXgLTlaf08Yo7djYL9Mxny/EJnTMndE83+RPVCvVa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dACztcfaUDv/JfpkNllrQiST2fOnTC/ghX6OrlEk5ufSBCxAyuEPmH+mePeBInjwa
	 7iUu0Edjt6lrJZvoGniqzyNTu75gGOs64k19WRnvv3987LszZsXPSJ5n7NTuJL7vl5
	 rWccovqzk9ismf7WBUa30/K3kFzlPpXL7e/R6GKITFt7T2boljKAF3lLHAkgH45Y7g
	 2GCWnuhNBeosHC7INezsF+ctt5UCyMiHSzgiafJyX8QxcvRmc8OqwUhaOO+saQTy9G
	 khWyaDeEmBhrb+MIchStAYogDjqKePMlfjRutW9HO3HoQ4u1TgVt4jjvdJrZ9SQHjf
	 7AXsbFIRZMFTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] Revert "ipv6: save dontfrag in cork"
Date: Thu,  3 Jul 2025 14:35:09 -0400
Message-Id: <20250703091338-c676720dcf973de3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702114150.2590-2-bacs@librecast.net>
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

The upstream commit SHA1 provided is correct: a18dfa9925b9ef6107ea3aa5814ca3c704d34a8a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Brett A C Sheffield<bacs@librecast.net>
Commit author: Willem de Bruijn<willemb@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: c1502fc84d1c)
6.6.y | Present (different SHA1: 8ebf2709fe4d)

Note: The patch differs from the upstream commit:
---
1:  a18dfa9925b9e < -:  ------------- ipv6: save dontfrag in cork
-:  ------------- > 1:  ad1fd59a93836 Revert "ipv6: save dontfrag in cork"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

