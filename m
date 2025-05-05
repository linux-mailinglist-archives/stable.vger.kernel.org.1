Return-Path: <stable+bounces-139709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED4AA970D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9F417117A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ED325C83C;
	Mon,  5 May 2025 15:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRjY4Tvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696EA15574E
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458030; cv=none; b=W1mZtnr7+nEwSAcXosV4ZAjVwVLj4RCPN6n24Ikiw8YUiz7rkkdnY1k+tsdz4m8v8hHuD1C6MnLLJdt22gErWnPH6QvaQiY6Zpk20SHyET6gmys7ARk2QFjJKYq4CMP8HUHRBRzVbImcFjLY9AyXFSF88kiyso++xJN4LS0GYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458030; c=relaxed/simple;
	bh=WUxJwvabvwJpgPbzXjGCldPG4fuwq+vr0Iz5kkrnbWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHwSH87m4o/HVTW5t6K1DWwGSdCJnZxJIUM/YIdR+qrai0PCUnll2/g2H7zvKevRGfG3zg65ftdnnTPJdIC1kQXHSByQKpwDfp5CwUYhJ0fpCp3YOz+vggkkab+neLRjEqTQdQ8b8v2nsZ4dJa+aMZwodWcaSjraD8uc1aVWm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRjY4Tvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C09C4CEE4;
	Mon,  5 May 2025 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746458029;
	bh=WUxJwvabvwJpgPbzXjGCldPG4fuwq+vr0Iz5kkrnbWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRjY4TvrrVIxPgTG+NdNtkax0RsHaDQepLHQIq4F7H3y5puAcnHGh3XIJ+xloSGxL
	 Lau1riaUUI0RrYnuHrOXbYhEfus9m3toAHu0rpZqcSOtUQTphliMWcRKQ+j0eKqlB+
	 kM4N9VpBkwhvCBsh/jeliyPquMLF8i1a1ODL8EdmcpQtloJmhlvAASo/PGXzy7Ms/z
	 8IAKnfIY6yhTP6RkKhzjxc97yYaOnOw9cQ56kYPQeurN+d1nu4Ylm0I1TgRmxEPfcy
	 Z7LMUcGZosC1Zh9nD51+N0hwe227SLn3nxFbM32UM11KQuVvso1sT9OB/rV/ScW4v+
	 9jggGWdpNUDkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Matthews <ryanmatthews@fastmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/2] Revert "PCI: imx6: Skip controller_id generation logic for i.MX7D"
Date: Mon,  5 May 2025 11:13:44 -0400
Message-Id: <20250505085048-dd59e62841bb7264@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250504191356.17732-2-ryanmatthews@fastmail.com>
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

The upstream commit SHA1 provided is correct: f068ffdd034c93f0c768acdc87d4d2d7023c1379

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ryan Matthews<ryanmatthews@fastmail.com>
Commit author: Richard Zhu<hongxing.zhu@nxp.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d0f8c566464d)

Note: The patch differs from the upstream commit:
---
1:  f068ffdd034c9 < -:  ------------- PCI: imx6: Skip controller_id generation logic for i.MX7D
-:  ------------- > 1:  ca4fa020c1b07 Revert "PCI: imx6: Skip controller_id generation logic for i.MX7D"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

