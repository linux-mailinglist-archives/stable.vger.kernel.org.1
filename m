Return-Path: <stable+bounces-89531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF919B99BA
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB791F214D3
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47181E2315;
	Fri,  1 Nov 2024 20:58:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894E168DA;
	Fri,  1 Nov 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494699; cv=none; b=Z5I+jnpCGhtjNJUqi+aM46rSowHVVDRM7ip8zx4uyuINdrhrkGtlYilBNwVJgiKsRem632e4beNT4+6JW8lkPXD7mqk/UThGAxWEvEVCc6fNOavZCjLAheEVeVpw03jlamgEXiyDrCwXKuTb8QgqXu3XzOYTUsiom+254dPYuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494699; c=relaxed/simple;
	bh=wM5F2MoqeUldCrgjuxiEXfId7YhxL7NazUjn/wdUFn4=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=BnqKqOpYho5xmtiN8J84am4yV4U/RYkf8T6PzIo1Y4TKJ5IHZpuiyd00NWmH5JWmvoradd0AX72HBZvwlqjR/LzJV7FfO75VeNzsbrQodLWMBXJ4hvC7C0gElr4Yn/d8+L42uzpI73F9fpKXn8qlo/jECEUwEImaqQjpCKK6i/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:35126)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6yik-000Xdi-Q5; Fri, 01 Nov 2024 14:58:15 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:43058 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1t6yij-00DBDy-QX; Fri, 01 Nov 2024 14:58:14 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-kernel@vger.kernel.org,  Andrei Vagin <avagin@google.com>,  Kees
 Cook <kees@kernel.org>,  Alexey Gladkov <legion@kernel.org>,
  stable@vger.kernel.org
References: <20241031200438.2951287-1-roman.gushchin@linux.dev>
	<87zfmi3f8b.fsf@email.froward.int.ebiederm.org>
	<ZyU8UNKLNfAi-U8F@google.com>
Date: Fri, 01 Nov 2024 15:58:07 -0500
In-Reply-To: <ZyU8UNKLNfAi-U8F@google.com> (Roman Gushchin's message of "Fri,
	1 Nov 2024 20:38:40 +0000")
Message-ID: <87o72y3c4g.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1t6yij-00DBDy-QX;;;mid=<87o72y3c4g.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18YM0p06uj2VuDktBx8fhDPerYYvdr1wZU=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4550]
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Roman Gushchin <roman.gushchin@linux.dev>
X-Spam-Relay-Country: 
X-Spam-Timing: total 402 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 12 (2.9%), b_tie_ro: 10 (2.4%), parse: 0.85
	(0.2%), extract_message_metadata: 14 (3.5%), get_uri_detail_list: 2.1
	(0.5%), tests_pri_-2000: 21 (5.3%), tests_pri_-1000: 2.1 (0.5%),
	tests_pri_-950: 1.05 (0.3%), tests_pri_-900: 0.87 (0.2%),
	tests_pri_-90: 54 (13.5%), check_bayes: 53 (13.2%), b_tokenize: 7
	(1.7%), b_tok_get_all: 8 (2.1%), b_comp_prob: 2.6 (0.6%),
	b_tok_touch_all: 32 (8.1%), b_finish: 0.80 (0.2%), tests_pri_0: 275
	(68.5%), check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 1.90
	(0.5%), poll_dns_idle: 0.25 (0.1%), tests_pri_10: 3.8 (1.0%),
	tests_pri_500: 13 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: restore the override_rlimit logic
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, legion@kernel.org, kees@kernel.org, avagin@google.com, linux-kernel@vger.kernel.org, roman.gushchin@linux.dev
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Roman Gushchin <roman.gushchin@linux.dev> writes:

> On Fri, Nov 01, 2024 at 02:51:00PM -0500, Eric W. Biederman wrote:
>> Roman Gushchin <roman.gushchin@linux.dev> writes:
>> 
>> > Prior to commit d64696905554 ("Reimplement RLIMIT_SIGPENDING on top of
>> > ucounts") UCOUNT_RLIMIT_SIGPENDING rlimit was not enforced for a class
>> > of signals. However now it's enforced unconditionally, even if
>> > override_rlimit is set.
>> 
>> Not true.
>> 
>> It added a limit on the number of siginfo structures that
>> a container may allocate.  Have you tried not limiting your
>> container?
>> 
>> >This behavior change caused production issues.
>> 
>> > For example, if the limit is reached and a process receives a SIGSEGV
>> > signal, sigqueue_alloc fails to allocate the necessary resources for the
>> > signal delivery, preventing the signal from being delivered with
>> > siginfo. This prevents the process from correctly identifying the fault
>> > address and handling the error. From the user-space perspective,
>> > applications are unaware that the limit has been reached and that the
>> > siginfo is effectively 'corrupted'. This can lead to unpredictable
>> > behavior and crashes, as we observed with java applications.
>> 
>> Note.  There are always conditions when the allocation may fail.
>> The structure is allocated with __GFP_ATOMIC so it is much more likely
>> to fail than a typical kernel memory allocation.
>> 
>> But I agree it does look like there is a quality of implementation issue
>> here.
>> 
>> > Fix this by passing override_rlimit into inc_rlimit_get_ucounts() and
>> > skip the comparison to max there if override_rlimit is set. This
>> > effectively restores the old behavior.
>> 
>> Instead please just give the container and unlimited number of siginfo
>> structures it can play with.
>
> Well, personally I'd not use this limit too, but I don't think
> "it's broken, userspace shouldn't use it" argument is valid.

I said if you don't want the limit don't use it.

A version of "Doctor it hurts when I do this". To which the doctor
replies "Don't do that then".

I was also asking that you test with the limit disabled (at user
namespace creation time) so that you can verify that is problem.

>> The maximum for rlimit(RLIM_SIGPENDING) is the rlimit(RLIM_SIGPENDING)
>> value when the user namespace is created.
>> 
>> Given that it took 3 and half years to report this.  I am going to
>> say this really looks like a userspace bug.
>
> The trick here is another bug fixed by https://lkml.org/lkml/2024/10/31/185.
> Basically it's a leak of the rlimit value.
> If a limit is set and reached in the reality, all following signals
> will not have a siginfo attached, causing applications which depend on
> handling SIGSEGV to crash.

I will take a deeper look at the patch you are referring to.

>> Beyond that your patch is actually buggy, and should not be applied.
>> 
>> If we want to change the semantics and ignore the maximum number of
>> pending signals in a container (when override_rlimit is set) then
>> the code should change the computation of the max value (pegging it at
>> LONG_MAX) and not ignore it.
>
> Hm, isn't the unconditional (new < 0) enough to capture the overflow?
> Actually I'm not sure I understand how "long new" can be "> LONG_MAX"
> anyway.

Agreed "new < 0" should catch that, but still splitting the logic
between the calculation of max and the test of max is quite confusing.
It makes much more sense to put the logic into the calculate of max.

Eric

