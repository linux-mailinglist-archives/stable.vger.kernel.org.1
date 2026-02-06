Return-Path: <stable+bounces-214638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM0YFUfGhWnAGAQAu9opvQ
	(envelope-from <stable+bounces-214638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:45:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91BFFCC2D
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BF34300D351
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA8366079;
	Fri,  6 Feb 2026 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1fYHLZv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B5389E02
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770374719; cv=pass; b=hE719oUlJtcLDctgoI24STyHTxBnEvSVNu90wn3iE76U+1d82EqkpzDwhVIi73cjy7V8EnzMs8kp2FSDZT3KneDtAAeAWMEnpZ4sR2N0kzuYlbyklkasvrWI5CPzLeTDUTn/uOnk5CSQ1rIoTv4TKtmY5VqP7Oy7HyZEji/LYDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770374719; c=relaxed/simple;
	bh=WYE/Ux0k6bTD8gUaLSSCKuXlCOa0T/0c6aLHDFYACSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stfQj4uOvEvAKkmm2u0hpn+sWbn2evqLhx9WtO757dmXj3I56EWYQslj/rDCxk9ui5KO89i9T6qVUvmxxpBeYLkPG7HZ2zODRkwgyYxi1TQWb2krlMVy3/3cyfyodyNeMC/qIN5JABSDAcJHuzZ5Gq4ePsVOp1wAFiPxpWWL/IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1fYHLZv; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124a946a340so153433c88.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770374718; cv=none;
        d=google.com; s=arc-20240605;
        b=h3Qvnp2bE0aeUzWOAy5Lkyu8cH+zCaKkQNN/rnoSyBaqEbPd8Z6zJUMHFUSolxTxsO
         be0nSrS4Tz2nKducknsZhUa+NYsu6HtgHCysL0RqxieJGFQw882ixtlakg9zk5D1O3vd
         sokfMXksmfF8yivYtvSeiaquW4d6uqvQHBjg43vyV6Ywkc+1VE8bo497xpyCZXyhXUho
         EVT4DUavh2UldQXxh2LW2C2u/rOFogZe+y8qZ9Ij81y4a6Hlu/vyNvIHckeUBwqmEaKA
         3mToJvvq9Fh+82wz78+Qe870GW7hmOzH9WE/maoSza17LoDk+c0Y0pGlj2BXAakXFn2b
         1tGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mz1u76uRyaS95f+K63u1YH/dFS2hWnXDhis+xg5cvO4=;
        fh=9Sb8YwvJDmcPwcq1V2lmhByYDrguFj/2JyLiW615YWE=;
        b=DqcAqJRFWNTKaGBOzXWkR3z58Nmu4CXr2kwE4R86daAyV9v5GR7P68Dav+TQ3S8zis
         AbESmgj4ykYBBjrGub31IGT/qTyXVcnC38t4I4v8S4nwV2T93Cs7y6GOttjZoPFFnOqI
         /H8hdNtz+AlFhjAsz+BiKy2rKD1gatuUiNQo2Cee7x/6JTj6zog2LhbClzhrIsogykta
         riYpqzFKpzm3WbQuuTyQDslWIwJ33J4kwGsYxjGeDorfcw7+wTAU6itYBPtW0GXNKq9D
         BFwpIh0LhxEA9Alu/3Pe6EFKljL04EZlk8Y9WqcZAAo7JlkLEyAtMp4zs2oKwa0+RKj/
         /R8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770374718; x=1770979518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz1u76uRyaS95f+K63u1YH/dFS2hWnXDhis+xg5cvO4=;
        b=R1fYHLZv47up+vriSaXbV6jmjYX+FsTtnKXhzQ3Y/bPbPsY4UK5FdmDA+TnEoTaiMT
         0ccRkvh9/EUY1Nj6QHHKyER8N/NKIrR9SYXLkH6PaQ07A+5WVvuDP8fvymJjk+MHr1EF
         hyZ4St99+wRjoTRpUypxsjeH/YgTVjH61oumN0SbhBbHUXn/092+aLCDQlyFn6A/gaQX
         QXhCczmeN2ALcaAB8GhpiQ4mTLbCexsnx3bSZJHCzrealNldqon8CaqZGNeasUn2OwPm
         EYGeXRsu5me79HR5nJewl3ehg7kNBM2CFY2MMvCcdBxdgMbK0kZhUExd/EkwuTF+p9Qb
         4s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770374718; x=1770979518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mz1u76uRyaS95f+K63u1YH/dFS2hWnXDhis+xg5cvO4=;
        b=tZ1a85ZMvYsPILYdbhQ1De3uY1Z1+8g38Z3BYzF1Phn/UiO8aswie7K1pe3HxBJEWC
         Tz/SGlefATUzhR8+alxUB1ZJmoPcovABWfWr1HHx2MCNCQMxgkP2y21zV/KvpJc7n3kw
         asAT+UkS3VffP3nkiKmiS1msPBPp5i7a1yC0LjERpx2naW2UHOfWy8d8JIsQeqgK7QIT
         Hbd0rsLJJHCj5WMRZcSy07XX2166+EyRzim9YM4uDGbcdE98cwdFuQ5LfmTg1+gGVmv/
         EeqLkUGQJN8+PWqNimfFtmXdIK7shelRoauQxVB7mGbcvqFkL2lVXmkUdixNiGIGGbm3
         BWow==
X-Forwarded-Encrypted: i=1; AJvYcCVW+dpC8UOL02u0bWFvsjNh5LObg3RvjsB0/tyn/xzaPnmUfBURe6CfhLB48+wYx58KEYf3A5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+1Dh0iqGy6zMw0H4vC/mMdDbgxe5OJipjNVfspyVsh4eTOko
	E6eJO0FNSMrJR0e+46z87FcP6xwKbMkTGyRW0tW3eWOo7jNeeyv91OlRgsr/hVjUoIvAZiPOwBT
	7MtUWF3kvgOKwS0udBbPl2pAh+/PYe50=
X-Gm-Gg: AZuq6aI+c02KEaGtDjou3Hm321dDe+FzPDDjLybf1qgfMwZyaKLjPnlGzVimJ4M/fu/
	Qu6dUyuEzuSxasBUpUHtCQq+Pml3ZmIbN08f8npXZppQftEF6eiSeam9FzxTzvaVVcbf6meKzBm
	1vXHMxaL46TLQj6Pt+AO+whptE+BSgI0vF13Uq6BjAEL2SVM8Q4H1BDuxpBtk2UtxJ41PNdAwgN
	CGsw99unPwy+ICPOdP1CpWu6ayPbsWxJIxntBvOD65bj7SZDnho7yKdqIyZ2ARtoFkngLlmhxEz
	WTclCPsyegu1FvP5bjSlGj+RySvkina0ZiJvV5JLNbE61ZHVJLKh/nd+dVgN37K3JlMJqE1Me++
	ZSrN04+znSMyP
X-Received: by 2002:a05:7022:ff43:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-12703f3c740mr591063c88.2.1770374717874; Fri, 06 Feb 2026
 02:45:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129133715.23095-1-hi@alyssa.is> <CANiq72mD7BZB4KUNNnboK81zLRLVqrZ7CaQQJsG0GTqTO_ZU=Q@mail.gmail.com>
 <CANiq72kXfdBtGAxdqer_t4JC+57mjgTpEE=D1VkAeODCf2hiZQ@mail.gmail.com> <2026020348-rehydrate-glider-b1f3@gregkh>
In-Reply-To: <2026020348-rehydrate-glider-b1f3@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Feb 2026 11:45:05 +0100
X-Gm-Features: AZwV_Qg1oPiUyiou-Q8KITVbfP54hJtrs4wmapf_RsIpNtSHvVrCZD7P5vpdJi4
Message-ID: <CANiq72kY--ovLHPEA24_Q6kabC3gAw_5Xo4YiLZ7gDLGqLuggA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: support `-Cjump-tables=n` for Rust 1.93.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alyssa Ross <hi@alyssa.is>, Sasha Levin <sashal@kernel.org>, 
	Huacai Chen <chenhuacai@loongson.cn>, WANG Xuerui <kernel@xen0n.name>, 
	WANG Rui <wangrui@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Nicolas Schier <nsc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214638-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E91BFFCC2D
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 3:42=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> It doesn't apply to the 6.12.y tree cleanly :(

Yeah, that is why it wasn't applied in the past -- I was just bringing
it up again to keep the "chain of dependencies" we would need going in
case LoongArch decides to apply it. This is the past thread:

  https://lore.kernel.org/stable/CANiq72kEzOa60EhLQ2YnBOD6bsAHc7qA9v9-MP2Ft=
xMa04Q5PQ@mail.gmail.com/

Cheers,
Miguel

