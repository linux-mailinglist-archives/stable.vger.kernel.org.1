Return-Path: <stable+bounces-216842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPiwKv16lGkfFAIAu9opvQ
	(envelope-from <stable+bounces-216842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BBE14D24E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 015103012233
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198DE36BCE6;
	Tue, 17 Feb 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USaO3SAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD636AB7B
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338488; cv=none; b=P3cpVSjTyNebZZv9aYvQSozdVvb84A+FIN8/tuI5YjZ9QPeyPRBWjvpxWPzCiuajX6mJ6hMHxwq1teYYESjghfM5bJhuatE6l9RLIt/1cs6gwQnuQ/TYFzcqJkW0fQMKznEfzuvZyO8dkrtNqL3B/ewWxLLyQh7LleCy8N3MA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338488; c=relaxed/simple;
	bh=D60oHNN6lFdIL7vwcATr/pv77WmeYhYGvjsPCv64dCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZLnEnSF7LScE4DEuGy6wqfQWodpTG7REhkQQbDK57eBeNn7nRl2kGp3esJ3jbzSAJi87JG0DdMtswX4woIW6Nu7evwzTvgYRO/16QvzHzEkHTD2h4FyXDrZ28xzHtbICT/c/C7lKGmjKGwL2t3XCa2saOv7FB3DKP1hBGFYS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USaO3SAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC9CC2BC9E
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771338488;
	bh=D60oHNN6lFdIL7vwcATr/pv77WmeYhYGvjsPCv64dCk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=USaO3SAbpV9UhORq0ncePYzUxVJVjZF4WPEQ5AuHbNwei+7Z9CneyFfsoupnQqh9j
	 iHLRFky9v1JGN++iUtO++MOEAc5oo/O5jYYaaYHq23SLB/Cswof6oc58cAcBzXuzYj
	 Z6qS6wCWskdH9Q3X+/SxETEwqWswZjur16X7Dp0cSRNUIBsyTPhSV60aRMGtjV4Dxo
	 59qVrHa5Y4iaACCbPYJO1SMhs/yLSXq+gfvEvmLEkrnnjTu3UWRQGZNr2Gry5rMt+m
	 +966BeycMEOxxxGFf/l3E20jwWlCs09HOImPmne3mWZHnMXDSl/oth3YcfsIKvjWdl
	 gO9R2DaCOsYEw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-387097ae2e3so33560131fa.2
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 06:28:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVm278DureXZOdI28m5YgU+McwtNLP8rVrTVMqhhRWDPMue/+p74xehTWVuY7eX8TKgmTz8xUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvQ2RemzbFj8E9ch+WIa/oHSf95cO+IgzqQ1WMRVp++1dh/Wyr
	3AlQS0RIvsaEfkgzuODRcAcQWetIdB35QNJMDW7mYlpfcx2j6XAj2H48kw/qiezTqKR0EEwR2gz
	e5nJu+zlNwKJIjc+IqAzi6BCwF39PObM=
X-Received: by 2002:a2e:bc0c:0:b0:380:a1c:7045 with SMTP id
 38308e7fff4ca-3881b8b41camr30976861fa.8.1771338486818; Tue, 17 Feb 2026
 06:28:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217133411.2881311-1-ryan.roberts@arm.com>
 <2026021700-chafe-jurist-cb24@gregkh> <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
 <2026021718-citrus-parakeet-dc60@gregkh> <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
In-Reply-To: <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 17 Feb 2026 22:27:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v67_UQ9rAFPQ5mqTFdNdPxyAJj0WZ6PwOLbHxU_0XQM6CA@mail.gmail.com>
X-Gm-Features: AaiRm50DlbCKmsQK00mf12t22scEG_EaCKBpc0WZ1vuqzX-7ewC1OTCugfPntLo
Message-ID: <CAGb2v67_UQ9rAFPQ5mqTFdNdPxyAJj0WZ6PwOLbHxU_0XQM6CA@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/3] arm64: Speed up boot with faster linear map creation
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jack Aboutboul <jaboutboul@microsoft.com>, Sharath George John <sgeorgejohn@microsoft.com>, 
	Noah Meyerhans <nmeyerhans@microsoft.com>, Jim Perrin <Jim.Perrin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-216842-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 41BBE14D24E
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:21=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 17/02/2026 14:10, Greg KH wrote:
> > On Tue, Feb 17, 2026 at 01:58:36PM +0000, Ryan Roberts wrote:
> >> On 17/02/2026 13:50, Greg KH wrote:
> >>> On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
> >>>> Hi All,
> >>>>
> >>>> This series is a backport that applies to stable kernel 6.6 (base v6=
.6.126), for
> >>>> some speed ups to enable significantly faster booting on systems wit=
h a lot of
> >>>> memory. The patches were originally posted at:
> >>>>
> >>>>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-r=
yan.roberts@arm.com/
> >>>>
> >>>> ... and were originally merged upstream in v6.10-rc1.
> >>>>
> >>>> I'm requesting this be merged to stable on behalf of a partner who w=
ants to get
> >>>> the benefit of this series in Debian 12.
> >>>
> >>> Why can't they just use a newer kernel version (i.e. 6.12)?  Surely t=
hey
> >>> would be able to justify moving to a newer kernel for performance
> >>> reasons, why enable them to stay on an older one, just delaying the
> >>> inevitable upgrade they will have to do anyway in a year or so?
> >>
> >> I can't answer this presicely, but I did ask and push for that approac=
h. As I
> >> understand it, they are stuck with Debian 12, which is stuck with kern=
el 6.1.
> >> The Debian maintainer apparently requested that these go through stabl=
e in order
> >> to get them into Debian 12.
> >
> > I understand the position of Debian not wanting to take patches for new
> > features that are not already upstream, but really, Debian offers a
> > newer kernel for hardware that wants to use it for things like this,
> > right?  Why not just use that instead?
>
> Let me go push a bit harder. But I expect we are in the grey zone between=
 bug
> and feature here; this is a performance bug fix, not a new feature. By
> selectively backporting I'm guessing they are avoiding the risk of new fe=
atures
> that a new kernel brings introducing new bugs? I'm guessing there is a hi=
gher
> qualification bar for that.

Why can't they use the kernel from bookworm-backports, which is 6.12?


ChenYu

