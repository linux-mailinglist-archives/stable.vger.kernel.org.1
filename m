Return-Path: <stable+bounces-132796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEFBA8AA49
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3094175D87
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBEE25744B;
	Tue, 15 Apr 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiVMkfEg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E784253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753433; cv=none; b=ZRRmODv2DYmenyftnr5PePCM8CpBhLazO+gNbmNjOVO+8SDoXEpwa9Kv/4VzVUIuJXkzQOF3WM1P8g0bjj/pYOvejWdxDztu2uuUWRAyMnEyO0T9BIZRRbVSoa86OvsLkpz2vjzdkNILKE9uVMZ0EiJmslO0UP+KVcdMlfWwduI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753433; c=relaxed/simple;
	bh=V3aTAohgM+4PlokH9b/gUuIIF7oyerzAGtOzQ2pP+rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt6d1fjfxB2XaO90g35qHMvQ8WmRGjP6phqt+vwb6wuSOpE7yVL3POrfUAvkuOm8Y8dFfnq5WVyMM/9R5lq9RZPgBsD4XMLI23U46pRJw+Chh899Xb59FnYnaKgKN3HLkqPTSmWAyg4mvIZEvzu3waqTSoxQbccsKUN4uVWkgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiVMkfEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66FEC4CEE7;
	Tue, 15 Apr 2025 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753433;
	bh=V3aTAohgM+4PlokH9b/gUuIIF7oyerzAGtOzQ2pP+rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiVMkfEg+7BvE52tIMbOC6+lg8egkD7T3VTEKH6tOWvjfjLxu0M5WyeJIZnMcdcQA
	 0WZaTNr106cNls7Q3YNm1yDe/0PJWzj6Xj/ro+XrM86zfVRB2WWP6+52MAG7ffLzJr
	 029537o945o92Yf5WYL5a/030VdWj021lOexfcIfPxdVL8WxKHE8Aw9jNJKx3Nxdcw
	 KGOqgW+OZYOzb08yCFoFSQY8jy+N6UO5fSl3CkafzWKPQYxmsniVNXmoAR0PPn7UWb
	 dM4U4I4hYzgf5c4dROHzml2r0u6BZWOCQmEMkNldDhUKlrNTK5VtOoskZ0uFGf982o
	 yTONHrBY4fONA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] bpf: Remove tracing program restriction on map types
Date: Tue, 15 Apr 2025 17:43:51 -0400
Message-Id: <20250415111814-87ab1240b7637bc3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415130910.2326537-1-devaanshk840@gmail.com>
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

The upstream commit SHA1 provided is correct: 96da3f7d489d11b43e7c1af90d876b9a2492cca8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Devaansh Kumar<devaanshk840@gmail.com>
Commit author: Alexei Starovoitov<ast@kernel.org>

Note: The patch differs from the upstream commit:
---
1:  96da3f7d489d1 < -:  ------------- bpf: Remove tracing program restriction on map types
-:  ------------- > 1:  9bc5c94e278f7 Linux 6.14.2
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

