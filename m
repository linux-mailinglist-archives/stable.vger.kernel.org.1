Return-Path: <stable+bounces-268219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZCBhGVMvPGpdlAgAu9opvQ
	(envelope-from <stable+bounces-268219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 21:26:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55C6C105E
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 21:26:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=RYHMlj5u;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268219-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-268219-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D255F3014272
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 19:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1EB3812F1;
	Wed, 24 Jun 2026 19:26:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978C331EDF;
	Wed, 24 Jun 2026 19:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329159; cv=none; b=P3uMPRjMLxxW6voZdcnL2VMHYhnw0HBXQq72+XGIjEbyJ196bymlkN8njyByTP5WFF7jD+UuH/6tJrV3AOowry9gKmKQuTCEW0/JcnpIguIRh+ZVDaCROeiufCQeuUDepTBKj2DW5iUE5g1MjWGBa6tFJ6Ml7PPEaJuYlj/Ym+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329159; c=relaxed/simple;
	bh=eRW7Md+JjldaGsrUD1klWO7OmLbzNaJSDOs7U856joo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITugMOIDC3TTem4ARluXVD5p1wLUH+UIkDsrSH9gnPqTpVzAIknLfYTMKvis+ukGzFk/1F+dsYt5MwA5GSJKTO4LtdkHhyH0i2Ne3Mj/p8pX48dNgeNp2azcTRqScao0tkJuCMQK9XtwpSKPMIrAEf8j3usZ3Ph49VXNjECMo6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RYHMlj5u; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BCC9540E01B4;
	Wed, 24 Jun 2026 19:25:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id n3VmArBc5l0H; Wed, 24 Jun 2026 19:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782329145; bh=vofPsZXndlgnddA1fWiHsMB5dX5k9G936mVniZ6iLFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYHMlj5u1sSGuWArFESCTv8c5gq86TEzhrSVzE3E7L/GT7CRyLsgxcZGfw4lQPpUc
	 gAtNnkjnjT+JRJ98ofajutJpqdwplWSqBI3ChdU/uuFLv0q2ZdPdLOlICGwhzUQk43
	 WVDc2yMngAeuiKpTls+l/1yCsHpskaTzwvV2DojONVqRQECqRzf9SU41WpPY7FLw9S
	 +Ngt/yZvU6k5OJ2ma2vjV0qlI/Umh82op64v0mEXBmSrNUTF2XGF3eKffhfVAKwSgN
	 LnhCCh6mEfc3Xm0Qwk+y1eKhtHWNLU7Ylvqu4SqODHc4u8QNtOaLFaxgkeFE/c24h1
	 vU/DnMVyn31Mobk9ut/6MYADGVh9TNWn/1NhCD3aYeoES0b8NNGrbzugUCVVi0cDZZ
	 l8oYed45c5jmxB/JJFpwgC6EaThF+2Ax9vUeomPk2F4v1OyuO3SmJjztb+Kn7kotfB
	 MqiP0soso3bFCBPaX2WIza52VnrdVvKLYbfflr1n0c/LiXGx6fgF/2wKaCxhUpb9M7
	 Lq7wEdY9FhUNTCgj011DZ7JhnIQk7jK9v2stzH9jyrhDbJ4jK5SciMRLXVhzuapOVl
	 en+9TjXOp2iyItBc16Zk1GLtETCd659tKihcuth9eTtT60mq+TN9JNTMr+5I1xPXTx
	 1hXLlUvn3v3e1F6ruDL3Pb9s=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3877D40E0031;
	Wed, 24 Jun 2026 19:25:33 +0000 (UTC)
Date: Wed, 24 Jun 2026 12:25:30 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Penny Zheng <penny.zheng@amd.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: Avoid divide by 0 in amd_smn_init()
Message-ID: <20260624192530.GGajwvKuhxbnHe0s42@fat_crate.local>
References: <20260623211904.3674-1-jason.andryuk@amd.com>
 <20260623213552.GAajr8ONjXFUnuUOE3@fat_crate.local>
 <48629f88-4b78-424e-a199-d87594c8cb40@amd.com>
 <20260624155910.GCajv-zguf0GiBxt2F@fat_crate.local>
 <0500111d-91bf-4105-8de3-af44a113157a@amd.com>
 <20260624171536.GDajwQuLD9pkLRLpLE@fat_crate.local>
 <4b551319-0a04-47d2-bc57-2f0d4d9923a9@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b551319-0a04-47d2-bc57-2f0d4d9923a9@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268219-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bp@alien8.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:jason.andryuk@amd.com,m:andrew.cooper3@citrix.com,m:mario.limonciello@amd.com,m:yazen.ghannam@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:penny.zheng@amd.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alien8.de:dkim,alien8.de:from_mime,fat_crate.local:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A55C6C105E

On Wed, Jun 24, 2026 at 03:08:08PM -0400, Jason Andryuk wrote:
> I think Ingo's suggestion to re-add the check will at least get systems
> booting again.  Then when Xen SMN accesses is sorted out, that can be
> changed as necessary.

You could do something like the totally untested thing (I'm hoping dom0 sets
X86_FEATURE_XENPV):

	...
        roots_per_node = num_roots / num_nodes;

	if (!roots_per_node) {
		if (!cpu_feature_enabled(X86_FEATURE_XENPV))
			pr_err(FW_BUG "Error detecting roots per node.");
               roots_per_node = 1;
	}

until we sort it out and as a stable fix perhaps...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

