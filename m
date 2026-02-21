Return-Path: <stable+bounces-217631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EORrHX9xmWkfUAMAu9opvQ
	(envelope-from <stable+bounces-217631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 09:49:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA516C6EC
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 09:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A07F3016523
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 08:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779682E6CA8;
	Sat, 21 Feb 2026 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrvnVVe0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3921B905
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771663729; cv=pass; b=sJ9hEGRhKpJ8JbbU/aBweIcJDv/CsPtVOa1DCqlKf+sd90s4UIQPJS5eg4H3HFlK61k1pY4J3MceNdkLSjeChktp/hcVYgkozHE06lTxHWTX9al/GXH4X3e0ia7K9V9Bxe2caOwYzeJix1qp+UlEyIDrG/IH/fOHiv68p+BHUTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771663729; c=relaxed/simple;
	bh=s3gXvks3AbonXB5RGf5/6lI41YpUBobgidLTD48EYD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmP3b8RuwEgAyjhiFTJY3TSmMuH83EH0ELyQG469dtPD/EMnzf9kNZMwLLn3zGkTJEsb5NQQWLck3lxQU0znRvCgvHRNpNJJZHkfxAYqQHzcrUptONrlnE4a9ABN/1k0jxr7mQDsEE+AxsowF16sqoAKRlFbdOybmm1hGKSn8I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrvnVVe0; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f92f3db6fso442443866b.0
        for <stable@vger.kernel.org>; Sat, 21 Feb 2026 00:48:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771663726; cv=none;
        d=google.com; s=arc-20240605;
        b=AdX8BcIolfdowLqcNQ+4U9mVWvCmGUJ0AVsMgf4e8MYv4Bv9ZT4D/t9+mzu9yJtie9
         y/tnp5XQVeKZ6yxTS2bwjvVKkWMwlGmqR47/UKv84Wv9U0askH8BWVU5ITLOqWxsV5r2
         cBDMpz8+FeF58eFa3mGYNlFr0c1bZmGwJkZ7hxSjb3lYvVnNa3qkUaN0GsMK5G+fOeZi
         kfdQWjKtnR/Lff0LROpyqh3+ubxrxDkeul3nCkubPCPrvauDaYfiYV/FnEhxaGB5IAJ0
         6SKhCbSiEBGCx2UR3Mlk8pAC4e//Pgs4qWLiLrImrW/Zh00gq1O9g6ejUXmVlV5nfKs8
         MLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2EY5qpVvBsTDuSWve1J1gQhJ93SfOnHR3h2XpXzEvYk=;
        fh=iLryWfP5D+1yWWR82cy56fWpQuLvIOi2LdE+FlaUCEY=;
        b=VnxsZ/C74BpSzbT1LFgtsbZZCqE+RJFWnFVekp4YqSzHsTlopF7mJ/4EI0Y74qHZD/
         1cQYb5/fob8HacMzGdG/DtdmpyuJaKzaDMVlIBZs4HvvvToQik1jyfKNQ08YGRoK6tbX
         mVgvJEYjmRNLOFKhoPTqMUX1ywJSk+LHTPKf/54EpN8Le9Ylpwou2D5blK3uu0IdT7KF
         UZpkOdpl/yj4M6lEJ4Wn/JQhQ7n2KmMb85zarcwcmxkS5qqPL7IpC8e5kxQN+3+NyeFn
         QkVa2zP6EbBVQsfiKMHLOTj2wpWEahuLF13F6mvnh3o6hIqMpTypoP3q3AJDKPBiNu2c
         ljYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771663726; x=1772268526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EY5qpVvBsTDuSWve1J1gQhJ93SfOnHR3h2XpXzEvYk=;
        b=VrvnVVe0QwW/+hOeir7cHmozTuTY7nhbBf+VlKBzcV7FGQ+Gftn2yZjNPQqoVuNPWw
         g1LimMjY5ehiizNT5apae8kW07ohWfVhGY4c1NGSAahrAZHry8LGgc2VvDLasPrvhiVU
         QXVj8EV90mQhWTrGWXGO5/1BrK5qJFfmPzgiIP5yPlowCTsrG1/U6qAYUWozevHhUPst
         8UWeIr6hEd4dNafAiq2oWm6MuaaHAYpKvnrFMs1to0ZToTVASy0cERDoAEb0Tj+O0PhN
         9JCeWaLWzup4LOjOwHJfRx+q3wUcu0uGfN6pj33eqNMeQkEdBtEKAIEZ9SaNjssSF422
         DhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771663726; x=1772268526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2EY5qpVvBsTDuSWve1J1gQhJ93SfOnHR3h2XpXzEvYk=;
        b=MmkjfzDdWgCiqbiuif97iMIKptvIVt5kDdJdm09PiqchomJYX6DviGamAyLF9r8o02
         5bexAUvEYVqH7JCeHPZGDXvtjnBWVUvkXpUs+EzjyHXYpAyI/FAr5gd2BekO4/s1fltr
         XVZGsdm0aIB06dP1aj0Ecp8Xr3izB9LwpCr/J4bOY6uDdgC8uqmTxfWSroD6f2RkzAsy
         ADrmgw0QQ0P30kooIe95+H1rkTGlSHinxLTqUmhX59aU3a+Lkk4iPGeJbJtx/PvWrPlI
         H8GOqyVu7TxdUEmTmO8T5XL+3acKZyt1uC9a5ds485N7YqQ7d9ANyk6XmZcEksEsSK8D
         WLFA==
X-Gm-Message-State: AOJu0Yw8sYiyPsK/PHCSMNoSOKrX4xobp47ShZBza+N1DlaiKAzK/8Of
	TM/M5Ba0fzHUaw1y6D/WTG+Eau5JPtGQMQxmOCFpnbOBQ011v+79XZjzr/GnCuItICBshA2mt/w
	ff7IRRt7h0RDHfRhEnrGDuE/Yv36pH7s=
X-Gm-Gg: AZuq6aLnoOz70VjWxSjULfIp7ca6VokNG8E6GFYaq+5k3BeOxozFykhD9VV6q5a+jmO
	Ts1r9Z5m+RvoThZavteQ8xLYxrReVrYffuJqUw1PDRvu+N1sYhFS2/ZAyFDwdSF0eNSAEtda5yS
	M2/DW6h7Q0r+uzSydhQ8CLVEzD1gMapvt7iLM/nuqGSSa5JMqQSrqNOUv7MljAHlxZ31aVvJQCH
	66saZRi0I0gBRUascbP3mNXVNQR/uEyfZmw4pVwmrXg68Qb5Mwa+q9kZ8WK9ZQhJ5ysosaP9sTU
	SEIQsWEIXuWVwi3Pnx2eF1p1h/dd2RIyyBRD9165NT1AJoNmhOmlqVKWjDBoN6J7BIERy1dV2Oo
	/JydfWw==
X-Received: by 2002:a17:907:3c91:b0:b87:b0ba:5d2d with SMTP id
 a640c23a62f3a-b9081c42436mr136091166b.57.1771663725994; Sat, 21 Feb 2026
 00:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com> <20260221034402.69537-3-rosenp@gmail.com>
 <2026022148-unsorted-pushover-8262@gregkh> <CAKxU2N9dJg9dy05h6oGgWidc81-kdGw=jUuM-i4KL1=EhevrZw@mail.gmail.com>
 <2026022126-chair-spout-641a@gregkh>
In-Reply-To: <2026022126-chair-spout-641a@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 21 Feb 2026 00:48:34 -0800
X-Gm-Features: AaiRm51RjwwZfhQIEJaLMLmlDT-qI7j28uWxDcE_9CBb9uX55P5V7cGqPAMw40E
Message-ID: <CAKxU2N9Fz7SCHUah3LbWSwyyO61v5iB0A0cPkMBBBZ+pF4gWwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm/amd/pm: Disable SCLK switching on Oland
 with high pixel clocks (v3)"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217631-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1EA516C6EC
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:33=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Feb 20, 2026 at 09:52:29PM -0800, Rosen Penev wrote:
> > On Fri, Feb 20, 2026 at 9:41=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Feb 20, 2026 at 07:44:02PM -0800, Rosen Penev wrote:
> > > > This reverts commit 0bb91bed82d414447f2e56030d918def6383c026.
> > > >
> > > > This commit breaks stable kernels older than 6.18 that are booted w=
ith
> > > > radeon.si_support=3D0 amdgpu.si_support=3D1 amdgpu.dc=3D1
> > > >
> > > > In 6.17, threre are further commits that are needed to get the DC
> > > > codepath in amdgpu for Southern Islands GPUs working but they seem =
to be
> > > > too much of a hastle to backport cleanly. The simplest solution is =
to
> > > > revert this problematic commit
> > >
> > > Ok, this is better, but still, this only applies to 6.12.y, right?
> > The reverted commit (or rather the one from master) was backported to
> > at least 6.12 and 6.6. I didn't check what other kernels include it.
>
> I see it in the following kernel releases:
>         6.1.156 6.6.112 6.12.53 6.17.3 6.18
>
> All except 6.17.y is currently being supported.
Yes. I complained about 6.17 being broken at the time and luckily the
proper fixes got backported to 6.17. There's no issue there.

Those fixes are too involved to be cleanly backported to older
kernels, hence the revert being needed.

I'll mention 6.1 in v2.
>
> thanks,
>
> greg k-h

