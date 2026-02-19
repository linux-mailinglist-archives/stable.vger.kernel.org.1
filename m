Return-Path: <stable+bounces-217462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ9dHSM5l2l2vwIAu9opvQ
	(envelope-from <stable+bounces-217462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:24:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABC160A19
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EEC93025F55
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7B34B1AC;
	Thu, 19 Feb 2026 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrZJT7J4"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEF345CD9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518240; cv=pass; b=l/ENIjuZOIBikw4BxHBKGswPfeW5o76sMXVWdhNhPFs5rfjhi+5Inky5iY8+L8p7EvALi1kXgBgnK1u3Kc3yMFoWSvaK05z8eb4MS/mpdhu3r53semXPV1Cvjzb3RHiONA/yE0IzJvb9ZX5/TwSsHYUxcXJ73Hkg405x/cPcKS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518240; c=relaxed/simple;
	bh=Pet/c2OGnY1gfQmFiC8Mebb/GP6QRqCrlNN3wTZ2f2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USr3wMp9Aohfs6fB5/+Uiu8//hL1sBxatVvg0l2HrqKhgLb5EGH50wOBLeC75kgWMj2U1+ne4J3DsmLzw1J8ZiAJkcOGa9dRKcEDo17+HvJxTM4tJY1z03/Yb50FEt8v175ZprRM1IoPG4UnKt05e4uTKt5BY6bb0omdoy2HQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrZJT7J4; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-896f8feee14so15868916d6.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 08:23:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771518238; cv=none;
        d=google.com; s=arc-20240605;
        b=lh88FxdAQjrze0jHyIA3se+dEfQX9uXW4MTdKhujqUBojq5uGgtpQTk27wrY0jYtdz
         3ms1iatEw/WcgiA0VgZFF4WWC3tu+zMPtBbEHVfBzIt7A2wlObf/g0SXnfKdcT2n2NHc
         8T8k2PUsKDzlr0v6uvrpuzIhWftXC78noABRe5qJywUmWT230AmgA7dHaCvKNHfErann
         iOKGcxAxTXUXTaQBsuPqWvn6ZcWa9c43VFwGSxG8rOrHoogkOEwn1hRM/g7nKoiBiq4D
         szCW2VVXrW8p+YjToolDs+mPHtavp6W47n64Rf6Uem060+U6HSifOEcg1XP9wVz0KkIC
         kA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4yeHhzpJN+4nhHpP7a5dAzytay7Sndg0H7YbB+nOFY=;
        fh=EEwhLiTo6it25qz2Li4JiiPQNXES+V53AHdAzlA7F7M=;
        b=jN9ZGRw8pFXlLb9Cxhwb2uuofqTnKqnJnTP2ZEeocuxTC1wg3Z6ecDuka/o7HakYRZ
         iXqz9m/SmieebTKNjnMrWOZGCJjnmN/QiDwO9g/n0GrZpDAIYjKNgTnM3mzoF0E/wD1i
         8xjU2MnF/pCBxCNPOJlKeGMo5MNKQ2J6tjy9lICb7dg/G8t9vXcEVmxrkEdVzl8fj3pS
         RxBXxEhCN+kYjsERCxrxddH1OCYL228xa89J2d0Ep2ZFFtj9P5VqvC8GJT1rPDhgKA3K
         gqAqbHOBGFdEetFvUG7hQhFADbEWaR7R2FrLn5q3wOpjs/9rPRsdsNOdVviapmY+Nsys
         HNKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518238; x=1772123038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4yeHhzpJN+4nhHpP7a5dAzytay7Sndg0H7YbB+nOFY=;
        b=mrZJT7J454lOVT2fHTGATGc4l8IO2bPDStIQnggw0HMTtL4ogP7jQP4B2SVnvHEQHS
         6ZjV+PkQp59VtiFOYqr3o+cnTcAY47usUPIjkj/eqhojDO2zR+sZ2F0Dbh3l9A158lyj
         TBKPq4T/kYOtPMAWoIzERcvj/Fh7M1BhLFce2yp4Pj8XKzYFk+P1iTiuKiV7Cuu+GOdg
         jUJ7fC3/+mWXSx6eaGBfQQ8zk4Pz69t7RsnlphkJp2Jfe1hn0zC9SJpdyfkYwefRKutl
         qL5ot5zxVg5oehijT0c5ji5vo5TLK+qkShxz1jsjx2CQE8ApboRDYcC7J/3VWlJZYCaB
         FIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518238; x=1772123038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f4yeHhzpJN+4nhHpP7a5dAzytay7Sndg0H7YbB+nOFY=;
        b=AgN6eoRSn7J4NmZO5F7/SLUJViJ7FoEilnc2cEyfQbGKfcFNoK4+h7o6kYh8Tzl3JN
         gBCIUIyJCrpFfTKtuehmnFkt6yznQC/IdDUhg0xNms+MVSsRhB3czp3Lr1yMJQDBsLD1
         Bu7/yfG0uI22+utXqqRdXMual2vUvPavVwxeiWu57FY1PLkPmlqEgCsBGvLLo3IVXQWF
         2r2m9cuDOd82LwL6grbdeUyaOTiq/fjyhMrAHyTATNLa6NVPDbeN45WI+dzsFXs1e/Zb
         6umwvoqxe94ecO4veygWfNraANGAZZZGxdCSQCHlZcS42Ea97wnuCOVYrWt5Owt3zJ8/
         6jlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQnXamM4T1/bT9n5pIE+pnYsTWj9SgzdjS778DQluRwDNx4MaGh58rv0ebPqpHXBqxapYn3RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExX/msTkmdv5rdHuJKjvNP4YiR7DITPAAvGUJ91gehe594sCb
	Bv3SmABeuoXGCPtPAtsiNQsJYpWsWkEudkkfa8PoL7SpF5lqK9HHRMrKX2NTlJrEXgKinB8e8ph
	7BkJ7fgFADfPM0PGsS9fyUZPb4kawF7UEzv+c
X-Gm-Gg: AZuq6aIl0Ioh8zY+NxTLAkvK9j2xyLBZcDkcc7RbhK/UPzKDsrGFnh/1/4pYfGXYhFV
	6cmbkIAPmOGUleM5th19A96L8vZ9wLaEYCsyWoPOMtLIDJqlykqpUcIpqxX1iwZZ8t9mITantHJ
	EYRFBg8G6W6KXCDhuQP98EhFtAz9HwsgPuQjx8vekpJIYLDrER2QNVATKWVu6adw9iNwnFlY8TV
	ug4Abn1Uq149DaO6PEX/s3IkMpBQnrUbSFmEPqp0Qd/pDj1lNrE7qgPx1jsNe/ZKbzvw1l/cf05
	z3/XMqmOAYwB7O6wpmgowRsjhDnnmdC/jBZVbDATkGTTK4cCVBmt6+rhg/wd+KxPOtBBQqZGKpW
	W0on/BT5g5R9TApMLNS6TiEZR
X-Received: by 2002:ad4:4ea6:0:b0:896:fb02:e3fc with SMTP id
 6a1803df08f44-897361aba19mr295664726d6.38.1771518237674; Thu, 19 Feb 2026
 08:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
 <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
In-Reply-To: <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
From: Daniel Matsumoto <insidetf2@gmail.com>
Date: Thu, 19 Feb 2026 13:23:46 -0300
X-Gm-Features: AaiRm50d6W_5fE_7G4yZsWAY8m58LxN519vozyjLw2jc2sNJvuLhnez0JhwrDVQ
Message-ID: <CADbaWgEfX87oPoiO3vdn_s4=Q4TVRVzh=qDgewEC-t2Xa9gU7Q@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: luiz.von.dentz@intel.com, maiquelpaiva@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217462-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[insidetf2@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,celes.in:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CDABC160A19
X-Rspamd-Action: no action

Hi Luiz,

Makes perfect sense regarding EXPORT_SYMBOL. Thanks for taking a look
and dropping it.

Regards,
Daniel


On Thu, Feb 19, 2026 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Daniel,
>
> On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.in> wr=
ote:
> >
> > Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow in
> > mgmt_mesh_add"):
> >
> > I reviewed the call path for this patch and the overflow condition
> > appears to be unreachable in the current tree.
> > The only caller of mgmt_mesh_add() is mesh_send() in
> > net/bluetooth/mgmt_util.c. The length parameter is explicitly
> > sanitized before the call:
> >
> > if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
> >    len <=3D MGMT_MESH_SEND_SIZE ||
> >    len > (MGMT_MESH_SEND_SIZE + 31))
> > return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> >       MGMT_STATUS_REJECTED);
> >
> > Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which includes
> > the param buffer sized for this maximum length, the bounds check
> > introduced in the commit is redundant.
> > While defensive programming is valid, tagging this as a fix for a heap
> > overflow is misleading for backporters and security scanners, as the
> > overflow cannot be triggered.
>
> Yeah, well I would say it would only be valid to apply defensive
> programming if that function would be marked with EXPORT_SYMBOL so it
> could be used outside of net/bluetooth context.
>
> > Please consider dropping this from the stable queue to avoid
> > unnecessary code churn.
>
> +1, will drop it entirely, it seems I will need to ask for more
> evidence as apparently people are relying too much on LLVM nowadays.
>
> --
> Luiz Augusto von Dentz
>

