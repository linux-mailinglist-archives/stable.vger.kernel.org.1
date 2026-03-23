Return-Path: <stable+bounces-227950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMJ0BacYwWn5QQQAu9opvQ
	(envelope-from <stable+bounces-227950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:40:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D42F059C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 11:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FED63045C0E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1D31B839;
	Mon, 23 Mar 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9EkIsXy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F40237DEAD
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262042; cv=pass; b=D/L+W9XOsZg1LIsAZyNDU9z5zgcCCWCLB2RrLTaly1UgyZd2wjJb05f2I/ZiS0XwvF3HR3vmoIJwzuNvzjJMVDkAsYh404qNXjvjJ0GccRciChSPAqiai6yydfgENcPwirl3ULKTrQQoE0ou6G7Pt0NjcZvg5tHmWN6ZnapKzLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262042; c=relaxed/simple;
	bh=6jR0jMrKtaADO1Mog744+8WpYaKXv5ejmy4WbH4opvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOVaq8oaTxwrkUyJXAzsqQZ30QWEeU5Jj6dyUfkKdeVc4WjAcqQaCPEXP88OOgW9Oa/VYGjm1wIORD8Sefii8CqE8QKFKOAutXfZVWDzegUMdlwFo5cDZAUnE0MLklufxP8s5ulH8+esA7wPn92M3mdl/mReYSiguzgp6Pbxq4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9EkIsXy; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso2656344f8f.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 03:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774262040; cv=none;
        d=google.com; s=arc-20240605;
        b=S+tsI4lbss8D903iT+ZvNCmZJDe6h81ASpL+xWH7Sa0i3qT51cAWv1cpihSsMi0DVY
         vcnfaviyMX7hu3RZBB190EJHbpDMME0FdTugBcFR8M01JOUX8uilFDmIV3qSzoP0N31k
         uH7BFi0zPWgYB6iCjnkNfB8f4srHN+RSUCBXsFvE41Mh2hdTwzNgbgPszd5Qs7UKW7GM
         hXBtZum793UXTDFvJFaMGCv/NDxub5v5RzDWMQoMDlaDR7xG3BfLru5xNmtXUyfyhAj/
         lqY1T7TgSwzwV+6WbrdW9K2QY5IMIm9oVDC+Hd9/3jnpQTM1v0gVP/oT9GlbPSsiM+Ll
         aAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JXXlmvHYgiroDUVxGLzgwLwnH5ySB/ZVCNUTizqHdbo=;
        fh=4nXHklv2MGZdjJcdNLvQ2hHUvua6jUXhwDxgzZw9y4s=;
        b=WINv7xCjnHFf73b1gpbPGMTRxdrKk4ffTXthVnGX/6U9kzVFc2MLR+RwPEsHgJIqcT
         5KDwkrdNwdPFYz8V/Od5BTW42TAgmnnKuVHYfgAv33kBVOuJxHgdcjNWZcPK7rqO3yF5
         wBdhyZbvxjpxa5M3f2eUvDnzfHgcL3eyMd4a/MDmiYeuM/rYrJzR8Zg8AVGUapeg8R4s
         BKB2n3mqos1eH8nh5S1Xn/tpg2jtxqgf0zR6UfstI71upFarCwyQO1ZdM9oPfVHxylEo
         AeLNMcp6COBxmNQQUgHx+hHRVKdNsTtdwaR4xpJQluBa+gCjf5cvQTDgnstM4KtEZIoU
         /YLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774262040; x=1774866840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXXlmvHYgiroDUVxGLzgwLwnH5ySB/ZVCNUTizqHdbo=;
        b=r9EkIsXyCV7qAlRpXxRzkxyBRHaWSDzMDKDsNPGIXg048eFjKZY6PoHopZ96zDPzvc
         ijeD01rmjZBkMVMgbKKKgzf9HuLjk7Wx5J2BKa35G4KcX5Lfp3tu0K2Yl1MLb5X/lz2r
         bRc3T3/m69uJ9ob6DIiHEo8BVVw/B2zUnLlRdvNJQwZQO7Y8PP2+xj0F+FoLKuCenHLw
         msUgM51pD0QvathLDWWDWkGUkh6aQVTyJxtBDWcLMajwSdVXPex4tYOvO2U1PHzx8JmD
         iXkOiqktm2mt2mKOV+wBJiBI0W37NQ6gUg6qyBMma2unBDOyfKDV+QmYD+9Fb/fAaMv1
         bBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262040; x=1774866840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXXlmvHYgiroDUVxGLzgwLwnH5ySB/ZVCNUTizqHdbo=;
        b=kWcm3b7PhOUdE8YW7iFdCaL3yrVg1roAIWaURQZcBXs+hnZbr9eYKXiDSZDJNgZob1
         a+n4z0aaSVF0HApA/82KwGURge9TZMp9upTxNZxayb9gRWN5K2Jgb7mUhGOU3sGtu+QO
         eMbhKRLbchw2JilBu9sRg28i/qv1aiWeAYpUES1b1Jc2LSTuxSyJ0299IEXYQcyQfjOm
         ydqsK1V+pXHKay4Fx9aJUnviEEgkTZwSP8hOzk55bg74ZHHNvTkknVAEzKmdzKT35ADV
         gGVLLZccpiYAt8U9QyoAEEgy+AWi9fRHWJvwzbaIcd54KbaqAqd7wCItqH+64YMjlRNW
         WEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOygYHMQQ8eWJWTsmk2wjDRr77oxDX6Qka5naVz7YzWwD+jMfTCucY5gIXm95Wc6BXtERAVqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8kQa3DUY/xU0CNDCBzzMrTz3K7boyTsW3BP0l+k3rgSmfPg1
	de1HA1S628Ong/+HGqfDd3bodEe27DtLWcaZ8Z6GKn3HYM22iUT0Dy/6tIzOAJB9BisvQ/E8rkb
	LxGR28D0DttyhwFDqMxU58JA6LMgwAZApS7GW/idKszt/CtWqW/WezucC
X-Gm-Gg: ATEYQzx/07bnEX935OLx58XQyk0jzqAJtunb9f3hRCke1C2DiHaQZqHwMXhGhaowFEJ
	FsCjOWMu26whGPU6WcGdGgw/fAXROP9YKN/D3QPUaJFu4bRmXkHkETyDa6P+dWGnQjkaAvENRLS
	EHZEPQv2v1jrBiRUQ4O/bN9FRuXjuEszQDdC13XB3NYRGEcvwdUkDeekGkN+m/18woOzS9fhMwn
	/Jc9NKUpEfHcDyF3alxWZb6SC1qKirGpsJ+jMg4YHIkm7/AoZwBlJqkKa5F9DUmq0/09C2+lrGC
	olscLubN2DcAbukZfzbw8hcEK0T6JkoLWgRELDRY4OsnB7/bIjX5Fj8e1oy4KWb09lwdrA==
X-Received: by 2002:adf:e403:0:b0:439:fd13:5c48 with SMTP id
 ffacd0b85a97d-43b64275609mr12928495f8f.31.1774262039577; Mon, 23 Mar 2026
 03:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221161726.4075998-1-sashal@kernel.org> <CAH5fLggmuHNXpfHo2mPS0TYu8mwr8G6EKH0YPuCLX77u_dxF5Q@mail.gmail.com>
 <CANiq72k6=OSk-vLbmKjqcAUza700v-OtToEXiVbqWPkNpPbVVw@mail.gmail.com> <2026032349-unlawful-undercook-400f@gregkh>
In-Reply-To: <2026032349-unlawful-undercook-400f@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Mar 2026 11:33:47 +0100
X-Gm-Features: AQROBzCZCW_14_O5545bOurAA6hgX7VyS8Qjq8tEOrAOdpQtXVNtccvyj4L9bjE
Message-ID: <CAH5fLgjG+QsBDNWZ0uViZ5nZJJDdoufpnySGZDzUz=Za=8ozMQ@mail.gmail.com>
Subject: Re: Patch "rust: task: restrict Task::group_leader() to current" has
 been added to the 6.18-stable tree
To: Greg KH <greg@kroah.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, stable@vger.kernel.org, 
	stable-commits@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227950-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,garyguo.net,protonmail.com,umich.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kroah.com:email]
X-Rspamd-Queue-Id: 734D42F059C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:31=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Mar 23, 2026 at 11:18:50AM +0100, Miguel Ojeda wrote:
> > On Mon, Mar 23, 2026 at 11:11=E2=80=AFAM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > >
> > > I noticed that this was backported to 6.18, but not to 6.12. Is that
> > > because the first user of this function was merged in 6.18, or is
> > > there some other reason?
> >
> > If it was meant to be backported, then the commit should have Cc:
> > stable@vger.kernel.org.
> >
> > Perhaps it was picked for 6.18 (and 6.19) because it applied cleanly.
>
> That is correct, we take "Fixes:" only commits as a "best effort" type
> of thing.  This doesn't apply cleanly to 6.12.y so it was not applied
> there, nor was there a FAILED email sent as it wasn't asked directly to
> be applied by the developer/maintainer.
>
> hope this helps explain,

ah, ok, that makes sense, thanks!

Alice

