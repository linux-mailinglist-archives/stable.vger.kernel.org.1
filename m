Return-Path: <stable+bounces-134706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E0A9434A
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11429189AB35
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9C1D63E1;
	Sat, 19 Apr 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLD1CINV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154CB1D63D8
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063448; cv=none; b=EO1Doc71gj82tdnHvL9RU15Zk5tgjLsnmA6YliFgwUL9cMRZMYCoJ3rZEP3eSbHBPcCS4sSx2xW/uhVSSyzO9Jz7fss23s5HWsDwCJ7OzqmCEDxgmVs6iclvuhlhK7rbS2HQCu0V3LHb61OY2iBaZ+xGqc68d1ZSg8hP+8yqbQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063448; c=relaxed/simple;
	bh=cTONtWI9ap4kYLWJo3/mjdHI7w87B69j7aOECqyF0gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgrZgpqcAcup+Y5bDUtZa7X+DDBUZsBlaxqYdRTHKvikttfTVZwk2mEMExFjB7NyIjnXOUQ2wFLgowBVRGbI6+8pz0GUDcdCPdK3sD3iEceEe/D4/g9F1aceVt90dyKGUAja0eq+NMF4u7ZI9705u2AM4Fs9qec4AEF5yAACWtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLD1CINV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1D1C4CEE7;
	Sat, 19 Apr 2025 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063447;
	bh=cTONtWI9ap4kYLWJo3/mjdHI7w87B69j7aOECqyF0gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLD1CINVvgDCKxZ2k60PnGsbp/72mSKZQPsiS9KMEQovdYwnYuFU5Uig4VYA7f7Xv
	 GozHdLwxzO8vrgtQq3HVJttbCCqCe7HumyfcKd+wptWHePWsKHt5bq3NixvRCNZqLf
	 8w93HdBbtX53W9Nbzue+9HRdZ79BYtvpDXk6oZSrp/TnONFL+liis1EPPiXnFeUg5f
	 h4E+PVcfkPibN+1F7AH5l9KZO5ftlint0UXtNZmXy5GZhHXNSmjWRgKPXrbqZNn1Bi
	 4Ff1jXecAovWh+UE5LRYmGGgbo1uRlFKsQLgEiyZKk7h6pUaygNecT3SGLBJSXce2/
	 EVg1IsVisyLqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	marmarek@invisiblethingslab.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y and others] cpufreq: Reference count policy in cpufreq_update_limits()
Date: Sat, 19 Apr 2025 07:50:46 -0400
Message-Id: <20250418200224-f13c7b3ffe6c36e2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418021517.1960418-1-marmarek@invisiblethingslab.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 9e4e249018d208678888bdf22f6b652728106528

WARNING: Author mismatch between patch and found commit:
Backport author: <marmarek@invisiblethingslab.com>
Commit author: Rafael J. Wysocki<rafael.j.wysocki@intel.com>

Note: The patch differs from the upstream commit:
---
1:  9e4e249018d20 ! 1:  cd95c6b965176 cpufreq: Reference count policy in cpufreq_update_limits()
    @@ Commit message
         Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
         Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
         Link: https://patch.msgid.link/1928789.tdWV9SEqCh@rjwysocki.net
    +    (cherry picked from commit 9e4e249018d208678888bdf22f6b652728106528)
    +    [do not use __free(cpufreq_cpu_put) in a backport]
    +    Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
     
      ## drivers/cpufreq/cpufreq.c ##
     @@ drivers/cpufreq/cpufreq.c: EXPORT_SYMBOL(cpufreq_update_policy);
       */
      void cpufreq_update_limits(unsigned int cpu)
      {
    -+	struct cpufreq_policy *policy __free(put_cpufreq_policy);
    ++	struct cpufreq_policy *policy;
     +
     +	policy = cpufreq_cpu_get(cpu);
     +	if (!policy)
    @@ drivers/cpufreq/cpufreq.c: EXPORT_SYMBOL(cpufreq_update_policy);
      	if (cpufreq_driver->update_limits)
      		cpufreq_driver->update_limits(cpu);
      	else
    + 		cpufreq_update_policy(cpu);
    ++
    ++	cpufreq_cpu_put(policy);
    + }
    + EXPORT_SYMBOL_GPL(cpufreq_update_limits);
    + 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

