Return-Path: <stable+bounces-177777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C7B44A8B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 01:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793F63B14C6
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 23:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FA2222AC;
	Thu,  4 Sep 2025 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5wfDxtI"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132972EF65E
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 23:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029609; cv=none; b=VxTkQ7YA+Zg31O5/7wHk1Re7rxWywTPnK6kCfWLQpzj3Xu5EAfskA/fW1ecevXP80wft1AZs6qZxG0Rl/yLZ2wMbuvwWfJo/4EVZXXseS/1Q14VdXDrecd44gSufdAcWGNK9DuD9xHOfZ2CTQQLPplGa2wRFu8OMUP04bonv7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029609; c=relaxed/simple;
	bh=iA3S1ACvgcS5OxfGjnxYjopkhd18w5vT+bVo4+opKNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrhLaSM7H5XWaTF+xUZ5sW/zT39FXYKta40mTtBXp8qnJF+AxnXlZe34y1Zzreo4PYnyTTIGixsY35SrUaW2a4GkOLyvVNkA8MXW55g8jaLvnObA9NBBSh09ulGnmTdNYbmVFpl1t+y8qfWL3rCNpwvx0wBYJvWjUYNyWkP5t9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5wfDxtI; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 16:46:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757029595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqKck8IQZ46DJR+L/eLjx5QE/TgVdwPRfFBH26lKqMc=;
	b=X5wfDxtIPe8XZ/0otmvcEduLlN05p6d+h7kq7MPzhgDXrQDzKZ/Zo1iYJeOnYir4OZY8kM
	ldZWNSAgetrt8ig0GX954UkxcdtONpQERHHgqH1Qz3vWLi69NLSnaP1POE8A6NarLbQ2E6
	+ZuGL0XjaJrGinUNYBPSCU+Y0DPSMQM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, stable@vger.kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Subject: Re: [PATCH] mm/memcg: v1: account event registrations and drop
 world-writable cgroup.event_control
Message-ID: <sa4mytppu6dfpquytx6jwdvak7bkyruztnr27vibbzhux2rjsl@pnrxdi5ecua3>
References: <20250904181248.5527-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904181248.5527-1-disclosure@aisle.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 04, 2025 at 09:12:48PM +0300, Stanislav Fort wrote:
> In cgroup v1, the legacy cgroup.event_control file is world-writable and allows unprivileged users to register unbounded events and thresholds. Each registration allocates kernel memory without capping or memcg charging, which can be abused to exhaust kernel memory in affected configurations.
> 
> Make the following minimal changes:
> - Account allocations with __GFP_ACCOUNT in event and threshold registration.
> - Remove CFTYPE_WORLD_WRITABLE from cgroup.event_control to make it owner-writable.
> 
> This does not affect cgroup v2. Allocations are still subject to kmem accounting being enabled, but this reduces unbounded global growth.
> 
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

