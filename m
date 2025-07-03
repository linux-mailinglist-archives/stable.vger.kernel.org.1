Return-Path: <stable+bounces-160102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D2AF8036
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2761CA2C52
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0182F531B;
	Thu,  3 Jul 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAs7wVKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34DB2F49E9
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567685; cv=none; b=KlpTWJbsReO2/iuVY4CU0jDgTxozs/K1n1SH/F24sJmHVZjCVQin3CNJPCk8Dm7pDgTvKZIqWSVwztAo5GkN3gq2mJ9wo4S+qLFNT+m99zjoNWdOkTJV0rC+i1ctuy9Exvj8EjBe3mpHCQgF9OPA1AaASJYjdbFHvZfSmcFXMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567685; c=relaxed/simple;
	bh=eNnglS8q4VrnGdBMnd92cxiZ9Os6xdI9Ehtvqk3L0Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBlUNSzptRMJE/8eYS58Ip8lcBkGBlh4+G6xP8R/1CyicuyR96AtZ1AYC4ixK/vm9CeNBi+TBwPS4wX6sZ7YcU3gda68bViv0n4ZKjzqrGSFshRaetwB5/m2TmXoIGm8COKXxcyGB1Ks3AWVCXvk7PjpuBqtSWAOxppq/p1l9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAs7wVKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31742C4CEE3;
	Thu,  3 Jul 2025 18:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567682;
	bh=eNnglS8q4VrnGdBMnd92cxiZ9Os6xdI9Ehtvqk3L0Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAs7wVKxKBrCBoCVsgbmR9mAywHZuEHSzgBAcMyYlLsiZCj65qDmp6f/X6MWu3HD6
	 sqctsmVqZ9ECtlj7kYqbll/n+0arWXayThcmKf1ZsJH3GG7/AW+TupoBdW6JvMJLOV
	 OW7bjAgjiKrS5Z4UmddCXTh4l/ULB9xB8zNTdgKSrMN0GuYdkn2G6yzRNAOkOPLQBW
	 7LlLJ4RVcLyRJc5Fg9kay7GEoZ4m+hoWcX5f+9XpeemINKmyVi8Dea1W1WwIjk2plI
	 gA1mZwyxUlOtMnL3hO1R83+cUssDPiWTNiy7TgZgYcGg7oMQjOCIDXHJtshn2GSRlB
	 Tlx5wh1bk09yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] Revert "ipv6: save dontfrag in cork"
Date: Thu,  3 Jul 2025 14:34:40 -0400
Message-Id: <20250703111431-bead69e7c565ee0d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702114113.2512-2-bacs@librecast.net>
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
6.1.y | Present (different SHA1: 4f809be95d9f)
5.15.y | Present (different SHA1: 2b572c409811)

Note: The patch differs from the upstream commit:
---
1:  a18dfa9925b9e < -:  ------------- ipv6: save dontfrag in cork
-:  ------------- > 1:  c6ed53575069f Revert "ipv6: save dontfrag in cork"
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

