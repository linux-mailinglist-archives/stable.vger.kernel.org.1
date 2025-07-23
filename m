Return-Path: <stable+bounces-164371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7311AB0E99C
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27DB56350E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6A8149C7B;
	Wed, 23 Jul 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liYHADIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16A2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245232; cv=none; b=Tdcw5mwjF/8GeeYrYaqcXRUPLNdcGjoB0KVCCzOCg4qAH/pWAc/Mo+/4Y9VtSb8vFKvqoqcRVIsKPPbfgNkVh9K3wvc8RUKbdLBvCYj8gQVQw6/dRGFuC1F5fgDKksiD3Ej0CDhRktSdBahtKCWNgHRnNwF2qHT8tLfwAPLiOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245232; c=relaxed/simple;
	bh=0rIPfBpWMYm5RbZ1q67xFuWwfQLgY+X1spg9ESV6VSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+/A4DUM2/dT0XNMKKl4Z9QOINj90CS2ujBEBc6VKDzzfoTJTKalXV4kOfy15bKVkR0RRlEiSQ//fBIOm4Oog6M6ZoVPSMtO2tpoqqgteW9ycRpVNHvoD1C1Z5jg+4poC/aYhTDb2XmpGm1ugwoHzfi1n2p3TltlOOeE5xTeK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liYHADIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E861C4CEE7;
	Wed, 23 Jul 2025 04:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245232;
	bh=0rIPfBpWMYm5RbZ1q67xFuWwfQLgY+X1spg9ESV6VSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=liYHADIuW8Ym6VquTItFeUifmprf54AYzRaVKL8EO6Bo5uXa/qLGZURU2E1MNLcpr
	 FAFIr7KkQ1aC+bZmL9rIcFojS9TohZDSozgIz6hC6xS/WhjiRcs4RYYxiIfbSlW2Tv
	 VJTbjdi03hypU4Wh5XWObVFRipn8w8qkpWyLQ3nLufssqp1/4GGRigkZo/UG3TrVFg
	 Ph7WY832G/fo3u/b6HIPztU96WfXeLAedHoq15ZZ/wtchSRt7IIEfuNLFa7VLU9dfs
	 ILq3vdqLj8kr/LBY8iytFpsDGB3yzZAG1emKftm1m4jp747qqtCNvRPSBBymNH33yO
	 aiTDGzTb/OEVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	giovanni.cabiddu@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 v2] crypto: qat - fix ring to service map for QAT GEN4
Date: Wed, 23 Jul 2025 00:33:49 -0400
Message-Id: <1753226943-64f06291@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722150910.6768-1-giovanni.cabiddu@intel.com>
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

The upstream commit SHA1 provided is correct: a238487f7965d102794ed9f8aff0b667cd2ae886

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 82e4aa18bb6d)

Found fixes commits:
df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx

Note: The patch differs from the upstream commit:
---
1:  a238487f7965 < -:  ------------ crypto: qat - fix ring to service map for QAT GEN4
-:  ------------ > 1:  58ce42abb968 crypto: qat - fix ring to service map for QAT GEN4

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |

