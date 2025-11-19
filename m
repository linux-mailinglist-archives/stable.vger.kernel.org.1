Return-Path: <stable+bounces-195165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E5AC6E4A6
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 12:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB798350142
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 11:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0C7352955;
	Wed, 19 Nov 2025 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHlmx8Jt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B833C50F
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 11:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763552159; cv=none; b=aEbu2dkQ8rfIK3MF7zs4TKyvL6q4iMOeh0erEazDqagWadV1PRIXvO2wnbXYiOv48J7u6Ujnek3qu8BO2Mt2E446PSvosSl1Od/SVGPHB1Gq924xbUOqerEOdCArvOgNB7BkvFzi8MNkp/LIJGFy5HFKFJv8JJQglOIwJ7q0wq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763552159; c=relaxed/simple;
	bh=XeetoD9h5YFMO/jwCNj9WxEZ/IVBUdwKo6worfpDAPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oaiqs9P7OTt8zevx833xpbbSZ67EHF9Z9SoYBnZGs8xOwsTHBLU/7zPtOmrhfEzYfKimF0sByknOCx3uGyvYSWohXjpp4o/j36kN/BjPbctQPQ4uswkijCh1rNkcF2d7A5aHCbCjE/AzqqSaJb4pdD+Usau+qrZBxLw063EnvsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHlmx8Jt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37b97e59520so45006641fa.2
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 03:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763552155; x=1764156955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOjKGZlnAXgjmbnxI7QvaAPBMson5j4nh4MkPbAPAEs=;
        b=PHlmx8Jt5vIs0Pvnug1QmJeSQ5mJZAvLJPcg7XqiobEHEwNPbruwQnDhUp+JSuzS9B
         JxwRPIB3f1HMWPOmGY/NzQlUJOplyXYmGzkjduW7sUfVOnEd+BB2rBUDXq8MNHqkOP+2
         ZSYNlwtmpopWVatk9zFLQU7+lgizzq0I+fukdiq2O7Tnzc2ksSutSKDlXOVR+jqBdPWP
         qCpK8cA+Iimqah34r/DWOK1MtFc/JpyVJjlgPAAPHv0DR1KcBx/83zieOztd4jliT/5p
         DFJeySbm5rLUFaNqxr1PDR/Kmul1+fwyuNg3AeG3H3tebcTV5HDQR6FeRUaZHkupoOFA
         VwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763552155; x=1764156955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOjKGZlnAXgjmbnxI7QvaAPBMson5j4nh4MkPbAPAEs=;
        b=LiR3hXOa6n8bx91rnzMjGdFBR4A5Nnr95oXLx7iLecPVyL/yQ5xQzggPNCx48cYqX0
         nPhSbUMiyX27HEzMUSJgMJt3nHG2dwvyU4hfQsY++H3yo5oTOifL8Ti4A61LBu3Gbusl
         e9VXfrcbpw3ZvlXlojyg05KzfUcwRBdpbsZVdRyRaIms/G+zzJ2iq83r+aEeGQerAfow
         LvlGcPu5Q86OR3t4H1YAZ07TMjZHpAUpIbAv7ZL5vbWUucl3EOWh9fbfn6dK3+DO2HUQ
         q4oNffoo9qRKwSAku9grzTT9PKlz5e6Ge4H9pOrwGeFghWg9d/rPt5VOkzsPcR/MajA2
         UaDA==
X-Forwarded-Encrypted: i=1; AJvYcCUg5RB+X2cFNXtPsdfkXGhR8qbETfI3DN4KJkJvSfzyeVBGxRj9ccsuWfydV2CEMZ7tCQ0skjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgG05RiMZEUQKSL0Y+OiYMjS9ovqfJ79mZ2N6GuZlEfdvupqa
	mkOe/a//9c8Mqc1He1xmAH8rs1XUFGRtCUWZPJmgovAWFCLWp+bqQ9dMIQVnCE+8kTcJFnsR4Ds
	RhB3kGeSQAauzwE4ouy7fFwh7CLpG1m4=
X-Gm-Gg: ASbGnctv0T9IZs1Kywi8XtDHvksvfoY3/NnG3lcZal9gB3vfB1UpDQy94oF6W/o/wTP
	c/BfEyC996zgo3GQP3qdkxh8PLpnurCAf5Z71OCTDA9MmbmaDtig51Yv51aoLWoVXJN3R7cR/Q8
	UoyDZHdq2GVtW7x3VRvUVToejDYBS2c6MO10NgD2Vdq3eSMB0uTLsGsJRLNUima5gkdY/U7b7Fk
	vpZIl/40S83UlGT7aIbKpcdghKOo8qqOCs6gklkd2Nfx8BeMT3gLVTf6QGqeSpv797U9A==
X-Google-Smtp-Source: AGHT+IGLB87l3c6YQaMAVvCIZHa9Iaw20ytZFxmWh7hR2zupdPWm65PeLgAMP+NHumhl01ckY9NXDPo9Y80ggn2lAT0=
X-Received: by 2002:a05:651c:20c6:b0:36d:4e3b:f1e3 with SMTP id
 38308e7fff4ca-37babb619famr41318181fa.13.1763552155407; Wed, 19 Nov 2025
 03:35:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf6e08dfdfbf1c540685d12388baab1326f95d2c.1762165324.git.xakep.amatop@gmail.com>
 <176307584246.496508.12079514999315183214.b4-ty@sntech.de>
In-Reply-To: <176307584246.496508.12079514999315183214.b4-ty@sntech.de>
From: Mykola Kvach <xakep.amatop@gmail.com>
Date: Wed, 19 Nov 2025 13:35:43 +0200
X-Gm-Features: AWmQ_bneNTA_MoPN6LwNuV_BB7nADqcezocvI0r4IOjj8wtQr6qn-bFxwXAym-o
Message-ID: <CAGeoDV_R8GBSs9qjY4772ymU=LsLiP=LTTx2-4uBLkB2PAuVhQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V
 regulator voltage
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Johan Jonker <jbx6244@gmail.com>, 
	Michael Riesch <michael.riesch@collabora.com>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>, 
	Muhammed Efe Cetin <efectn@6tel.net>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 1:18=E2=80=AFAM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
>
> On Mon, 03 Nov 2025 12:27:40 +0200, Mykola Kvach wrote:
> > The vcc3v3_pcie20 fixed regulator powers the PCIe device-side 3.3V rail
> > for pcie2x1l2 via vpcie3v3-supply. The DTS mistakenly set its
> > regulator-min/max-microvolt to 1800000 (1.8 V). Correct both to 3300000
> > (3.3 V) to match the rail name, the PCIe/M.2 power requirement, and the
> > actual hardware wiring on Orange Pi 5.
> >
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] arm64: dts: rockchip: orangepi-5: fix PCIe 3.3V regulator voltage
>       commit: b5414520793e68d266fdd97a84989d9831156aad
>
> Please start new threads when sending version x+1 and don't append
> that new patch to the old thread (less confusing for tooling like b4).

Got it, thanks for the explanation.

>
> Best regards,
> --
> Heiko Stuebner <heiko@sntech.de>

Best regards,
Mykola

