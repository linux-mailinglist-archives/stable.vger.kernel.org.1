Return-Path: <stable+bounces-222713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJavGvn8pWnvIgAAu9opvQ
	(envelope-from <stable+bounces-222713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:11:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAEE1E1F3E
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D86730FDBEB
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F90B3AA78B;
	Mon,  2 Mar 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IeLsr4Ae"
X-Original-To: stable@vger.kernel.org
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D53AE1BB
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483921; cv=none; b=f5gi1zJ0qPHeBWjIWOAVRaVRRAN7tJ5WjPirRrJv5AnBZt/hwq74w7m7dFY03sn5xo1RdLc+pRoSe7DYPQacOoCOZIi1w592dL9ytrYap/qrAojyBMFdU8Dbwcg9w198nhWMSKvUXEbT77snwalqr3gJv+GW37RbG6eU3YQOel8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483921; c=relaxed/simple;
	bh=gktXXbam6ntPTHcBfzv3YUEtIlefEdqomFngrPRlFyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+pCdG7160EqDYO+/zIz2ZN6Sg/7aJ8sJr2chqH0G1ZD/mkk8NhrROCMOxwzyYglgvPN/IJtqX7+IykvUJKlHaPcfPsjALAwjnrH3fpfQCCU/OmQyPuLycATOiINrjiJu/YvSqaFH96AeWdl19NlThbKgmo2POscNG5JZaZGu7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IeLsr4Ae; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772483917; x=1772743117;
	bh=gktXXbam6ntPTHcBfzv3YUEtIlefEdqomFngrPRlFyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IeLsr4AeAoHlKHa+SOpnUqnvEfZPvg28jkAXsC2xTXU+ls2yI74fkBj69aBoKK0J3
	 vRbohRwuOJcdOBCu+9XolJlQODqW1FodXz34XJL/RhfZYjlz9SIVFgDzfjSwOxLVvG
	 6eP4qupO7NSvpnwHrrzfibe3ZFCaa8lAngzzkueuZUyiA+zVVeoUolYn/vUg1Q6ZTx
	 nyg4VogdwwO13Nr7ZF2Yr5S+pusw/YKhc8URwfT2Qz31qf5bonSrSSo36MlhvfdkAG
	 bqKJCgPPZ6XfhkUV+H19uZpMOwVQLrHrRxXVRx7P85GhBHOoMlHY0SkRWHr0C0XHf5
	 Kzhg9JBgqZKxQ==
Date: Mon, 02 Mar 2026 20:38:35 +0000
To: Borislav Petkov <bp@alien8.de>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <aaXz0ENy6iq2DuxX@wieczorr-mobl1.localdomain>
In-Reply-To: <20260302202504.GIaaXyIAQnaHTdzN52@fat_crate.local>
References: <cover.1772453012.git.m.wieczorretman@pm.me> <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me> <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local> <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain> <20260302202504.GIaaXyIAQnaHTdzN52@fat_crate.local>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: 88bc59ca0b008142b4f795b2f9d4de6ef1f932cf
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DDAEE1E1F3E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222713-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pm.me:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pm.me:dkim]
X-Rspamd-Action: no action

On 2026-03-02 at 21:25:04 +0100, Borislav Petkov wrote:
>On Mon, Mar 02, 2026 at 07:48:41PM +0000, Maciej Wieczor-Retman wrote:
>> The documentation from at least 5.10 onwards promises to have flags in c=
puinfo
>> only if they're truly compiled and enabled. So I thought that incosisten=
cy can
>> be corrected from that point on. For the 6.18 stable kernel this particu=
lar
>> patch applies cleanly because it already started using the awk script. F=
or the
>> older ones I took Greg's advice and prepared separate patch that worked =
before
>> the awk script was introduced.
>
>I don't think you got my question, lemme try again:=20
>
>How serious is this bug so that you want to backport it to stable?
>
>So what if some flags appear in /proc/cpuinfo even if they're not compiled=
 in?
>
>Is the cat going to catch fire or no one cares...?
>
>IOW, does it really need to go to stable and if so, what's the grave bug i=
t is
>fixing?

I don't think it's some big threat. But then would you agree it'd be a good=
 idea
to backport a change to the documentation that the cpuinfo isn't as reliabl=
e as
the documentation entry says it is? I would imagine the documentation shoul=
d be
kept as accurate as possible.

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


