Return-Path: <stable+bounces-261905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GizqKmyIJWoaJAIAu9opvQ
	(envelope-from <stable+bounces-261905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 17:04:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B02650D0F
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 17:04:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=OemTHbqs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261905-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261905-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14092301369E
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124430D405;
	Sun,  7 Jun 2026 15:03:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076FF243387;
	Sun,  7 Jun 2026 15:03:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780844624; cv=none; b=nwLiWbH1a537sDVQ9dlnfKTzPNiTvHyJOafahoG1tjSnp2sy14nBjdH0rtTcovokqmSuQHOs8tDyHxJwJgrpuXjy4gCub5tWaawi/2NwMwbx1grzuckxwKQogBLUE6/aJJS0VAqvafM0YBGvAhMvX2bSqteCp4RpVOd7wQsg9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780844624; c=relaxed/simple;
	bh=/J5n8J3YoaYjsjj0/1RcMbmCp33LRAswhlJXies9Sbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKr1z57rKmozDzL2fbbmLUcv4crK5Jv+kRB3dDwWANtTkscLnthefpJJAs8YhZsk60Xxa5WD/4vOYawln63J6h2XcjoAk6FLW644xluV0b/Ku1HKIWOk5ksDPT3pHCo9aHFIm9gFulWp48fko20hhdwducbhfNIRrj8piqMhtRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OemTHbqs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93871F00893;
	Sun,  7 Jun 2026 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780844623;
	bh=SYGPCVsO0pzj7zz/LmnIqaKwdK1SmteuqABvRk6oT2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OemTHbqsDFvau4drDS9ZPHG7N2dLJ63KyYsaptuuMAGwqJEnHOoQR7Fx7TQjjjJm2
	 C8Et0M7tBsNHqbM3QLe5zAHx13PDWqD4jEpQHxG6H/ZIobLdhLp6NFT3N/ysB9O6ku
	 gZ4642dYOSvP8iQj+QgLYvpJuiUulWD67cfaqhO8=
Date: Sun, 7 Jun 2026 16:50:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Deepanshu Kartikey <Kartikey406@gmail.com>,
	syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,
	Michal Hocko <mhocko@suse.com>, Ben Segall <bsegall@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Kees Cook <kees@kernel.org>, Liam Howlett <liam@infradead.org>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 7.0 015/332] kernel/fork: validate exit_signal in
 kernel_clone()
Message-ID: <2026060759-anyway-straining-d394@gregkh>
References: <20260607095728.031258202@linuxfoundation.org>
 <20260607095728.598854921@linuxfoundation.org>
 <aiVOEKt9QL5cvkwz@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiVOEKt9QL5cvkwz@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261905-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:oleg@redhat.com,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:Kartikey406@gmail.com,m:syzbot+bbe6b99feefc3a0842de@syzkaller.appspotmail.com,m:mhocko@suse.com,m:bsegall@google.com,m:brauner@kernel.org,m:david@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:juri.lelli@redhat.com,m:kees@kernel.org,m:liam@infradead.org,m:ljs@kernel.org,m:mgorman@suse.de,m:rppt@kernel.org,m:peterz@infradead.org,m:rostedt@goodmis.org,m:surenb@google.com,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:penguin-kernel@i-love.sakura.ne.jp,m:akpm@linux-foundation.org,m:sashal@kernel.org,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com,syzkaller.appspotmail.com,suse.com,google.com,kernel.org,arm.com,redhat.com,infradead.org,suse.de,goodmis.org,linaro.org,i-love.sakura.ne.jp,linux-foundation.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,bbe6b99feefc3a0842de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A3B02650D0F

On Sun, Jun 07, 2026 at 12:55:12PM +0200, Oleg Nesterov wrote:
> On 06/07, Greg Kroah-Hartman wrote:
> >
> > 7.0-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Deepanshu Kartikey <kartikey406@gmail.com>
> >
> > [ Upstream commit 09e7827e785729f391c8d46dc71becce70d296ab ]
> 
> I don't think this is the -stable material.
> 
> > Note that this is a user-visible change: previously, passing an invalid
> > exit_signal to clone() was silently accepted.  The man page for clone()
> > does not document any defined behavior for invalid exit_signal values, so
> > rejecting them with -EINVAL is the correct behavior.  It is unlikely that
> > any sane application relies on passing an invalid exit_signal.
> 
> Yes...
> 
> This patch is the preparation for another commit 0f8e38eeb995b
> ("do_notify_parent: sanitize the valid_signal() checks").

Then why does it have:
	Fixes: 3f2c788a1314 ("fork: prevent accidental access to clone3 features")
in the body of the changelog?  That's why we picked it up, is that not
correct?

Should it be dropped from all stable queues then?

thanks,

greg k-h

