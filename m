Return-Path: <stable+bounces-226918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OBNL53TuWkqOQIAu9opvQ
	(envelope-from <stable+bounces-226918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:20:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5762B30DA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6F693060CFA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247DC395D85;
	Tue, 17 Mar 2026 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0YgK7gH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FD393DC8
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786006; cv=none; b=cigGhvn8sssWoLynBC8ei8m2SBk47OqKZLUl56QMMOwDmGua4OHkhkrohS0gRCJ1x/p1oODDNHAoXjn6wTbKOOj4ix+6kG+lHPs6tUD15d3zUm32nGcO9yHin8s8Pup3NdIpfNr0MOgkSHCGmnWWKh5NqOiw+SX23+DLvhTinLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786006; c=relaxed/simple;
	bh=y/EmYIg0gRmVkSyOE3fKWNsZUImGNsUyuRa0ygA4/YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAd1R+kuP3OHPh0MjRVmPDXPBznT5sdsbg4YcnVVpT0yWYUAoESWhHYxChQDXOQh9NSsrvLfUPhsAkzeordmLCzEa7Qcs7jvTIcxOkkrxPCEiqpNIE0adzOMq+ZK9h5kSCE8GLhtVfHzc+HEAFA9Wnvbx5M2ayqXrIlsDFYxNQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0YgK7gH; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9003891eec.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773786005; x=1774390805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yPZOqi1ryUibCEpvsqKM4HgGM7evfo9zGBJ9SdBBPQ=;
        b=W0YgK7gHc/sgaz4Yujm3o8Qs3rDhg6AVp+xfKH/+UQB8pJ3oUxrYBgAgLPXoAQDC4V
         vsebvbJTRoGOMXztaJeMjYdooCeoQHTEDkY3ugSHgvOHeQbqQDRFh7MLb6vlIpZHPc2Z
         YBeDCnGb0dHt3yevD4VqOhE8cWiQ9d1qNgo8GRhKDbGvzhKRLfIy5dChhqtZIaVL6bOF
         QEHfKD+sG0clVFqvGwC3Aq6Mpt2a2apsZsYi3JlBgbXXrO+SYE1M09UmQR5nlpE80ria
         QucN9fBBj8vmcvTcOiiuaAtvFVlDICjmMfMIYTUfrJsfir3+PrhMpSmhXgasdrIuySLX
         o4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773786005; x=1774390805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/yPZOqi1ryUibCEpvsqKM4HgGM7evfo9zGBJ9SdBBPQ=;
        b=OMl3aJ/Y2Iy+QIdLlO8wX+I4ZUar2IyrTmbykBRi0r/pWtYU3twPabha2B43hLTIEq
         XORs5lv2wXPp9yN8FQxfRz29FfnB0XWJHphfMbX1q6NtjMrXFUfpaqm5a3vKIBeZgxxf
         vL+9P8mapvK/Sla20Hd/kDj/lijEdWTut2UEYiFM2LNecvvxf7LvsrZnuxXkf62cWOiS
         qPzWZwYhYfBZwuELHs2bOFINGcoDH4jJMnWGXDj4VxBL59GNxWiC6O2LrObRRFwT9tet
         Ddov6PBwR/OJxk2O4Eim+jRZsAP5u2WhKEfA9lIhXdEfJcsNmLvRLZj1DiymsKVOlQ2f
         JziA==
X-Forwarded-Encrypted: i=1; AJvYcCXsDs2GyEn+oJapeCDg+agncbXU5jjJTSiFP+58pVcCaPSLEu0PmfILFHEoSSmX92U160i0d4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqrEA9ShtN3lTHd7xTZwwcP1FTp7v7r/UyIbyx/J5rAIKdSOm
	Y4/uUONM219d8WlE5ozyZAWG3llF9mgN8REarOoAZut3gX1PoNdUmUp4
X-Gm-Gg: ATEYQzxTtaAtMYWixSJT6NE/USom6nNS4vEj5qJoww++nhublGjhwlKSpKCg98k2ZjY
	NUMS1tndsv3bwUASfVwkH/X/LFHF/jiCWqc+LDEQMT8A/KctkQUnyEDcUeefbCccnWrgk3x/ml8
	EU2DeGMtHvkuiSexVVp1d5mJpmyxbg/siQHi9GMFn9wQfRL9m3Rggu8mGr8TLK4SaJiAdQvSRPo
	1Dctb8Xac6FZHF6Q+SpaysYsBf5wbY0jio8h4/uovLTY0jw3S8T7jmDvKMtiYkT3jFUwW1H6kwY
	nUrATLBnwCe2umFko4SH9MtP4iU31Ma24F95IojJNIVZaC3OIIW3CyShIZKoHzR5N62jK2r9G9V
	PLrdmLn1Gpa0r4Q1LaA7GDoi95GE3iFkk0TuWUCqsd4sfUn8zn96RkDYxbzwa0Qywj7qmjzwGiq
	m38jW053hDsVK54RusB6KGsPS/yNPo0D0V1DB66HwAZEt/cDM=
X-Received: by 2002:a05:7022:90e:b0:128:ca90:32e2 with SMTP id a92af1059eb24-1299ba8b9a6mr586674c88.7.1773786004776;
        Tue, 17 Mar 2026 15:20:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5583533sm1291913eec.18.2026.03.17.15.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:20:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 15:20:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"vasileios.amoiridis@cern.ch" <vasileios.amoiridis@cern.ch>,
	"leo.yang.sy0@gmail.com" <leo.yang.sy0@gmail.com>,
	"wensheng@yeah.net" <wensheng@yeah.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/5] hwmon: (pmbus/hac300s) Add error check for
 pmbus_read_word_data() return value
Message-ID: <8aec79cb-3884-4aa2-870f-6e136f6fb373@roeck-us.net>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
 <20260317173308.382545-2-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317173308.382545-2-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cern.ch,gmail.com,yeah.net,juniper.net];
	TAGGED_FROM(0.00)[bounces-226918-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C5762B30DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:36:53PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> hac300s_read_word_data() passes the return value of pmbus_read_word_data()
> directly to FIELD_GET() without checking for errors. If the I2C transaction
> fails, a negative error code is sign-extended and passed to FIELD_GET(),
> which silently produces garbage data instead of propagating the error.
> 
> Add the missing error check before using the return value in
> the FIELD_GET() macro.
> 
> Fixes: 669cf162f7a1 ("hwmon: Add support for HiTRON HAC300S PSU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

