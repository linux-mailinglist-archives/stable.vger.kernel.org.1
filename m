Return-Path: <stable+bounces-120418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83BA4FC7E
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 11:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188393A927F
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3E20C486;
	Wed,  5 Mar 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEz9WP6+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104B20C46C
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171453; cv=none; b=MEsNzlsbfkg27fQhTU+ksSZ/CJRXH60W3J8bZYvYsIcUZYgY9y3bzfwINC2SBlHDqmsybT4QN7f+M+yjo4lICLp58vQXGaxuQfR8RwUZmtMe8UcNe5M5n8ALhcbrsx3ivRG785JscG8h0q+7+4zzB/r4e9gGTRPoW82/rE4ASHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171453; c=relaxed/simple;
	bh=pnb1XIoRVPvlKMtRz+d0FdZ4RSoph+8TZDhNZ6cm7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxBRCy/HBpmGsihxWYZnnSIi7A1iVGv0Y4lRG9YoUbpOtEyVv5sqzTvUPZvDfdCLf3kqOHE4hFk/Ni2/E0WeyTeu6O5yWtihsJXoXRFaJ+3erZahtxOw4/HbRcWbmPCSimm+C4Ooojkd46ovhG9c1SUK8zbAwAkEka5tMd4+9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEz9WP6+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+3VZ7mTjx3GCM+QoBE9ZjOyMpVhYxq40Dj4O52FkRI=;
	b=PEz9WP6+mwBjrvfBOqMa9FGo2BETADLSkhEv2L5wr1cVtsGbdExFI81NDzBx5460cXrdut
	6poD0Vtt3kADGkYfY8Dbh73gK7phE5042qwB2+dOG1zeAHIOxDEcwypJaCAvg9vLvN79kq
	Yakgoo54vubCFeadMC9jQR6cUURDvwQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-ETxo7cLJPwaNG_Y5w_7w3A-1; Wed, 05 Mar 2025 05:43:59 -0500
X-MC-Unique: ETxo7cLJPwaNG_Y5w_7w3A-1
X-Mimecast-MFC-AGG-ID: ETxo7cLJPwaNG_Y5w_7w3A_1741171439
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e897598070so143623916d6.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 02:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171439; x=1741776239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+3VZ7mTjx3GCM+QoBE9ZjOyMpVhYxq40Dj4O52FkRI=;
        b=PfBxBm7xqwEPcRmY5qu0m3QC3Y9CfRgDCK6STHmw6fOOKxy3+XIQgNYOF6ONpe2uyz
         ro7oyUIb3bMdvcvCxA3Ldxdv5v9LpeZB1+0IuFx1ykZYrrV46fHRa6EYcp89FCayWpMu
         gT816A01an8MEDsGVYZdLxb7OnVBITWabcRHF1dqX3nC1CD7AlGNS2V4Os8k9L0cj/1M
         5Nh2H0G6Rg/0v1DzmpJY7Mg5YiJel3WkrxshUl4DP6ydrUNTRGlMpa/3JhwZgL71DEo2
         R3nO0zzfA4Mg/YU9DaDyGDASGQrZizebi+n6xwMV9O2+PNCxPd6cyxOuJE+31x7/bPtj
         oTbA==
X-Forwarded-Encrypted: i=1; AJvYcCX4wUYmPln7IA1K9J6pFKLdk4yicmY0Z6y0Z0jLMp+wR8y6/2HiEwD/P/Vk/VzSi0xclkIziHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7V8jTpeDEY93CLQ6MreZidxEg5QJYgVJdlLxhqQEI4Jtuu9IH
	bivYeYVYwfp4inVPakkF0gvN8mtGplRzqpP/PBg4PgoSGw8re4bylZOgcn8Y8RBzaHRK5Mpa+re
	vcscFrJqTuCp1Cxmme/yShpq3qWu6jylnW7y1nCYAXJTQrNh0FvAuiQ==
X-Gm-Gg: ASbGncsQzM4juYkijWTYzw1PfzMB0TbGIes821GI5qABUq+IFAb0iIFz62k8dEeYMdN
	tkKCpdhQX5lk44GXZZx/z0F7ohupLPo9XzEAaJnDu7sGV0yxlJtlwmtdVyRnhirZ6WzCMOrghLQ
	zTOpkymkY8MOjh2D4VCqPebChi+43t59cGeDLuSYnRUCpqyJtEyy3DWu1NRIuWwUXcPQq5r0mMV
	1bz7deokKwzdwZpFyBEAVEO+i3AVRhMgtwF0g5eggb1XILvYhopjhRqE9qeZxOZ1t9L2Znvivl+
	FMekVybpXCBT2dhDaae64k5YKC2Zt+ln2AkSkuR8pWSA1qBBnafeCKkti660EDqrQXhMoZaTPKq
	DsTu9
X-Received: by 2002:a05:6214:2122:b0:6e8:9b55:b0ab with SMTP id 6a1803df08f44-6e8e6cc7655mr37526386d6.4.1741171438992;
        Wed, 05 Mar 2025 02:43:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdlHjzz7+7wDbWNIybVn4Volb3Dg5cZdQXTOpT7OoT7JX+QAw9eiw2fXX/FzYzQ1jmLHgwkQ==
X-Received: by 2002:a05:6214:2122:b0:6e8:9b55:b0ab with SMTP id 6a1803df08f44-6e8e6cc7655mr37526166d6.4.1741171438699;
        Wed, 05 Mar 2025 02:43:58 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976d9fb8sm77893696d6.94.2025.03.05.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:43:57 -0800 (PST)
Date: Wed, 5 Mar 2025 10:43:53 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <Z8gq6bWNPDtnUYsW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
 <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
 <9688E172-585C-423B-ACF6-8E8DEAE3AB59@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9688E172-585C-423B-ACF6-8E8DEAE3AB59@nutanix.com>

On 04/03/25 18:37, Harshit Agarwal wrote:
> Thanks Juri for pointing this out.
> I can send the fix for deadline as well. 
> Is it okay if I do it in a separate patch?

Yes, we would need a separate patch.

> From taking a quick look at the code, I can see that the same fix won’t 
> apply as is in case of deadline since it has two different callers for
> find_lock_later_rq.

Right, indeed.

> One is push_dl_task for which we can call pick_next_pushable_dl_task
> and make sure it is at the head. This is where we have the bug.

OK.

> Another one is dl_task_offline_migration which gets the task from
> dl_task_timer which in turn gets it from sched_dl_entity.
> I haven’t gone through the deadline code thoroughly but I think this race
> shouldn’t exist for the offline task (2nd) case. If that is true then the fix
> could be to check in push_dl_task if the task returned by find_lock_later_rq
> is still at the head of the queue or not.

I believe that won't work as dl_task_offline_migration() gets called in
case the replenishment timer for a task fires (to unthrottle it) and it
finds the old rq the task was running on has been offlined in the
meantime. The task is still throttled at this point and so it is not
enqueued in the dl_rq nor in the pushable task list/tree, so the check
you are adding won't work I am afraid. Maybe we can use dl_se->dl_throttled
to differentiate this different case.

Thanks,
Juri


