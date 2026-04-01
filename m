Return-Path: <stable+bounces-232614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJyNAqJhzGnZSgYAu9opvQ
	(envelope-from <stable+bounces-232614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:06:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C6A372FBF
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 02:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BAAD3060BF7
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 00:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2241FB1;
	Wed,  1 Apr 2026 00:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1tY15Y6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290E191;
	Wed,  1 Apr 2026 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001943; cv=none; b=O4jcJN+xwkZ2WFF5saemyedXuyXt+FDTsUWXIRZq2ut6J4FpOzIzYECTEO4N+jLYxTHLqBxXzkDYjj4q3vY8mxbOSBrLh2qmeUiGCV07XRFuP+xysP7N9N1E/CdSqe6MRN+DPnjOh+0mefAqvR9fuB6wcVTg5yYSQSqSah3tXwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001943; c=relaxed/simple;
	bh=Z5BZ/JumfybSInyb3/dNCVeo40Y5CQhBHcoIcom2nVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyj4KZmawQU1KQognmuWdmSE9ptJpxx/uCMG1URo30QwCg5uRv/KVsu3cDL5+6jPewHwMlMKDebMOu/a+3yuLFQY8twU1QEgPOPUTsxghx7LmQyqFx9SddkK2mCl6DtF9MAyprHQR3qlPDZ63Z2HREPCflTga86bRiNPOaOa2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1tY15Y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72700C19423;
	Wed,  1 Apr 2026 00:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775001942;
	bh=Z5BZ/JumfybSInyb3/dNCVeo40Y5CQhBHcoIcom2nVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1tY15Y67eOqzSQF1clsFT+4WXALa93aYxetdZUXEO07Pyd41uHHNllqhiqwpZcgH
	 ObQjjvgXDVnazSuyFWw4s0Y8i51/Cma9fZ6V5aToGc3x8ixyH2Dj4cD4p62MZMsEJK
	 zqywnUxcUnjiJmbnksDDyqn4qpUnYIUJZV10E3Kg1yFmTKPkdLp0yn/VMaQer2YeI/
	 Xvm2z1UTTd3VFBiKyV+thFTLN16OV8was8dzUW37K2AgvxpKOhoh/ZOjIF0xFGXKCc
	 +7XZauKJxOQVg434eD5fCjjJGx1ay6HMQzRGD0Fx6AA1Vuf959pblL9ziIbnPMQitS
	 4zMp/0JlgMb4Q==
Date: Tue, 31 Mar 2026 14:05:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Carlos Santa <carlos.santa@intel.com>,
	Ryan Neph <ryanneph@google.com>, stable@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] workqueue: Add pool_workqueue to pending_pwqs list when
 unplugging multiple inactive works
Message-ID: <acxhVZK_zlv1orIX@slm.duckdns.org>
References: <20260331221839.1033423-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331221839.1033423-1-matthew.brost@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232614-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,intel.com,google.com,gmail.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 74C6A372FBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Tue, Mar 31, 2026 at 03:18:39PM -0700, Matthew Brost wrote:
> @@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct workqueue_struct *wq)
>  	raw_spin_lock_irq(&pwq->pool->lock);
>  	if (pwq->plugged) {
>  		pwq->plugged = false;
> -		if (pwq_activate_first_inactive(pwq, true))
> +		if (pwq_activate_first_inactive(pwq, true)) {
> +			if (!list_empty(&pwq->inactive_works)) {
> +				struct worker_pool *pool = pwq->pool;
> +				struct wq_node_nr_active *nna =
> +					wq_node_nr_active(wq, pool->node);
> +
> +				raw_spin_lock(&nna->lock);
> +				if (list_empty(&pwq->pending_node))
> +					list_add_tail(&pwq->pending_node,
> +						      &nna->pending_pwqs);
> +				raw_spin_unlock(&nna->lock);
> +			}

It's a bit gnarly to open code locking and list operation. Would just
calling pwq_activate_first_inactive(pwq, false) one more time work here?
That'd trigger tryinc_node_nr_active() failure in pwq_tryinc_nr_active() and
the addition to the pending list. As this is quite subtle, it'd be nice to
have some comment - it's compensating for the missed pwq_tryinc_nr_active()
call due to plugging, right?

Thanks.

-- 
tejun

