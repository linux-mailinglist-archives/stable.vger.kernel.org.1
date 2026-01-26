Return-Path: <stable+bounces-211548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N8qCi9Jd2l9dwEAu9opvQ
	(envelope-from <stable+bounces-211548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:59:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9C876AC
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F124301ABB1
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B326980F;
	Mon, 26 Jan 2026 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJTBt0Dz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A132F747
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769425180; cv=pass; b=jewxLjxmw27Xh4379olizzRIUrJSItYz+EeXWChxmqwa3UW5QwawDkCqzDDTSUnublGrXcqhjxu/pRxgFN9TGiBPtVqAjF4kfQpKxqO0MrYtkwb34Bg0jq8iZPgE3aQ7c0xI1yBqd6JQxqOYvk052d3ulI22BKkT0/ZFdm1llIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769425180; c=relaxed/simple;
	bh=wHXF1wV82IKX1fk6i6FfyBpJsnjkeU5lQV2RMucL0XA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX053V8FrEvw0xHTOi69gjlKRCYxFQQ2+11OSCWSAtg0ZmbZ+NoA4mUFUyR7lCthebCFMigIlm1uxdRkRufk1P+a9Ns1fUN//AR4fPZZQ8s4IjiDoCYJ9BzBf7r58vzWVRCm5lIS6x7AviK+EQtYve9Ii6stOa5vjLFl+gJXGEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJTBt0Dz; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81f4e136481so2155507b3a.3
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 02:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769425178; cv=none;
        d=google.com; s=arc-20240605;
        b=EnWEx98b7E0VKqgQIgM5OomXoMq1R6yiJVNEbqHvUVPPLRPv+/ejfvVDf4ho1Re659
         nhW+AJ7QCJGagntEUanwqmq4/FsvAaspwXCz4mX+2SB/0YkZ0n90iTUi5h1uwZuTI8xM
         9Zgpt9MRe37RFvP1/YY1h/VFbgIFDxRwzsYKf/sgtNf1yQrjFJ0K0zGTkgybXkVyjYTA
         JQ4BJXn37lbrkI5zLvr00+1UE0BNBMzs5ZLljwAn1RcXcdMBfOs4Al26rfm4bdFDZX3o
         GibKoI6ze4O9ZxnMNhZUz/jk/9/OQK2b/X9BlBVbFoH4qzQyqiwV9DtxwIl7eW9gG1/O
         n3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ieZfh7XN2nwRcQ7BoDeL/HcIutiEu3jiWbij35hZX6Y=;
        fh=FmEd5ZdGWirxr2vxqE/mYBXFwXkU4qrqGuJ6LuTUDts=;
        b=hp4DkAZ7SBFIAuF8CKPYtT06rVp80QDTSKQHbGxX0SMbJynaEUdEfoA8qFDh4eQJdT
         iPKvqmAZ5nhPylIenYa6k9SHEdCFsrUeW02euxTjG4d0ASSUfn3o2jryEFod+6MXRdn9
         zMgHbcTW/uoPqxX5rDO7MsRMpLCfTj5uWgl3m8gJ4DszkPlkErIbPp21OrIszkk8QDHk
         FliB279g3r3lQadIv8errxeU9RhP26brW64OnI26u1P4YdMTV+VZJ6rYNSrBh4750Bze
         T/Wf4KSSLFbNkOjZOS5e3rkHUrpjoldIo12OfHs6XfSvSEwLQ3swxonpS/AANzStcEqA
         NA1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769425178; x=1770029978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieZfh7XN2nwRcQ7BoDeL/HcIutiEu3jiWbij35hZX6Y=;
        b=UJTBt0DzzgJse4c8ger2CeflfBSkeu7AtxgfIZ380zr0rOvCFtAJMK8YZwZxGXRiuZ
         H/G/FCNmhwp1Wx8U3WjRIvVsnW8rLSIfut+WD/+2YfYwZbSZENt0t+LiCxTrR4wBzWa/
         PYlxY4eXQSWL9I0awViAtz+ebXVm63+l3keoBTJdglaWgqIzkkJK7rcUT1+31Nxmq9G0
         +fwn97KKEzI6UcKpq2CtXdeiEwpqd1GZzFWcLBVdv0MyfmsZue+vbUZEeHVKDcX81V6L
         AVP1lv8cp7BuNWBKjnSjbuuE1JoSTUnNVfJHd+yc/ST96+9AhifP94Lw91HQPgkhjsCZ
         6boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769425178; x=1770029978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ieZfh7XN2nwRcQ7BoDeL/HcIutiEu3jiWbij35hZX6Y=;
        b=aMYbzRHOBPPulQUdpD/Y9mOq5xSKC3//X7uB/nhxtF/KGEB+5vrPyRqhcr+sGz0Qei
         jW62RS2RJ5VFuC9IzVKq9pJAgRuFSiVvDH/wt35q/GdzMdXU09oE+x16iYOR3NDSpBLV
         toZ7lree9Po1hD94oqOHnFuYpSerp7FES96ZWrt1c7mwdul0qwnlgPXRjmvR4UBxx0sS
         k13lkv1RZOmbk9G5Jluo5UIcipvTPKK0fG62ciP4Ntxc2CEb7ubparqeQe13JClgpD1J
         3clr9EbmWmxGKf4oXBO3P53ZJDE/hFEI0FwAkC28nYAbhLjBNWhCkSrLv3neAIDnlIm7
         rAAg==
X-Forwarded-Encrypted: i=1; AJvYcCWfd3P9e9FziCjnSR8Lo39WfEH+9JaCR7efulKShGZ9mw7lQvaEoB5KYr8VWEtFBoY/0bFU5yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CiAczDVz9v7583NtEYAGYitdvu1gI9Mu7i+wsWVcEbwYpqvU
	djP/0NeIl2h+NSb+hKrvfIWao8SNL7QHWOPMDdPPgxWHNXVxliupXHMs5WTzDmmk6nc2K6I7/VB
	TXutRJephfe0tIElB1Tvxvd9wObKlw6s=
X-Gm-Gg: AZuq6aJLwaPgHeVaeCwbvtJ34jbBk/VQHE3FwP55O5El+Qha79j0gg8pgt9VReknfhN
	UDCiX5gEVD9ASUtKaQy6O74uPjnjehd9tcJXiw+jBVKtfqsrFrMcIwYEifhj0ve/yOLFRth1VmV
	+zyYOj4ygD1hRL8izia+3CJIcMhDTCsRACXdNi+tMW9WOU++T6LwgpGjkRk+afTWYa/ATGk0ZVh
	ZwBHKh79syLtlFI2dvDb8BF4WAv8bwICCeJVsZcJiz8xpWeZBWNJlkcowkd9TdZApLdO8OdXgWU
	EK+nUhn7xcKSIJiYL0gP+JEY+19L
X-Received: by 2002:a17:90b:1fc6:b0:330:bca5:13d9 with SMTP id
 98e67ed59e1d1-353c418be41mr3003268a91.32.1769425177788; Mon, 26 Jan 2026
 02:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125171745.484806-1-bjsaikiran@gmail.com> <20260126061528.63785-1-bjsaikiran@gmail.com>
 <20260126061528.63785-2-bjsaikiran@gmail.com> <8c864434-f5a7-40bf-8bf4-9d594177547a@kernel.org>
In-Reply-To: <8c864434-f5a7-40bf-8bf4-9d594177547a@kernel.org>
From: Saikiran B <bjsaikiran@gmail.com>
Date: Mon, 26 Jan 2026 16:29:26 +0530
X-Gm-Features: AZwV_QgKNC_FJwCoYp3kW9h7fYHpRKqXNHJMJzTEUiPoWMZmd2r6j6STzoUTe6k
Message-ID: <CAAFDt1sner2Vco0E7Ffdh3C7ad=u7=2DkF0NiiPb7cwwtgX+QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] media: i2c: ov02c10: Keep power on and use reset
 for power management
