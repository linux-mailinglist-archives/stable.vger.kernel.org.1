Return-Path: <stable+bounces-139379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FE2AA638E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6414C2C59
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8B224B15;
	Thu,  1 May 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGHTpXR5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1CC224B04
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126641; cv=none; b=G7+kHebYM+NcoZpc0wtU2aUVUikPmbKzKxbomrEblpGIObmOA3XMqRMzWB5t4seRjtZnYpqO/0opdQQK2wpDMehw3BqdU5dkXroIJX+9EkdMEJAji0m1Q/I/PImpadUdhykwJb0fACNK+duAAMVupTwFCHo3PZMSQpeTlzlvY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126641; c=relaxed/simple;
	bh=2ri3tYbkXXjtr9AIHPu9g+iM6DfDq3HsbyD1F+KTd98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8eOuyXFb8Bo9Rro6Eb/LXgpFUwI9mRdaeYv6XobfUifsNlRIitavYxYy8WXM3P530lPaQF2kx1o6yJrsc17KCNpTi3P/kU9d+b/PlBxP46s6a9Q/RIJdFy5m8PPZPndNIBKODQ2D3pbWyMtvlpr9Rcq4XPa6nirCdwn9Cv/hvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGHTpXR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9EAC4CEE3;
	Thu,  1 May 2025 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126641;
	bh=2ri3tYbkXXjtr9AIHPu9g+iM6DfDq3HsbyD1F+KTd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGHTpXR53Rxr7GXYI+tRd5G2Ipf4/8ZVHAA7uMgLtLxgkEiujtqJ2OTUE4Xf3rlvs
	 sYQb+Fl0tAQAF1r/X0MtcQ5+0/F+pP97/z/DLLJx0v2w9fvUe9VM+f032tQgBqnuwC
	 YIUNYXMNMk9w6ZUP8HFd8qTMfWuZchJjQdxF7w6lYXv+CgA9OZTLKxE7bJFVXs2SIa
	 w6itWbv902yNdybEK5fKL3JbnFycl8sN/s6AQfGevLOLbVP+TiSLRAvsSylJUCTvlz
	 zkMDGjXaWzQgN9BT0M32P5YL2tCCp2Kz3ynclmWvW6jlIQCpZKgDEnVbTCtTDZy06i
	 C2lbIAp8ztpdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/7] accel/ivpu: Make DB_ID and JOB_ID allocations incremental
Date: Thu,  1 May 2025 15:10:36 -0400
Message-Id: <20250501114412-bc1b64ebacb1ad77@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-2-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: c3b0ec0fe0c7ebc4eb42ba60f7340ecdb7aae1a2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Tomasz Rusinowicz<tomasz.rusinowicz@intel.com>

Note: The patch differs from the upstream commit:
---
1:  c3b0ec0fe0c7e < -:  ------------- accel/ivpu: Make DB_ID and JOB_ID allocations incremental
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

