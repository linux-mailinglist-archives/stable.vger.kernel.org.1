Return-Path: <stable+bounces-227836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNmFBTL7v2lFCQQAu9opvQ
	(envelope-from <stable+bounces-227836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:22:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6F62E99F5
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 226CD300F5CE
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F53630BF;
	Sun, 22 Mar 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f18sPkKy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37635F5EC
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189355; cv=none; b=EJAZPwVNDMDOXfJv0hrrLChS330pl22kc8bO0zIc0cjrTHLmbdm14TyeAZSVxFKVPcD7p+OqGR9n4K16+jxN97TUgxBfgcfkmAR3NTSf6+aVZ4SZ6HlIQj2KDxS40rg1zeRvzS98Kw0cD5BnFBziZyDfEjNgwn+5qm8QnpFpGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189355; c=relaxed/simple;
	bh=eMDhzc2hSxs25T5e80ZInysl7aGQk4nQnQ4SDi73ZeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/0zeIUffB807nyUWQE/OO6Tnby75TWCpdE8rEYcrMW0f848INyAqMnf3lOEMtcR5uvYz6UMvr81Im9/GEsCIJY0BR4DdS9gXzAG9nBBhMHKny4pyexUCodOuOfs7PSHRrGr6Ev1rvW/MjLiW57EBc82yW7D7LFUd4pwWWkLgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f18sPkKy; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1954543eec.1
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774189353; x=1774794153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXtu4vWFf84nyFq4kigv3ZVOF6HDlGnNmELe5UVz+MM=;
        b=f18sPkKyGCVEu/ijDIn+U9FGWfkaq59h6nPaAA1TBf7Ey6Xvtqv2BcSGk/J8+oIXO3
         ykl8TszsnMWg1GXHXBjmaSJ9IUVEfg6GR7IVdt94sMqQ7rxKTJiyYTdRL4Y/H4OXT0KM
         2sxlBSPN4m0O88CBFJ1dhNJytgVjg5znsfVawMacrITaTbpqa8KHej71Rv99JW7X98cF
         n8Loi5/qwRGE96UkGO7R4rU1dcOsY1tw3ckT/L9Pai3j9WnkvmfPMAKMmLaMmJ+ly832
         iZUYIpVDisOBG2dsO7DfgWCSkU3M+ADgUObnIkUnC3dR7sa+C1q10GaU5/PGgXW+HNhd
         UBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189353; x=1774794153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FXtu4vWFf84nyFq4kigv3ZVOF6HDlGnNmELe5UVz+MM=;
        b=d2VmvcCFNK906K1oJStY0Q1OuK4qJGA5F+cQ28S/m9tD4Wki083gZme00Db/BKTdaN
         rzKF979DJc0uWFWLJ9A3zIyTl7IRMD7O4mt/osiXN4Cf1S2BEovNmM+/WrAbIExVmu95
         GrgnXA+qBOAZc/S5oUAJ0qVw2Vk+Sb9hGG38bcBLzuFDCG+CEq3PReT3en+bMF6CWc4g
         QaCipNjJRFtvH4Lz/sV2Q+Ql5jzO16Si+4yMDVLYzESIQgETAkaCCci/BJcdf4OxguC5
         IrEz6bvlemLfooMPDFxv5n+7eGVtgVmV3XjGlShSH6HeDglYIsW2cz7IDenJPoXsKwU+
         Eu1g==
X-Forwarded-Encrypted: i=1; AJvYcCXUQUZRSDxQXM/nuGmpzW8y3pw+LjVA31c52h0MPw/pJYk3CNnVbR85ZU9J19+V4K4WSW2iZ24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Zecz7QsKyfGFrKri8hRk9PC336KIFwmPR4JO58q4HYWxd8YT
	cmG77B3K8H1c50FOwE9H6WvttSqkJK+U+uHvT4qD8Z/9ZzpnrGIS1z4F
X-Gm-Gg: ATEYQzyoFHM99ArRVo35oOMVsdYbjui0EHx3rJwOaxma8saXprQjv9T1M2hgnS2g6uU
	B97pbQP1rZ+56u1bjExqjG7RGTUMxfSrOA4VScf8H9lv1ywUMB1m0bovWd9ngcgLoCynLsslexS
	ZIA0fa6rPn66zuthJN/bRb1frV6qRBB0qYl2oraG1JgzXmVCshCaYJQDpr+ztbbP8Ks3QIf5v0Q
	WVhEtIgUpFp0E09vcc6V2qKEJmYvJWsn9Gs9LV73p939DpYjhVxKGuD0Wz0lHEXrszq0+v0PL9D
	rGIpWoRO9WtT7TTXu0DrQAOkNXAG/bJSQsbJhlA/lxsKZ/m+F3lTsBaZMKMMkl0jXTmw1QwfVeN
	SkP8vplpaLhuCLBqlM7KUXCfhEr1z91Gb1eOh+xtjtohau82BjZmgU6vYYD4+OGHKRVDLMT0Yhg
	MFTG+PTtXk81tmZ+wSqqupRcrr8se5OIU5t11t
X-Received: by 2002:a05:7301:4083:b0:2be:8da:3207 with SMTP id 5a478bee46e88-2c1095a5704mr4502105eec.6.1774189353348;
        Sun, 22 Mar 2026 07:22:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14c99bsm10164098eec.1.2026.03.22.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:22:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Mar 2026 07:22:31 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus/ina233) Fix error handling and sign
 extension in shunt voltage read
