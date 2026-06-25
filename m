Return-Path: <stable+bounces-268549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CgZtAb4wPWrkyggAu9opvQ
	(envelope-from <stable+bounces-268549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:44:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F76C63AA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:44:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J9V24Po6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268549-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268549-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7DB301AD03
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B39B33711D;
	Thu, 25 Jun 2026 13:44:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12DE32E128
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:44:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782395065; cv=none; b=V91jaRRj5I31QmlL4lnwM2aNZPbSBLSlj5DSb2eyafRPSA4feATGACoxqHmGnXsqXmCmxMkMoa/xIwMRK+2T7bQGK3jQ/DZLH/qNyvB39s7WF/ntUiu/cAW6WcV86IqHdGJolzFnLWSzjwGJiXKXgJ3UVhT7LCgCSLIWN42/EbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782395065; c=relaxed/simple;
	bh=QKRvbgSIs2tFHUBa5X93644/2PO1rLUb6wSo2J+apI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keXIpsOTwepjMoyhLnLElCZUqu3MjqnLHrtLQEJytziof7j4DCrwKL1VQprRFFCJs17Mnu4LAHEC66YiCJfdKv3YTBSXHWz8FpQhd5O7erH9dtDZ9u9Iiw755uarfeS+E1DNenfUEO0AiV/SeR7Jo9CIRXeF+m7/0SkJd/X63SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9V24Po6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86F81F00A3A
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782395063;
	bh=Qw2Vxl+bknWvdMDnl/tVKs+kZ0MjbmwMJZ/OSAJ9qB4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=J9V24Po6Xm5gdIBRmIdKMo9q9ZLuavsoG9iGERlVJ2x/DDcvCPXJneGvfZINUFHba
	 TMXmWOhIdsBn2Be5ZvtikcwSfTZTWknJ11mPejGq9r/in30prgXk9CGgb4/xiASivX
	 i85nxJESK+J5nGm/w72zLDoMBsN6bDdEJFBXZMHYrV5DWQfzCkyPhpiWE38Uc9B5r8
	 A6xHglNMqW6DhdPUHJ3BRlGmPOY03nf0D4hUoAsqWrhkmBYbX+R0zMni8mn3LAqZvX
	 b3uARAStupwsreK/sQqOzeniyslHL4G9jLbzmveD3Km8DS/HDuKz9FtUNlIrUsLELC
	 DUq5RI9ovkhBA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aea0fff535so1026446e87.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:44:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoP7E3zl489XzxXDh1Lhrsh/pvUCeA82+szQCWyZXXy0UezKP9GYZtDIv0L+waOBKkDg/9msYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJUvUYZneADyuUALKmA//0ph2wD3ZiTMauVjj3EvoPoz5Aede
	8gN+VS7VL/odmjDfMxQteoFPxmQON3etTnMIKPp/CFk8bYkDI9cLBKS6W2/x2nalDk+IJANrS8p
	BLYHEcj++uCfJHKD3p+ZVMky2gAlv6eE=
X-Received: by 2002:a05:6512:251f:b0:5ae:a488:cda3 with SMTP id
 2adb3069b0e04-5aea488cde1mr449055e87.26.1782395062279; Thu, 25 Jun 2026
 06:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <961A84FF37B50665+20260625132903.2840457-1-raoxu@uniontech.com>
In-Reply-To: <961A84FF37B50665+20260625132903.2840457-1-raoxu@uniontech.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Jun 2026 15:44:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwx6FhnRs2HLNhNUAWtMMtE7vL8eGY6HkZj_SyUOgb=g@mail.gmail.com>
X-Gm-Features: AVVi8CfNwTK5ldVrg7FbS7Plh3b9hNya5WSYFmcRi__wVOAPSImoFyv9PB5ex20
Message-ID: <CAJZ5v0gwx6FhnRs2HLNhNUAWtMMtE7vL8eGY6HkZj_SyUOgb=g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: TAD: Check AC wake capability before enabling wakeup
To: raoxu <raoxu@uniontech.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268549-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:raoxu@uniontech.com,m:rafael@kernel.org,m:lenb@kernel.org,m:linux-acpi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D1F76C63AA

On Thu, Jun 25, 2026 at 3:29=E2=80=AFPM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> ACPI_TAD_AC_WAKE is a non-zero bit definition, so testing the macro
> itself is always true. As a result, every TAD device is initialized as
> a system wakeup device, including RTC-only devices and devices whose
> wake capability bits were cleared because _PRW is absent.
>
> Test the capability value returned by _GCP instead. This keeps
> RTC-only TAD devices usable without advertising a wakeup capability
> that the firmware does not provide.
>
> Fixes: 6c711fde3a1c ("ACPI: TAD: Support RTC without wakeup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/acpi/acpi_tad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 386fc1abcbdc..fc43df083738 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -856,7 +856,7 @@ static int acpi_tad_probe(struct platform_device *pde=
v)
>          * runtime suspend.  Everything else should be taken care of by t=
he ACPI
>          * PM domain callbacks.
>          */
> -       if (ACPI_TAD_AC_WAKE) {
> +       if (caps & ACPI_TAD_AC_WAKE) {
>                 device_init_wakeup(dev, true);
>                 dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
>                                              DPM_FLAG_MAY_SKIP_RESUME);
> --

Applied as 7.2-rc material, thanks!

