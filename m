Return-Path: <stable+bounces-121198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC1FA5466D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04A31895DF6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B91209F4A;
	Thu,  6 Mar 2025 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYc6XZMe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD811917D0
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253737; cv=none; b=Pp7n/e3cme2BMXvpUMCLhjccpkRWpjL+jkmuz7LoiYROhZUzIY+MHSPB1++zNAo3J+ALOeLLCIYFmh9tVFeBwIFSnGrNpxU3z12TPnFiWl0ODGUK04n5IqKC/y9VzBmH9xKE99aO9JrxBANaekZxGofSoblSe5RumbhzMaBZP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253737; c=relaxed/simple;
	bh=d0zVXr+v/Wgiq9owufdrl0TSiKuAeBy/lLTh6slUbYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8W0a9r0gXbrF3T6Jx9/yMzAnFk5bVYdHOtQON6VPeQwJ755NRo4DfnS8S0CRmJB2IjWAM8MGK+8dmY++dlW6+R9VnuM0nOZirD968WxhN1I4y+7/h6Y9cxBUVsXdDMCLOHgJghB4DwOcWxQxcQ8pqZWNafR8nwfWzT6oStPy3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYc6XZMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4Gn6RsFLMWYDAgd1mOSGDSxptCBTGDRt0g2HKO+JxY=;
	b=YYc6XZMehntATG0W9uPSCmIO2tIhEfoSCbaVmGP7hOhIk8gyDmzK0pJ1NmPbEYsZNl6ZI2
	VCyNjtjoSJCwRR79c4TWqOh47QACwkDUE2vTeTZmItQbJ8k50ZxWA5ktjoD2GEL4xkdcyr
	HipMYRdJmS2eV/U+F7AeWZEmSed6RZc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-k6QhvcBrPA6r7O63sPI0FA-1; Thu, 06 Mar 2025 04:35:33 -0500
X-MC-Unique: k6QhvcBrPA6r7O63sPI0FA-1
X-Mimecast-MFC-AGG-ID: k6QhvcBrPA6r7O63sPI0FA_1741253733
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8cf10d1c2so11515386d6.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 01:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253732; x=1741858532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4Gn6RsFLMWYDAgd1mOSGDSxptCBTGDRt0g2HKO+JxY=;
        b=PSiVtGNrnVYTVMk5ml+xAFR4kAUG/XWf0DZpe6Kug0XhYSk90DpXUUqb4H1PTd7Wdg
         R+CSp27aM88MnhI+5meGBzcWAMwIvWo5sCd6PgwXggEclu8c+aaSG6Lnc6b8yqxSVelx
         tPxfVJ9Z+h5VmPNjGmF19byAqIvms2nJnyk+/rbfMG0TZ2FS0Or5ECnyv3l1tgwi165w
         0EvK7imtZyHL8tyE8mwy7L3iekrMva57kZzy4idjdTgl2zj0x8ZdXsknAiD6pbXvRwL/
         F1LJ+NPloqXGUwjeX0fDFfxHIvAqoVqGUrPPBb7MxxNbpuN/h1sFBwjXxJSGhC3jRvAQ
         7q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZDFZ+Q3IY8QUdZzIc5TIBLvQ1NTd3cP6hU+TTQ8Hw98LrCis5aBNMHz5YiUIafml6wCqMVCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezF0SfPqZ1K568deGxv6K/DVF+1JZsp0zmE2aZcgHduQPKBRz
	tyCEM63svccVQHGSTUMfxJV0K+J5SdyTs26phOj5tjWhP+pKm6PoSDfOILOmm+FOE2o8gOzAD+k
	2WHJBT6qHllUrd09tmH0c4tz7SUVs4VvCejAfV5UOR1wk/1pXe1iqZA==
X-Gm-Gg: ASbGnctTw50BFx+5HS0RAaFzz3UcYcQUqP65L7Uq7Fr6w83MNPvplYJ7LrSfHpDQaJE
	W9RCQn+9OVF90rDK3b1khD91C9K1yDp4JtPqWUWtNp6z78IxqX36aejXsciRHXZTLr3DjI/INk4
	PZ4QBDDrDzJgDG2NJXd2U1dKWzRfLYQ8qq+keL5BWfUxYLrqCPYxd2rdlTkZSG/HOzlii6PZom9
	bziXQ5PfR8JNoK9xnA40e5qF2pDa9eI50re08qS27KWYSqUl9moHceL+wbESuB/7r6buMJbn9zM
	6stXWvdwzGafN+80BKpF1nO6kOa/tJyz/nX5oYmpR9B5QSrWqpQlEyrHsSLdKsPeOttNfOxLQuR
	i7ziS
X-Received: by 2002:a05:6214:2685:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6e8fb7ed69bmr5852696d6.33.1741253732648;
        Thu, 06 Mar 2025 01:35:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9D2PvqOQ0l2XmU4Rpj97A53jhU4Fn7KveyE0/a4OKM8y07aCbsVmiHy1x6Z7yx/4binaK1g==
X-Received: by 2002:a05:6214:2685:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6e8fb7ed69bmr5852426d6.33.1741253732352;
        Thu, 06 Mar 2025 01:35:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b5f9sm5383796d6.81.2025.03.06.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 01:35:31 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:27 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, stable@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Disable DL server on
 rcu_torture_disable_rt_throttle()
Message-ID: <Z8lsX0GDrx7Pa8vd@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306011014.2926917-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306011014.2926917-1-joelagnelf@nvidia.com>

Hi Joel,

On 05/03/25 20:10, Joel Fernandes wrote:
> Currently, RCU boost testing in rcutorture is broken because it relies on
> having RT throttling disabled. This means the test will always pass (or
> rarely fail). This occurs because recently, RT throttling was replaced
> by DL server which boosts CFS tasks even when rcutorture tried to
> disable throttling (see rcu_torture_disable_rt_throttle()). However, the
> systctl_sched_rt_runtime variable is not considered thus still allowing
> RT tasks to be preempted by CFS tasks.
> 
> Therefore this patch prevents DL server from starting when RCU torture
> sets the sysctl_sched_rt_runtime to -1.
> 
> With this patch, boosting in TREE09 fails reliably if RCU_BOOST=n.
> 
> Steven also mentioned that this could fix RT usecases where users do not
> want DL server to be interfering.
> 
> Cc: stable@vger.kernel.org
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: cea5a3472ac4 ("sched/fair: Cleanup fair_server")
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
> v1->v2:
> 	Updated Fixes tag (Steven)
> 	Moved the stoppage of DL server to fair (Juri)

I think what I suggested/wondered (sorry if I wasn't clear) is that we
might need a link between sched_rt_runtime and the fair_server per-cpu
runtime under sched/debug (i.e., sched_fair_write(), etc), otherwise one
can end up with DL server disabled and still non zero runtime on the
debug interface. This is only if we want to make that link, though;
which I am not entirely sure it is something we want to do, as we will
be stuck with an old/legacy interface if we do. Peter?

Thanks,
Juri


