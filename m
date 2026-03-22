Return-Path: <stable+bounces-227835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DqcFML6v2lFCQQAu9opvQ
	(envelope-from <stable+bounces-227835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:20:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E282E99CD
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42EA0300AC18
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 14:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600BE3630B0;
	Sun, 22 Mar 2026 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/9t/5nL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7691E633C
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189245; cv=none; b=YTikXyQQUXCjGn8AfwEl5M0RNQ5b1dS1kb6LLnD3XXvAB5lEUHv/MTa0Pm4KtwJ46hB3F4EILzIE0rnI++qoesvcTUT13g+30TJdIuqDpit03vQS4nGjPGIxb3x2zscfcMR7cEY4vavyheCOMtjpKxREPjnxMC3y8C/VW7pec0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189245; c=relaxed/simple;
	bh=engp1nQNSX9vhPkXGfLguo1jEktsA/8b3yfVE0qSsgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWz2tviWSzM5YeI/ciu4kCNgKLatpWDWCCilLrRbe+uehgGiqwWaiD+fR9AVaD48GUzM4jqMv2OYouRxTCyC8V49Xi+FwVYR6K47afpcrSoUF2nhUYSqzQWSYBdWelFHhKPkfD0hZRwM6dhM9uiOCzDDbNCrcu6brof3nr5ai6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/9t/5nL; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a693cdf29so2451360c88.0
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 07:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774189243; x=1774794043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c90GIT6mW0YUjHC07UDbUeOA+0vWgoPqFFOks4qskQg=;
        b=F/9t/5nL/5wHQ8NRe1Aw8EufQOxkd2ncID66rn/+RlDG00PEXnJzckfb9UJWa5i+Rr
         r3OQEuK8G46NAXe4FPF25cs2GzHCdsiFcd940v83EtxQB4n1+zKErkrUj9UcAFndq0NY
         XYga2mPMqfSDKYMo+dE7GCLW40XoYTnUECk6SMJC/sjUToTCD8rG9Fgu7AgXHJA4QrVf
         5ViQ9uQTn4LfXp3S1SPox9iMuXNM23af7yVMrsAu36yZ08r2EJIwyQ7WpA14EaHokHe+
         SRI6XQ1J0QIz1O+EnBeGUwRroX+3+ZOIanbzuA6rORqHeDdmsz5bcBilEHwDQNTyK479
         nZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189243; x=1774794043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c90GIT6mW0YUjHC07UDbUeOA+0vWgoPqFFOks4qskQg=;
        b=YdHcGPdXVsGIH+kbe+nW6G2Ss3hjIt3W/qCiUQPRN0O+Jni6Db6gjfdZTVFvh2lFxU
         iW/j19tmM8OcT+W8E/isTcje13jxcLXAOhLaTJWwqIf+shgziee0zE1hnrl0WZHP+B9+
         ir97prrPiNcp45qXfMFkNbkg9FWJi1OAsV7cn/phiJO0yZD4btfURzSmvursaQ14pR5N
         X2kdabIcYf8L2X5Azf0TZnjO4NVgYCwCiJB5HXaN20ZZDSFOb+0nqG5Ianp1jKtTvIkZ
         k1xa47/AaH1DlxF5JDhKQt7WWsSkSIKVyLN2edAefggu9mtr88mK5e+I8erRhO0FHvIg
         D2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfuTUjQF8RR4m3cGbLvouV7JFNh3QraXRgsbr8kFXt9bFw2WBfR0SD4zpgkDO+XR5NW/OksXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+IRgALtdwskfHsXghPLA70IRhVPNNtrV3SkWk+cR1DbpJMYC
	XgLQG21CmRpBicAOY50VeyOjgpQMcnf5o3oEi7G83L8knkeUMXa4Z6Do
X-Gm-Gg: ATEYQzynhGKQ6HRrTUEOQk7L6N4KOjCFMkDTYpUiGZHTLP1vnTOI8vnOSVocmZMO1mZ
	HZs/qLbJCNHZEzFk1dL3SFojmed7v2/FT50HHl5grJ6CyhbHVjkTaXQZNgA9l3P8WyvwHhC8rmw
	DtNKpF/EP0vN5Ura70keM9ARqvh1NnznC4hl7xN0gxb5FdHlrRwcpJuLtXWuwy98AdBUtsHWD+z
	Kl9SQz/axCoMX+0uMKq3ccympRHqbT6Rfv+Weqsz9N7auwdq1MntwLoaXlncgNU+9rGETBKY3/k
	TNoMw1HL++zdq4Os4nXc3qDz26Jc9VchsLn+l+TGgUhkUcrH63YqbGzUenW5iOd1+ng0STgh7Pn
	+lNN5flOwuIkTUht22bWMPdPmPZ0fwDU7CV5q3IMsQFHo/ePKjML4zXz4G4cq/XXZtasfpmi6Av
	IpOp+O3XPpmvmJHVzmLBV3t3o195ZsrgqJeyn8Y/7gIg63+E4=
X-Received: by 2002:a05:7022:6894:b0:128:cdb7:76e1 with SMTP id a92af1059eb24-12a72326a69mr3242178c88.13.1774189242952;
        Sun, 22 Mar 2026 07:20:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbb57sm7408905c88.10.2026.03.22.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:20:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 22 Mar 2026 07:20:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] hwmon: (pmbus/ina233) Fix error handling and sign
 extension in shunt voltage read
