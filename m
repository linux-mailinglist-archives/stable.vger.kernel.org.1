Return-Path: <stable+bounces-238300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADwSJS254GmIlAAAu9opvQ
	(envelope-from <stable+bounces-238300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:25:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31A40CE3D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC23A301A518
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010739EF35;
	Thu, 16 Apr 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9pFIaBS"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD039E178
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335013; cv=pass; b=iV2cIRs4SUFjDQfLIRWgIKHHoG/4PLMoZzeSxmQYGsYmbp8W7JGY87c20aIjZYQLQHVBn5roWJ5P+7To0/Dcuies5bel++9YseOb0nSkuq2aTNnVirHozPkAYyqsxufAQ+Bq5Eom9OF6ICTcZ+/K3jyWsaMDhjW492MAS3V3V38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335013; c=relaxed/simple;
	bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHGUdl9vBazFrZoYvIIQTByuOJ8pdQxICiFTq/09S5oBxxtzQoMpgun4MclFiBU3U8uUxRXNoXxye0YwVGpDLDNh9+99dAhmKKN5rpx8VrdfuiRXwP8JpOBcVra/aHnwKIYx2uPppLva1IFmmLlN4696JeEgVCzSgTBeNOe12/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9pFIaBS; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651c7ddf514so4569585d50.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776335011; cv=none;
        d=google.com; s=arc-20240605;
        b=gFXPwBZRS3OiZkizZKKQsOPNrNWO4kP0/aIJOk4OkEhYkjgbOSDrDFbSbAZknDIWa5
         xxkOpG/NreLS0uwYUDmWyPzv0Jme9dXKPxoy99g+mW33GWc6zG2qUoor3VWWItJiOLl0
         sS+mPU3KyvzHjo7dBSWxUW0nouhtd53t68fE9ZxtlFDftZamrAx18DG4a1EoecUgCjJW
         cnV8+urT1my8gmMDfoOSEGIYzJpqih/P/yi1APXpnNSK2HXtzGQyEmkLIO5uWiVy6hxV
         BnQrL5ix1X6HVz0SPUg+TbyARsgkw6/gjdSFpvBgP0nKwukJWoS02WtK3O8R3tsVK7jS
         e/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
        fh=Ab6fYyToC0fMrbmJboTA2ZT6BIRQcYolFR1bH8qurTk=;
        b=EfVDWSrDmZADyjrzR1qCiixgYE/G6JbPwCx2+AbEeakanB5RcGY9MNgvgFLxJw6Do8
         arEkjcHFYjleKE+JzrDaMADSO13UlswFivnCwOVxoZbF4TGNEhiglgmJ2op99gKP5km5
         41O055TRn89HzOqdEMjtuBwxinzJ0WKAuvPueTPr4/fNHfswkdXp0L8XdmZivQu0r1+/
         YIOG97656R48n8JeNIrrlibq/CPXjfxS3gA7gRQsZycR/DyrzfY8kIyAA4mU8XW4Rpd2
         jujdOCIoIhicG3CrVSFtl8x02fB5QvkHmg71TFTx0WGTugRQdf/10nlawkXJfUpYnw+w
         xnhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776335011; x=1776939811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
        b=H9pFIaBSWUfwB9RidOxbGZMjFRrZ/3N3NGzJFirU7eXnhdwofkOpDo0m/3CylWwzDn
         H6lrjwGi+0F9QzKMAUzMMsXtUKVpYa8nJSKb3xdJh71gS47aLZwpW+LxR/kpxLqwc3Cp
         7Pn+r0wBMUysPTz7duEDGI17GuEVcfEBEfthH2xZeAcrdnUFchKI8vBO0NrONHYyipq9
         l2v5u2XUSc53A4JHkQ4HIvXk5GLxJeOTdJFESJddXzS9csCeeQoK2tvp4i3t8nH4Gu7S
         yg4GhZuCRaJ548Vogbs6HzwdfGiKUJRZSYwESKncXr5BL2O48+ieaxINxhSUiW32uj0E
         jAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335011; x=1776939811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbTzRS7v1RQTEFBbLZEgMN4JOcHAPPaG3nlUPacsRSM=;
        b=XVvzIoEQ1k1S8OZKHhTUGicsTlNTzasPOj58Hj6Aj+1H5UP/r0Fi3gbPGA4w+eu4Vd
         uTqs0P6BUOjEXz2Z7tPDlPWJ1tbBi9l3BPINN5DJKlgBOa1EzhZQrk4TyINDArf4w4yz
         P5HiiWOf1L1DfjxUGekcF3CICLvHFJCs19elDM3mWY0OZ9Jyn2bqhk+U9MBW/+E3SoUY
         aS87x7i9Jut++/G//NfaGnUOQptbbaMB5dOFNKlR+gvywU7sVu/BNgKXUxCau7KHu3de
         Gk9ljjugdBt/dOrEFPWS4n9sACwBQL3n2vb6tIo5qz9q9zv2pUPwVSR1ugp+SLa/TiZJ
         Gsow==
X-Forwarded-Encrypted: i=1; AFNElJ9zv8oKl0nYxV89F/NX5BUiuqK9KMSGORhocnSIeytNV5YOFJSr3ewmiyrrdLBdd9PtoANhC3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Hm6NAIJvGSMdzsYsBEkG5y0oBlANBLkdEaXUiWg7vts0f+Zz
	+Z1t1VIeaoaFHQiv5JNGi32dvOQrn6rJ6cY8z3AXD1nG0YnT9YO+49BnXwLML53vAFpGv17wRw4
	p3LTeXWNbaimxWb7vNYQdfj9w/9kkwKg=
X-Gm-Gg: AeBDiethRbvouAcIDKkV+BEAChCnxy6aj9Vh3haAb2tVoxK1b78Tlc+cCIilfeIGOTI
	nOPTVbuO5JJo2uoEThrpw79H7y0cJ7ZDqv4ee0LzKP/9y8GluulAZ9561fJCqumcRhSV9TsdRqw
	n97lGglqQ3WhsgihMRjDH3uMAE/oHGxdUCL/Z7QHottlIvY7Qrt/6fS/zLj9geVCbRUteFw5m6j
	bXo9zBBGFH4bErHyD/tL0ptcuSGBv24degIt+YdE3U+N8oqofYjPS6YoR2FW9gw04to2+9Zf91I
	dN0UMD/ylKLHGAWKoVBH
X-Received: by 2002:a05:690e:4011:b0:651:c71d:8a74 with SMTP id
 956f58d0204a3-651c71d9744mr14382278d50.46.1776335011072; Thu, 16 Apr 2026
 03:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183436.3763871-1-lgs201920130244@gmail.com>
 <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org> <CANUHTR9toK-PS8qrTd-=ATpSi8xbnXmF87sfRaMDp_jG_eiVMg@mail.gmail.com>
In-Reply-To: <CANUHTR9toK-PS8qrTd-=ATpSi8xbnXmF87sfRaMDp_jG_eiVMg@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 18:23:17 +0800
X-Gm-Features: AQROBzDJwF5nR-YRaxJ0GiQSty_8vbImmxuQxj_nDAtrvfhqoyQZXUThlhF2q1Q
Message-ID: <CANUHTR8Hje-pP=7=2hLwkhPMb6cMWosDzdY4oLneFpH5-hfS-Q@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238300-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,patchew.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CA31A40CE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jiri,

Thanks.

On Thu, 16 Apr 2026 at 17:37, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> Hi Jiri,
>
> Thanks for the review.
>
> On Thu, 16 Apr 2026 at 14:14, Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > Hi,
> >
> >
> > What reference exactly?
> I was referring to the device reference initialized by
> device_initialize() inside
> platform_device_register(). My reasoning was that when
> platform_device_add() fails, platform_device_register() returns the
> error directly and does not drop that reference on the failure path.
>
> >
> > How did you verify you did the right change?
>
> After my tool reported this case, I manually audited the relevant
> source code and
> checked the related core API definitions. However, I did miss the
> special handling needed for a static device in this case.
>
> > In particular, what does put_device() do on a static device, even
> > initialized, ie. with no device::release? Try it...
>
> Sorry, I should have considered and verified that
> more carefully before sending the patch.
>
> Thanks,
> Guangshuo

We are also discussing in another similar patch whether the
better fix, if any, should be in the API/core code rather than in
individual callers:

https://patchew.org/linux/20260415174159.3625777-1-lgs201920130244@gmail.com/

Thanks,
Guangshuo

