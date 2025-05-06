Return-Path: <stable+bounces-141797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0FAAC234
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D977B3A74E4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36972797B5;
	Tue,  6 May 2025 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYfu3Hm1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDAB278E5A
	for <stable@vger.kernel.org>; Tue,  6 May 2025 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530098; cv=none; b=NSBppsj2L7IuXGqbHFaB4JGktRl2T/PnBX6tVSzJozg6ftlKDBPBoCBRv61BAF3SMhZmEKnTYkKae6t1CASHWZpH8p/93uy+JNTls/qD4ckk7opkILxKZovjdn7VoHIcfBSrePGV6YLpOHYpsJ0CR8sQO9/vY1ICuw2eM65i/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530098; c=relaxed/simple;
	bh=iNDXndNS0psG5zwgSqZ1ZEQgECK96DWsmfy1XbYV5TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdQnyVaSFm1U1bOf4PZAapoGyIja68wiZpDhYqlELNWqa+OLxWPj8xrlxlw12QXWbDLjQkgtMn8KQ80BFti3fE2Q/Vz5h0XsBFwu0HjflufBLAhocHPaDI8WIyb8/PgFt4BvDJwE0DpWuyTqJsU1bqKZcYAzXg4iUITgKzNcUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYfu3Hm1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746530095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPr0Ma55LXpDzIrYy137g/YiRzM88HOwoh8sYc6w+Gc=;
	b=XYfu3Hm1VjCGQMtmOyzRHyftuD4O/aHP1kZyaWWsC00HO5sjsRMva1f0O75z1gkrBM+/dU
	CloPrqK/InbZYJrm4DatIuStKvQ56dBBKkUmxjJvJiQ2WC5Y4AVostK/SmTM/Nyv5eSYIj
	LwIlVSGUqBbQe5lfscVTuC+47lAQGd0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-mH_4oftnOLenk3Um4rrXog-1; Tue,
 06 May 2025 07:14:52 -0400
X-MC-Unique: mH_4oftnOLenk3Um4rrXog-1
X-Mimecast-MFC-AGG-ID: mH_4oftnOLenk3Um4rrXog_1746530091
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 817FB180034E;
	Tue,  6 May 2025 11:14:50 +0000 (UTC)
Received: from fedora (unknown [10.44.33.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AE66018001DA;
	Tue,  6 May 2025 11:14:46 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  6 May 2025 13:14:50 +0200 (CEST)
Date: Tue, 6 May 2025 13:14:45 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	mhocko@suse.com, mjguzik@gmail.com, pasha.tatashin@soleen.com,
	alexjlzheng@tencent.com
Subject: Re: [PATCH AUTOSEL 6.14 046/642] exit: fix the usage of
 delay_group_leader->exit_code in do_notify_parent() and pidfs_exit()
Message-ID: <aBnvJYXqsfn0YG19@redhat.com>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-46-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505221419.2672473-46-sashal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

I'm on PTO until May 15, can't read the code.

Does 6.14 have pidfs_exit() ? If no, then I don't think this patch should be
backported.

Yes, do_notify_parent() can use the "wrong" exit_code too, but this is minor
and we need more changes to make it actually correct.

Oleg.

On 05/05, Sasha Levin wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit 9133607de37a4887c6f89ed937176a0a0c1ebb17 ]
> 
> Consider a process with a group leader L and a sub-thread T.
> L does sys_exit(1), then T does sys_exit_group(2).
> 
> In this case wait_task_zombie(L) will notice SIGNAL_GROUP_EXIT and use
> L->signal->group_exit_code, this is correct.
> 
> But, before that, do_notify_parent(L) called by release_task(T) will use
> L->exit_code != L->signal->group_exit_code, and this is not consistent.
> We don't really care, I think that nobody relies on the info which comes
> with SIGCHLD, if nothing else SIGCHLD < SIGRTMIN can be queued only once.
> 
> But pidfs_exit() is more problematic, I think pidfs_exit_info->exit_code
> should report ->group_exit_code in this case, just like wait_task_zombie().
> 
> TODO: with this change we can hopefully cleanup (or may be even kill) the
> similar SIGNAL_GROUP_EXIT checks, at least in wait_task_zombie().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Link: https://lore.kernel.org/r/20250324171941.GA13114@redhat.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/exit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 3485e5fc499e4..6bb59b16e33e1 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -265,6 +265,9 @@ void release_task(struct task_struct *p)
>  	leader = p->group_leader;
>  	if (leader != p && thread_group_empty(leader)
>  			&& leader->exit_state == EXIT_ZOMBIE) {
> +		/* for pidfs_exit() and do_notify_parent() */
> +		if (leader->signal->flags & SIGNAL_GROUP_EXIT)
> +			leader->exit_code = leader->signal->group_exit_code;
>  		/*
>  		 * If we were the last child thread and the leader has
>  		 * exited already, and the leader's parent ignores SIGCHLD,
> -- 
> 2.39.5
> 


