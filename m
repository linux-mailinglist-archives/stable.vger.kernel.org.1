Return-Path: <stable+bounces-253695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJALHMrnD2q5RQYAu9opvQ
	(envelope-from <stable+bounces-253695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:21:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80BF5AF0E7
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 07:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BB793006944
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 05:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B04379C41;
	Fri, 22 May 2026 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFVZ71Eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E016619E839
	for <stable@vger.kernel.org>; Fri, 22 May 2026 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779426899; cv=none; b=fZGHL+kQSBckIVfgpK/oCz65HvD4re+DflAcygef1A9PlPD2hIaKtfFNk4D3Tz/2FGVXx9LdEY1xLPjniCYB7y+0dgPTlj9b1Z4IfjfrmdsfKiGXbuB66EUYFvS0O98uMpwqUDJiNkTmNKceFmu+06Kf3k1HT4aM/M0CBwk1PTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779426899; c=relaxed/simple;
	bh=dA0Jbw94OP9v5Eqq5b4ENxfdjIBDU4AuaC/iXD0KC88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHG1LG+E5FOOh319L9iUGHYulaL7HjjzW0kSsmQj5Lt4tKuocwoeJu5Gfq/NjF1hjZLL+fjnSWKjG0bNHOwKp9wl9pgGzWnj066dE8d94lOECtlzxm6xIhQ42d7SaqggMsHt5xxza277F189kcd+th84ihkS+cSfm4vufJGiaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFVZ71Eq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3511F000E9;
	Fri, 22 May 2026 05:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779426898;
	bh=bmn1BFDtSGP0oBGzToytufHuBiHFhs5DyCUwddSItbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFVZ71Eqc/wqu6q1RXjsWH3GbI5/OsNiz9WO/ZcKQTNLRqaWqb+bTJAgQNYUPMh/Y
	 d/PUCgjA1P5N9v0VEbA3TOozB7k5fNwModW03dH/5O5yC4aAxeJ+jew0qyfJfhM3+n
	 2zFmDhaZGkAXeBKHBYxSF67DrXjmvW9zLOPFIAX8=
Date: Fri, 22 May 2026 07:14:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Uros Bizjak <ubizjak@gmail.com>, Jan Ingvoldstad <frettled@gmail.com>,
	stable@vger.kernel.org
Subject: Re: Linux 5.15 bug in vdso_read_cpunode() in segment.h introduced in
 2025, commit ac9c408ed19d535289ca59200dd6a44a6a2d6036
Message-ID: <2026052230-obtrusive-prowler-86c2@gregkh>
References: <CAEffzkxUELNHBzABxVmekE2C_MFuPyfbsvO33MXZy46pNRU7xQ@mail.gmail.com>
 <CAFULd4Z5vE7v37+4J5MLCttnG=cF0XX+Y_T0p1yeY36dL6i5Kw@mail.gmail.com>
 <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de>
 <F51A475F-F50A-4DE2-A098-871047496301@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F51A475F-F50A-4DE2-A098-871047496301@alien8.de>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253695-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alien8.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C80BF5AF0E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 04:47:43PM +0000, Borislav Petkov wrote:
> On May 21, 2026 4:46:11 PM UTC, Borislav Petkov <bp@alien8.de> wrote:
> >+ stable
> 
> Now for real!

Ok, so what are we to do about this?

> 
> >
> >
> >On May 21, 2026 10:07:45 AM UTC, Uros Bizjak <ubizjak@gmail.com> wrote:
> >>Please see [1]. Patch 2/2 was not backportable, but was backported
> >>after it was merged with 1/2 nevertheless.
> >>
> >>[1] https://lore.kernel.org/lkml/CAFULd4aZYEi02cKeS1RAL66Qs149nLys8SJfTvfHuPH3FMXJeA@mail.gmail.com/
> >>
> >>Uros.
> >>
> >>On Thu, May 21, 2026 at 10:06 AM Jan Ingvoldstad <frettled@gmail.com> wrote:
> >>>
> >>> Hello,
> >>>
> >>> In the following commit, a bug was introduced for older systems without older binutils versions:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/arch/x86/include/asm/segment.h?id=ac9c408ed19d535289ca59200dd6a44a6a2d6036
> >>>
> >>> The commit states:
> >>>
> >>> «Use RDPID insn mnemonic while at it as the minimum binutils version of 2.30 supports it.»
> >>>
> >>> This statement is incorrect, and results in a build error on older systems:
> >>>
> >>> ./arch/x86/include/asm/segment.h:272: Error: no such instruction: `rdpid %rax'
> >>>
> >>> For Linux 5.15, the required minimum binutils version is 2.23, not 2.30 (https://www.kernel.org/doc/html/v5.15/process/changes.html); the requirement for 2.30 exists from 6.18 and up, so this bug likely affects all longterm releases before 6.18.
> >>>
> >>> While reversing the patch does result in a successful build, I am concerned that doing so introduces other bugs. Based on the commit description, it seems that the change *could* have been limited to changing "p" from int to long, and using the %k operand prefix?
> >>>
> >>> Could you please have a look at how your patch may be modified to be compatible with systems using the actual minimal binutils versions for 5.10, 5.15, 6.1, 6.6, and 6.12?
> >>> --
> >>> Kind regards,
> >>> Jan
> >
> >So why was the patch backported in the first place??

Are we to revert something?  Apply something?

lost,

greg k-h

