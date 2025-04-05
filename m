Return-Path: <stable+bounces-128385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A4A7C8FA
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBC53BBFC9
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC21DF990;
	Sat,  5 Apr 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szfafIKD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E9F8F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854264; cv=none; b=ohAwqBG8hOIUyYZZmwOUo7QEl2eALYr6VZnSJ8xHQTAYwIE6e/Rm1v/7NFIAteJgU5+yOepIC8iIOkqZmuhZOucPMpiAt8j510LnW2acocWYH6cL5o+vx2alYgX00RobtQ7ydSk/BhbYdU0edMdSl/7RVjoARlc7DacF9Yf2nfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854264; c=relaxed/simple;
	bh=iHnvsqRzC8qMgAzQSBwqLKYaknUoXaBAasfL0DNNx4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6QCXjditYp1GYMV8JSR/sgD5R50wcl1DGSc3eNavTNMoBKTKsszGi+x94Rc0fLbuL+l3Z14PBA17ETWPGqw1N1oXzZA+ZoO+gYHZT0sfTP7riVN9lOSLA6g4NtiTZpuxlysY0w34fOv0+qfCba1w22zXWbxDB/Zrk/RbkwfoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szfafIKD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1A4C4CEE4;
	Sat,  5 Apr 2025 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854264;
	bh=iHnvsqRzC8qMgAzQSBwqLKYaknUoXaBAasfL0DNNx4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szfafIKDQfSdcAn4kcbbIGfIh59Eol8xJrKt8Y1xevcaznxR6Nh4InTLMsdWTvEwd
	 K0EJD8RdjjGPdxxCg6qC+dLl9M9nbfXho0tqMq3K/W1tWnNdSaWsQHFWFWa7uLJG4A
	 xclBabyf4m8mlYcNBTw5o7ChoYb5gGfGjgY3euFjWgZud3frPYnfcXlqbyVkrjTF1a
	 vJbTbxFe7hvUqmJlpDJsN9EZ/0a24evsOPr3EU5B6ATnHRRevx/izA9bqGKdnsC/U7
	 14ANRBORfSbWmIYS+H6fw+8hyZLiQ9Rf6nitUH15WbiLAfxVL/7vLm313jI17jY64n
	 U0S7Fbe/uD2Hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 11/12] KVM: arm64: Calculate cptr_el2 traps on activating traps
Date: Sat,  5 Apr 2025 07:57:42 -0400
Message-Id: <20250405030025-f54a2889616bb943@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-11-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: 2fd5b4b0e7b440602455b79977bfa64dea101e6c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Fuad Tabba<tabba@google.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 626dcb1d742e)
6.12.y | Present (different SHA1: e6cd28bbbf90)
6.6.y | Present (different SHA1: 20c6561c4918)

Note: The patch differs from the upstream commit:
---
1:  2fd5b4b0e7b44 < -:  ------------- KVM: arm64: Calculate cptr_el2 traps on activating traps
-:  ------------- > 1:  d34afbc5f2f10 KVM: arm64: Calculate cptr_el2 traps on activating traps
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

