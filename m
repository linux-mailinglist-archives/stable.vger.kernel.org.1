Return-Path: <stable+bounces-227852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bUz7AwM7wGl6FAQAu9opvQ
	(envelope-from <stable+bounces-227852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 19:54:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBCB2EA63A
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 19:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EB693003356
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0379C36657B;
	Sun, 22 Mar 2026 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KbmB1Xtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A23290D8
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205693; cv=none; b=Ouo25dpfeFPBuAIlsaW4Fk6PJSHldY0hFCf5rM7NWDr4CmCMuJFb2K4T/4+mvPJPQ1XIQrHOFPlykFJ8uPpelJgsnaqKFVX1YayWCqr0B3HLeC7IzC8cRZWhx+aYtLtfU5mf1LQnS0zRjFNeNTVMcqn+9cizXgAza9e6tQHUd3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205693; c=relaxed/simple;
	bh=qDXlRfkTodGjLro0lMquyx5e4JEwIwAwz0SCRLtlrF8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cH7lhj3LLl00abX2YDMZ/3la/fGfc/OFvv4GFsa/0fni8t1XBRxLo5tMDOTJtvD+UtxvOtkXYwLAdeTxb3B0iQ73LJYxDgIky4vjbiwD+EDjY0qjvIeoZZ2Ci0UB2QP1JXTJEwsseOTGocdclPs7rENtxuyJPTdyzfBdHiYNaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KbmB1Xtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C4C19424;
	Sun, 22 Mar 2026 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774205693;
	bh=qDXlRfkTodGjLro0lMquyx5e4JEwIwAwz0SCRLtlrF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbmB1XtxdXnVUQFu2CgL1CdVTVnsASwmT1kRt0MviAOlKnBlsR7NwVwhoKLCJVFgH
	 myDCAswoa1nc6i/QleE+LWmtVibq+L/5VtrmNzZT6GZIgPMpmDDQ35FXlSNZsEQsb2
	 vds9bqxUVciQ9kheMo0oOE1RJEWJhUupQ/Rqz/R4=
Date: Sun, 22 Mar 2026 11:54:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Carlier <devnexen@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, Qi Zheng
 <zhengqi.arch@bytedance.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: fix obj_cgroup leak in
 mem_cgroup_css_online() error path
Message-Id: <20260322115452.29f2ce981610faf2d7b8df32@linux-foundation.org>
In-Reply-To: <20260322164943.37460-1-devnexen@gmail.com>
References: <20260322080142.5834-1-devnexen@gmail.com>
	<20260322164943.37460-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227852-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DBCB2EA63A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 22 Mar 2026 16:49:43 +0000 David Carlier <devnexen@gmail.com> wrote:

> When obj_cgroup_alloc() fails partway through the NUMA node loop in
> mem_cgroup_css_online(), the free_objcg error path drops the extra
> reference held by pn->orig_objcg but never kills the initial percpu_ref
> from obj_cgroup_alloc() stored in pn->objcg.
> 
> Since css_offline is never called when css_online fails,
> memcg_reparent_objcgs() never runs, so the percpu_ref_kill() that
> normally drops this initial reference never executes. The obj_cgroup and
> its per-cpu ref allocations are leaked.
> 
> Clear pn->objcg via rcu_replace_pointer() and add the missing
> percpu_ref_kill() in the error path, matching the normal teardown
> sequence in memcg_reparent_objcgs().
> 
> Fixes: 098fad3e1621 ("mm: memcontrol: convert objcg to be per-memcg per-node type")

Thanks.  Sashiko review of this patch claims to have found another bug
in 098fad3e1621:

	https://sashiko.dev/#/patchset/20260322164943.37460-1-devnexen@gmail.com

> Cc: stable@vger.kernel.org


