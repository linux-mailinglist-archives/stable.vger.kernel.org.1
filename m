Return-Path: <stable+bounces-125780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD6A6C180
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD747A8696
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9B822D79F;
	Fri, 21 Mar 2025 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6fBMgHd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082F1DEFFC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578186; cv=none; b=fJt9gI1ySoO1YZ0SZuGrUS9LCjQ1lvu7x1xEQRepcMFldnDy15hk5OnvZbfKX+i3Lc0JDqxac6EXwkQvn+o0XkcvPN9TScm26pEd8M14ism0ZMV+ZzZaxyHQxY0XgCSSplBuyZmtE3VhzN7H2GUXySzTlak4xikN68l/jsPLDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578186; c=relaxed/simple;
	bh=HszzOyKs+iljEmJTwVisd8n62XxkCE/7Qm24CDSn+N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6JAsa+Rfydnzrz5DVojrcWnwQLB5QFNKIO6kB162MBAVZ5QgByN/jnWS3zb0Yxkq2hnR5KmqEgICA8T29K7v94pvfteAD4UmZcF9seVtjAi4B+ljRN/7m7emA/AjU7GyUpf3hPY96Y15DHDwByd42HzXrvc900NZJUn6RT4yCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6fBMgHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1441CC4CEE3;
	Fri, 21 Mar 2025 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578185;
	bh=HszzOyKs+iljEmJTwVisd8n62XxkCE/7Qm24CDSn+N8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6fBMgHdoei/zpQ68ieHamYbwI2bLPNyE3l4POnnZApHC8F63MdyZ+vpWmGAzaRvQ
	 mROLy/iFNCo97GPg/B3QF1WpZCiyk3eVSu/TxyNNDq6ECni0SVXEb+yY/fU1Qp9Hut
	 8DaOSKXAf5q/KQHoV/B7Db/wO1JC73lzicC7mfOArKCwI7egqBP5W2KWSk04JzdlZY
	 DPaQPrEp7Cgh39zVZny/AnECjPqrGnpbSTutcaWgjsqeicorY5v5fSmFH2Kwhbpr5x
	 tmCLeQ+1X/9zxMSJWjOn4uzu7Z3ZXE3Rl4vThElwIzcyJpnipKcP9hsLoC6aIx2gK4
	 eeDVQXuJ2XeBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 8/8] KVM: arm64: Eagerly switch ZCR_EL{1,2}
Date: Fri, 21 Mar 2025 13:29:33 -0400
Message-Id: <20250321123838-32204d9ff1988e33@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-8-0b3a6a14ea53@kernel.org>
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

The upstream commit SHA1 provided is correct: 59419f10045bc955d2229819c7cf7a8b0b9c5b59

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 69fedc3eecf4)
6.12.y | Present (different SHA1: 9fa40dcf88c9)

Note: The patch differs from the upstream commit:
---
1:  59419f10045bc < -:  ------------- KVM: arm64: Eagerly switch ZCR_EL{1,2}
-:  ------------- > 1:  c16e8204920ff KVM: arm64: Eagerly switch ZCR_EL{1,2}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

