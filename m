Return-Path: <stable+bounces-223261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCtKD3/AqWnNDQEAu9opvQ
	(envelope-from <stable+bounces-223261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:42:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AA621664A
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4383300B121
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045D637BE97;
	Thu,  5 Mar 2026 17:41:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A13597B;
	Thu,  5 Mar 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732465; cv=none; b=HxGdLK+MsSg81ciFN8ri8ZDKdm3WwpWOdl6kwXrNOQmH8dv9FMpJShavIbvdDeXDQNmjjY4ABSFIJjgRT/br/3bfUq6JfeZ1yPuMmkuxoNX8Iouty9NfqeMUTjCh2VzWO/baEFYZl1M40JyyLU5Te+n5AZCqpRXUgLbDftJBoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732465; c=relaxed/simple;
	bh=pY344Qti2NzyuYpU3rhT5T6p12DGiOJLB8iAlb1slxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnoN6xmjA6Yg3fIajVDAQmWJaUYb0wJgEl4mR7EE+7ja5JdBH84IKQkiTQCVdjU1RPf5VKLlTCiB+/5UxBiMgEJuUzP5zwV4hNiA6nK+OuFf3M5pM7iZIrG7IMCcxRQFm8DOTwZ9sX+Lk53Nv+VBkKdLciT8kh8nlZmFnnAuYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Thu, 5 Mar 2026 17:40:09 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Peter Schneider <pschneider1968@googlemail.com>,
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
Message-ID: <aam_-Y7q-c3gmfGY@auntie>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
X-Rspamd-Queue-Id: 99AA621664A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223261-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[librecast.net];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[googlemail.com,live.com,linux.ibm.com,linux-foundation.org,oracle.com,kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linutronix.de];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-04 20:00, Peter Schneider wrote:
> I already found and reported this in the RC cycle [1], and Sasha dropped it in -rc2 [2], and now in the release, it 
> obviously has, somewhat mysteriously, reappeared [3], affecting all of today's 6.x stable branch releases.

Greg, Sasha et al.

Can we make a small adjustment to the stable kernel testing process please,
whereby we release a kernel that we have actually tested, instead of adding and
dropping patches at the last moment and releasing a kernel that no one has
tested?

We are only a small pool of testers. If we find a bug, can we fix it, release a
new RC and test again please?  We can have an RC3. Even an RC4.  Perhaps if we
bogoselect fewer patches in the first place we might have less work to do. It's
better to miss a backport for a bug no one has reported than to pull stuff in
without proper review.

The current stable process is introducing bugs. Bugs that never existed in
mainline.

The 3 kernels released today were tested by no one before release. The seven
kernels yesterday were similarly tested by no one before release.  We weren't
given the opportunity.

There aren't enough of us to do this right, but we can do it less wrong with a
bit of caution.

Cheers,


Brett