Message-ID: <c7be3ee6-174d-45cd-a9a7-17a7aad8e8cf@roeck-us.net>
References: <20260319173055.125271-1-sanman.pradhan@hpe.com>
 <20260319173055.125271-2-sanman.pradhan@hpe.com>
 <f5221388-a939-4a6e-a00d-c2d8302cca80@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5221388-a939-4a6e-a00d-c2d8302cca80@roeck-us.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227836-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid,juniper.net:email]
X-Rspamd-Queue-Id: 6B6F62E99F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 07:20:43AM -0700, Guenter Roeck wrote:
> On Thu, Mar 19, 2026 at 05:31:19PM +0000, Pradhan, Sanman wrote:
> > From: Sanman Pradhan <psanman@juniper.net>
> > 
> > ina233_read_word_data() reads MFR_READ_VSHUNT via pmbus_read_word_data()
> > but has two issues:
> > 
> > 1. The return value is not checked for errors before being used in
> >    arithmetic. A negative error code from a failed I2C transaction is
> >    passed directly to DIV_ROUND_CLOSEST(), producing garbage data.
> > 
> > 2. MFR_READ_VSHUNT is a 16-bit two's complement value. Negative shunt
> >    voltages (values with bit 15 set) are treated as large positive
> >    values since pmbus_read_word_data() returns them zero-extended in an
> >    int. This leads to incorrect scaling in the VIN coefficient
> >    conversion.
> > 
> > Fix both issues by adding an error check, casting to s16 for proper
> > sign extension, and clamping the result to a valid non-negative range.
> > The clamp is necessary because read_word_data callbacks must return
> > non-negative values on success (negative values indicate errors to the
> > pmbus core).
> > 
> > Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> > ---
> >  drivers/hwmon/pmbus/ina233.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
> > index dde1e16783943..1f7170372f243 100644
> > --- a/drivers/hwmon/pmbus/ina233.c
> > +++ b/drivers/hwmon/pmbus/ina233.c
> > @@ -67,10 +67,13 @@ static int ina233_read_word_data(struct i2c_client *client, int page,
> >  	switch (reg) {
> >  	case PMBUS_VIRT_READ_VMON:
> >  		ret = pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);
> > +		if (ret < 0)
> > +			return ret;
> >  
> >  		/* Adjust returned value to match VIN coefficients */
> >  		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */
> > -		ret = DIV_ROUND_CLOSEST(ret * 25, 12500);
> > +		ret = clamp_val(DIV_ROUND_CLOSEST((s16)ret * 25, 12500),
> > +				0, 0x7FFF);
> 
> The clamp should be to 0xffff, not 0x7fff. That is still a positive return
> value, but does not drop the sign bit (bit 15).
> 
Never mind though, I'll fix that up myself.

Applied.

Thanks,
Guenter

