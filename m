Return-Path: <stable+bounces-126710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E807A7174E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 14:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DC1898252
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91C21E5B96;
	Wed, 26 Mar 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU7JodmN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D11E5721
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995118; cv=none; b=sEE0JFshbTyoTTA0Q/hQLcoENAvMM4eCusv0J3+kc9B48HYXJSEzLILLgvv5M3biITkf/FFYNunMxXuQ+F3FDSjFW6YLkJSofL1XQeA/1dl2oTVlL81Az5nZ+6OL5XzXjXy3Jnw5Q9yyDaIHs0fpXLr6PS7Vy8FIOSnehpFiZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995118; c=relaxed/simple;
	bh=QLuJch2ERBqlv87gIUZKCCRf5Bhm6d2MbEPzKoCKVYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZ38kSXyrF5WbUbycaPnuaSzMr4tWx5oxV0X3ZIiEtrgYNp5JuCM3o6HzewZKbqKb1nG/7maJD3tStRUG0GE3f1/UaK6sGJJ45BNI6Qg+CxZveB/ZLhxUblbUDNbHoQk5hSvHt66jtkC2natTInHzxQq0S9V3P5WV5eM8D9PViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU7JodmN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742995114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8DVK2qL5FgbCY/uCKHMn6ye/SpMLqPirFZ8FryqEe8=;
	b=gU7JodmNMIkXEWDZXQlxpwzlkFh3F1Jq3aD7d5tsiHmK44lW2DH0aZ3s4xUGvZobKpl+y2
	y09+XK+k31zxlKVbSjG3W8GTGOBBVEdHmFFCIDnHU3NsAPXrQfKmRScozdTByXc9ukxRij
	lxs8EUv3p6nS5Q89IJrKlHfcIK/PRcw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-4onCRed-MtuYlvOKWRoB1A-1; Wed,
 26 Mar 2025 09:18:30 -0400
X-MC-Unique: 4onCRed-MtuYlvOKWRoB1A-1
X-Mimecast-MFC-AGG-ID: 4onCRed-MtuYlvOKWRoB1A_1742995108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 065BE1933B50;
	Wed, 26 Mar 2025 13:18:28 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.205])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BE10180A803;
	Wed, 26 Mar 2025 13:18:24 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:18:21 -0400
From: Phil Auld <pauld@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Harshit Agarwal <harshit@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <20250326131821.GA144611@pauld.westford.csb>
References: <20250214170844.201692-1-harshit@nutanix.com>
 <20250217115409.05599bd2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217115409.05599bd2@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Feb 17, 2025 at 11:54:09AM -0500 Steven Rostedt wrote:
> On Fri, 14 Feb 2025 17:08:44 +0000
> Harshit Agarwal <harshit@nutanix.com> wrote:
> 
> > Co-developed-by: Jon Kohler <jon@nutanix.com>
> > Signed-off-by: Jon Kohler <jon@nutanix.com>
> > Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> > Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> > Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> > Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> > Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> > Tested-by: Will Ton <william.ton@nutanix.com>
> > ---
> > Changes in v2:
> > - As per Steve's suggestion, removed some checks that are done after
> >   obtaining the lock that are no longer needed with the addition of new
> >   check.
> > - Moved up is_migration_disabled check.
> > - Link to v1:
> >   https://lore.kernel.org/lkml/20250211054646.23987-1-harshit@nutanix.com/
> > ---
> >  kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
> >  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>

We've got some cases that look to be hitting this as well.

I'm a little concerned about turning some runtime checks into
BUG_ON()s but in this case I think we are really just going to
trap out on !has_pushable_tasks() check first and if not, pick
a different task and don't drop the lock so it should pass the
BUG_ON()s and fail to match the original task.  So...

Reviewed-by: Phil Auld <pauld@redhat.com>



Cheers,
Phil

> Peter or Ingo,
> 
> Care to take his patch
> 
> Thanks,
> 
> -- Steve
> 

-- 


