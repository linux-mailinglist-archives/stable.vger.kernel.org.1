Return-Path: <stable+bounces-144432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E448DAB768E
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6A07A3ED1
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9749295503;
	Wed, 14 May 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy8mvdRT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992A1F866B
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253641; cv=none; b=d0mXMg2WxYnB4u36iczZza3rEdPlW0DcFDraxZUY5PW3+Me+zgRcZO/6bKGaHtneHHYJB6z0a9JAQr/6C5RWJ7scYFRv08BBKGx44RdWsBKi8HqJlPdx1mB54W2uwLur0kjBjeAnlJC3ZUXpdJZeABrHfZ3hPp7TDyGHqPKnOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253641; c=relaxed/simple;
	bh=9YFcABwodLzi5ERygHqQc9bP/jdroG+78H3wQlLgnMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOzeDdcdaNR/ndQbTRbi8dIxXo2fvVbflo0uzDsxCU3oDiWBVWBlu+3LSTd4eY3m4Bv32OjlKgdBXiqd4VNerRd7xogXZbRcn+OhCtZ9hNimySplNDwzN3mj00z44klYFHC/GPcnpiLrmGbMWSSGLmHYj5y4QDGUIHxTidcy6uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy8mvdRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67007C4CEE3;
	Wed, 14 May 2025 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253641;
	bh=9YFcABwodLzi5ERygHqQc9bP/jdroG+78H3wQlLgnMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iy8mvdRTWl0NkCyIF61GE/i6LEOZdiK96U5F2w6HMFrxhDTQJJqEH7Pnx66tnLBtX
	 6fPDGX9dtzpJiyY0FpJkR+mSckML3XJcJNvkDK/BW2dEgWTN3MEHsfa++CMTDB7Cs5
	 /lZW7626msrpIkGHURCXLL3B+1CWRrZ9h7alJBmjqtojCQOct6lWMr/kMiRGUEh8kc
	 Sbe6957OVo/A1GAPY2vRWH2jZaynKaPTUrbzvoF/i3GraWfbX4mOWES6J6w+ZsLy1+
	 KaGX0VSdKnwYDH8BWrBxls1ThBj1Pb95x6AfspF4wdkJA95dB5pGr9HIhVpVEaZbPn
	 RoS8G2Isgf7uA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 3/3] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Wed, 14 May 2025 16:13:58 -0400
Message-Id: <20250514103913-be7bb918882f7725@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-fixes-6-1-v1-3-757b4ab02c79@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  02b72ccb5f9df Linux 6.1.138
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

