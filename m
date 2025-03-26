Return-Path: <stable+bounces-126786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E996A71E45
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20B37A413C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F25724C09B;
	Wed, 26 Mar 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN1CpGSb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610EC24A077
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013565; cv=none; b=FtK/Vj32Dxr6yMMZ8mImFaROTGUIBUV/+wSc51Nyzevc+4vPsDqA3He8T75JSnqKa2SkDJxExj0BVGbc7NqZy1wat4UZwc/g2T/JGNKjgnN8VLTs5cYw0575O5KiPqGHhWbHW1eRzHmXmyHYpaYYJ/Hq02xiEyrY7JUjn9U65P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013565; c=relaxed/simple;
	bh=4a6MJVACf8plBUVwu7XMhK2bh2PQqvPirvejVyArCyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moUOP0zwy5cRI2OyyCX5iOCgde2J9P6ngktmXi/CEvLUS/k9NkUVaZhT/ifb5wcuiIV2RKmuUOIaBpdFKWhOjhtva+D/JpKkWc+ltiLMBUJWY6uKlNjy3gkHXZZAzgSs9uKaIvblLMbfjr3+HVb+LvXgz+AlZBP/r4uU2bsW27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GN1CpGSb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743013562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqF23292VQn0OS5nUGd1NykBkUqFN4AceX8/gqxGmQk=;
	b=GN1CpGSbUPVe7ClfDvnCgs3MwcR4jlZ4XqJbYdoiB4RNWnpYuKG0gVRsRPzycZLtWMK6dU
	WynZLNP/7hd94VI5UxB1ygjTNn6J94dvsOvJBiHQp6RGykw0iHGqAgH+oXrjyjoE94lN5k
	rLENkrV9FY4G6GRGH8MNxeG/q76dmtI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-x8HxVPtyPpOYrTsOH4ngJg-1; Wed,
 26 Mar 2025 14:25:59 -0400
X-MC-Unique: x8HxVPtyPpOYrTsOH4ngJg-1
X-Mimecast-MFC-AGG-ID: x8HxVPtyPpOYrTsOH4ngJg_1743013556
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFB7F19560B1;
	Wed, 26 Mar 2025 18:25:55 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.205])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 320E719541A5;
	Wed, 26 Mar 2025 18:25:52 +0000 (UTC)
Date: Wed, 26 Mar 2025 14:25:49 -0400
From: Phil Auld <pauld@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <20250326182549.GB167702@pauld.westford.csb>
References: <20250214170844.201692-1-harshit@nutanix.com>
 <20250217115409.05599bd2@gandalf.local.home>
 <20250326131821.GA144611@pauld.westford.csb>
 <801794EB-9075-4097-9355-76A042B62FB5@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <801794EB-9075-4097-9355-76A042B62FB5@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Mar 26, 2025 at 05:57:23PM +0000 Harshit Agarwal wrote:
> 
> 
> > On Mar 26, 2025, at 6:18 AM, Phil Auld <pauld@redhat.com> wrote:
> >> 
> > 
> > We've got some cases that look to be hitting this as well.
> > 
> > I'm a little concerned about turning some runtime checks into
> > BUG_ON()s but in this case I think we are really just going to
> > trap out on !has_pushable_tasks() check first and if not, pick
> > a different task and don't drop the lock so it should pass the
> > BUG_ON()s and fail to match the original task.  So...
> > 
> > Reviewed-by: Phil Auld <pauld@redhat.com>
> > 
> 
> Thanks Phil for your review. Just FYI this is the link to
> v3 (latest version) of this change 
> https://lore.kernel.org/lkml/20250225180553.167995-1-harshit@nutanix.com/
> No change here in the code w.r.t v2. I had just updated the
> commit message to add stable maintainers.
>

Ah cool, thanks I missed that.  So my pinging/reviewing here might not
help get it in. Let me see if I can find that and reply to it :)


Cheers,
Phil


> Regards,
> Harshit

-- 


