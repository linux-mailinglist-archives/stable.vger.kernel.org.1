Return-Path: <stable+bounces-120268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063EAA4E6C4
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A1319C54EF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2025522F;
	Tue,  4 Mar 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5tZCkHu"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB828255242
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105101; cv=none; b=gGqzcXLQGbgTDQeFdWBDc7XIuHkejjxHuMAoS422qpGfFHFxOO43XgSi0uzoOLHSka5T0zdv6hHkZd1rbiqY02ALwzMngFBHdDlSZRbGF/OhSZOz5qP1CE1iIX/yTCaMt08Z7r/GVBerGD9f2PvgmQXx5ArPmoCJcCZZd1rkYFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105101; c=relaxed/simple;
	bh=EUw6JN41FjtAkvEpNEZvohRqw0SNngFs3t0M/G8bodA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5vLCNnFycKpLbNeomlZF6oFC4eLV/o9OdJUUr9HkwUqOHQUcYosNhhOmOAoa+vqq3DztuXwrvOopsX0DotGPGrk+lco0iHGk+PBfKPG6tq8Y/PNWiP0wzLnn1XLDpQLu0DOiL5ch3slXWpLHKSmshCjkRcZ2h8JI9Xt/kDpDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5tZCkHu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741105098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JHbbkf59GK3BHCnXuBfd7al8ax8T3UploK3icFv3u0M=;
	b=F5tZCkHuZcQGiTbSb80qzQvsW/Q7fn+/PLlWd08tQDNl6eRV+gpMO2F3fv8Y1QSpscnRY8
	MAUngQwVRu2YVUHSnLJe2FYeUvXkJBzSu+OB/TgGAb+eQ8ESFAtJE7wpq1oQN/DRaptfAt
	J71jETQaAbB4C7KaojBt/bUYiV5wg3c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-J_Nifx3YM-OEr2BG8vCJww-1; Tue, 04 Mar 2025 11:18:15 -0500
X-MC-Unique: J_Nifx3YM-OEr2BG8vCJww-1
X-Mimecast-MFC-AGG-ID: J_Nifx3YM-OEr2BG8vCJww_1741105095
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e89808749eso136940066d6.3
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 08:18:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105095; x=1741709895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHbbkf59GK3BHCnXuBfd7al8ax8T3UploK3icFv3u0M=;
        b=QOXPKht42+hWefnGj0aIZ3+0kyAhxVyV0kEJOOVGwknepEK9kHBdmzDphSdjh44VFN
         tejAhEL9heHOOZVF2N16NA1J5J685xwqlVN1nFUThvOLBVktSydmzZJsxNDlZqL7ajT0
         ATSXeyOg9OBSnIatPJApNzyuiuP3jAIWYFaUUJhNcPJbGq7Uu4axJlgCrcJ57wtaRVMb
         aWj6hOxcPTFBjDqMi/7zG+lmj5QhKRn0PLZXjkeSikoA2COMTkbhiaJHCkOOBrBOtdG0
         XLvF6gc7BN+1oI6cczAEtVbhKVdXxv69FSz4CHIiIoI+VqL9U7xWJw3189m/wZk5FDkt
         rsHw==
X-Forwarded-Encrypted: i=1; AJvYcCUngWxPpUagRFhMGoCBmAsuuQJZto+rVzY22oQRglGvOevlzhaLfNkaBiFonb4vtDurXEXO+Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgULtKP5UL+6MkWaSCeEt3FuhS6WTZ3inf5pKOY9u+oGF1ko6L
	n/jh1oaFnZ5H0dT7vW9kausn67myIvwD+4K/RPjCEsqYa5W6AGL6Lom166PVWRfXdeShCO2bPSq
	kgvW0Nf8i36Je9dwkdcsK7M3w2bkV8vcpap9VKJXOXkpRtOZXh9rezw==
X-Gm-Gg: ASbGncsiPmxLWt6t7m65DBCiPq5i121kvc5bkFM8ilYqCk6Pn3c8KDomfkMOsfCvuX3
	7D1/QgYm1S4pWTBdKIAokNUH6PLUZXogjYlFW+bQlD0KQ/cAxWoww2p6e7IgE2Rtnoq5KjmTleK
	xWLIQ2x3hagCAgvyfK2aaqFPoYkELBINOrgduh0d5vk+7VmLoDQUOKuka6ksahzOCif4suTg6n+
	vf+uLQUpKX/zLL07uA9Lrub61KnrfEROFn9X0spkDgrNFxaNYeOxrSRNH+5NZ4zFSummavljs13
	lfwz5nX1RTV5sYQw+/HQDy/LoGUhVcIXk5YTmDp4GX8MhxzVmdxm0cLqTguNCsnMRQukM6rZOCl
	Bodbc
X-Received: by 2002:a05:6214:1d25:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6e8a0d2843amr244067766d6.26.1741105094802;
        Tue, 04 Mar 2025 08:18:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMZBXmxWTsjkO8lCuuk5ALhI5q/JUqSiC/jW4yEUCOQvQ6zIJ44eFdx2yvZOG7FjeiCP1pFQ==
X-Received: by 2002:a05:6214:1d25:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6e8a0d2843amr244067466d6.26.1741105094501;
        Tue, 04 Mar 2025 08:18:14 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec158sm68172966d6.119.2025.03.04.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:18:13 -0800 (PST)
Date: Tue, 4 Mar 2025 16:18:09 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Harshit Agarwal <harshit@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304103001.0f89e953@gandalf.local.home>

On 04/03/25 10:30, Steven Rostedt wrote:
> On Tue, 4 Mar 2025 09:15:55 +0000
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > As usual, we have essentially the same in deadline.c, do you think we
> > should/could implement the same fix proactively in there as well? Steve?
> > 
> 
> Probably. It would be better if we could find a way to consolidate the
> functionality so that when we fix a bug in one, the other gets fixed too.

That would be nice indeed.

Thanks,
Juri


