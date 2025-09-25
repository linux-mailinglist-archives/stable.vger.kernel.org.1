Return-Path: <stable+bounces-181663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A219CB9CED2
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 02:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625DE3B0E20
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 00:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A852D7DF3;
	Thu, 25 Sep 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B03GPHqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AED266B56;
	Thu, 25 Sep 2025 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761528; cv=none; b=YhGQxRvcXx2zolJ60WgmAMDlo7rlgimH0h9Jw6rW2sgBpMme9S5XGXQiU084mUj/e0eFJlMdGYZjYTERgMAxYPfhVS1sJdRGL4e/DE5BTejxVWU9thnfDaKgJ2he3gt7mtXRtgwrDm6vcv8IekG/e3YvPxwHYFSEhQ9hOQToQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761528; c=relaxed/simple;
	bh=4T9Uc1baOOm7aD/Y7ecu4SBOz/l6Ta2u4f5pFwwaU/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ot5guYIPoL736Smjp0IK6uMOtjPHeHqjq3/IUux39q9K5XCkXQ2KYEkbztquJoVxkYRUxwxHosONoziC1tujaW2+BdVrQz6eOfKWV4j0MU6HU6YQgJRQNd0c4VwwrzQ3lrEdifhHu4XVkBjEseGnAQE6OhYgreLrqag7x4sQpNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B03GPHqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE021C4CEE7;
	Thu, 25 Sep 2025 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758761527;
	bh=4T9Uc1baOOm7aD/Y7ecu4SBOz/l6Ta2u4f5pFwwaU/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B03GPHqEXFNSoAFj12gdqmEUDxjJgJlrNnFZRAMrjsiwN0DzlFF1/VsRgW70z6EmT
	 B/xxKoU+TsbzKDQjgmwWVeMY6TUXrKxDoLUIeIOvAKT9ZmoxJGuGVaQJYmiVmlH9fM
	 jo/b2zwOwm2e8CvYjMNhGwrEmy9kz8V4q59CTKnoXVMA5E4m2IrwWMEI4+sGVqDqYK
	 ori3GPqOR9vpt6d1BKHYhihhQZmtEq08kZDFc87NkDcl2ix7XtUJRUAI11W7W8MmQ1
	 uk6iI6zl9G4WKXV27Mu/zj7cZVqmP7wVEsuL9luxWtZlcm+Zwm5pZEaSBfCdvtEx4L
	 KJASNC13sSt2Q==
Date: Wed, 24 Sep 2025 14:52:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Chenglong Tang <chenglongtang@google.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	roman.gushchin@linux.dev, linux-mm@kvack.org, lakitu-dev@google.com
Subject: Re: [REGRESSION] workqueue/writeback: Severe CPU hang due to kworker
 proliferation during I/O flush and cgroup cleanup
Message-ID: <aNSSNgUeMSTtlimW@slm.duckdns.org>
References: <CAOdxtTZJqgDNMtqsq51hQ0azanFPLXHMAJ-mRhRS6yjzYhMf_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOdxtTZJqgDNMtqsq51hQ0azanFPLXHMAJ-mRhRS6yjzYhMf_A@mail.gmail.com>

On Wed, Sep 24, 2025 at 05:24:15PM -0700, Chenglong Tang wrote:
> The kernel v6.1 is good. The hang is reliably triggered(over 80% chance) on
> kernels v6.6 and 6.12 and intermittently on mainline(6.17-rc7) with the
> following steps:
> -
> 
> *Environment:* A machine with a fast SSD and a high core count (e.g.,
> Google Cloud's N2-standard-128).
> -
> 
> *Workload:* Concurrently generate a large number of files (e.g., 2 million)
> using multiple services managed by systemd-run. This creates significant
> I/O and cgroup churn.
> -
> 
> *Trigger:* After the file generation completes, terminate the systemd-run
> services.
> -
> 
> *Result:* Shortly after the services are killed, the system's CPU load
> spikes, leading to a massive number of kworker/+inode_switch_wbs threads
> and a system-wide hang/livelock where the machine becomes unresponsive (20s
> - 300s).

Sounds like:

 http://lkml.kernel.org/r/20250912103522.2935-1-jack@suse.cz

Can you see whether those patches resolve the problem?

Thanks.

-- 
tejun

