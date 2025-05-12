Return-Path: <stable+bounces-144015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B541AB44CD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD06B3AA710
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127DD2989BD;
	Mon, 12 May 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA3ytf3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D19297B90
	for <stable@vger.kernel.org>; Mon, 12 May 2025 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077600; cv=none; b=qU4WwZFa+Cua+kL47feSovQX1P2tehVWcASY7KfvkH1ouI5OlRdNPMzkLEKb7RaLRFV6EkVuFiWkbpKBVIxnKn4g1GGPGJzt6EAPa4KAKHDv0V/GCJVLoYaxdjSHSQYEzYCcIBTYcwYCDH5oRwzlHOCwHpI80/8A3phl1gLQME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077600; c=relaxed/simple;
	bh=Q6UJshaAenv1ZGMvkETITmAxvI6Gqszwy9TveJ9KnHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrffBSPw6i8Eo2qJNw9hG6qS2953MUa7BMo1aUHKeB7q97wTZC5uXYbL8qWRFndWQPwu4U/QDk2SG/n2GckDsb2UtTOrZ8TILgWcFOXcSaGzRoyRdNEb7tbNl3xZTzzAaVfLEskrQs0SvmmCf3DHb7WpbH0UsWZEwQ7j+ZZ32qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA3ytf3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B341DC4CEE7;
	Mon, 12 May 2025 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747077600;
	bh=Q6UJshaAenv1ZGMvkETITmAxvI6Gqszwy9TveJ9KnHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RA3ytf3SVTiXg+Ln7OvQBWv6EJxat0Id2RONz1XOe8vg1OTpQyTbAL8rfezQ+VJ37
	 XaFHRUbs3LbvjMb2hpmtQW6yn3L+WsqqqnCtQOzDH3AfdmIFJ3ZpLpm0lqX/Z4fnHo
	 SOvqSGX6K8CVPlWzx6/eL0AYbYsBLDj57ZABJlXvFfZf0D/tLzlrAlCTRXk8NOtMEf
	 +oqOK+1cs1ssL0piYG6f26Ti245z5f8MtrYmMhIrxU+LbOlt6CZ+TFuHy4PR22Mctj
	 LVIm7dy0EKPoBzH/fNYmeKjO2ASvskfHqKfClWKntXFw4ri0w5j3mzoIYTGGsA83IH
	 DNmj7bAL76fRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bin.lan.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Mon, 12 May 2025 15:19:55 -0400
Message-Id: <20250511203337-469c4f81716e356b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509062802.481959-1-bin.lan.cn@windriver.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: e56aac6e5a25630645607b6856d4b2a17b2311a5

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Dan Carpenter<dan.carpenter@linaro.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 56971710cd54)
6.6.y | Present (different SHA1: 0e66fd8e5a2e)
6.1.y | Not found

Found fixes commits:
b0e525d7a22e usb: typec: fix pm usage counter imbalance in ucsi_ccg_sync_control()

Note: The patch differs from the upstream commit:
---
1:  e56aac6e5a256 < -:  ------------- usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
-:  ------------- > 1:  7aed843847a13 usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

