Return-Path: <stable+bounces-134601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8D2A93A04
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C18F1B61705
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA02214A77;
	Fri, 18 Apr 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0JfALaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFF214A61
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990957; cv=none; b=W0dBR0hysE+IMLrXycrGCbQD7Z1/osEeCY0TNDLAaZwbvDhCEDbMr3+g65fY9KUlkbyfuf+OXboC0/UlV4yVMiIQsO07mfTpPhNIg6NbPF7DVgQYviTvJKvc9NtFfKeS3R0Y4zUbY3V89+SpznUEsf4k8RNfuUNXVaQbKDEnL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990957; c=relaxed/simple;
	bh=/fTHgVgPH151913RsJUnsjdWYsa95m6bo7rtLpzGceE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvMUQJmmOmZgIOL4yzxnF6uEeANSmts6f0s9XgmDcmiyr0d9JbZLDmj75VOxnK9oL264p9szqg9cY0KynjdZOG4r4cLMojEbdefcRNmLUBCjwLhJAjAmhyJya3Oy9dXFCNKKxOwZRTg6+MnytK3OOWUqT9vrcj9aZM1XCMfk5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0JfALaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106AC4CEE2;
	Fri, 18 Apr 2025 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990956;
	bh=/fTHgVgPH151913RsJUnsjdWYsa95m6bo7rtLpzGceE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0JfALaWzVsmytdKJykYGsyQgKIkSwLP8CSq+R3ibyKw/p8ctU9XFEh9jCMjc+yYh
	 pJ3C/OC26zwtmN/VZmkJxvZkzF1jTKQtNsLCj+dxBMa7ilpvokeKWVbbNNUuRUDIhi
	 5AnFyCc2ba2x7lLd+Jq7F1ouKEBPMywt17Q3ezEKhXt0DQiCZ8ONXMhFgz9k5E09AZ
	 2QVV3tI7ELuUW4U2LRgeLtNpbaSO6v+CoZFXWvJSTY7amdVou5qkyC4HTVRLUw33CO
	 gE3l2P4semERT+20q8sgTU6tOU9pFd9VSDjpuwvFfjSfqaOXhPTNuyOuCr47B8Mrel
	 NScRveXltOs4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] selftests: mptcp: add mptcp_lib_wait_local_port_listen
Date: Fri, 18 Apr 2025 11:42:34 -0400
Message-Id: <20250418084032-5be369899c4e4732@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417172749.2446163-6-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 9369777c29395730cec967e7d0f48aed872b7110

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)"<matttbe@kernel.org>
Commit author: Geliang Tang<geliang.tang@suse.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  9369777c29395 < -:  ------------- selftests: mptcp: add mptcp_lib_wait_local_port_listen
-:  ------------- > 1:  814637ca257f4 Linux 6.6.87
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

