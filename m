Return-Path: <stable+bounces-89524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7A9B990D
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 20:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696881C213DC
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D901D0F50;
	Fri,  1 Nov 2024 19:55:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C82A1CACF2;
	Fri,  1 Nov 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490917; cv=none; b=aJWhAWUXnMYf0/JJTzX/khnp7u7rdfIaeDExTaizpTG6jHrU2IAvrT8pdOsMfRiGvPVdoLKDk/H7XGcCBsK1aE8mXRfuytT0AkdMPTuzkfFHzEXXy0bsDCDhUPsgBunPxXs0aq2T14mJAiDKjaM0FNzq/t8uhvY2cCxZclINUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490917; c=relaxed/simple;
	bh=95gL1TFoXYVZqDY/XPQZEdvtTkbWp2aXpDUJQ1uG3PQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=oPnaDn+9TVLbyPNEAbjC9k+UVzPBxZ+bwaLZ91F1wDve31ebwZYS71MVz53bmFqP7QQNS1TR6BPQ7wbeL/tG7G29JIr5FzbBG9Wwwr4dXxl9Quac8PtfqRD06xzezRxapbP5s16e2nq2RE03O/mncaVkQGI2FN/qnDAqgDaXPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:34666)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6xjl-000SRy-La; Fri, 01 Nov 2024 13:55:13 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:58310 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6xjk-00CQGp-BK; Fri, 01 Nov 2024 13:55:13 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org,  Andrei Vagin <avagin@google.com>,  Kees
 Cook <kees@kernel.org>,  Alexey Gladkov <legion@kernel.org>,
  stable@vger.kernel.org
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
Date: Fri, 01 Nov 2024 14:51:00 -0500
In-Reply-To: <20241031200438.2951287-1-roman.gushchin@linux.dev> (Roman
	Gushchin's message of "Thu, 31 Oct 2024 20:04:38 +0000")
Message-ID: <87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t6xjk-00CQGp-BK;;;mid=<87zfmi3f8b.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+CX1NesoCLIVSguniXg58rmTf8tdMTbbc=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4286]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Roman Gushchin <roman.gushchin@linux.dev>
X-Spam-Relay-Country: 
X-Spam-Timing: total 631 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.5%), parse: 0.98 (0.2%),
	 extract_message_metadata: 16 (2.5%), get_uri_detail_list: 3.1 (0.5%),
	tests_pri_-2000: 21 (3.4%), tests_pri_-1000: 2.2 (0.3%),
	tests_pri_-950: 1.13 (0.2%), tests_pri_-900: 0.90 (0.1%),
	tests_pri_-90: 161 (25.6%), check_bayes: 159 (25.1%), b_tokenize: 17
	(2.7%), b_tok_get_all: 11 (1.7%), b_comp_prob: 4.8 (0.8%),
	b_tok_touch_all: 121 (19.2%), b_finish: 0.99 (0.2%), tests_pri_0: 404
	(64.0%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 2.7
	(0.4%), poll_dns_idle: 0.62 (0.1%), tests_pri_10: 1.99 (0.3%),
	tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: restore the override_rlimit logic
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, legion@kernel.org, kees@kernel.org, avagin@google.com, linux-kernel@vger.kernel.org, roman.gushchin@linux.dev
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Roman Gushchin <roman.gushchin@linux.dev> writes:

> Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
> ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
> of signals. However now it's enforced unconditionally, even if
> override_rlimit is set.

Not true.

It added a limit on the number of siginfo structures that
a container may allocate.  Have you tried not limiting your
container?

>This behavior change caused production issues.

> For example, if the limit is reached and a process receives a SIGSEGV
> signal, sigqueue_alloc fails to allocate the necessary resources for the
> signal delivery, preventing the signal from being delivered with
> siginfo. This prevents the process from correctly identifying the fault
> address and handling the error. From the user-space perspective,
> applications are unaware that the limit has been reached and that the
> siginfo is effectively 'corrupted'. This can lead to unpredictable
> behavior and crashes, as we observed with java applications.

Note.  There are always conditions when the allocation may fail.
The structure is allocated with __GFP_ATOMIC so it is much more likely
to fail than a typical kernel memory allocation.

But I agree it does look like there is a quality of implementation issue
here.

> Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
> skip the comparison to max there if override_rlimit is set. This
> effectively restores the old behavior.

Instead please just give the container and unlimited number of siginfo
structures it can play with.

The maximum for rlimit(RLIM_SIGPENDING) is the rlimit(RLIM_SIGPENDING)
value when the user namespace is created.

Given that it took 3 and half years to report this.  I am going to
say this really looks like a userspace bug.



Beyond that your patch is actually buggy, and should not be applied.

If we want to change the semantics and ignore the maximum number of
pending signals in a container (when override_rlimit is set) then
the code should change the computation of the max value (pegging it at
LONG_MAX) and not ignore it.

As it is the patch below disables the check that keeps the ucount
counters from wrapping around.  That makes it possible for someone to
overflow those counters and get into all kinds of trouble.

Eric


> Fixes: d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Co-developed-by: Andrei Vagin <avagin@google.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Alexey Gladkov <legion@kernel.org>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/user_namespace.h | 3 ++-
>  kernel/signal.c                | 3 ++-
>  kernel/ucount.c                | 5 +++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> index 3625096d5f85..7183e5aca282 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -141,7 +141,8 @@ static inline long get_rlimit_value(struct ucounts *ucounts, enum rlimit_type ty
>  
>  long inc_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
>  bool dec_rlimit_ucounts(struct ucounts *ucounts, enum rlimit_type type, long v);
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type);
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> +			    bool override_rlimit);
>  void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type);
>  bool is_rlimit_overlimit(struct ucounts *ucounts, enum rlimit_type type, unsigned long max);
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 4344860ffcac..cbabb2d05e0a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -419,7 +419,8 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
>  	 */
>  	rcu_read_lock();
>  	ucounts = task_ucounts(t);
> -	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING);
> +	sigpending = inc_rlimit_get_ucounts(ucounts, UCOUNT_RLIMIT_SIGPENDING,
> +					    override_rlimit);
>  	rcu_read_unlock();
>  	if (!sigpending)
>  		return NULL;
> diff --git a/kernel/ucount.c b/kernel/ucount.c
> index 16c0ea1cb432..046b3d57ebb4 100644
> --- a/kernel/ucount.c
> +++ b/kernel/ucount.c
> @@ -307,7 +307,8 @@ void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  	do_dec_rlimit_put_ucounts(ucounts, NULL, type);
>  }
>  
> -long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
> +long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type,
> +			    bool override_rlimit)
>  {
>  	/* Caller must hold a reference to ucounts */
>  	struct ucounts *iter;
> @@ -316,7 +317,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
>  
>  	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
>  		long new = atomic_long_add_return(1, &iter->rlimit[type]);
> -		if (new < 0 || new > max)
> +		if (new < 0 || (!override_rlimit && (new > max)))
>  			goto unwind;
>  		if (iter == ucounts)
>  			ret = new;

