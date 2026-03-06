Return-Path: <stable+bounces-223301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAOMJdlCqmkHOQEAu9opvQ
	(envelope-from <stable+bounces-223301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:58:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2A21ACF1
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D212B302F242
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 02:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC24366054;
	Fri,  6 Mar 2026 02:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luimFDE8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142333BBCF;
	Fri,  6 Mar 2026 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765874; cv=none; b=LHtvuYPHbcPluvYtiqDI97dpA6YkVFfHK+gmGj+UUpoUoiCKN16KugdQsMKe3rxO6mgKwkikxEsWtmXbtzLBL/99aclRyFnb4vGmipwdyg4wfbvx1uaN5qbdSPS9nm+c3HlMrUXdvyy9Yv2Z1d02A3+PaBFkluCzNb2WdbnrJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765874; c=relaxed/simple;
	bh=zK/+Pf0Sp4lJ7R9ekZERM/kLqH3SuxmogR85OYbHtgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHKJlgugxxilT3uL9fUbQiXqgQWpreOkTBBTVpvwOPY7V8ujJ+6KZF9b9AioalMkHFNzdOc5dUi/RogbN0Q5gOVb72Pir5s7ReD46YeVB3pXR178WKE+SMvKaEkhc5QUyrAKzIvQfZAyrU30/lbVzvroMf5/6X9lBhd6U8PLmh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luimFDE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5EDC116C6;
	Fri,  6 Mar 2026 02:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772765874;
	bh=zK/+Pf0Sp4lJ7R9ekZERM/kLqH3SuxmogR85OYbHtgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luimFDE89CBNICA667bcDXnJEPxUJdXtGIABmslcTeS2xWRy/kedHklaBXCnAipge
	 WAAJ2axP+Nqc5sPMndL/YVB+Y87f2H2yTby6Q80OR8HSevGVbi5Ii2vovHY+zc5oWR
	 jmvkmPZ0nA8sFzTDbpyu7FvXduQZ6vjo9T9pnIHH/gEWLqf4sVstJBSt821cY0kOR8
	 A8wn1lJz9aSiM3MdAF8BWnG73IX3SWQLYAL9QdyoR2DibIS4T3fvOOCmIUcbtOLPoC
	 0lHR4ixVCWPJuJjLGdMzUc7PIB+wL3FHJguFdNRfUhfZrTP6CAQvHOKiQKkOctX2Ss
	 9XaaMfVTThjxw==
Date: Thu, 5 Mar 2026 21:57:52 -0500
From: Sasha Levin <sashal@kernel.org>
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: Brett A C Sheffield <bacs@librecast.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aditya Garg <gargaditya08@live.com>,
	"zohar@linux.ibm.com" <zohar@linux.ibm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	"ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"graf@amazon.com" <graf@amazon.com>,
	"guoweikang.kernel@gmail.com" <guoweikang.kernel@gmail.com>,
	"henry.willard@oracle.com" <henry.willard@oracle.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz" <jbohac@suse.cz>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"noodles@fb.com" <noodles@fb.com>,
	"paul.x.webb@oracle.com" <paul.x.webb@oracle.com>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"sohil.mehta@intel.com" <sohil.mehta@intel.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
Subject: Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Message-ID: <aapCsLtZvNpJgrP5@laps>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
 <aam_-Y7q-c3gmfGY@auntie>
 <aanlzq-RqDF9xkdI@laps>
 <6f42cb43-c281-4565-b968-afc34502b9fb@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6f42cb43-c281-4565-b968-afc34502b9fb@googlemail.com>
X-Rspamd-Queue-Id: 01A2A21ACF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223301-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[librecast.net,linuxfoundation.org,live.com,linux.ibm.com,linux-foundation.org,oracle.com,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:06:06PM +0100, Peter Schneider wrote:
>This gives me some vibes of "It compiles, so let's ship it", which is 
>a questionable level of QA you might expect from some (shady) 
>commercial companies, but I think the Linux community should (and 
>can!) do better.

I really want to highlight this part.

There are no IMA tests I'm aware of (outside of builds with CONFIG_IMA=y).

For that matter, we only see a minority of subsystems actually testing stable
releases.

This is something we've been working to improve for a while, but we're quite
far from that goal.

Sadly your vibes are somewhat grounded in reality.

>Sorry if that sounds too harsh. I don't mean it in a harsh way, but 
>only as constructive criticism. I know Greg and you have an extremely 
>complex job with maintaining the stable branches, and normally all 
>works very well and smooth, because both of you are doing a hell of an 
>excellent job! But on occasion when a release was bumpy like this one, 
>we should look back and ask why, and what could have done better, and 
>how we can improve in the future.

This is not, and I appreciate the feedback. Thank you.

-- 
Thanks,
Sasha

