Return-Path: <stable+bounces-144422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8878AAB768A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D4D8C7C57
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E2229551D;
	Wed, 14 May 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfrS3m32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9810295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253602; cv=none; b=a6JShebqnByCp6XpUdSPkzYOlqVTzdNtgxG5S32Dv32iEsBfpxq9hCYm8bkEHPF1PyYJYTiqmrYl6nXfs8VoUdoqnazhGg7SFpzCMnT9oPd87LGTMQm8dgPD5hosUbVOolJjiAHPTuNo9R5fUDCU1DJWhZHvl1CxQOBLui7NMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253602; c=relaxed/simple;
	bh=AITvdPJspmNFHwuy0yawinHK8e3dPRdkt1hb5iBxaYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqJkG9xMM4vIU8DRO2C73wteLanNvnzVyLW4bZsSD0YIWY4oNiW/YPJjxVHjBjzuGBRC6Dxg5Eng+aXeN8+kNMkDYcbJCiH4PXBOvmZLP4Qo4akiS27GLWY86jdX9vOaZyp932HXEYNtDrgG2FA5EPlIKJ4Jsq9k5cAOrgU+P1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfrS3m32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5849C4CEE3;
	Wed, 14 May 2025 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253602;
	bh=AITvdPJspmNFHwuy0yawinHK8e3dPRdkt1hb5iBxaYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfrS3m32YxH3nixQjchRez+mCNiqzZ2CBkBee6/8zCd4u6pkW+ms10urlpRrFtz+F
	 WQMOfxz1lmQrbB7o2c02/Aw/SFly5RnhD6Hr2AjwqJ7OsjiPofNl/J+h3MvW/3Wy8w
	 Gb7A8bejG5PPJh1xdbWPAxVo8rQAT/Wpyv72kBJcmc8FPDPFQI0ZCTWq8b6XhiGEjD
	 g6bCTISYEEr6u8P2DLgebIXZ3sg6r3lQEnJYCxZf1r+QiokFZSdNGI/+O26Bq6WRq6
	 kSOzah4Z+jGvUpiRUb9EMeivqUWUAIHK90ZqBZKjE+/VZ50aoWsv1+8nzYxHze+TZa
	 wpYANEcce8jHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
Date: Wed, 14 May 2025 16:13:19 -0400
Message-Id: <20250514092610-01bcd587cbd7463d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250514124748.168922-1-mathias.nyman@linux.intel.com>
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

The upstream commit SHA1 provided is correct: cab63934c33b12c0d1e9f4da7450928057f2c142

Note: The patch differs from the upstream commit:
---
1:  cab63934c33b1 < -:  ------------- xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
-:  ------------- > 1:  e2d3e1fdb5301 Linux 6.14.6
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