Message-ID: <f5221388-a939-4a6e-a00d-c2d8302cca80@roeck-us.net>
References: <20260319173055.125271-1-sanman.pradhan@hpe.com>
 <20260319173055.125271-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319173055.125271-2-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227835-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 12E282E99CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 05:31:19PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> ina233_read_word_data() reads MFR_READ_VSHUNT via pmbus_read_word_data()
> but has two issues:
> 
> 1. The return value is not checked for errors before being used in
>    arithmetic. A negative error code from a failed I2C transaction is
>    passed directly to DIV_ROUND_CLOSEST(), producing garbage data.
> 
> 2. MFR_READ_VSHUNT is a 16-bit two's complement value. Negative shunt
>    voltages (values with bit 15 set) are treated as large positive
>    values since pmbus_read_word_data() returns them zero-extended in an
>    int. This leads to incorrect scaling in the VIN coefficient
>    conversion.
> 
> Fix both issues by adding an error check, casting to s16 for proper
> sign extension, and clamping the result to a valid non-negative range.
> The clamp is necessary because read_word_data callbacks must return
> non-negative values on success (negative values indicate errors to the
> pmbus core).
> 
> Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> ---
>  drivers/hwmon/pmbus/ina233.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/pmbus/ina233.c b/drivers/hwmon/pmbus/ina233.c
> index dde1e16783943..1f7170372f243 100644
> --- a/drivers/hwmon/pmbus/ina233.c
> +++ b/drivers/hwmon/pmbus/ina233.c
> @@ -67,10 +67,13 @@ static int ina233_read_word_data(struct i2c_client *client, int page,
>  	switch (reg) {
>  	case PMBUS_VIRT_READ_VMON:
>  		ret = pmbus_read_word_data(client, 0, 0xff, MFR_READ_VSHUNT);
> +		if (ret < 0)
> +			return ret;
>  
>  		/* Adjust returned value to match VIN coefficients */
>  		/* VIN: 1.25 mV VSHUNT: 2.5 uV LSB */
> -		ret = DIV_ROUND_CLOSEST(ret * 25, 12500);
> +		ret = clamp_val(DIV_ROUND_CLOSEST((s16)ret * 25, 12500),
> +				0, 0x7FFF);

The clamp should be to 0xffff, not 0x7fff. That is still a positive return
value, but does not drop the sign bit (bit 15).

Thanks,
Guenter

>  		break;
>  	default:
>  		ret = -ENODATA;

