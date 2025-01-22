Return-Path: <stable+bounces-110179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA29A1939D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14D31883F7B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56FB213E77;
	Wed, 22 Jan 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn6+MyIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793C2135CA
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555388; cv=none; b=Bs/M5NjrDfqABAKylBtZ7gucc4/VgJ5d88qinhOdoMSA3887Sl9D8Z4O7KHerh0Sz5thIiiSpCjgIAMo9oFtwT0Gx9qsyuiSZNOOkRLZ7qOdjGdz2BPjMlTVWj6UraX8EiU/yLUUBIr5jU/zIabB5hQKt5scP798CsTm1RbX+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555388; c=relaxed/simple;
	bh=swg7fyyF/HDI3SWKPXR/zHvlhIQNJRrAzjMRvu6Zq+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l5Vet8htjuZ/cEgNvI/ScBH56p9C8nS9eIXa6Ps1aVzgcef14vCmDlkle5O+T0LNUroVGvDoYEvKIIa+zFoMnVjZWFC1xBzxedOAwo+2UtIxHprZ932zdov2wekMSKU75FK2eHj/QgjJ9E41WXt66XU64K4+094+NmvB/lKF9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn6+MyIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F195EC4CED2;
	Wed, 22 Jan 2025 14:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555388;
	bh=swg7fyyF/HDI3SWKPXR/zHvlhIQNJRrAzjMRvu6Zq+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn6+MyIQzuWu+dM9Id95wyo3QaDpBTx3GyjY8HenYbdo3y2eBEB62jLXfLQf6iMHn
	 q10OTh8TBwMExqLJkTlcRvR4ryKOjRjFQYtdBKDWbmtWAHt9WsmxHJ5ipC3hEYqam0
	 RyhwDKVlNXhcv11izcLD6gQJuho1BmM8p3NgZh/jHGFVnWzpERLbmaYvdAk/B/yjo+
	 zeMN9AXYKg7xzHrod71jhfTrmPxt2Rku6nEdwjhO//5NCw+OL7ghM6l0H+g0f8Q5zN
	 S9EWkqw4q/ef1yv+82T6ARvX6GzhD1B3gpPPvWObedMnaWa2gqzw4jJY1bzlkq2Mht
	 EibvybtwWJqOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
Date: Wed, 22 Jan 2025 09:16:26 -0500
Message-Id: <20250122085621-2ab1779fc4c3e277@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <ZzU8qY92Q2QNtuyg@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: d96c77bd4eeba469bddbbb14323d2191684da82a

WARNING: Author mismatch between patch and found commit:
Backport author: Sean Christopherson<seanjc@google.com>
Commit author: Paolo Bonzini<pbonzini@redhat.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 91248a2e4101)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

