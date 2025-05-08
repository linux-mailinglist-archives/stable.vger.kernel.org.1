Return-Path: <stable+bounces-142887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA1AB001B
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1052B1C07629
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42A280A52;
	Thu,  8 May 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA0uYa1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFAF22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721087; cv=none; b=u1B30EuZYsUqWXpgoR1TcvQfIK7glGYh1naT3buB6mUrqIeMBwBkIZ2UNQPw/TgG5qFoA9rkIL7BPs4de9EduD9dpQN9CtCmT8fAFBFMuVaxIVjORr1NT4ERQqEdPX+a9XQi1r0Z+DJTI/XHDUd6GnRXVYbicfHTorpqp/9TxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721087; c=relaxed/simple;
	bh=o3XwYjs5Ryc5aIJUz/TWs5m0o3vkQAjIOfE9qLgJUcc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9btNZn91QDDH0yDjTwncILbcWLytfDyXlTHbPUgXCDi10viEd9nwBQWXEZ6cP1aj/KMlI5pdWvJWMoyM2rV8ibajGObcqi1u0138d9Hg3Kjmxopao60qmDpJPR0D3l9zkcTsJL0B5u9GlGYVcMO4McRAudryTnTKjaRsZkyEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA0uYa1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68164C4CEE7;
	Thu,  8 May 2025 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721085;
	bh=o3XwYjs5Ryc5aIJUz/TWs5m0o3vkQAjIOfE9qLgJUcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uA0uYa1flrcBan86Fc73LZzkuakfmQUhpL8mzFx7wy6Z6aSyuJF3sm5K9I9v9FnvK
	 SCmr/WusrhK4ph4D+Kt4FtrKabnJVnqEraK6FJTtHfoTAmEMtWk1WbeE9YK+MDSfQ8
	 zQMI7HvEf9QKJrs4TRtwzLqr4vKBTNHAim0QAw75nVH77ha072BmRDzPDwxTagsAi9
	 7SVg5IRLki10qnHo3FAV6d7lGFVqU+BWWRxLmzy3hOjxgsiWr9NEN5dRNeWWhRXUkC
	 UfaGGY+L2VW8qopUQs0MjEe1gM8ZIC/8bRZeWzQ+sDmoLTeDSijlLk8giRi1PqOnPp
	 CtSyoI+xZQ9OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 3/7] accel/ivpu: Fix a typo
Date: Thu,  8 May 2025 12:18:01 -0400
Message-Id: <20250507120340-6842bb4b5049b0de@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250505103334.79027-4-jacek.lawrynowicz@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 284a8908f5ec25355a831e3e2d87975d748e98dc

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jacek Lawrynowicz<jacek.lawrynowicz@linux.intel.com>
Commit author: Andrew Kreimer<algonell@gmail.com>

Note: The patch differs from the upstream commit:
---
1:  284a8908f5ec2 < -:  ------------- accel/ivpu: Fix a typo
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

