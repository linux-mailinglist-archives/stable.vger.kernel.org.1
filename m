Return-Path: <stable+bounces-254213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TWYFOtq5FGoOPwcAu9opvQ
	(envelope-from <stable+bounces-254213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:06:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5C45CECC7
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C34D3015888
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF26332621;
	Mon, 25 May 2026 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="mJPc4NnU"
X-Original-To: stable@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1144246778;
	Mon, 25 May 2026 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743186; cv=none; b=qdyOyUt2zo/OnenKG+gfmBZAVWygjjqo4cn5QWYDN03+F4sip8fecvn7DkSw8Rt81BbtilSu64i5GqxrUqETTj14ocFpQ8OacBIcEoy57VvsZlOrisQZicihguoIRs+6SoEg69iLS19evwa5BkA3dOE+onWl/+RC9Dm63rnMLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743186; c=relaxed/simple;
	bh=4Fko27QxyQJ3iwZmvSIB8DFp161HDuumBHTwdRH4Vz0=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=UiPeEcvWVKrdkXTEVScP+f6zSC6r9rNFyA8F4aPOcLVXUCxzmZKU4y5BHPHbB1Y94AN3epHr6zHFHUiAs40BB0rgoxJWAHmDlMfa2+mBH2RWDBJocpmr6K+PNAkLfzNGEeTVCWw7DcCZ2oQMUDBCSvBsQLuPP8dBkPCH+d5V90U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=mJPc4NnU; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4Fko27QxyQJ3iwZmvSIB8DFp161HDuumBHTwdRH4Vz0=; b=mJPc4NnUdJJ8GOVIJNcLABA0gC
	Bi0i+5tapKMaA+U3KUVSwVYFHzf32I0jKnXpODV322bCSBcljtXJZWLNBurKvc4JHEHSBxAtLx2G3
	VhGeZxns/7su4xdDnYOMXKGbnS4r9YqqMJJIjgmtlC4CH4IwOwGb0DgLnYaFH2tWEQI0=;
Received: from in01.mta.xmission.com ([166.70.13.51]:32914)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wRbPV-00Cfdy-CP; Mon, 25 May 2026 13:56:25 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:49450 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1wRbPU-003d4d-2B; Mon, 25 May 2026 13:56:25 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,
 Arjan van de Ven <arjan@linux.intel.com>,  Jake Edge <jake@lwn.net>,
 linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org, Kees Cook <keescook@chromium.org> ,
 Oleg Nesterov <oleg@redhat.com> 
In-Reply-To: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
	(Jann Horn's message of "Mon, 18 May 2026 18:35:14 +0200")
References: <20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33@google.com>
Date: Mon, 25 May 2026 14:56:19 -0500
Message-ID: <87ik8b2rh8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1wRbPU-003d4d-2B;;;mid=<87ik8b2rh8.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/uJCaudyMDocTlnS+yEEa12ZejkOKFcZo=
X-Spam-Level: *******
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.5 XMSubPhish11 Phishy Language Subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  1.0 XM_Body_Dirty_Words Contains a dirty word
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
	*  0.0 TR_XM_SB_Phish Phishing flag in subject of message
	*  1.5 XM_B_SpammyTLD3 Phishing rule with uncommon/spammy TLD Combo
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 830 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 4.4 (0.5%), b_tie_ro: 3.1 (0.4%), parse: 1.23
	(0.1%), extract_message_metadata: 13 (1.5%), get_uri_detail_list: 2.8
	(0.3%), tests_pri_-2000: 3.7 (0.5%), tests_pri_-1000: 1.98 (0.2%),
	tests_pri_-950: 0.97 (0.1%), tests_pri_-900: 0.78 (0.1%),
	tests_pri_-90: 76 (9.1%), check_bayes: 75 (9.0%), b_tokenize: 7 (0.9%),
	 b_tok_get_all: 10 (1.2%), b_comp_prob: 2.4 (0.3%), b_tok_touch_all:
	52 (6.3%), b_finish: 0.71 (0.1%), tests_pri_0: 426 (51.3%),
	check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 2.6 (0.3%),
	poll_dns_idle: 287 (34.6%), tests_pri_10: 1.64 (0.2%), tests_pri_500:
	298 (35.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] proc: protect ptrace_may_access() with
 exec_update_lock
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: oleg@redhat.com, keescook@chromium.org, stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, jake@lwn.net, arjan@linux.intel.com, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, jannh@google.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[xmission.com:s=xmission];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[xmission.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[xmission.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[ebiederm@xmission.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.903];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,email.froward.int.ebiederm.org:mid]
X-Rspamd-Queue-Id: 3C5C45CECC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


I have added a couple more people who might be interested.

Kees Cook because as you have structured this it is an exec problem.

Oleg Nesterov as he is knowledgable about ptrace.

Jann Horn <jannh@google.com> writes:

> My understanding is that procfs is effectively maintained by the VFS
> maintainers (though scripts/get_maintainer.pl claims that there are
> no maintainers for procfs because the VFS entry only claims files
> directly in fs/, and the procfs entry has no maintainers listed on
> it).
>
> In procfs, most uses of ptrace_may_access() should use
> exec_update_lock to avoid TOCTOU issues with concurrent privileged
> execve() (like setuid binary execution).
>
> This series doesn't fix all the remaining issues in procfs, but it fixes
> the easy cases for now; I will probably follow up with fixes for the
> gnarlier cases later unless someone else wants to do that.
>
> I have checked that procfs files still work with these changes and that
> CONFIG_PROVE_LOCKING=y doesn't generate any warnings.
>
> (checkpatch complains about missing argument names in
> proc_op::proc_get_link, but that was already the case before my
> patch.)


I think I finally have my context paged back in so I can intelligently
say something about this series.

The scenario you are worried about is when exec gains privileges,
and we read through proc and authenticate with the old credentials
instead of the new credentials.

Question 1.

Assuming the executable is world readable (which they generally are)
is there anything that becomes accessible in that race that was
not already accessible?

Question 2.

How does this race compare to racing with setresuid?
Do we need to fix the setresuid case as well?

Question 3.
Do we care about the case when a privileged process calls a setuid
process and drops privileges?

Question 4.
Is it possible to use a seq_lock instead of reader writer semaphore?
Or is that only for non-sleeping readers?

There have been a number of nasty cases lurking in the background
involving seccomp filters, PTRACE_EVENT_EXIT, de_thread and the like.

Blocking locks, especially ones that get widely used, just scare me in
this area.  Being able to see that something happened between start and
finish and say -EAGAIN or retrying internally seems like it would be
much less prone to weirdness.

The ugly with PTRACE_EVENT_EXIT as I recall is that if ptrace stops one
of the threads (not the one calling exec) at PTRACE_EVENT_EXIT it can
block de_thread, which blocks the rest of exec.  But there is something
in there where the ptracer hangs waiting for the exec to complete.  So
everything just stalls.  The ptracer waiting for exec the exec waiting
for the ptracer.  SIGKILL can get you out of that mess last I looked.
Still it is an ugly mess.

Getting everything away from that mess is why we have exec_update_lock
instead of just cred_guard_mutex.


I would really appreciate hearing the scenarios you are aiming to fix
and how this fixes them.  There are enough races and special cases
I don't feel comfortable reading that we just need exec_update_lock
around ptrace_may_access.  It is not clear to me that is sufficient
to close the small races we are worried about here.

If I could trace through someone else's logic I could be convinced
and the next people to deal with the code could look at it and see
ah.  That is the detail that was missed when it has to be fixed again.

Eric


> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Jann Horn (2):
>       proc: protect ptrace_may_access() with exec_update_lock (part 1)
>       proc: protect ptrace_may_access() with exec_update_lock (FD links)
>
>  fs/proc/array.c      |   6 ++
>  fs/proc/base.c       | 159 ++++++++++++++++++++++-----------------------------
>  fs/proc/fd.c         |  27 ++++-----
>  fs/proc/internal.h   |   2 +-
>  fs/proc/namespaces.c |  12 ++++
>  5 files changed, 97 insertions(+), 109 deletions(-)
> ---
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> change-id: 20260518-procfs-lockfix-part1-5dca2d95bc12
>
> --  
> Jann Horn <jannh@google.com>

