Return-Path: <stable+bounces-249602-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFJ/IC5vDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249602-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:09:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C979580494
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A5E6300748D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF33403FF;
	Tue, 19 May 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQrm9+X/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C5C27E049
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199730; cv=none; b=JpXzF0FP6MTqbWhmaqheVE2Uoux6EEHFlvMDo6r3uZ1TFBepG7h8a/D7kq1cW+kZzMqLEmV0Qn3Y3pwhE+EMevy7QtXigvezDEzqJu5DR/ukqZtd9S/gs6560yxaBZwewfnDWHb+AHZcZu8wXM7eXxWi+i6h0c4rPZN7RKcew74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199730; c=relaxed/simple;
	bh=g0OSmfsNbDEyt/NV945XR6ZR476gQ9iLJFvsCNc9nKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uI4scnq6dAccs86U4QevxHrMpM7ScWcdQoDWQbVvZJZtH7cme6Q4ol5L6PjfgU3ysCtGTsZIkbJpH6SyyyetkXW5QeEfLaYgshgBHtAN/FPB4DgJUTH3v3CUyLA237XQJ0pYFxDdxDGxXhT46ofJxYN6Rj9/4s8637wJo/M3nek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQrm9+X/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B9EC2BCF6
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779199729;
	bh=g0OSmfsNbDEyt/NV945XR6ZR476gQ9iLJFvsCNc9nKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IQrm9+X/iiPr0al/z0NC3EhqjsaOwtlhOYVehYQmP1pSjloODYvfVaPm6aG98IYBa
	 7PFGw6Fehm/zwTntc433ZxKqPW+BoE+OKM5h++IipFPbzuN/JkouxJGA0LeItGTIz/
	 cI4u6HMKawQS3DvcBUVcGCFQFURteHx6Ia0ZT8zJBeOcDRGF3oRQ7+tvxpC7N+nk9t
	 gq/MthtYmK/Mm7pjB/Rg92/SEPy52ahQXq0Ta6/J84JqvUz3HAIYRiGLUvTsIf/+VK
	 W+QC8aAbe+wRCBMmIfcoSObbjLzRGrFuzUXCMki3pUv3yBySKqg1DwPofzaSjAqmgK
	 7sbgyxkXSTE/w==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-393d07e8938so32306411fa.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+UJTs56WJMWbT1sgc/xzoZWFp35WlIxloFA2H5/4QIZOQNGMTASSbmEtDyyVQiW9y7YSrn3g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAdLh+o6N4CgGmRzNz+mGQ8f0ES8PF7dd4dUDm/W/hWcyJhS/
	kj9yaAwkm+fwoDGaH0ZjLWG00A2otgYuOjm4AD9zF8TsxjT5Wzl65+I8/GCjRoNIUeD1XMrkHna
	zyGAuRrGL74SW735FRsOFPUGT2xamZCI=
X-Received: by 2002:a05:6512:1321:b0:5a4:1a2:1d39 with SMTP id
 2adb3069b0e04-5aa0e5ffab1mr4973395e87.6.1779199728096; Tue, 19 May 2026
 07:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E2OXET.4X5GTP37VTNC3@kousu.ca>
In-Reply-To: <E2OXET.4X5GTP37VTNC3@kousu.ca>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 16:08:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
X-Gm-Features: AVHnY4IYHpFZ_8NApVrHEaV-a4gahD_pRqfgG7xqb3mOswDf3PM0BnPOwltOgho
Message-ID: <CAJZ5v0jVQyWYqPo_MiUwNQb7FLNR_Q_++Xq=xA1owcHpcjN=OA@mail.gmail.com>
Subject: Re: [REGRESSION] Toshiba Fn keys + lidswitch
To: Nick <nick@kousu.ca>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, regressions@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, todd.e.brandt@linux.intel.com, 
	xi.pardee@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249602-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,kousu.ca:email]
X-Rspamd-Queue-Id: 6C979580494
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 12, 2026 at 7:16=E2=80=AFPM Nick <nick@kousu.ca> wrote:
>
> My Toshiba Tecra X40 laptop's function keys no longer send events.
>
> Specifically the mute ("KEY_MUTE"), lock ("KEY_COFFEE"), "power plan"
> ("KEY_BATTERY"), sleep ("KEY_SLEEP"), mic mute (for some reason this
> reads as "KEY_SUSPEND"), screen switch ("KEY_SWITCHVIDEOMODE"),
> brightness ("KEY_BRIGHTNESSDOWN" and "KEY_BRIGHTNESSUP"), and rfkill
> ("KEY_WLAN") hotkeys -- these are the Fn-shifted versions of Esc, F1,
> F2, F3, F4, F5, F6, F7 and F8 -- keys no longer work. Neither does the
> lid-switch.
>
> Fn+F9, Fn+10, Fn+F11 and Fn+12 still work; those show up on
> /dev/input/event3 like the rest of my keyboard, but the hotkeys show up
> on /dev/input/event6.
>
> I'm on ArchLinux. My keys worked on v6.19.14, I first noticed them
> broken on v7.0.2.
>
> I bisected mainline and found the break is: "ACPI: scan: Use
> acpi_setup_gpe_for_wake() for buttons"
> <https://lore.kernel.org/all/2259694.irdbgypaU6@rafael.j.wysocki/>.
> That is, 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a is bad and
> 88fad6ce090b395af4c654594a54589a386bf24b is good.
>
> #regzbot introduced: 57c31e6d620f132dcf610b2c52b4cdbd203c6f4a
>
> Maybe acpi_mark_gpe_for_wake was initializing something particular to
> Toshiba hardware?

Thanks for reporting!

I think that the problem is acpi_setup_gpe_for_wake() doing too much,
I'll send you a patch to test later today.

