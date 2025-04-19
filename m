Return-Path: <stable+bounces-134703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A3A94347
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8B1189A985
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547561D63E1;
	Sat, 19 Apr 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEphAFAJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C291D5CE8
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063442; cv=none; b=OB8njiVBZQ1SmNTPlbYExU3uv/h0X+07DIkOauNwHRkJQbHipal3tPKMZdyCvHue6w9Ddilyq9slIgdl//ALvWzs+GsgyUyqPqpeR6UBHgOVLe/7pjkQBeJ4cCar+HiiMimx2pyoMroPU1q87kXyOh38qZWwycGzoNNakI0BoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063442; c=relaxed/simple;
	bh=XaJZPaI1COpq3copYHmQ6Y7XcKUgspd71D2YgpK4+gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1AEQtaKzAPd0pEG9dX+TW2YsGOt6LOdnj5o0Fc355/MUseovFbL9WAZhdrL53qhPpj/nGn10cNrLYwtWs2eWL8m7M3OwPJc7YBSm1AxasM4A1MQjKveLRpc/AnT60Mm5kSTiRhCdzADWuG2++NBcz5ZocltTPe6gWagsdSRbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEphAFAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF74C4CEE7;
	Sat, 19 Apr 2025 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063441;
	bh=XaJZPaI1COpq3copYHmQ6Y7XcKUgspd71D2YgpK4+gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEphAFAJonRqJ5eiiSFCKu2f0/ltAocFt610ChziqplgvBsv8g5Fd2vSBe4qUuh7b
	 b3p4olh/IPNfr0Y2I+y7khB1m6cQ5a+s/QF36yrcOkNccjTCpc5T28Kdbnm+AOIYBL
	 4eavVbaY9muQ32rwHOd/KVzl/jCjploD15Y0ujwbhgjry1sBHMxGp1/EGDwdP34OI5
	 QWuMMgAIfzVZ3IX+hdUXw16iH1YwJOQIaoiPh0hNncQT/7Wya9/a6xLc1sz5fHKg1Y
	 QswdEmJngs7zLvEKuAO16hPfwJi1nAP9PD7X2a2ykJqizTfm2azqTmbubMJuhVXAHA
	 qDySCXAzx1OwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/3] mptcp: only inc MPJoinAckHMacFailure for HMAC failures
Date: Sat, 19 Apr 2025 07:50:40 -0400
Message-Id: <20250418203326-98252d9a1f423c86@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418164556.3926588-7-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 21c02e8272bc95ba0dd44943665c669029b42760

Status in newer kernel trees:
6.14.y | Present (different SHA1: f41db9f7222f)
6.13.y | Present (different SHA1: ee6cece8b2ca)
6.12.y | Present (different SHA1: 711bc4864e66)
6.6.y | Present (different SHA1: 440cc72ac34d)
6.1.y | Present (different SHA1: f92899f0301c)
5.15.y | Present (different SHA1: 738aefd9d94f)

Note: The patch differs from the upstream commit:
---
1:  21c02e8272bc9 < -:  ------------- mptcp: only inc MPJoinAckHMacFailure for HMAC failures
-:  ------------- > 1:  97a808168f008 mptcp: only inc MPJoinAckHMacFailure for HMAC failures
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

