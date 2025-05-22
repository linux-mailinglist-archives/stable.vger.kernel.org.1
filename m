Return-Path: <stable+bounces-145953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723BEAC0201
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DD69E19C3
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE92B9B7;
	Thu, 22 May 2025 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQTGMiwW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25EC1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879434; cv=none; b=OVCwhGi3HBBJEc6o2hgoINvc4KXGo/6482faQoSYpvzam498nJ2jO1APMl01eBS0urKE6UKjz/exMU5AaBiRyB8y4SbT7N/YWrmtZevutY5O6wTIihTESTKSDhwvbS2LG9DLVA+Unyr7Ng6XlvpzZSc4BQ9OZBcZWrdqba7eNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879434; c=relaxed/simple;
	bh=xx3cIpIqyd7+OVNKVeA256J6ydho3MJZzqdp/WwuBa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqgeW+qY0JmT9DIqe3jM+Vd9rHjkTgZK6MD/UZI+hw/UOLNXnxo4ThLFu/jL7O66FNFxQb7klO8tdngPHiIoGQ0DIPVZi6l8zxFt5XEbkWuaI8I8k6ogvT4u0RhT838MX/61dXmgd/wsYJQt6vw1qThKRlMt+YUsVcGPYRlqYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQTGMiwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE257C4CEE4;
	Thu, 22 May 2025 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879434;
	bh=xx3cIpIqyd7+OVNKVeA256J6ydho3MJZzqdp/WwuBa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQTGMiwWdEcmAsnKD5SvJLMexoMmBrqbWAzHpJ6lMv/vSU0SDY8brIb94AWlsBSN/
	 kc3zqw9Vc/4vYXXfwaJ14IyHmyhxOVMEiZg8XKCumjwKXNTaV66Cy7JYWmI0f3vN7q
	 DX3XNAN24WcZDv6tU5K5WEfuns/+9dkSg3jVstKkHHXDV7jJftN6+jWv8p9uApx+VT
	 H581bYCjOSwby4IUngS/OROfpGwk0SSlCj+x1nQQrcOTph4NUdHb8LMLF/zjqz2cBp
	 fcCQXZUX+Gvk4+kLmUYk72WWTblMsunFygN2gtsfr/SfqXgwQMk7qGQuBmUFW11Izs
	 0FGm3ue66VRgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
Date: Wed, 21 May 2025 22:03:50 -0400
Message-Id: <20250521145353-5e9f6a84b5aa803f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521020216.539748-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: 53dac345395c0d2493cbc2f4c85fe38aef5b63f5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Frederic Weisbecker<frederic@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: e456a88bddae)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  53dac345395c0 ! 1:  d4b970537740a hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
    @@ Metadata
      ## Commit message ##
         hrtimers: Force migrate away hrtimers queued after CPUHP_AP_HRTIMERS_DYING
     
    +    [ Upstream commit 53dac345395c0d2493cbc2f4c85fe38aef5b63f5 ]
    +
         hrtimers are migrated away from the dying CPU to any online target at
         the CPUHP_AP_HRTIMERS_DYING stage in order not to delay bandwidth timers
         handling tasks involved in the CPU hotplug forward progress.
    @@ Commit message
         Link: https://lore.kernel.org/all/20250117232433.24027-1-frederic@kernel.org
         Closes: 20241213203739.1519801-1-usamaarif642@gmail.com
     
    - ## include/linux/hrtimer_defs.h ##
    -@@ include/linux/hrtimer_defs.h: struct hrtimer_cpu_base {
    +    Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
    +
    + ## include/linux/hrtimer.h ##
    +@@ include/linux/hrtimer.h: struct hrtimer_cpu_base {
      	ktime_t				softirq_expires_next;
      	struct hrtimer			*softirq_next_timer;
      	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
     +	call_single_data_t		csd;
      } ____cacheline_aligned;
      
    - 
    + static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
     
      ## kernel/time/hrtimer.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

