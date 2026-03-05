Return-Path: <stable+bounces-223213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jd6LQ+ZqWm7AgEAu9opvQ
	(envelope-from <stable+bounces-223213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:54:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D67D213E91
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4A9C308F6FD
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818AE3B3C00;
	Thu,  5 Mar 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZkeeuZe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB43A961B
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721913; cv=none; b=eXWRSYtDM8R7Yx3nArA50rt6BNSK/ehhU5vD6ixhde0nrkH7uRmQydxMVEEamt2cLnUnkil6qCidK9aWEgV/7aepwEwmjBdisrP/1R+SiKV9ljYuz7mKpsB4XvaO3NpzDMKr945CWjQR3V6HGaAp8fwaATPeoV3YCop1GJ1H0r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721913; c=relaxed/simple;
	bh=JxAXDy8Qg0kPE0csEH3JZwQ2zDkqgb1p9YwasOy2dlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEbSDi4WdaUQrjTk8Kkc2Sdvn8556GwzqKfxELEVjuM/2TXuKCbh2PUQKwZZDIWTv+Xi62BYM8OGS2kJmatIEwzBYLm+PrN0TMxOxezd2jiieyIUrOg68sABpp8XsyIeWYmkn+WT4jD1Owzv9QKRlDbXgPiDcRmXOrhyRZ1K6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZkeeuZe; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be1c918173so6660826eec.1
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 06:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772721910; x=1773326710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1/ypJ6rTR5qngL/oS2fXdtqhXdpRH9GGWDsGzbr/Gg=;
        b=LZkeeuZeRsVYLpGK4f5QTR8n83Lg1QJnAfYz9usZi6ZJ35erXz9hehWRrRRSvO0s3M
         OoAwKT0UkuVzRdfBEIOQcCjg/tpmjpksfOvqz0id2xYYtPvUWr7pBFSi7Up/mM6tj/8m
         PmuPDoNvQ3ky9glAl45LTbNyIp3A+b10YPgbU4mVtacm45C+1ibqyViVjW8FtI72YVv7
         Ub1HMvyMg+w6N0SauOT3LCdYzPGHCb/ub/7dF6PIryB24eh/AJ16fCmWay0yu3z42t6U
         UZjDfjHbAFUS7d89pJNz8+9TM4Ccy5Hcy2jGNrwlGIngzroDKSiVdsfkaCBbCr9fng5T
         dsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772721910; x=1773326710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l1/ypJ6rTR5qngL/oS2fXdtqhXdpRH9GGWDsGzbr/Gg=;
        b=cQkatx7fsU+ozLqoSvkr+GNDS9mEc8hUM5oYjfFlhyTR1IG2P5Qk382H1dSd7O3ETf
         c8YHXFQ3OIPbJYGv0sWi0JDwx2QqvZDFaeH2vrOkKx9I7NwcR1kh2TQp0X8yMozr+Uor
         chYedWGQn4PiBaXtaoqArXLrBpN3rP6pzECiOQW6U+ivvi3L/ujBav8wVqbHGmLg45z9
         kraoj2TL+rbF8KTIwKT118nvkaTQeGkCi+THJXYslZVgPLqkdVqiX2LIZ2e0yaTqlmtJ
         E5zvF/rewUlIJKMWXIA3WT30HSgoJXrXtiXn09+xGkNv8dKiWfsl+JLFfKp5wNBrgez6
         bwfw==
X-Forwarded-Encrypted: i=1; AJvYcCUaRofv5kxEkfah829r+pzpCiZfIBiwy6KiKTNsxfThxXrrDz1NTIYbTDIwXiGu/lNJVGuxEQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGCfccBmudg+FNokszFbu5764EXXGPlzwV1qPWCKDW7vKylJwe
	dNpzMRs8MMer3LqUTWMucFAkgWv87NpaxZWz0ODFw76U8Ks1nK3UP8oy
X-Gm-Gg: ATEYQzxuKjDUbrcgqnknQZIKY3ZcfN+PKxNGAGty3NIK3f5b7419bSMOGQR+wcuv+PG
	mJ45+g67AZFWDeoBAAKzXnMn/3ps2YTIRPtm5v0VPCSzb74Vpgt937jOVz2IapK63sJlQlD6ouW
	NNbuEQ7NOmvFoiGgMq2W4smnGSfEM2GJ9Oj7vGPmiFuL8SYwCv1MbcvWJ1/9rUUmOjn9A3PXw9Z
	uMew6N6eBzUFU+BCH5VH+nBni26Aorh38EUwMOfpVPerroXDyzCIyRWRL2m72a14gKr+Umnwy8i
	huKLAxs9l9JK/za8s+zinxJTRlNauDRlE55HR9Z36ffB7AqlrRLiLFXiNzgfP97VttFHvNCqB35
	Bqmz1sHnpvXZHqGvngzfZ/+pAAvnK5Zoqpb3kREILtjl1hJVS3NipvDqC/S7qcEv+38buf60iXV
	ua1USJI9LET8VELSgcPw5qdMMI/3GmMXOdZapi
X-Received: by 2002:a05:7300:d717:b0:2ba:7b0b:e20a with SMTP id 5a478bee46e88-2be311df80bmr2191076eec.37.1772721910085;
        Thu, 05 Mar 2026 06:45:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be381d5ae9sm2343977eec.26.2026.03.05.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:45:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 5 Mar 2026 06:45:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: psanman@juniper.net, andriy.shevchenko@intel.com,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (pmbus/q54sj108a2) fix stack overflow in
 debugfs read
Message-ID: <c64ac068-d657-4d68-8721-dde09978e4dd@roeck-us.net>
References: <e7191c1c-ecd4-40f8-9e47-9357bd82984f@roeck-us.net>
 <20260304235116.1045-1-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304235116.1045-1-sanman.p211993@gmail.com>
X-Rspamd-Queue-Id: 5D67D213E91
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,roeck-us.net:mid]
X-Rspamd-Action: no action

Hi,

On Wed, Mar 04, 2026 at 03:51:17PM -0800, Sanman Pradhan wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> The q54sj108a2_debugfs_read function suffers from a stack buffer overflow
> due to incorrect arguments passed to bin2hex(). The function currently
> passes 'data' as the destination and 'data_char' as the source.
> 
> Because bin2hex() converts each input byte into two hex characters, a
> 32-byte block read results in 64 bytes of output. Since 'data' is only
> 34 bytes (I2C_SMBUS_BLOCK_MAX + 2), this writes 30 bytes past the end
> of the buffer onto the stack.
> 
> Additionally, the arguments were swapped: it was reading from the
> zero-initialized 'data_char' and writing to 'data', resulting in
> all-zero output regardless of the actual I2C read.
> 
> Fix this by:
> 1. Expanding 'data_char' to 66 bytes to safely hold the hex output.
> 2. Correcting the bin2hex() argument order and using the actual read count.
> 3. Using a pointer to select the correct output buffer for the final
>    simple_read_from_buffer call.
> 
> Fixes: d014538aa385 ("hwmon: (pmbus) Driver for Delta power supplies Q54SJ108A2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

For future patches, please do _not_send new versions of a patch as reply to old
versions. The reason is explained in Documentation/process/submitting-patches.rst.

Thanks,
Guenter

