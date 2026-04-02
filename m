Return-Path: <stable+bounces-233099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOtZAEi9zmmTpgYAu9opvQ
	(envelope-from <stable+bounces-233099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:02:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2038D869
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C27D3014743
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 19:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB5353EDF;
	Thu,  2 Apr 2026 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cTICuSfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D3355803
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156513; cv=none; b=hTnQm0NqIMKSE1PJoHbQhLnMlQPgidNYH0q3zI6/sGiytc4NxdDrm1yVLHaLqgHNtnLLWd/AywN6xiq8gYmEXV1u+CkG4REXzO5hYNly0QP3r4oohPgyYGFGFS3fVLAifl9LCBQ3tcRn7Q4HL5CqQqWdwEDqe7ZPwcFvhHZmzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156513; c=relaxed/simple;
	bh=5gvDNIZh56fnPyMYqOFq5V8DvAaa2psRL0YCTSOjWiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am9OwZcQ3/C2Riuj+5ZIBKg5vdc185gMgCrrJUam9IVEDgoMGIi5cey6xCLAORdKc+Cl3RANvd/++XllZ4DInPLbOv1DNpWS59ij8HbMJpNVK77sG/AwggruhnrYb5K3AYx/n5/Wj6BrYW0NRBgkuGI+D0AGmbWtcYkG4ZZ1a+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cTICuSfR; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fmrZn6P9yz4Pn;
	Thu,  2 Apr 2026 20:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775155969;
	bh=9z4Xc7uCSmWKhTHQuyiwO6u+N2VzB0/CNlB8zYdL2F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTICuSfR73kB9ORWQNr9KBMF6+SyWYtWmfmi2Z4HFm6Le89ESCV6aJ+wJjIYmnz8A
	 b2RlF2JNE78uROR/CM/YsqtMLHs+oZI2sJSZWkjerDMOgBSSpnK1PTbFbdiIuuJpy0
	 EidnU9UFOn4zYvOeuXBZDLc0E6/dJzneerG06ocQ=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fmrZn29NrzWNL;
	Thu,  2 Apr 2026 20:52:49 +0200 (CEST)
Date: Thu, 2 Apr 2026 20:52:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Tingmao Wang <m@maowtm.org>, Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH 6.12.y 2/9] landlock: Fix handling of disconnected
 directories
Message-ID: <20260402.chiniey9Beex@digikod.net>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
 <20260324140456.832964-3-harshit.m.mogalapalli@oracle.com>
 <20260401.Ahd4leZ5Dix3@digikod.net>
 <e5296586-c00d-437d-b7b5-bca4ee3a330a@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5296586-c00d-437d-b7b5-bca4ee3a330a@oracle.com>
X-Infomaniak-Routing: alpha
X-Spamd-Result: default: False [-0.99 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233099-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[digikod.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[digikod.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8FC2038D869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 12:31:13AM +0530, Harshit Mogalapalli wrote:
> Hi Mickaël,
> 
> On 01/04/26 20:54, Mickaël Salaün wrote:
> > Thanks Harshit.  BTW, the following commit should also be backported
> > (and it was specifically created to ease backports): 6803b6ebb816
> > ("landlock: Fix cosmetic change").
> > 
> 
> I did see this as an approach, but I felt like for CVE backports keep the
> cherry-picks minimal if they don't really help resolving conflicts. I had no
> conflicts while cherry-picking and its a cosmetic change so according to
> stable rules I didn't take it as cherry-picking the final fix is clean.

Ok, makes sense.

> 
> 
> > The current patch should be backported down to 5.15, but it needs to be
> > adapted.  Harshit, I can work on it, please let me know.
> > 
> 
> I agree and will give it a try, and if I can't do it I will let you know.
> (just was focusing on new branches first)

Great, thanks!

> 
> > I'm wondering why I didn't get notified that some Fixes patch couldn't
> > automatically be backported.  Greg, is there some way to register for
> > this kind of issue?  What are the rules to not automatically backport
> > patches?
> > 
> 
> Greg can answer this better probably but just sharing my learnings, Fixes
> tag is never an assurance for getting a patch backported to stable or
> getting a failed patch notification when it fails to apply, CC:stable is the
> only way to request backporting a patch to stable.

Ok, I couldn't figure out in which case a Fixes commit would not make
sense to backport, but I'll add CC:stable next times.

> 
> Commits with Fixes tag only(without stable tag) are not guaranteed to be
> backported and particularly if they have conflicts. So, for making sure
> these get to stable I suggest to use CC:stable that way you will also be
> notified if the patch fails to apply.

Good to know.

> 
> > I also noticed that other Fixes commits were not backported to stable
> > branches whereas they can be cleanly cherry-picked.  I'm also wondering
> > why they weren't pick.
> > 
> 
> They might be clean cherry-picks now but not when they appeared upstream,
> that is one case, and Fixes tag doesn't always ensure a patch is backported
> to stable.

I'm genuinely wondering in which case a backport would not be needed.

> 
> > FYI, here are the ones that can be backported without needing changes:
> > - 602acfb54119 ("landlock: Optimize stack usage when !CONFIG_AUDIT")
> > - 60207df2ebf3 ("landlock: Remove useless include")
> > - 7aa593d8fb64 ("selftests/landlock: Fix missing semicolon")
> > 
> 
> The first one doesn't apply on 6.12.y(6.12.77) , maybe that's the reason.
> 
> 
> > They should all be backported, even if they look like cosmetic fixes>
> (because they might be needed for other fixes/backports).
> > 
> > Here is the other one that needs to be adapted:
> > - e4d82cbce225 ("landlock: Fix TCP handling of short AF_UNSPEC addresses")
> > 
> 
> I think the way to get these to stable is include CC:stable along with Fixes
> tag. As documented in Option 1 of [1]
> 
> Now that we have missing fixes, I think the best way is to send backports to
> stable@vger.kernel.org

Yes, I'll do that.

> 
> I wonder if it would be helpful to make this explicitly stated: "Fixes tag
> alone is not a trigger for stable backports, CC:stable is needed if you want
> you patch to be backported to stable kernels(and also get notified if it
> fails to apply)" ?

I think yes. My understanding was that if there is a Fixes tag, it will
be backported.  The same for CC:stable, but in this case in a
best-effort way because the fixed commit wasn't specified.

> 
> [1] https://www.kernel.org/doc/html/v6.19/process/stable-kernel-rules.html
> 
> > Thanks,
> >   Mickaël
> > 

