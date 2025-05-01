Return-Path: <stable+bounces-139388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7088AA6399
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F298351F
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB82253E9;
	Thu,  1 May 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYEcc/Ho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434881DF751
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126730; cv=none; b=I8I5OTwdgCJN6J13HeJfbGwEBrYklZbhn/W+YmF6slO7hAQeaWC2mV/p0wtMdRh3UIIRYupV4K+sWUx1XdYgWFhW6+8WxZ+kDSGUHstQwnvCrPDMb0G9pjd48j0vdJumhPd1LAVwP4qMp9kICZJMmqXZ6xBPj37YvtBSP0TIdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126730; c=relaxed/simple;
	bh=ZeZUxCDTpmy9Ygj3voUG9x1qqNvA2AsW9q1BGdCbKxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+pjxypGv6O7lGQDCfBBQea3pluKVRqCe0fgTzlFHOVtuPzUHSZ970gt6HJHmj1HONdc8BJL2/I4PVDRJ6840JUGoejRvT/xga1lvFeUYx70zSWZoZdqr7jhW/YHjByIV22rtlyWsu8tL9XA1wJy2Ip+YejeXaq3VXntstoenK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYEcc/Ho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EE6C4CEE3;
	Thu,  1 May 2025 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126730;
	bh=ZeZUxCDTpmy9Ygj3voUG9x1qqNvA2AsW9q1BGdCbKxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYEcc/HoV9f/2wkE9M4JeOEJ2d6vy9Ste+E+tSQuTGXp63KExi3NEWCYs7oCR76zk
	 Boms9GefY23z2C53QwYphbrxt/vC+NCD+Lpcicp5sqUou1CTcV7GhtAa/kGuTrDJP1
	 uS73Lh/qB3h7cAuwL94z+JQJUg0wcMU/T4guz3IHlJYcvWHlL8WimBbiRf9dcUVRqD
	 UL5fZBm81OiyPbrpiPQhLpzW5sKlwPK42v8XET+TW6+kx2q5TeVSSAqQ3tVdz8DYX2
	 eWXbKy8XoL+1jo2CIYKSURvqutWXQeb4p0Jm3ksqeRxUray8tarmqKyT+wyT7sZwmX
	 /YPw5CQZhrhUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5/7] accel/ivpu: Abort all jobs after command queue unregister
Date: Thu,  1 May 2025 15:12:06 -0400
Message-Id: <20250501115625-1c5548523711678f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430124819.3761263-6-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 5bbccadaf33eea2b879d8326ad59ae0663be47d1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Karol Wachowski<karol.wachowski@intel.com>

Note: The patch differs from the upstream commit:
---
1:  5bbccadaf33ee < -:  ------------- accel/ivpu: Abort all jobs after command queue unregister
-:  ------------- > 1:  ea061bad207e1 Linux 6.14.4
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

