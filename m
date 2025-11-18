Return-Path: <stable+bounces-195098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B8C68DCE
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E29E34D96E
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 10:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D4A30E84D;
	Tue, 18 Nov 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqk7n7eZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C127E1D5;
	Tue, 18 Nov 2025 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461850; cv=none; b=V8JV5NQLxSjJhUyqCns2vQSAJHmdz8Pa1JnOh44Bd+t4JAHGBuuzQhHPp6fx3aiO9wCOWMMzL1NOtLa4YKlW5O4EyRsuPyZ5fDNKeXRyJQBeGV4oRUBh+F6ni+HcLktefypu3olvRrc/OdaTrpNWPmuizzrfOKTaj2iPXDtAb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461850; c=relaxed/simple;
	bh=97rveo2IXOkr8UnydUJWTQGyrsAxOU77Y7PsYTPIAL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9WG2gCwaF9JFZXLdIvKzujsDzkwfGsmNxgroYDcMNagJKvCVXDpOer0871dfqGTaezAIebAfdBGMlqgnKt9h32BDQFxVhrQZLRCC+kITZ55h7GCEoljz9kMBjHrvAMjeXfHLzwDU8Nk4Qymq1RajLEa2XgymTnl59OIJUdKcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqk7n7eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AAEC2BCC7;
	Tue, 18 Nov 2025 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763461849;
	bh=97rveo2IXOkr8UnydUJWTQGyrsAxOU77Y7PsYTPIAL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqk7n7eZ8ANWuGK4G/j8wdCO+hGb0dXf7hZP6q3I8b/IKwfWr8ldB3KHDJajm/J+o
	 nVEGXH3pyv3oDwdWfOCs0qVkYM6OwY3nYnCxnoOujFs4ioWSMyHrdk+xtGf3R710ut
	 eHEkBXw2MZzCgFQSlybQDpo/xshHEzz56G/zGL9XIa39y9cM4N/ly0EbVbWUuGKbz9
	 kKZlhGoNzjhc9lSSdjtt1GcyMFSG6x+RtSpfEpxU6Qcf6emCDPNFeNQ3zPM/dJiMu3
	 pfjbBit3vCPDO3jQv01R9VLxcfK3zw5G7O/62m1WVFMuatKDe3jea4VgoxkAVgyr8t
	 ADkxOpDYe3lSw==
Date: Tue, 18 Nov 2025 11:30:38 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] unshare: Fix nsproxy leak on set_cred_ucounts() error
 path
Message-ID: <aRxKzrX5np4YpS19@example.org>
References: <20251118064552.936962-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118064552.936962-1-ptikhomirov@virtuozzo.com>

On Tue, Nov 18, 2025 at 02:45:50PM +0800, Pavel Tikhomirov wrote:
> If unshare_nsproxy_namespaces() successfully creates the new_nsproxy,
> but then set_cred_ucounts() fails, on its error path there is no cleanup
> for new_nsproxy, so it is leaked. Let's fix that by freeing new_nsproxy
> if it's not NULL on this error path.
> 
> Fixes: 905ae01c4ae2a ("Add a reference to ucounts for each cred")
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Cc: stable@vger.kernel.org 
Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  kernel/fork.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3da0f08615a95..6f7332e3e0c8c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3133,8 +3133,11 @@ int ksys_unshare(unsigned long unshare_flags)
>  
>  	if (new_cred) {
>  		err = set_cred_ucounts(new_cred);
> -		if (err)
> +		if (err) {
> +			if (new_nsproxy)
> +				free_nsproxy(new_nsproxy);
>  			goto bad_unshare_cleanup_cred;
> +		}
>  	}
>  
>  	if (new_fs || new_fd || do_sysvsem || new_cred || new_nsproxy) {
> -- 
> 2.51.1
> 

-- 
Rgrds, legion


