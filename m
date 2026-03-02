Return-Path: <stable+bounces-222728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO8tERITpmnlJgAAu9opvQ
	(envelope-from <stable+bounces-222728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:45:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8491E5E11
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 456BD350EF50
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F4C367F43;
	Mon,  2 Mar 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ADEiaxQ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59914326952
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486579; cv=none; b=bwgcX0OeVgCsDFKr6Y3JUbCyjdQPTgZgRYl9Irw02fXvpx4PxssEs+wGNkURcPS2pJuF5Py/0mLMSqqcWJ2YYb24ETYXZPjddH04D+6NP+y5r62/7K4ivUnjgIyXlb9zRhRK/0SZlvMrRyUmRcVsXMNYBWWGGj1jiJUJrGjOsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486579; c=relaxed/simple;
	bh=fgGG8AS/9VVzNKyjjd1Wzv9JQAwG0/2kOH1gucms7X8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tt64LBum3EJKZ1qz0shjmeH7gP06R7EMHkr+cg++yRWgLET3v9E2zvGXM7XjxCR4V0rJ93C5DDfNF8NOG0KBizYCDFMoyXR+uTrgCSj+EQR97/sqWipvxQ41kF4qjBh4mRLGHNWNRFi76sXyPpbRz2nRnfbzVe4WKHJLtoFh32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ADEiaxQ8; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772486571; x=1772745771;
	bh=Hd/awoLykZWPmcw7RKtq+jyNd2IAFLkiTLB+uqCtcEg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ADEiaxQ8WpJYiry0qJuaVgu1JRDNpiKxNGZkPMXwyRn/ZoHShDonhnHBPGpli7+es
	 Wprc947pnB//ZffYGS/I/+mjBAUgyXgPziNnkilFjKpvpMi0nQTwyIQzsl4nUYK3Ym
	 8TPGfFCVKSK5hWCvEH2YR22RZnxdHPTRKIfTf/eDtW+RM7ClSdPyKrudb11X5D/NnU
	 /USnYlUWa2Lohn+qhPNHrZFxnlSIJweOcAEc+tTvswTJUzRvR6I0u8cIc07vwBeNC7
	 A7PssxMP7+xGpqiBYmf9SFJBlu2OGSG3M5HZidMMYm34tttmWURCrEhitmu2O1ANKb
	 LQyGcQBYy+8Uw==
Date: Mon, 02 Mar 2026 21:22:47 +0000
To: Borislav Petkov <bp@alien8.de>
From: Maciej Wieczor-Retman <m.wieczorretman@pm.me>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Farrah Chen <farrah.chen@intel.com>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] x86/cpu: Clear feature bits disabled at compile-time
Message-ID: <aaX_EBPkvou6POYe@wieczorr-mobl1.localdomain>
In-Reply-To: <20260302205947.GJaaX6Q5Qx6vJMdun0@fat_crate.local>
References: <cover.1772453012.git.m.wieczorretman@pm.me> <cb4c2a6a0e67320b24244658b724acc1bf9686ef.1772453012.git.m.wieczorretman@pm.me> <20260302193142.GBaaXlnu86gUtPyQG6@fat_crate.local> <aaXmP1pOU_feTVu9@wieczorr-mobl1.localdomain> <20260302202504.GIaaXyIAQnaHTdzN52@fat_crate.local> <aaXz0ENy6iq2DuxX@wieczorr-mobl1.localdomain> <20260302205947.GJaaX6Q5Qx6vJMdun0@fat_crate.local>
Feedback-ID: 164464600:user:proton
X-Pm-Message-ID: ffb98a3c0127dd99f4d89467025dad26d8900f58
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A8491E5E11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222728-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pm.me:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.wieczorretman@pm.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wieczorr-mobl1.localdomain:mid,pm.me:dkim]
X-Rspamd-Action: no action

On 2026-03-02 at 21:59:47 +0100, Borislav Petkov wrote:
>On Mon, Mar 02, 2026 at 08:38:35PM +0000, Maciej Wieczor-Retman wrote:
>> I don't think it's some big threat. But then would you agree it'd be a g=
ood idea
>> to backport a change to the documentation that the cpuinfo isn't as reli=
able as
>> the documentation entry says it is? I would imagine the documentation sh=
ould be
>> kept as accurate as possible.
>
>Point me to which rule your argumentation applies, pls:
>
>Documentation/process/stable-kernel-rules.rst
>
>--
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

Maybe it could fall under the 'some "oh, that's not good" issue'? :)

But I see your point, I'll drop sending it to stable.

--=20
Kind regards
Maciej Wiecz=C3=B3r-Retman


