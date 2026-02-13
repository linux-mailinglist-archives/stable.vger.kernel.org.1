Return-Path: <stable+bounces-216033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aErJAXnZjmn9FQEAu9opvQ
	(envelope-from <stable+bounces-216033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:57:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD32133C01
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 08:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A5643008D4D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 07:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9271312837;
	Fri, 13 Feb 2026 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8irZ+ss"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC86311C1D
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969462; cv=none; b=idWLX5+uL7OMxBKN9HcGNpmmUD6iOGF39ii++nJjKkoKWXeriFvab5Y4D0y/pUoUBiCmiMzpX2+ATGUkqiTa1SBfu5/yJSCVXo6J507OSRgA7kxQI44mFoeEFRU/w9PRsxa9ikoiAFBJpYMeHx8AVweNuz/7tgyfvx06MZyazqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969462; c=relaxed/simple;
	bh=faX4c37UJq/IghxiFYJTQA/NLQfMpGvibnLnj60FnyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rdeq4rpkwCgFCw2sEuqfMUskKHmvqbG21g//Lop9IJvKHXP3vYnceGxmZYdy2q7R8YwVIYD0xDKLdNIE0b2Mss3a8+GT7FtJr9XZjlAhOGxTpnyST12S1+n7LKohFtEvciZbqklvPB/EzL7m5KpMsmNPMaOkzYMw6fkSAW7nxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8irZ+ss; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43766514653so409338f8f.0
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 23:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770969460; x=1771574260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdjISIOyUztyDUdAxqdnyQht9GvvjjW3hn7WzZDyBC8=;
        b=Q8irZ+ssU530ZhQCk5V2URZMeqxsiJ7+mTR+Gklm7F+6CWF09jYBJiKd9hcpgHuOeV
         uHfBkhRn6Dk6wNBKB0mZyiE+Vn25i62NsGnljnY0NfLcnKTD21iUH5wD691LCwPtWeGO
         B31eRFAHU2WvROoZQ5NwTtYq1WXUlvBR3Z/X4jogeik0mL8+QCyAb3eRynbotPxGpCSw
         Xbci5EWJoxdq53w7X3QjPoo6dU5wWG8L3XwUW6bPfrNks16BeKzNtRW5SISJE/c5TLwk
         yKuTHmK9B8S0IHaJO3px26OvvhV9mIE0iE/A6erw1MSBdA0ql7BuheAkwztXULkTipER
         ygkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770969460; x=1771574260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdjISIOyUztyDUdAxqdnyQht9GvvjjW3hn7WzZDyBC8=;
        b=ZRfJGjtiDjPWrMy38fJ1kI2t3a0DaNeRbjOlDDsD0emRxCBy4O+B2MclVRMPzAkQ3i
         V5ksX5vZjE/g0Kwgm9Us/vqSonrdNMfFNnzm0JlCcQbqQaqf8DCFx8cDOlxGQcab2TQO
         V/2wKUIIeKX5WVC7KrxNFf+6IiUagomkqodxSizT75oW3XG9467scVveDZDGQ4yM7BLd
         Np7VdXhsHXwnPthI43CBfS9wB6QC8mcMYZjOuMsjda0vWoP7od0jubdKMGKxBHg+IS4+
         YWV7GyENuJ0mWRWeWzSQHcg7BwSDDQZK18gfFgvK+czvqs3xyUyygTkOjTdYwjjA4ngJ
         Z6/w==
X-Forwarded-Encrypted: i=1; AJvYcCWtwc8uiaVNapxJNL3WAVGeLoR9ZONpphpv0uVOB9n+Yo8nfiWAgJWG83b+zg9kEs7DV9UMSHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8RtyEY+4D6zUP6fEbj4NWqaMyokN6zxpOirvuwaJYMKm4xnlI
	SuGZDCSRS/W4LpbZwZGlivwkE8ZPfKq/4d5qf6mUIb4nfYsqDdvfkE/xVi4lcR/jws/MVEyVPYU
	r93ZdzCZwjiT2D7AsJQ==
X-Received: from wrrv10.prod.google.com ([2002:a5d:43ca:0:b0:437:729f:8dee])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26d2:b0:436:3707:2be5 with SMTP id ffacd0b85a97d-437978cdfaamr1806967f8f.15.1770969459539;
 Thu, 12 Feb 2026 23:57:39 -0800 (PST)
Date: Fri, 13 Feb 2026 07:57:38 +0000
In-Reply-To: <dbx85x82s91n.fsf@ynaffit-backwards>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210232949.3770644-1-cmllamas@google.com> <aYxM9JbH1tlTtxqi@google.com>
 <dbx85x82s91n.fsf@ynaffit-backwards>
Message-ID: <aY7ZcgDNS18bhRqM@google.com>
Subject: Re: [PATCH] rust_binder: fix oneway spam detection
From: Alice Ryhl <aliceryhl@google.com>
To: Tiffany Yang <ynaffit@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, Paul Moore <paul@paul-moore.com>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, Miguel Ojeda <ojeda@kernel.org>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216033-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linuxfoundation.org,android.com,kernel.org,gmail.com,paul-moore.com,konsulko.se,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCD32133C01
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 11:41:40PM -0800, Tiffany Yang wrote:
> Alice Ryhl <aliceryhl@google.com> writes:
> 
> > On Tue, Feb 10, 2026 at 11:28:20PM +0000, Carlos Llamas wrote:
> >> The spam detection logic in TreeRange was executed before the current
> >> request was inserted into the tree. So the new request was not being
> >> factored in the spam calculation. Fix this by moving the logic after
> >> the new range has been inserted.
> >> 
> >> Also, the detection logic for ArrayRange was missing altogether which
> >> meant large spamming transactions could get away without being detected.
> >> Fix this by implementing an equivalent low_oneway_space() in ArrayRange.
> >> 
> >> Note that I looked into centralizing this logic in RangeAllocator but
> >> iterating through 'state' and 'size' got a bit too complicated (for me)
> >> and I abandoned this effort.
> >
> > I think current approach is fine.
> >
> 
> Is there a pattern that would allow us to avoid so much duplicate code?
> Or like... a nice way to call into a shared low_oneway_space? It's
> frustrating that the two implementations are basically the same except
> for how they iterate over buffers. I've been thinking of rust binder as
> binder's chance at a fresh start, so I'm reticent to introduce this kind
> of tech debt so early on.
> 
> I don't have a clear idea of what the appropriate fix would be here, but
> I'd be happy to help do some plumbing if it'll make things smoother in
> the long run!

We could potentially have a single low_oneway_space() that takes an
iterator over the ranges. Then each impl can pass an iterator specific
to its own impl.

Alice

