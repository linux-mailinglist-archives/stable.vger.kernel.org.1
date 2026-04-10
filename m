Return-Path: <stable+bounces-235634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLgLIB4h2WkqmggAu9opvQ
	(envelope-from <stable+bounces-235634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:11:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A23AD3DA264
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCD4530C3793
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80863DBD69;
	Fri, 10 Apr 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPWiWOoi"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477643DA5A6
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835078; cv=none; b=f5sIdDubsHOTA63R6S2tWdDOBreew8SE+eX62ILLaibcHVSAd5s5kMod7zaPzne29GbAidVI4aZ0TFthJq9VGRoBIzOj3zVVFEXpEog2GEExf3XqOg04IRRXTNklDEDhEFpq9RGB95j2eyadoXbXRXijRwj6izgq62A2PPHyrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835078; c=relaxed/simple;
	bh=ymqpIN1RZy9bvrx0CZk4ryXQZ43lJJxuI2y3U442FRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJOwmiV27oEsK7NnqpQK6yeGPr4YHhc4Nx1XTjGFKFIGyGIHUy28vSARlrcV6q6uWw/nWtU4NgJPBo+qI/n6BNC9D8ex4dzNer3CDe4169v+i7LLvtkQYf9ShoUVf1qAhBb++I4nANCLSthJWzIUH52dRmlJhFj0Iv2IT8fltrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPWiWOoi; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c25b90264so190413c88.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835076; x=1776439876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLrdRwNV2I6dqfO4+G4/OGLFyZBRBOJlZXwsNZ6t6Js=;
        b=cPWiWOoiaTNlwtNENoxrH28nV//kgJx18yX6aq3GNoBNd7KQ845fkt9DjLGgQadXCv
         6S2lygDPM6LBU2v9pZji7pA4pl0DAehUnewvtRC4qZ/N4C+EGJBzYFZzhrC+Qwt2dto1
         QQqH5HxbHWlljtXa0ePCQC3V18sgsgWSuQwUao+x4ZTMCHC4W7v0D5A4Q7vj+ehRZh66
         8RsRttOeEHWdDLoK3wTejRajYfENqi1tsrCoelT+rIVsiSoDRXBc2dWZkf+vvukhIW1X
         hEkSEmKEZlmRD18w0EuDAavCXHOFYp+JJF/kVfw+TOBa3kcqPV5S/wPMUZouWrDW7tJR
         E9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835076; x=1776439876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aLrdRwNV2I6dqfO4+G4/OGLFyZBRBOJlZXwsNZ6t6Js=;
        b=ONhqWHH1x/DEbOoVRFnfZdkxfbQBSORnEzzntnRiprouk8RD+xAZc++LChUkefc7KW
         lYLMTX/ivnnOYMzIeeycodYUMXhdruFwWEfBxs+4N8aIjhnZ/pOrd/fiG81TB6SM0lVR
         zr5DOexmKm+/XdDz4iL5yfOuaVY+iiNOIAyxYmbszLaGom5ehf7jKDy5VyYgCzpFFXlv
         BD6/GNOWWmnK+9xfAloulDdKtImqte/0w35iNOLWOBpWoDMbV8Erky3WsvzkaUh1MhrS
         yO3kU6nh5w7pubXkmJBe0kofDSkoSbVWWMHax3lnW1/DzVUM8ygEfNU6924UsW9eQe1A
         dNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6su11EA7+R1w1Jf3SldjTsfkIyNTlfSH9HaYDWq9iamHC1aCneH/b0TjDkfJNljn1Mxg+8uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrTNVK2lpdr9LO3t+gAs8w0HEKEwMEuz5E7SpEyHKoq3tOp5Iz
	i6fXgTpedS+II8uY9/fj9oWZQDOkKw7JEMG7AgJCXkR6wOUsjXsd+Ice
X-Gm-Gg: AeBDieu/DoNuucVXJVaQRFSsfyVQmlRxXY/fTg4TSqksFuZYAqMuLYJlW7aUI2amXvp
	qE8rhVQq+ixDYgrDJ6jikXvmmNOiPRKNKs/egyDGBd1YrOm3dHC9LLEoZw8HPdAxhDrbQFU+HBL
	nbkeBRHKa3dWJxrZUo2MsF0evY5CW595AVCne7YDEvL1ar2SaNZ04CIOyVMoO/ZgOnm0+YZRi4z
	yILMPgmTsPmiSsjUqlhAfr+nm0fTr0hZm6Ku+qS8e+Oqs9x228h81r13l9cAwF8sVZmQ2yuWCgn
	PbnPU3ZuigX8ta3vRQwmYqA7DctQZwVMcF3CIMjYi1O6hdbOqtp1h8zDTJUVokNZMG5o+UhkCos
	UPJUMdUbefQ/P+2ri4S/2Qq+Hdd6x/mbDS6uaDqrFITmBxoezB5Tv7QFeB2vtApxlY+RfB4hSaF
	rsjJFTSiZi5UI/CNEPcEx81ZY8nd89XhMO8wHV
X-Received: by 2002:a05:7022:112:b0:128:ca6f:adf2 with SMTP id a92af1059eb24-12c34ef263bmr2427626c88.32.1775835076339;
        Fri, 10 Apr 2026 08:31:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm3690760c88.0.2026.04.10.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:31:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 10 Apr 2026 08:31:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sanman Pradhan <psanman@juniper.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()
Message-ID: <3dc5812c-1ced-4fad-82e8-ece32a30b9bb@roeck-us.net>
References: <20260410002549.424162-1-sanman.pradhan@hpe.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410002549.424162-1-sanman.pradhan@hpe.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235634-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,juniper.net:email]
X-Rspamd-Queue-Id: A23AD3DA264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 12:25:55AM +0000, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> Fix two bugs in pt5161l_read_block_data():
> 
> 1. Buffer overrun: The local buffer rbuf is declared as u8 rbuf[24],
>    but i2c_smbus_read_block_data() can return up to
>    I2C_SMBUS_BLOCK_MAX (32) bytes. The i2c-core copies the data into
>    the caller's buffer before the return value can be checked, so
>    the post-read length validation does not prevent a stack overrun
>    if a device returns more than 24 bytes. Resize the buffer to
>    I2C_SMBUS_BLOCK_MAX.
> 
> 2. Unexpected positive return on length mismatch: When all three
>    retries are exhausted because the device returns data with an
>    unexpected length, i2c_smbus_read_block_data() returns a positive
>    byte count. The function returns this directly, and callers treat
>    any non-negative return as success, processing stale or incomplete
>    buffer contents. Return -EIO when retries are exhausted with a
>    positive return value, preserving the negative error code on I2C
>    failure.
> 
> Fixes: 1b2ca93cd0592 ("hwmon: Add driver for Astera Labs PT5161L retimer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>

Applied.

Thanks,
Guenter

