Return-Path: <stable+bounces-237929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMZgG9Bz3mkqEgAAu9opvQ
	(envelope-from <stable+bounces-237929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:05:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E30CA3FCD13
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD7633021A06
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B42EBBAF;
	Tue, 14 Apr 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lse/8cWw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC929ACD7
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186317; cv=none; b=Nf53PhqS6HEFUjRlmxwxBM44K645u3n661KzvfArX4swUv02Qw8h628Mte4rUVoM3IAiYNFEFQsnvbxIkcsivD/q+LsrIyr6JSEyMFVJVEr4DLzASG5q8FfwkpvemvruzO7WSlIJw1Unck4cvnl7ff8FRcBgb1eLetu8SSc+JdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186317; c=relaxed/simple;
	bh=WTBuw93b1FoXdiTf+ccgKqIkAq/vVQHDLivoX9bjrc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrgOtfvoHx1Id5Gs6qgLG54NHnL/jw4at165If8a2+HWzV7PYdGsOVycrb9JBi3ldjfysWPM82YfQLh2hyxGaBfwuEKjuCBObAB4zM/xUa0W/j086pbi76VsKPxRuLZex/OKHE5wa7ulTp4mFR48eMV9BsmfJDAokR+ckKuhKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lse/8cWw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b45cb89f7eso16935565ad.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776186315; x=1776791115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2BfDHSzCeSREz/dP7uAmnGq3TsH/et6isuhvmuO8qLE=;
        b=lse/8cWwWueT6zLmegh4uBpmumguexknFcfyPBuyuzQntODxGyJLAHCsuMUzUdU3JS
         sd7Ttcaels9yQ7oAAUjhudT62ArRpPlKQFS7K4jtZ1q2sl3bzOyhk26TKzwFFYJjBnZR
         W7bwBkAhcy/h0ALU1FYTujNdX1aobX+Zi8oiynT4KQIichaWcmUZDwaxQ+t5wbnoR4L5
         rhcKKDv2UN8RiQG9pspi+cN2DY3iS2co2jm+I0/1p1yoFaNOVhkKbyAQrTQJVJ2opkKe
         O5XmKPgPdgQtqh/PVR+UXIONU26eIl5xkkQHGl0AP2odFgICstnsGqF3HqpD6vkCVVSW
         8xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776186315; x=1776791115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BfDHSzCeSREz/dP7uAmnGq3TsH/et6isuhvmuO8qLE=;
        b=QPg1cKg0hGRpFZUk8+MazYyj+ZuEpzghY9ozlBElq1SWoO7mm8GcyJDG9WDsVz4k8p
         4++QyswaZTTXI7ldD6nyg9dsSOic2J1uIkTMKWPMkYwd9nfNW3Y4i3RYEZE6iKabXmUY
         tt/Ox8dg4kpzgfH3QtSJBUzABQnKmBqm4/7cy7aH6TTNgre7S54hDd5UXuQB7gBY86Ch
         VKaI8TJqiUVagJLJZK1tXNeiaEfjkPmTSSsaztDkLJtoCQlPHXoasRRMMKAVRycSyL7Z
         mqfK0VFZg1LUDzhoBSS33BEJ7EIBU4RRZdVCitfZYrKYfp7dFA5ow2AxMNBLUTUiJZUJ
         cc1w==
X-Forwarded-Encrypted: i=1; AFNElJ/ZOGcm+4E5ZP6LM/7BMRhtfdMDqlDLDO9k5cdk6/IIq0rklc3joCuEEHbwedFfSpuX8hOKMgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNTu/woLlHy8XsZh5lm0TzzaF/g1Qt68eRLJA58CWnKrmdezZ
	/sX0c9EygKh0jaCxaJE1zD+w4U68/uWNRpmR12wUMChHSLgsdgXOxC+e
X-Gm-Gg: AeBDieuEq7QWPlP+tPbiKmA6PYTCLxxr6OXJSo/VQrszgIhP9AjF1EzXb08GyGZGOXF
	kgBXIY2jHn7dHgxLbAXkSBnQiG5fVaM7VXaVPgf1MqVu9FWBoJIdi2StT48GRKH2sT5sy0dVg+9
	UQvh+xKkNcFgi0SOUK1domOa/eL96Hj5d9s2druf0b/Ac7UFg3DernDJ7+FDz3MoYjEiDW0xSPf
	EtuIJkhDlAJlwvSYnyBUvGVVaVGqsgymILsoBOxr1zIr2Bx8mjsTIc7OZI8cCUg/5lLXADguyH/
	TLG8atMRGb6wRO6sqFQdedC8rRAKsYV/dhGKmWNNMPo8Vg/+bB8UTaX77pXWlBTYa/fT18XY6WO
	r+eQYwchnY+bSgbYJWgoyBAf85WFddFnYPH2ke5+oRf6IVbuwhJD/85SyHbhExASzMWJOIeek3F
	jt2y1s3AtQK8VfChlpMuOvHRuWLEcIya5KP3+QdIwWe3oR9yd8aUIvtFYC9bgg
X-Received: by 2002:a17:903:283:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b45c0d3361mr93427165ad.38.1776186314338;
        Tue, 14 Apr 2026 10:05:14 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3ab3dsm163655085ad.74.2026.04.14.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:05:13 -0700 (PDT)
Date: Wed, 15 Apr 2026 01:05:10 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: stub: Reject I2C block transfers exceeding
 I2C_SMBUS_BLOCK_MAX
Message-ID: <ad5zxsFtxvuCpkXM@SLSGDTSWING002>
References: <20260329164126.820797-2-bestswngs@gmail.com>
 <20260414172239.7e98a0ae@endymion>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414172239.7e98a0ae@endymion>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237929-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: E30CA3FCD13
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-14 17:22, Jean Delvare wrote:
> Hi Weiming,
> 
> On Mon, 30 Mar 2026 00:41:27 +0800, Weiming Shi wrote:
> > The I2C_SMBUS_I2C_BLOCK_DATA case in stub_xfer() uses data->block[0]
> > as the transfer length. The existing check only clamps it to avoid
> > overrunning the chip->words[256] register array, but does not validate
> > it against I2C_SMBUS_BLOCK_MAX (32), which is the limit of the union
> > i2c_smbus_data.block buffer (34 bytes total). The driver is a
> > development/test tool (CONFIG_I2C_STUB=m, not built by default)
> > that must be loaded with a chip_addr= parameter.
> > 
> > A local user with access to /dev/i2c-* can issue an I2C_SMBUS ioctl
> > with I2C_SMBUS_I2C_BLOCK_DATA and data->block[0] > 32, causing
> > stub_xfer() to read or write past the end of the union
> > i2c_smbus_data.block buffer:
> > 
> >  BUG: KASAN: stack-out-of-bounds in stub_xfer (drivers/i2c/i2c-stub.c:223)
> >  Read of size 1 at addr ffff88800abcfd92 by task exploit/81
> >  Call Trace:
> >   <TASK>
> >   stub_xfer (drivers/i2c/i2c-stub.c:223)
> >   __i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:593)
> >   i2c_smbus_xfer (drivers/i2c/i2c-core-smbus.c:536)
> >   i2cdev_ioctl_smbus (drivers/i2c/i2c-dev.c:391)
> >   i2cdev_ioctl (drivers/i2c/i2c-dev.c:478)
> >   __x64_sys_ioctl (fs/ioctl.c:583)
> >   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
> >   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> >   </TASK>
> > 
> > The bug exists because i2c-stub implements .smbus_xfer directly,
> > bypassing the I2C_SMBUS_BLOCK_MAX validation in
> > i2c_smbus_xfer_emulated(). The I2C_SMBUS_BLOCK_DATA case in the same
> > function correctly validates against I2C_SMBUS_BLOCK_MAX, but the
> > I2C_SMBUS_I2C_BLOCK_DATA case does not.
> 
> Thank you for the excellent analysis and detailed description. I agree
> with everything you wrote above.
> 
> > Fix by rejecting oversized transfers with -EINVAL when
> > data->block[0] exceeds I2C_SMBUS_BLOCK_MAX, consistent with both
> > the I2C_SMBUS_BLOCK_DATA case in the same function and the
> > I2C_SMBUS_I2C_BLOCK_DATA validation in i2c_smbus_xfer_emulated().
> 
> Would it make sense to also reject len == 0? That's what the i2c-stub
> driver does in the I2C_SMBUS_BLOCK_DATA case, so it would seem
> consistent to do the same for the I2C_SMBUS_I2C_BLOCK_DATA case.
> 
> > 
> > Fixes: 4710317891e4 ("i2c-stub: Implement I2C block support")
> > Cc: stable@vger.kernel.org
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> 
> If there any public link to that report? If so, it should be mentioned
> here with a Closes: tag.
> 
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  drivers/i2c/i2c-stub.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/i2c/i2c-stub.c b/drivers/i2c/i2c-stub.c
> > index fbb0db41b10e1..349ef9fb2fdbc 100644
> > --- a/drivers/i2c/i2c-stub.c
> > +++ b/drivers/i2c/i2c-stub.c
> > @@ -214,6 +214,10 @@ static s32 stub_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
> >  		 * We ignore banks here, because banked chips don't use I2C
> >  		 * block transfers
> >  		 */
> > +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> >  		if (data->block[0] > 256 - command)	/* Avoid overrun */
> >  			data->block[0] = 256 - command;
> >  		len = data->block[0];
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
> 
> -- 
> Jean Delvare
> SUSE L3 Support

Hi Jean,

Thanks for the review.
I'll add a data->block[0] == 0 check to reject zero-lenght in v2.

The report no publick URL. sorry

Thanks,
Weiming Shi

