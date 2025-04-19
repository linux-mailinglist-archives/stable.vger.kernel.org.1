Return-Path: <stable+bounces-134678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1653AA9432D
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5BC1899E23
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183421C84A1;
	Sat, 19 Apr 2025 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTmR5psn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B318DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063220; cv=none; b=WYZHrYvdtF8Es+i6s410cJzNwPyimbmziXvdgXr9ZgLSd6S6d5JnjMiUjHYmxvYRub4rC1a485sv8gu8s5uCsn/6TKiUUrGjW2XZ99/AdWqEd1SLB9BmUFEwfzAlOpJzD7gyrzckhVKzCJzy61Xo/ywaBYHJlT8T8nxhI+T5seg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063220; c=relaxed/simple;
	bh=NO/vgAIzovzti8529vS0xrBf10RT3xqt3n0+fXUUznI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ajSV9wosQ0NIDtpCRkC3iyoAaQY40zW4H8m4SL2Zm1oXpxzTwy03e1kzML2HCbQXI8h8d6R+eTpOEYhyJH8DPHwM2UQdc3LgYDr8hPSO66PqDDkdSXlD1/sW5YkDRqvjIQHV8nkys3umo7v0l+DPgCt+gL0bkcXmdgLdvUlKWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTmR5psn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A2AC4CEE7;
	Sat, 19 Apr 2025 11:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063220;
	bh=NO/vgAIzovzti8529vS0xrBf10RT3xqt3n0+fXUUznI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kTmR5psncST7Sqm98bNRPBCakGfSIRamAAPZ7Ds+U0cFO+PTxKfADLqxtCOOhIHkG
	 7rEoGkhXilGLBj4qcChZf9t6seIm9FsTxgpdmgdCLqLYkx3bZlHrwksTnVJ3LnpXCE
	 niXDyJaSI10DeFjHhzkgTuuFzx7dgwmX1u9DXCiDc2CTPmMiTP+GxHZzWBtKhTGSnF
	 AfzcbRat4IruI/HIoSr/6wbdd1maPenReY8aX0btnhHF2qMKSVU7gm2cXRZz59aRN7
	 ttLdYY2gIoqOTuo7XAMTpa3/ahlaJQO7ret3r6NhQeWkq7tzzgosQSjUznh7Vh4dZ8
	 lqIWOFa4av0OQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 3/3] mptcp: sockopt: fix getting IPV6_V6ONLY
Date: Sat, 19 Apr 2025 07:46:58 -0400
Message-Id: <20250418203720-3d69b1c33b49f395@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418164556.3926588-8-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 8c39633759885b6ff85f6d96cf445560e74df5e8

Status in newer kernel trees:
6.14.y | Present (different SHA1: 233afced24eb)
6.13.y | Present (different SHA1: 41e890efe9aa)
6.12.y | Present (different SHA1: acc1f6a05ab2)
6.6.y | Present (different SHA1: 51893ff3b0f8)
6.1.y | Present (different SHA1: 0fb46064c253)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8c39633759885 < -:  ------------- mptcp: sockopt: fix getting IPV6_V6ONLY
-:  ------------- > 1:  be06d8825e39d mptcp: sockopt: fix getting IPV6_V6ONLY
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

