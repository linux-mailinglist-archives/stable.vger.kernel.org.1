Return-Path: <stable+bounces-238239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNWSJjRP4GnJegAAu9opvQ
	(envelope-from <stable+bounces-238239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:53:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62687409C31
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B06A3094D00
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 02:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BF272803;
	Thu, 16 Apr 2026 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VIxOU/hi"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA5B265606;
	Thu, 16 Apr 2026 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308007; cv=none; b=KfGW1nsQSuCJg5fVQGzKqdDCw6kG9Qfzaz1bBlBA7hXWGrYvDIath5x7w+3zchpqZ/u9RBedYBHkyK1BP1ZOZ4/piC2gApeZGAm6R7jMLFMJ7EXyHt5TCqlT/Ms4HKkRhpY2Otuq5oYGXy0xP8dsQg5VvM78YeHZQKLUCDm1ggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308007; c=relaxed/simple;
	bh=uw4TJRcZecoYqhluEdXNdZaZx+M53Sr/JbHlnLY9DjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL/Tgyjysg3RK8mL9SwXPDB/brYNbuEYiCIgIBxhCGnf30nM8yqBEy43tlHUmSvB8OytrmPsJLniP7haBm6YRs7Zx1ESu4OdnE/Y7zKLsWCMIwFKp9FdOqpPmzyRvVOKs1wGNA3iw4rrD8chnzoMjY3W+nDOQROupAwKMu+pP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VIxOU/hi; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id CC69914C2D6;
	Thu, 16 Apr 2026 04:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1776308004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJgzEL0OfHe6N3xps6g3ofo9dCYH4b5e+rS7BaFxA9E=;
	b=VIxOU/hiRoBur8Omrpk+v3YaYcLNbRygg1HAFzZs3VjShlLGQsNNrkZuC6LTjQMA+IDv5j
	q/AcCry9RHTTOv/Nv8gDb1qi/F/qEZToZm/UKThCwidwRwnyXAi1PdSq4vfvoEdrc42Ieq
	GsROYmHb5aqX/7TVosAJGVchIs922X9FfJy7HvUPJmHay1lUxQb6lS/PY5jvJjb9zDI1o/
	258lITZr75ipHMSqv+NNNrR9GKi8k8WzFfU9ZMnGHUVRW8Et+IixD7TJNm7CbNs4KhwU/G
	/03vBRqdlLvpYo7KCYY0fTdnDhLJy15jks0M3oMJ72tO3ZRwMmE4evth28lGhA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 94f1f706;
	Thu, 16 Apr 2026 02:53:20 +0000 (UTC)
Date: Thu, 16 Apr 2026 11:53:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, Pierre Barre <pierre@barre.sh>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, sandeen@redhat.com
Subject: Re: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Message-ID: <aeBPEcmAaVv5Vt5d@codewreck.org>
References: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
 <2406037.ElGaqSPkdT@weasel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2406037.ElGaqSPkdT@weasel>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codewreck.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[codewreck.org:s=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238239-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codewreck.org:+];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmadeus@codewreck.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codewreck.org:dkim,codewreck.org:mid]
X-Rspamd-Queue-Id: 62687409C31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Christian Schoenebeck wrote on Thu, Apr 09, 2026 at 04:51:07PM +0200:
> > diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> > index 057487efaaeb..05a5e1c4df35 100644
> > --- a/fs/9p/v9fs.c
> > +++ b/fs/9p/v9fs.c
> > @@ -413,7 +413,11 @@ static void v9fs_apply_options(struct v9fs_session_info
> > *v9ses, /*
> >          * Note that we must |= flags here as session_init already
> >          * set basic flags. This adds in flags from parsed options.
> > +        * Access flags are mutually exclusive, so clear any access
> > +        * bits set by session_init before applying the user's choice.
> 
> That phrase is a bit suboptimal, because V9FS_ACCESS_ANY is actually a bit
> combination of single, user and client. But OK, I currently don't have a
> better phrase for it since the access fields have to be replaced altogether.

Yeah, it's not so much that they're mutually exclusive that we need to
clear the default value before applying the settings.
The key distinction here is that it's not "any access bits set" -- if it
were arbitrary values then it wouldn't be acceptable to just or the
flags out, you could risk e.g. creating a client with 2000L but setting
another protocol in the flags and there'd be no end of things to check.

Something like this?
           * Default access flags must be cleared if session options
	   * change them to avoid mangling the setting.

> As for the actual behaviour change; makes sense to me:

Yes, that works for me.

Note your patch converted tabs to space and couldn't be applied -- if
you have to send patches by web mail please attach them instead, that'll
be easier to apply than a corrupted patch, even if some tooling like
sashiko won't run (it doesn't run on corrupted patches anyway..)


If you're fine with my wording for the comment I'll modify it in place,
otherwise we have a few more days to discuss this before I sent to Linus
for 7.1-rc1
(and I'm really sorry for my lack of reactivity, I'm sure I'll miss some
patches anyway...)

-- 
Dominique Martinet | Asmadeus