To: Hans de Goede <hansg@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	bryan.odonoghue@linaro.org, bod@kernel.org, rfoss@kernel.org, 
	todor.too@gmail.com, vladimir.zapolskiy@linaro.org, 
	sakari.ailus@linux.intel.com, mchehab@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211548-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linaro.org,kernel.org,gmail.com,linux.intel.com];
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
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87A9C876AC
X-Rspamd-Action: no action

Hi,

Thanks for your review, I understand. Let me try that. Will resubmit
if that approach works.

Thanks & regards,
Saikiran

On Mon, Jan 26, 2026 at 4:02=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi,
>
> On 26-Jan-26 07:15, Saikiran wrote:
> > The OV02C10 sensor was experiencing brownout conditions during rapid
> > power cycles (e.g., browser WebRTC permission checks) on Qualcomm
> > platforms, causing the sensor to lock up and require a system reboot.
> >
> > Root cause:
> > The Qualcomm RPMh regulator driver does not support active discharge,
> > requiring regulators to passively discharge via leakage current. This
> > takes 2+ seconds on X1E80100 platforms. Without complete voltage
> > discharge, the sensor's internal microcontroller does not fully reset,
> > leading to I2C timeouts and a locked state.
> >
> > Solution:
> > Instead of power cycling the regulators, keep them continuously enabled
> > and use reset signals to control the sensor state:
> >
> > - power_off(): Assert hardware reset GPIO (keep regulators/clock ON)
> > - power_on(): Release hardware reset + trigger software reset via
> >   register 0x0103 (standard OmniVision software reset)
> >
> > This approach:
> > - Eliminates the 2+ second discharge delay
> > - Enables instant camera reopening (~17ms vs 2.3s)
> > - Properly resets the sensor state machine via reset signals
> > - Maintains correct power sequencing on first initialization
> > - Follows OmniVision sensor conventions (0x0103 software reset)
> >
> > The first power-on still performs full regulator and clock
> > initialization. Subsequent power cycles only toggle reset signals,
> > avoiding the discharge delay entirely.
> >
> > Tested on Lenovo Yoga Slim 7x (X1E80100) with rapid camera open/close
> > cycles - no brownouts or lockups observed.
> >
> > Fixes: 44f89010dae0 ("media: i2c: add OmniVision OV02C10 sensor driver"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>
> Thank you for your work on this, both the root-cause analysis
> and the code changes.
>
> However I do not believe that this is the right approach.
>
> This is adding platform (qcom regulator) knowledge to the sensor
> driver where it does not belong.
>
> If these qualcomm regulators need to be powered-off for at least
> say 3 seconds before being powered on again then that should be
> represented by setting struct regulator_desc.off_on_delay
> to e.g. 3000000 (usec). On a quick check I'm not seeing a way
> to set this in devicetree, so maybe this needs to be done
> inside the qualcomm regulator driver.
>
> Either way this does *not* belong inside the sensor driver.
> We don't want this in the sensor driver from a design pov and
> we also don't want it in the sensor driver because then it
> needs to be repeated for all sensor drivers.
>
> To avoid this 3 second delay everytime on rapid stream on/off
> runtime-pm's autosuspend feature should be used with an
> autosuspend delay of say 1 second. See drivers/media/i2c/ov2680.c
> for an example.
>
> This is a good idea regardless to also avoid unnecessary delays
> on quick on/off related to the reset signal timing.
>
> Regards,
>
> Hans
>
>
>
>
>
>
> > ---
> >  drivers/media/i2c/ov02c10.c | 119 +++++++++++++++++++++---------------
> >  1 file changed, 69 insertions(+), 50 deletions(-)
> >
> > diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
> > index 7e9454e8540c..08d268de60ec 100644
> > --- a/drivers/media/i2c/ov02c10.c
> > +++ b/drivers/media/i2c/ov02c10.c
> > @@ -22,6 +22,8 @@
> >  #define OV02C10_CHIP_ID                      0x5602
> >
> >  #define OV02C10_REG_STREAM_CONTROL   CCI_REG8(0x0100)
> > +#define OV02C10_REG_SOFTWARE_RESET   CCI_REG8(0x0103)
> > +#define OV02C10_SOFTWARE_RESET_TRIGGER       0x01
> >
> >  #define OV02C10_REG_HTS                      CCI_REG16(0x380c)
> >
> > @@ -390,8 +392,8 @@ struct ov02c10 {
> >       u32 link_freq_index;
> >       u8 mipi_lanes;
> >
> > -     /* Power cycling rate limit */
> > -     ktime_t last_power_off;
> > +     /* Power management: track if regulators are enabled */
> > +     bool powered;
> >  };
> >
> >  static inline struct ov02c10 *to_ov02c10(struct v4l2_subdev *subdev)
> > @@ -680,25 +682,16 @@ static int ov02c10_power_off(struct device *dev)
> >       struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
> >       struct ov02c10 *ov02c10 =3D to_ov02c10(sd);
> >
> > -     /* 1. Assert Reset */
> > -     gpiod_set_value_cansleep(ov02c10->reset, 1);
> > -
> > -     /* 2. Disable Clock (Stop sensor state machine) */
> > -     clk_disable_unprepare(ov02c10->img_clk);
> > -     usleep_range(1000, 1500);
> > -
> > -     /* 3. Disable Power */
> > -     regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> > -                            ov02c10->supplies);
> > -
> >       /*
> > -      * 4. Discharge Wait
> > -      * Wait for regulators to fully discharge before returning.
> > -      * This delay ensures clean power cycling.
> > +      * Keep regulators and clock ON to avoid discharge delay.
> > +      * Just assert hardware reset to put sensor in reset state.
> > +      * This allows instant power-on without waiting for regulator dis=
charge.
> >        */
> > -     usleep_range(50000, 55000);
> > +     if (ov02c10->reset)
> > +             gpiod_set_value_cansleep(ov02c10->reset, 1);
> >
> > -     ov02c10->last_power_off =3D ktime_get();
> > +     /* Keep clock running - sensor needs it for software reset */
> > +     /* Keep regulators enabled - avoids 2.3s discharge delay */
> >
> >       return 0;
> >  }
> > @@ -708,50 +701,63 @@ static int ov02c10_power_on(struct device *dev)
> >       struct v4l2_subdev *sd =3D dev_get_drvdata(dev);
> >       struct ov02c10 *ov02c10 =3D to_ov02c10(sd);
> >       int ret;
> > -     s64 delta_us;
> >
> >       /*
> > -      * Mandatory Cool-Down:
> > -      * If the camera was powered off within the last 3 seconds, ensur=
e at least
> > -      * 2 seconds have elapsed to allow full regulator discharge and s=
ensor reset.
> > -      * This prevents brownouts during rapid open/close/open sequences=
.
> > +      * On first power-on, do full initialization.
> > +      * On subsequent power-ons, regulators/clock are already on,
> > +      * so we just need to release reset and do software reset.
> >        */
> > -     delta_us =3D ktime_us_delta(ktime_get(), ov02c10->last_power_off)=
;
> > -     if (delta_us < 3000000) {
> > -             dev_dbg(dev, "Enforcing %lld us cool-down period\n", 2000=
000 - delta_us);
> > -             fsleep(2000000 - delta_us);
> > +     if (!ov02c10->powered) {
> > +             /* First time: enable everything */
> > +             if (ov02c10->reset) {
> > +                     gpiod_set_value_cansleep(ov02c10->reset, 1);
> > +                     usleep_range(2000, 2200);
> > +             }
> > +
> > +             ret =3D clk_prepare_enable(ov02c10->img_clk);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "failed to enable imaging clock: %d"=
, ret);
> > +                     return ret;
> > +             }
> > +
> > +             usleep_range(2000, 2200);
> > +
> > +             ret =3D regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_n=
ames),
> > +                                         ov02c10->supplies);
> > +             if (ret < 0) {
> > +                     dev_err(dev, "failed to enable regulators: %d", r=
et);
> > +                     clk_disable_unprepare(ov02c10->img_clk);
> > +                     return ret;
> > +             }
> > +
> > +             ov02c10->powered =3D true;
> >       }
> >
> > -     /*
> > -      * Standard Power-Up Sequence:
> > -      * 1. Enable Regulators
> > -      * 2. Enable Clock
> > -      * 3. Release Reset (with ample boot time)
> > -      */
> > -
> > -     ret =3D regulator_bulk_enable(ARRAY_SIZE(ov02c10_supply_names),
> > -                                 ov02c10->supplies);
> > -     if (ret < 0) {
> > -             dev_err(dev, "failed to enable regulators: %d", ret);
> > -             return ret;
> > +     /* Release hardware reset */
> > +     if (ov02c10->reset) {
> > +             /* Ensure reset was asserted for at least 2ms */
> > +             usleep_range(2000, 2200);
> > +             gpiod_set_value_cansleep(ov02c10->reset, 0);
> > +             /*
> > +              * Wait for sensor microcontroller to stabilize after res=
et release.
> > +              * 50ms prevents black frames during rapid power cycling =
by ensuring
> > +              * the sensor's internal state machine is fully initializ=
ed before
> > +              * software reset and register configuration.
> > +              */
> > +             msleep(50);
> >       }
> >
> > -     ret =3D clk_prepare_enable(ov02c10->img_clk);
> > -     if (ret < 0) {
> > -             dev_err(dev, "failed to enable imaging clock: %d", ret);
> > -             regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> > -                                    ov02c10->supplies);
> > +     /* Perform software reset to ensure clean state */
> > +     ret =3D cci_write(ov02c10->regmap, OV02C10_REG_SOFTWARE_RESET,
> > +                     OV02C10_SOFTWARE_RESET_TRIGGER, NULL);
> > +     if (ret) {
> > +             dev_err(dev, "failed to send software reset: %d", ret);
> >               return ret;
> >       }
> >
> > -     /* Wait for power/clock to stabilize */
> > +     /* Wait for software reset to complete */
> >       usleep_range(5000, 5500);
> >
> > -     if (ov02c10->reset) {
> > -             gpiod_set_value_cansleep(ov02c10->reset, 0);
> > -             usleep_range(80000, 85000);
> > -     }
> > -
> >       return 0;
> >  }
> >
> > @@ -924,6 +930,19 @@ static void ov02c10_remove(struct i2c_client *clie=
nt)
> >               ov02c10_power_off(ov02c10->dev);
> >               pm_runtime_set_suspended(ov02c10->dev);
> >       }
> > +
> > +     /* Clean up regulators/clock if still enabled */
> > +     if (ov02c10->powered) {
> > +             /* Assert reset before disabling power for clean shutdown=
 */
> > +             if (ov02c10->reset)
> > +                     gpiod_set_value_cansleep(ov02c10->reset, 1);
> > +
> > +             clk_disable_unprepare(ov02c10->img_clk);
> > +             regulator_bulk_disable(ARRAY_SIZE(ov02c10_supply_names),
> > +                                    ov02c10->supplies);
> > +             ov02c10->powered =3D false;
> > +     }
> > +
> >       v4l2_subdev_cleanup(sd);
> >       media_entity_cleanup(&sd->entity);
> >       v4l2_ctrl_handler_free(sd->ctrl_handler);
>

