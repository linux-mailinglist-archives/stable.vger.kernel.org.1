Return-Path: <stable+bounces-135184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F43A975D4
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CF31B61D20
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B0F2900B4;
	Tue, 22 Apr 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD69VOBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2C290095
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351154; cv=none; b=VoIuVWEVtwKAH84Iw1BL3PaQpO2+zN9+gCEWFUlUdeMDBE+l8W+PGJ2IN+l905arNGBZ5raz7aBYoN1c8wLA0aOcPx/HBDJLJ7tNPOguBalHiRW7cx0wEYsyaVMS363/fNMa+E/T91LSa9jTHi7cq5kG5ASbuop7aQgyg+hW934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351154; c=relaxed/simple;
	bh=EKV5HDm6TL/OJ5X/6iFfZvfmR/OQvztGsL/1iRWaWIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElAiOi2mPN9Qch36gEJ9WVcQYSOw9wOu8+3KkhUNYTvEqqLAAQk2ZQKwhJS8MIbPwi37Vvbqxto5qA/2kP5gKw72g/eO/vsESpn5mYAJo9g5j0NAJuEfgcEsgsMD5M74W3gfdTlo7sdFmd1XU21DQoOCvNXOAPm2XNRvBpkIPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD69VOBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73220C4CEE9;
	Tue, 22 Apr 2025 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351154;
	bh=EKV5HDm6TL/OJ5X/6iFfZvfmR/OQvztGsL/1iRWaWIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nD69VOBAm6SlBrPhA66KuR/yy2LDt6mzy7/w7AqTQvF0NJSs4I2eGLp8UhZKE1/xr
	 y7iKkJ5Y5kSyBTpADbX2VRmQHH5bIv9q5yoi6fAJzFFtPvpyX2d+UdL2ZxtbnSsG5z
	 EdMZrE0XFhClMZ/vyAA9YvkrthNmD+9RNHH2wotJgW0kYWcI9TSp6nc5W6dhOuULkw
	 XgMvTYW73NME3fvjy/RdV25SLrxGjpmw/eyqc4y+ApUJMpYSpqdXiBkdp6WFCmSw0W
	 Y4h4jckMf5qOohRrBepSSrhWpgW5VVS+7L5Fj5xMZxx8s7KMcZOK1JS2ygg19lUtqA
	 W+WE4cdCRsbZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4+] MIPS: ds1287: Match ds1287_set_base_clock() function types
Date: Tue, 22 Apr 2025 15:45:51 -0400
Message-Id: <20250422133725-099a0870f9e4fcdb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <418FF04C2B5B986B+20250422092415.120647-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: a759109b234385b74d2f5f4c86b5f59b3201ec12

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a759109b23438 ! 1:  ad27ae5c0ffa5 MIPS: ds1287: Match ds1287_set_base_clock() function types
    @@ Metadata
      ## Commit message ##
         MIPS: ds1287: Match ds1287_set_base_clock() function types
     
    +    [ Upstream commit a759109b234385b74d2f5f4c86b5f59b3201ec12 ]
    +
         Synchronize the declaration of ds1287_set_base_clock() between
         cevt-ds1287.c and ds1287.h.
     
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

