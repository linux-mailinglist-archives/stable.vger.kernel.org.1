Return-Path: <stable+bounces-232973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKtuKnBFzmlQmQYAu9opvQ
	(envelope-from <stable+bounces-232973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A5387C16
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 728C1301602A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290BE3DFC8B;
	Thu,  2 Apr 2026 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxuec0E"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C133DEFF2
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125865; cv=pass; b=lUWNwo6qN//9g/W+HJJY34u8/MMOXy182MkX1gCwTg9RVtXo0oFolQop8uAOqKs1JcgObmCK2d+7+wwej9QLrvTyFj1dQVvlobQT2X13qxCI53L7tw5mW8DSY+cqcLk0fzxuTz05duI5wezQr7ZpRWMA8CkfUgfApbrZjCC4Ptk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125865; c=relaxed/simple;
	bh=MUZx4Y9OyelgL3hyVBr4k6AAzEQS/l7Wd93ZjmObqWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eS3/QS3YIekQMtNjQa8Vfn//GCuTtj2A0LniMGkfIJboFntWjX7xKMV8Ffyu67AFdlP/5lHMAGEknEw9hULZDbo/y0CZMyJOqa/F5ZyA8IEH5+AG2ivMyWvaFeGX9BAU6EKB47jbuma+IE1Mb1YEauItuECjq54sih04uBQ66/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxuec0E; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-9539d9f1675so450474241.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 03:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775125863; cv=none;
        d=google.com; s=arc-20240605;
        b=f+CKEyw0j8zs260UURJjjwScQwl1P0YHsqXapM75+ELu/qQh6j/PoQnJ2x1uj9nkSc
         CBedIT8NkAZptdB7LOzg1eHYtdgUxDCXzfoA3jYeZzBx/tDQ4E4984gl1C6a+kgy0NlW
         89fx1fTTHszGPvuWZrWP8oWPik7mFJWdWvUlrA4mr4lI8ARqJxds47qgDdw1mD6+cMxc
         j4mMubDZL2bmvN4jGdF80wQ8zn2Fa6s4VQ5RKxnsvJtlzUP+1BG+tQ5AZz9jYO352dIO
         nHeRp+WfLZbsuso+JXURWq2bAijpc8wI0hEoLb8s835KZBbcUY9TXqzoWWGig05DyXCq
         iEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Ob4WvASBXKLoNDxbRXnh3mN8JCXap6XQdaiWgxzkgI=;
        fh=aOL0ddPt6E7N/7IkWwsEr5zJ/rkvE3UANBTaueRo0Ck=;
        b=dR51zuutTC+GpH7rdSkTv0gpre42+gkMfXcfGZ7g97colpKPFFfv70RaA9cb+IeCWC
         L7M0Nc8B94YTRgN+F4p1rRP2T6GzUmLR92aSzicQU1qC3QjTHT0lkj2Zl+LoGeO5MLuY
         2yfOk+O7aE6Lh+47KA+8/NDY3QROSwmA0EthhFiWum+xESdVobxxV2OubXHrxXmb8uZI
         htOAS1mbab0CgJxyR0a622QFx//IplECyQIjRDlh53glcM8pjIWhL+kNrlJNoPQ5o+1V
         l2usapl1OxfoMAgJDpeVwvceQPHSJbR+8Su7SYgl8LZfyOIodJVCvksPLu0NjI5mJUmU
         E6Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775125863; x=1775730663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ob4WvASBXKLoNDxbRXnh3mN8JCXap6XQdaiWgxzkgI=;
        b=UTxuec0EMljOElkQdGAzDus6SYqvMppVh9GQZVaCS9Vy8i/LrsHJMDQrYO9CBPBiY4
         4n3tgBvjxhz/jP2KybP1b4APUcm900XPsGEld37rYe8hJZc2XKHInjZcFm/r9NS2IIzS
         EgFnCSJqwqBjpEGebQmNhnCiKcAtULdOja8UQ8MaV0GYygeaTwgwMpaswyE0fL+IWQCc
         Q1qH/i2pcy3MiS8IQY64gMPkxBvjuNw2aBq705zgWD9/Bh43bArg9KYKOhGRFqYAB1GK
         xDIWNZ/chFP8Ep6TevUE1zSYZTcivEbdBZgh39hINlW3g68r2wDb5oWPg7Ac7KAF31x0
         SFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775125863; x=1775730663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ob4WvASBXKLoNDxbRXnh3mN8JCXap6XQdaiWgxzkgI=;
        b=IZRFa+2f7hiZk/feGzhKcheZBmLP4chA7bQE2wBS1wd3rKej9AweQPJfC21Cy2H1mj
         6R8iyxv7k5ilhx+u15EQhxIW06GBdEFWuuSFXLoR2G8c7Xb7uJgKJRSJogGpalLcQk5s
         HkNv4cZk0K6uIMiU356cjk7JIZ1qdeKtSuwbZNx7o49S0yrnrXab8/ZLlQz+TtmfmaEf
         yqxoueh5S8xVjfz+ynOBWlp8k/0S4RLVbGHVcMJVfzmPBl8iVuvrfsKCPTuec36S+/gX
         8qMdoaVXtUQqmOaL0mgiubyXWB+tPzWwcUsdf4EPl2w/LlE3SmyL8RFHcFab8IYgJzZM
         bevg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGJY1ZYys3f5eqc+RmOigmJ4JWIUr6d+/O0zZB/qu+8OxDV0gUMMQmXc2t5dwQnJK3xJiGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOjV75iaSRYDn1z48/bCBwKgeHE7kTmFyDxieXpg4+3eDBIvV
	8Fu5jl7xpynltQHI5QKFqrEWKOiu3tK/3+t8+1pTKwjrh4d5Lr+SMpqCljjaxjKInKqsbiMOac6
	gzOVXlLpJ4uv4VG2e7Q0ps2LuZVSuohs=
X-Gm-Gg: ATEYQzy1UjHqnEqTfNkGbAp3F1qQTm+irXjxPrCsuux+uqynbKCDwhlYgsoO6/mZsH+
	JL0sg2jnKJOdSun/E/NiUgRe5NvxnzPDmkY2vV6okLdONvBfiw6uiJOmrU4cFv8zLSyk63mBT9/
	KYCypybSLT0izDMhZpZi7vY9+yqVIleiQIDN9v7nIP7kr23hPuDctpPtKYVklu3IYeu0xRtLaBw
	NsCwkuUoRmqHnG7fdSEVpCOrBCV9X1CgQUqGVttLSmbcgNEuWelYXvy4thGn0/lAYK8VoQDqwjB
	WC0GvmOWDpPQWHeGYzUJs5aOdIu0cSz1kCiWmjE=
X-Received: by 2002:a05:6102:5343:b0:605:17b8:16db with SMTP id
 ada2fe7eead31-605681ba7d8mr2632044137.25.1775125862274; Thu, 02 Apr 2026
 03:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331171248.973014-1-gaohan@iscas.ac.cn> <20260331171248.973014-3-gaohan@iscas.ac.cn>
 <MA5PR01MB12500707BE1C6E11EC3F4B94FFE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA5PR01MB12500707BE1C6E11EC3F4B94FFE51A@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
From: Han Gao <rabenda.cn@gmail.com>
Date: Thu, 2 Apr 2026 18:30:49 +0800
X-Gm-Features: AQROBzCGzBaggmtPSR3_A5qLKsf5xg9SqM3fnlQMsletNH9S6oyqQ5RfqOQtIhM
Message-ID: <CAAT7Ki_BkfYCN_AJtksOEopU2r0iYPybuEQfm+pMLpsm8+EJkA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: dts: sophgo: Add dma-coherent to SG2042 PCIe controllers
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Zixian Zeng <sycamoremoon376@gmail.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232973-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iscas.ac.cn,google.com,kernel.org,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rabendacn@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CF2A5387C16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 4:44=E2=80=AFPM Chen Wang <unicorn_wang@outlook.com>=
 wrote:
>
>
> On 4/1/2026 1:12 AM, Han Gao wrote:
> > SG2042's PCIe root complexes are cache-coherent with the CPU. Mark all
> > four PCIe controller nodes (pcie_rc0 through pcie_rc3) as dma-coherent
> > so the kernel uses coherent DMA mappings instead of non-coherent bounce
> > buffering.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> > ---
> >   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/d=
ts/sophgo/sg2042.dtsi
> > index 9fddf3f0b3b9..3af770549742 100644
> > --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> > @@ -417,6 +417,7 @@ pcie_rc0: pcie@7060000000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> > @@ -439,6 +440,7 @@ pcie_rc1: pcie@7060800000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> > @@ -461,6 +463,7 @@ pcie_rc2: pcie@7062000000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> > @@ -483,6 +486,7 @@ pcie_rc3: pcie@7062800000 {
> >                       vendor-id =3D <0x1f1c>;
> >                       device-id =3D <0x2042>;
> >                       cdns,no-bar-match-nbits =3D <48>;
> > +                     dma-coherent;
> >                       msi-parent =3D <&msi>;
> >                       status =3D "disabled";
> >               };
> For binding changes, LGTM. But I have a question regarding this change
> in dtsi.
>
>  From your patch description, I understand that enabling the
> `dma-coherent` attribute requires upgrading the firmware `fip.bin`. If a
> user only updates the kernel (which is relatively easy) but forgets or
> doesn't know how to upgrade the firmware, enabling `coherent` might
> cause the kernel to skip all explicit cache maintenance operations.
> Could this pose a subtle risk?
>
> Wouldn't it be safer to leave the upstream unchanged in dtsi and allow
> users to add the `dma-coherent` attribute themselves after they upgrade
> the firmware?

In the firmware, fip.bin and devicetree are distributed together.
So matching issues are unlikely.

>
> I would greatly appreciate your guidance.
>
> Thanks,
>
> Chen
>
>

Thanks,
Han

