Return-Path: <stable+bounces-210541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFwCJo0pcGmyWwAAu9opvQ
	(envelope-from <stable+bounces-210541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:19:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7654EF70
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE6406C9E5D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B042E009;
	Tue, 20 Jan 2026 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFr5+SXq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A79427A06
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914899; cv=pass; b=B8TKcq3fTyddVwWwL/LRQJSaTaj7WCNbsRpIoC0sL3l2YKU2hb5Yi/wnuAFU7CujXFqXNVYW4knqaH6RwLoBS1wYkrFO+8WFlmNhfaT3/Kg3GT26RnfA/jgEYQioEK+ChxzFvd5CZbXV8LNrotn5fdXJWGmcnDY/QS76ALsV6EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914899; c=relaxed/simple;
	bh=JUFK8qKP08ZRWFLH22g9Uv2mxoFc4rdFsO7jZeFdgb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHZ4vHw2JqTDESNlsVca+FIjS0feYZH4edSt1lrXLNhFWDIiMvGQsctI6EfBtuauhR5i7snYJqrvASyqAmRak8hus2fNlj7ZlK/sRIsJYbC8e/k+IAxmspusmfAuEchYPRzOaW3smvE2c7YFJrdhzXZhr8WxkttQ0H05grtEGQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFr5+SXq; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502a4e3e611so34404321cf.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 05:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768914896; cv=none;
        d=google.com; s=arc-20240605;
        b=i0vWwGr0Ifu6t2T67Phag2aNY23JO+Nq2vvOjkYCgRGexTW5hK4bR14rTdq+zyKrZ4
         RPQSW6pJ3C7iPASOG14doEge3wGYuPP+sNi9elVnq89oPZawVPkX094/A2HJAldcSQwf
         PLwtz+xoUEHkE+kAorhKi1rbf4NO10CAomF8PXB4g0ABwblTssNB1vHDi8qoa/xnAHyY
         IPuy8zuOEtABM7bAiVnxmHpIT/fexnlrECTF5wUCmWj8fELayCPYoMhQ5BXMiduioh/P
         fAeFin5DsO9fn3DFWMWKG2W3nbwCsWqxNrFQaDpnCK1uf7F+XpxalZTUl3Zefx0txbJz
         QJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=61FVTvC+OPYsLfCnTMn5A70RhUk+8hVfV9yJPBCxid4=;
        fh=+rpOaRTVM9XfD59yHGGraESOrof9o+jRh4gvwaYqq6E=;
        b=Xu2d03H+5vVPvXsJB7IZE8HeA4dVQqN+cMvSs5u/gRwlLU92wwYqg8W+3ZQ9auAxOg
         1kTDXuJyI5z6rMxC/6PtFL9ezDFMMAXq6CssCWX4cJR6UUMInTF/ODhCJZ4U9Y+t0umT
         x8xlPjgpPCjR+QnYEqf6FyXDaVMQyUYplGe0XAICBXN9IHRm06rED8RiXcblO6YD3mT/
         wQcTj+iuvONPcoe6AyLFdQl2rl4pwZZZ9ri0Ob4/ICFa9UIxssNOZklN2rXASdylazg2
         m4A304T7q79PMLpiv2qySLXCxhg4cgrGRdispyomwYguLlbHolvw9whq43OyN+ltsHXr
         slNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768914896; x=1769519696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61FVTvC+OPYsLfCnTMn5A70RhUk+8hVfV9yJPBCxid4=;
        b=fFr5+SXqN76cCULuB7R6wohEESZ8p9HZlTSiL31trGkfn2C7fXp94UVqJkJjW9jBoH
         QbiROSfbVWa2BqFM0TwnFl4vM0EW5LZT3/68URFZ+/52iSyjN3teF+jKZLY9iLyV7XMN
         2Ly8CS4a44e5iiqS5bEhk2O3KBTPS//Q/zH5ixCUA75i+oOtPcPVF/yX/9wRUlzjp/hj
         fUU2nJj/1LvVbFD1FgSEq5r+B7Vigy/A/MET2czwKtPOL8z03J0vCrxYaMZRRa7ND9uF
         MljXSCZhiefbjr90BNTyUqcZepqoyPtGJaJePa4V9z9YcOKETE53kvQMhMwbT70iJePM
         1y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768914896; x=1769519696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61FVTvC+OPYsLfCnTMn5A70RhUk+8hVfV9yJPBCxid4=;
        b=HGXSXKSVFrItkXb4PNEBobYXSfkNgowB8Jn8+6FTVaSSyvqJWlJ9TJ7ufYs4H5cm20
         WGhkSR1JZHE/vmSksO0RRr67wZZK+6Gz6YjkhysiD3NVGMT9ktKKp5mSkUypVCdCWokZ
         zCDKzzoiBhJHOfM2fo0fP+x8LQP8P/fxwNjU/rYywe3sQCfg9O5qXyi1xixCKdxNWR3M
         w5i3yiH668teUsbhUD/hGL2hB2Ci+oZWF+k88QrLowGStMEmrqBsRuRds77UQwH0KlOH
         kp0Xmp78M4stvl6gMi+VyRIWFpnd/zXzFliInfN7/8DxLzP9KL31/FraVYdVDGxoBj7X
         E3gw==
X-Forwarded-Encrypted: i=1; AJvYcCV4LgfS5Nwy8jnPTD1A93mbt/Ew2T7KWFYAAAtrmNbb7xq2/Wq5BTnpHXB0qeC/HD/4E05YHjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtc3n9g7xxVhY0RWcLOiHzfiiJGWtPwr6iB+/xnMQ0GRqk9WBJ
	/aT8SKrGtOIEs7lGEh8tKfnNQ7RbLnPWl/h/X60Oe0QQiJJf03PhpECACqA3UFsJiDWMhw6PAhv
	cQOIQ/MVan+RN+CS/oZBjKw+4YJOtqoM=
X-Gm-Gg: AY/fxX77ZtcqfGzF0KQRyvS1bqjrZS8h1sV/UzBbSaIlUsfsG4mqco6CLj8eoV6qQkI
	/bJR6h+hCxKSSi3bgzaaIj8Ze4XWkh1QrrQvIlVCH2chXciGjAZ23D9Q9+QaytpW8mvMLfY5+mT
	gIOqLbYD7loYT2wp649xWioNuk5atwU70zIw9mrO8Nh8vM18Qliha/KfXKtllZGIvWG2C4bDTyv
	RajrdDBKp9hSZ1UGdgpaqifNZBNx2gnZL2iG1YgRpYSl0G/fWH69CQ/OfrpfRKgDmpHRMHPyINa
	cQoAdgjKldxA2fM2Y3qgiRR8WTRuYowNQFkCiQ==
X-Received: by 2002:a05:622a:204:b0:4ff:a8c1:b00e with SMTP id
 d75a77b69052e-501982dcb6amr257878141cf.2.1768914896054; Tue, 20 Jan 2026
 05:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-ufs-rst-v2-1-b5735f1996f6@gmail.com> <9e51b504-e0f0-4d17-baa2-387339507c86@cherry.de>
In-Reply-To: <9e51b504-e0f0-4d17-baa2-387339507c86@cherry.de>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 20 Jan 2026 17:14:48 +0400
X-Gm-Features: AZwV_Qhp14S3f8jxRdEKOTb8-WUOX2RQGlmlwHiEcT4hA3FpWfhKr4Hgbt-e0zM
Message-ID: <CABjd4YwAMbH21jcjhks7ThoXzcF8GeOzBPYDvN+7cip0iA6stg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Explicitly request UFS reset pin
 on RK3576
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,2a2d0000:email]
X-Rspamd-Queue-Id: 1F7654EF70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 5:00=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 1/20/26 1:53 PM, Alexey Charkov wrote:
> > Rockchip RK3576 UFS controller uses a dedicated pin to reset the connec=
ted
> > UFS device, which can operate either in a hardware controlled mode or a=
s a
> > GPIO pin.
> >
> > Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> > hardware controlled mode if it uses UFS to load the next boot stage.
> >
> > Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> > device reset, request the required pin config explicitly.
> >
> > This doesn't appear to affect Linux, but it does affect U-boot:
> >
> > Before:
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> > < ... snip ... >
> > =3D> ufs init
> > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], pw=
r[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> >
> > After:
> > =3D> md.l 0x2604b398
> > 2604b398: 00000011 00000000 00000000 00000000  ................
> > < ... snip ...>
> > =3D> ufs init
> > ufshcd-rockchip ufshc@2a2d0000: [RX, TX]: gear=3D[3, 3], lane[2, 2], pw=
r[FASTAUTO_MODE, FASTAUTO_MODE], rate =3D 2
> > =3D> md.l 0x2604b398
> > 2604b398: 00000010 00000000 00000000 00000000  ................
> >
> > (0x2604b398 is the respective pin mux register, with its BIT0 driving t=
he
> > mode of UFS_RST: unset =3D GPIO, set =3D hardware controlled UFS_RST)
> >
> > This helps ensure that GPIO-driven device reset actually fires when the
> > system requests it, not when whatever black box magic inside the UFSHC
> > decides to reset the flash chip.
> >
>
> Would have liked a mention on why pull-down in the commit log.

Indeed. Heiko, if you're going to apply this to your tree, would you
mind amending the commit description with something like the
following?

The pin is requested with pull-down enabled, which is in line with the
SoC power-on default and helps ensure that the attached UFS chip stays
in reset until the driver takes over the control of the respective
GPIO line.

> In any case,
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks a lot!

Best regards,
Alexey

