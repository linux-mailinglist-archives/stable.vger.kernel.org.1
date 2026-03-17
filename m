Return-Path: <stable+bounces-226920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFWaMd/TuWkqOQIAu9opvQ
	(envelope-from <stable+bounces-226920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:21:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0792B310F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E09B63026432
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833EB39B977;
	Tue, 17 Mar 2026 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7AB7s4g"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337663976BF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773786070; cv=none; b=T6J4fjskP+NuI3zWI7a0aKzVfjIMOTrUoskGQGeN4GyoCEG1z5Tyd47Tjgs+sn7Ttzo6UfYDttkmNTIQOUBJ0mIpHxwVxP5RTerEchrurDz/ztj1PWlnE3iYEBWjkBGDTCr+vkafselTW/nYTzo1iMojKs1+S4H2oKLFCFDAV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773786070; c=relaxed/simple;
	bh=0Uv5d+5bbxOiBwF6M/B3VboB0yLE4Kxcf8RxYCwaTRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSMW6aMBAcw5EsO1cMwwdO3hBsEJ7yFsY7qJ6VaApvHKrzwnotjZT1Pf0kdc5h1X8cwM9AHnN+/RKn5Agix3XLUhtjMZbtGYP6MIp5bh3nLzS2jYA3fX6KqXEE4jY9v0Ukyqp46/18V/yueACu34wf9VK85qYATtY5xCqS9bWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7AB7s4g; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso7508967eec.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773786068; x=1774390868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuptZXzFK4L2PdpOl2b489CN0eHGzhpdwJXoMDn53BA=;
        b=F7AB7s4gJVImSXktvFOgLyIwzHGk0B5R7JerD7UQh+Qo9e6yZ4v39A12FEgpMq1GMm
         mBkTVbd2RkMc58UKVyCQot/hS9sFerfbfsAy2jFEMmkrY3jRBpc5WpoWYGXlAmqbSWqv
         yquWa+xpctIe2CJOgFFOPXeeA8KeFqS4SzFSJt7Synzrbl2BNp6Gf8zI2Pt/r4mEv2VU
         YmZH9u1mweVrf8d86q359Dy6D0pq7Ti8q5fJi3rDNwpaihQSNLD0H31CVlGaM9TDe4ps
         rRit7AmPKOT2Cn2R2eZF8yklcLl5ep26nlo2Y16QsSZSd4ROfptXlaB1LT+fop5CSnZ3
         RXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773786068; x=1774390868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WuptZXzFK4L2PdpOl2b489CN0eHGzhpdwJXoMDn53BA=;
        b=MlRSpFnXvV/HkYriRNJMT4phmFTEbi9E7PHfwxANILreZf8fYVm9X1MV+gufJv5uEa
         s3/7w+/eXwfHSJgiSlkgppDHpSQHsJ3n9aXRLC4G1G4omBTPjG9e03BxeWXL8GaKxeEY
         1Nm5NBcYqLqT0s6gphQEpaIFFVQGrTbaInUiXhW7S7OIU9mTBE3Z69L23f+hWvEZHdVq
         j4mmeb35ZtxXf/b/W/s7P4olccEbI2a/1wNnSxR0qkGf3oRXRBeHeSU6gGmLP8w6b0Ad
         EaaFQvRFHdLBEKm4kzDwahazFExmeSdk3LBHF6HoqU1zaM1KdoBhAQcS+53KeSYYI6vb
         5EUw==
X-Forwarded-Encrypted: i=1; AJvYcCXGi/yP33swhXiwy06dPc26E0sgkTz0mb7Zd2fIdVbHczH0rCsUF+T9J+LqUX5fQm8Y+OG1gNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53v6RRTgHJJDZLUhBvOz04iOGQDm9sLIHSsg5Y+etvg8JI8+k
	iVz7KSU3j6CktoSuDb50g1b3PxuaRPaeiFgj27gQjGq1QykXf4UepCiv
X-Gm-Gg: ATEYQzyzMCPSQci4Hf5Z1umW7XJsMIW8gmP8AK0eactN7PMu5PZZi8d/42YBm+XvuxC
	h+NvViRWvpfF+L2bCnxwXVMmrnkroPPoSrWvC6oA088oguH8NWUlncMjbbqqLD0564py66mxQJb
	IeavRccwqnFksErezQuZP9MOWikPoWoUwQ4meBLxK04eh+x5yRo9KN4K/bA38IMOV6y3z6R+MJu
	YqQ+6scjlIe+WHvvNh1CoVZvdE8CobY9N75jZcOcnstDruttXbq69viG9MiDo5c78SxUholuFgs
	12ECc0xRzWHYdjmkuMnzaWThQsSI6WztrQjIOzajyF3U341S1kZSOoa0Ay5Tqe5wQtcu8EPJZPt
	9ZkGrrWP5n/ZzmzZbtUnQbBlgtszN5XhxzdzlxjAiaBr1CnKZ12qE3g+O6bvFD0QL4b9PYx99zQ
	B/njOYX5Edpuj9qSx/CAOXXOXO6G/QUOXSJHXhVZr7GCMrIx8=
X-Received: by 2002:a05:7300:cb0b:b0:2b7:19f2:6b70 with SMTP id 5a478bee46e88-2c0e51be9abmr465026eec.26.1773786068215;
        Tue, 17 Mar 2026 15:21:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55a2be4sm1414926eec.22.2026.03.17.15.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 15:21:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 17 Mar 2026 15:21:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"vasileios.amoiridis@cern.ch" <vasileios.amoiridis@cern.ch>,
	"leo.yang.sy0@gmail.com" <leo.yang.sy0@gmail.com>,
	"wensheng@yeah.net" <wensheng@yeah.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/5] hwmon: (pmbus/mp2869) Check pmbus_read_byte_data()
 before using its return value
Message-ID: <964686d5-a9d1-4db4-be24-81b48a0db3bd@roeck-us.net>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
 <20260317173308.382545-4-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317173308.382545-4-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,cern.ch,gmail.com,yeah.net,juniper.net];
	TAGGED_FROM(0.00)[bounces-226920-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:mid,juniper.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF0792B310F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:37:41PM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> In mp2869_read_byte_data() and mp2869_read_word_data(), the return value
> of pmbus_read_byte_data() for PMBUS_STATUS_MFR_SPECIFIC is used directly
> inside FIELD_GET() macro arguments without error checking. If the I2C
> transaction fails, a negative error code is passed to FIELD_GET() and
> FIELD_PREP(), silently corrupting the status register bits being
> constructed.
> 
> Extract the nested pmbus_read_byte_data() calls into a separate variable
> and check for errors before use. This also eliminates a redundant duplicate
> read of the same register in the PMBUS_STATUS_TEMPERATURE case.
> 
> Fixes: a3a2923aaf7f2 ("hwmon: add MP2869,MP29608,MP29612 and MP29816 series driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

