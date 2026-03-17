Return-Path: <stable+bounces-226921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l9c/LwjUuWleOQIAu9opvQ
	(envelope-from <stable+bounces-226921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:22:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D522B3125
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0158230480C1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BE39D6DF;
	Tue, 17 Mar 2026 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZrQrk9h"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924439D6CF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786115; cv=none; b=K65GWmyk39KO609scJ4ih5qtl684OMamMfP8vhYTDXVwpITeoio29WnapViiizean05ojbkPO7nEw2QpN2eNilrb57+v+utK8vfcsmt5pIbWsSvu0+Mv8eX7W8WBWG9+pI4thsKW7c8aCA2Fysmq39fXAhEEUueIfho77VaftpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786115; c=relaxed/simple;
	bh=XnVsP7/5zkWF3z1O4+8fBwGTX/voMAX58gTtGPTEWYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGZ8ERCSeiFgby9B+HtypNg05lfl6q/eltqDOSJGwMfeLf86unW8jWrKXbPTivMsIpHTXSv0ZySdrrSD2zE9amTUGSlKgZ06K7bAsFLA1/XX1xjm30MA2KWZw90pk+ty1G9QrrF5qyRLRq2wItzq6IgFoQsGzMsCNpdejwCgd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZrQrk9h; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128ef6c4a41so3065372c88.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773786112; x=1774390912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9cdnqRDoqmYIcJosBdr9gdcUWkn/AUmemr1WXNUuBw=;
        b=VZrQrk9h1d5fuDT0KQQ4yGwp4NNXzqy3M+2DV/yjkhA8c6W5lHEWF/QoZe4r/NI9/+
         hS6fi7dvsqEIqFcNd00AU6Ym8bprWLeHMZKw4x/6cBFCR55zhWjoYgo/nCxdv8jv/rnQ
         J3cEV9oKyVojSWd66UYbvA7LLPoJN40vCCChqUtZSpgE49qqwFvY+EhWA4ytc37Xm17L
         uod0igYTOQofqFvIpO8mZp9htxdzl5hd7LDz/6/K+zHj5tycYUpl2TyV2eLfj5gw/uPN
         9AK89hk8pz3bZHQ6LEY0oWm4v40OuRidOFzXm6PNP9j4w/tpZR0cy7thbJ5rRulH5xg7
         gWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773786112; x=1774390912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G9cdnqRDoqmYIcJosBdr9gdcUWkn/AUmemr1WXNUuBw=;
        b=PsNFuj0YXpddRrWNSIhnhmhRAwL4fGGJTjkW1dhoca1L9KBgGk2AevEcaLkhZtgEUv
         3x8j6O3dnsNJi7eDJizwcAaNwUyU+sMDAZQVD7N2jnEM0O5mrybRQIkirct0CLonmyeR
         rz3LwTpRBjJppHSSitAwUVzwMTqJMObjPuNNJ4jBe40Eu/W3W5SNWV9OSbF2RzPC6pPK
         lkv18NvGQfh+QUMxXEl2MVIFJ/xt102kQ7HThEYY77g1RE0ugM1HZCu6hdildwTFK/Xr
         F4de7gvlF1AFEfNHaHfIDPzPkH1cgv9jwm7SLoorFd+XOUbzA1/tdek1Osz8NQ6AYTRb
         LJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUXgMEz6Nw0HSQDl8ZXoICGhNbJv6aFX9uCjiER3g7JPOgAO3j/ELYTBbcgbS0rIlgtahp9Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6F3/UVWptoUeU86/a28mu7TUi+FCdnC/yUP/r3k1VW621V4uo
	csTwD7HNEjlkmmOuQgjCFKhuXid4QtEfixhoiyCqgDA1YDhgbkWkBO0e
X-Gm-Gg: ATEYQzyrOh167oQfcFGQucu9nZEa2Lrszb/ZszlbqROv252N0LySgE5Ve66wIhg8bMv
	b+Moud/qfNlEKULsinzKkakHrvsmaG9gBYTySMGY6LvJ5D6Xfuu+B60uONz8AU4fPoT0J4XwaI4
	hq86lefGt3NIEHlkMFyCWbMrc1UDaF8wu3GsOCJBT2wzSl5VSt8c2/zVK+NyIero5iqNsP7BrWY
	3Xu75qpcNIshtud6eZTteV9dFzGFrChbIGT4aS/PXKaD5rXOe+u6QWxZIWU06ewMmAF+Ga8DR1q
	/DL7oEQrMShxeiGQBi3eHVtWnqlUCaOuxc4bZJ6ONfRQPp4kw5G71zd7rMDso98OfTHb1wWm3g6
	IxUdo0wLfxWupIt9EoqSWKWca9+VMXddLeo9P3qlZoqo8kqVSBEjplfcKf7NGSNxiJ1HlNJHMOS
	+OEIEH1HhmC6B8c97hk2Sh9RRtGB44eyRmyjMr
X-Received: by 2002:a05:7022:f91:b0:123:330b:398 with SMTP id a92af1059eb24-129a70d5e0amr663838c88.19.1773786111970;
        Tue, 17 Mar 2026 15:21:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5368ae6sm1314541eec.6.2026.03.17.15.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:21:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 15:21:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"vasileios.amoiridis@cern.ch" <vasileios.amoiridis@cern.ch>,
	"leo.yang.sy0@gmail.com" <leo.yang.sy0@gmail.com>,
	"wensheng@yeah.net" <wensheng@yeah.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4/5] hwmon: (pmbus/ina233) Add error check for
 pmbus_read_word_data() return value
Message-ID: <103369ea-f4eb-4858-a72e-3f9bc00bcc48@roeck-us.net>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
 <20260317174553.385567-1-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317174553.385567-1-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cern.ch,gmail.com,yeah.net,juniper.net];
	TAGGED_FROM(0.00)[bounces-226921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: 92D522B3125
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:46:31PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> ina233_read_word_data() uses the return value of pmbus_read_word_data()
> directly in a DIV_ROUND_CLOSEST() computation without first checking for
> errors. If the underlying I2C transaction fails, a negative error code is
> used in the arithmetic, producing a garbage sensor value instead of
> propagating the error.
> 
> Add the missing error check before using the return value.
> 
> Fixes: b64b6cb163f16 ("hwmon: Add driver for TI INA233 Current and Power Monitor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

