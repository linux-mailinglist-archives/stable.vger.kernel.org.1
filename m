Return-Path: <stable+bounces-127445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22ECA797A3
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B708E1665ED
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1AE19D897;
	Wed,  2 Apr 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B62Oj6rJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E7288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629126; cv=none; b=b1KKf02OJIw+b6lSlgLw02tOfhdEVVJLK1LnK4Oak1TgiNHb2GSAiTLU+PhmXjz0LpzQZ5aWf1XKVzu98/fpozH2TylWFWewm7Gn984VityeKwS/93mH/ZdmEtCHwdbVISyESABgswEAVfsh8nBHqYT+MtuP48xAq2umU8ClAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629126; c=relaxed/simple;
	bh=FjoZS7sn/fXeE+EqSxh1t1aqFHEuZB/sNyJIR08Jdxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q23BvQu7fYnm5L3IM7otv9KKdhVxv9tRT+5r6qZqbTY6YrFNOGfZXobZrbKvEq6THadNO9y/IwzsOpbA4JyJy4LrleVz32q4hfTKrY5kRwUPwj0ph0p8dD826qk3PqN4y9j9Sgr6B9tfW23fbnqF6XphmEjbL6udHLYkqSLh3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B62Oj6rJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A35C4CEDD;
	Wed,  2 Apr 2025 21:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629125;
	bh=FjoZS7sn/fXeE+EqSxh1t1aqFHEuZB/sNyJIR08Jdxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B62Oj6rJXKJnq02jpLkBF97uI2SenLDRUnhDJx2oNmStuVXCCIuRIro+Tj9uNeUX8
	 oBEtl3ahotoA+5QyksBagzLdUoosW4kgeRPcsAUJ3OofYtelcUPp+UiI97KhfnkkqB
	 oLSfsvH2lr5KwkzUVctQDuYOlE1mhCRj8zu4D254U/4Hb1xXEzqSUlJteB1pHcOp22
	 Qk7y7b0+5q39hWJm2oxwKvwLOtw3GZcyhjDWRZwGugy8XklS2SMJrizrD/mu+CvMcR
	 zYNf7MfRuA6WISNrzbmOzlUgSkwBq//dKoejncSlzRU1lPEKsM1tgI6WGkVNsFGmbz
	 yt0xO/GJv/bww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
Date: Wed,  2 Apr 2025 17:25:21 -0400
Message-Id: <20250402122044-f022dbde3d3caee8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402095731.1813286-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: d328c09ee9f15ee5a26431f5aad7c9239fa85e62

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0ab6f842452c)
6.1.y | Present (different SHA1: 558817597d5f)

Note: The patch differs from the upstream commit:
---
1:  d328c09ee9f15 < -:  ------------- smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
-:  ------------- > 1:  eb18335a35941 smb: client: fix use-after-free bug in cifs_debug_data_proc_show()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

