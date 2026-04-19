Return-Path: <stable+bounces-238655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCe/HlgC5WlCdQEAu9opvQ
	(envelope-from <stable+bounces-238655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 18:27:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4A424B13
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 18:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DC9301F9DA
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804B2BE7DC;
	Sun, 19 Apr 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="nsdRXPDA"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68727FB0E;
	Sun, 19 Apr 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616015; cv=pass; b=oUT6hLm/fxhoa8NT7T+NoCAk0LX3sAyLp7sZaxy4WPxwCnEGGCR6RlAhzbqtJmXimhFbE3EF0JDlSJMg0N+6xW8wHB7bdyl0zBWWXg0GCYVye+UoRcAtjyoQWW2Byg5XV+3LisNTMqxrvJP+Y2Cf4EjQH77DdNNXRozzbPbPMfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616015; c=relaxed/simple;
	bh=yxjEoMXGzc/WdkfSdsocpIic0FHGlTrW9jCQZ5b8YNk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xmd9ieqHhzPFJQTEaFrON9XhR66J5gYyCBjmqfET3ClDk805LXdaxaqNZYKsbttI8MadJy1yDfS4x+q2/DOciRX1XcyiHOJYj/ZsOPaQwqYiecHgbgq5lYLz6/ED/S0WcwY+nIgwOaYrxFMxzWNNOtBlAnrmMBaT20nZSwrQgC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=nsdRXPDA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1776615992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kQSnz1iBfr3zPc9JyMtd71bSN55fRDtkz8V+izPOrszcIFWW8eiE2GQ805NYkzw77JS5KVENc6lXWNqZOe+/sKNLz69fHuCgfAF9oCtd1e5aU6VeHPwPIef8/XgyMuaMjGAkUPZoJNTH9pAZNy3PCt9oSc0vBJAAF2REgRnjEu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776615992; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XDxRzUYghQyLSOtVSFJCCp821NYg75PtJOz/TeevvgQ=; 
	b=F+vTlr3zGS9R9vpQsoUo6w/jtWCGwtwsWifitwBJRmWj5Oc0ZJqTvR+Qoq63JAbiZzaKyzNxjDWmicFYMzfQHkC/DurWfG2e41wz5IDi9JM0qfH7bNq2MXicFJ5hGdhAwEKiTYXPVCcLFzOZxN2YXPJqlTA/9X+LVqyuTqv5uT4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776615992;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=XDxRzUYghQyLSOtVSFJCCp821NYg75PtJOz/TeevvgQ=;
	b=nsdRXPDAm9LAwbVoZpAUCLGasQ0RZhdslKj90S5qOE/YGg6tTQNGWI++ab7vFRhm
	tPo+C6x4ZEwqbQgprBNDC0VpMnZPpBVq519MrRKAXD6UrRI9aeEjP6c8p4sHI0me7oj
	+vk8EP4DaZcvoR9xvAB77dl7f+W2Q8fdGtIrAED43YQ8fZWfGYPKZ9CSX/3D4+L/m8I
	FSskX4UJkqr4+vW0c++dI1oahwaQ7tafT9MGLcOpXrj1JlRj7GDhF5w9z0qdiuGmiPP
	iI5D7oJdTY/7n1AwonQDyHr22e2tyhDVq198BodPjidz+iYfWris+qlVcGt+fn+Zg5O
	imvgwHnlNg==
Received: by mx.zohomail.com with SMTPS id 1776615989353789.8106081725186;
	Sun, 19 Apr 2026 09:26:29 -0700 (PDT)
Message-ID: <938e8afadcbf2d7b9f0397e24926224985d9c385.camel@icenowy.me>
Subject: Re: [PATCH v2 1/4] HID: pass the buffer size to hid_report_raw_event
From: Icenowy Zheng <uwu@icenowy.me>
To: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
  Filipe =?ISO-8859-1?Q?La=EDns?=	 <lains@riseup.net>, Bastien Nocera
 <hadess@hadess.net>, Ping Cheng	 <ping.cheng@wacom.com>, Jason Gerecke
 <jason.gerecke@wacom.com>, Viresh Kumar	 <vireshk@kernel.org>, Johan Hovold
 <johan@kernel.org>, Alex Elder	 <elder@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Lee Jones	 <lee@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 20 Apr 2026 00:26:21 +0800
In-Reply-To: <20260416-wip-fix-core-v2-1-be92570e5627@kernel.org>
References: <20260416-wip-fix-core-v2-0-be92570e5627@kernel.org>
	 <20260416-wip-fix-core-v2-1-be92570e5627@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[icenowy.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icenowy.me:s=zmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[icenowy.me:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[uwu@icenowy.me,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icenowy.me:dkim,icenowy.me:mid]
X-Rspamd-Queue-Id: DAF4A424B13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026-04-16=E5=9B=9B=E7=9A=84 16:48 +0200=EF=BC=8CBenjamin Tissoir=
es=E5=86=99=E9=81=93=EF=BC=9A
> commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()") enforced the provided data to be at least the size
> of
> the declared buffer in the report descriptor to prevent a buffer
> overflow. However, we can try to be smarter by providing both the
> buffer
> size and the data size, meaning that hid_report_raw_event() can make
> better decision whether we should plaining reject the buffer (buffer
> overflow attempt) or if we can safely memset it to 0 and pass it to
> the
> rest of the stack.
>=20
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> =C2=A0drivers/hid/bpf/hid_bpf_dispatch.c |=C2=A0 6 ++++--
> =C2=A0drivers/hid/hid-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 42 +++++++++++++++++++++++++---
> ----------
> =C2=A0drivers/hid/hid-gfrm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0drivers/hid/hid-logitech-hidpp.c=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/hid/hid-multitouch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +-
> =C2=A0drivers/hid/hid-primax.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/hid/hid-vivaldi-common.c=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0drivers/hid/wacom_sys.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0drivers/staging/greybus/hid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 2 +-
> =C2=A0include/linux/hid.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0include/linux/hid_bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++-----
> =C2=A011 files changed, 53 insertions(+), 33 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

> diff --git a/drivers/staging/greybus/hid.c
> b/drivers/staging/greybus/hid.c
> index 1f58c907c036..37e8605c6767 100644
> --- a/drivers/staging/greybus/hid.c
> +++ b/drivers/staging/greybus/hid.c
> @@ -201,7 +201,7 @@ static void gb_hid_init_report(struct gb_hid
> *ghid, struct hid_report *report)
> =C2=A0	 * we just need to setup the input fields, so using
> =C2=A0	 * hid_report_raw_event is safe.
> =C2=A0	 */
> -	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf,
> size, 1);
> +	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf,
> ghib->bufsize, size, 1);

Oops, "ghid" is misspelled here...

Found this when building some gaint kernel with this patchset.

Thanks,
Icenowy

> =C2=A0}
> =C2=A0
> =C2=A0static void gb_hid_init_reports(struct gb_hid *ghid)

