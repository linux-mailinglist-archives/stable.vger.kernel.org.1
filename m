Return-Path: <stable+bounces-256589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPKWDBppGWqrwQgAu9opvQ
	(envelope-from <stable+bounces-256589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB4600BD8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDFA53043F96
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B227120D4FF;
	Fri, 29 May 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="e2KAPrBl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C313C3420
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049858; cv=pass; b=cZNrhRfTFwPFIhDVK+Vqrm41yFUJs+H4H6/rzv0uSKyMcBNtmSL2TPs20pitZJjmjjjMb3juFdSjjI1kjVLdl9AKNYw8Ql0ceLHm8HekbqSG2sx/2lPUlVF4OaYFyhJ3wmdmP7iy0oz1A2RxqIEmGP0Nmem6VvTkYP0NiPe+gdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049858; c=relaxed/simple;
	bh=DdoSdrQ+89tESFM1bFydDaaZ68yxYAOFRLyfghWWbMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acgHC2VItbPzhnMaV0iTan2DvHkp5SzLx1bcf59Q0A9hJUtjKS90ynNGyWc7U4sBF37mHzHqHOf0w0604q2DBHWlGi+5ldxPpu7vyBqnaCtYiA7gdlfO9xAyPcYKy7a2AKqGAlXb4n8pfvyD2SVWksOzSZUZxJIY2Q/0nIgyWv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=e2KAPrBl; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bcceb394417so1679898266b.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 03:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049853; cv=none;
        d=google.com; s=arc-20240605;
        b=cyVi1YU5u2hVM5k/z5ukVk1jiS1op+Lm89BtXwDMkY6jU2qPnISeRWm+V5fsBb1roX
         +GZHZjq5Q8vkTdcoTZ1fqzaZNyzDRo1ZdAuV1FrzHwi6txL0ZTvLCdoSjQP3SEhyFz5W
         bXr+P07lIUbuf6v+udz/6AhvLKphAfJbUVb37y5LNvABJ+Q2Dll5E6u/3Pz7zsM1a8rJ
         rZKvyieyWI+d9C44D6Sf/+Nx+FBTvCPezEYhS6f+6K6yWq0DfCghwgEhitaLdezZfjvQ
         DIP6akDpNZra0AOmmtH/J257yqbtsNVJwn7O60zCTKY/hafsHUaaIYAUNVTAalgRVt2Y
         6FTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RTuQXj3d4ekOvv+GEi8JE6sp9274elScrD+Oea8c6fw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Qw+UT4RFWxOKc/TBo+pYv+J4yKw6qWTi/7HvZhjHGhVAS4+gnFfMrhnefRaIvxyRpL
         Ki86aGdbI5SVJD64ddErpLtuWEqYMHCU8bKQ2rbqOhveBPXhx/NQ8jIiDrrEoyNb3lqh
         BZiR/zOn0CLt3rTRNDUpnX2RO4WEu0yfH1nU9DbNQkkruUacuXD4r8f2fAlA1BDyWdoY
         Pfbdcp+jXmfBCZ539o9kCWQl1r91HkzAmkbnQP9UafRpW4WdpIwI+lCNQo5VP0CyTRRl
         rbC3hKlQli/Jvo+yRlZzYj7hBK5wl6V9hS+pCnqwF7/c42ndQq2tv/NBWiv9LE0Ylo9D
         l0iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1780049853; x=1780654653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RTuQXj3d4ekOvv+GEi8JE6sp9274elScrD+Oea8c6fw=;
        b=e2KAPrBlzkuy57mX19o2/Er0ke0ZZPju0vymI88/UUK35mv+5Xk0fWzbivLpsotbY9
         k/BGIBhKJyaBVO5YICbBBCbchPwjPVojwAmmOtNwQXOZhZBYJOqDZY0VUmFfFjuAiufb
         rk21ClxomhCGVsY7VQWH0nOLBtBXwhkCI4j4HpA1Rng7KoqqDdYZHS4J7aXk6vupjHMJ
         rwhI1WXWG0iZo1rMZewMPrDYtoDOe217vKxs1cXYRb1oLk8aC+j7U4R48kvM1pHcjaL+
         ycS6b28w8xzrzdhKtrDGgEg5snCShf2gxwW7x7Jwm5Xpgs58+LFN2yfjGJmtyt60GAr6
         gphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049853; x=1780654653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTuQXj3d4ekOvv+GEi8JE6sp9274elScrD+Oea8c6fw=;
        b=g7cjm7hll0U0mVhHgqg/l/+IlNUKQUrH71nJ4GPv33lCZ4/vqn+NS7f+kvwB0hJaN0
         P+vCA9ad9F8oM6a1QvYFvnX34YMUHZR8d3RXqWUWBeZ0Qyb8T+IOZWEVpV0POejCXQtn
         97dNsbf1zjrNx0ENP5WyYCt6qoQNaBMq7MNpRLWbeGk+k7eFb1PknTX4qWmxZQHg+JG4
         m85YA2+DEsF60rjJTGLYepwUV1EGYWLiq6rF3ac/NbO/cVJfrNUcMFfbyXjbIz1azCNg
         1eCA000bwJ/PeaxMM932Ov3dNxtEsLsuNLSigAORnhTdc9Xcn5tYucbVTPGJpIx5ZBtL
         eXLA==
X-Gm-Message-State: AOJu0YxuS0D2UaRJJ9hvR7CckEMjVdnbR85Qqqi+kUyQIvyhe/oCgWqJ
	mqs/eR8bG3vSH3n21DYmoFT2Xoo2hMMmkKxCfNmRltX4cr95iPVYirkURCdXG0xTbFxlRF/Kq4s
	Dwc6Ol4hkT4XxgZHsmjnd2idxcRznFX2CXMUn+kA11g==
X-Gm-Gg: Acq92OFROkX9YplP49wbZFQyTneRovwm7dBnUl+FUe96QBQv3cylE63kPYZW3OkbM5T
	XL9h02N5hBi9FTh+kDvKBIvfPoHJuo3JFKOYfkhAhzY5vPhlBvWIOCU57c478fQQ46lkAkS3VYA
	bXZazIk5TpBMnypSDohvq45y2ZNx8PM/kiG8Xf567JL3Kg6kEyqASu3YCpDi5tyPyK/MlYlvu/K
	+9M2J4H8BpdU7zSIncGSrG+WxHizr5aHa8oAQ+JselLPr1xIEfJ98PP0uHvNN0mbTyA2DN+ZB/P
	b8Rwy+PXS4F/0fELx7ZnYn6V7LtuHA3ZPeWMaFVFSC18zs4AMy38e3ThfematuRRG2Eo4258bOW
	HH1Mp
X-Received: by 2002:a17:907:7b82:b0:bda:2929:6f07 with SMTP id
 a640c23a62f3a-be9cbcc7e5emr118816366b.45.1780049853340; Fri, 29 May 2026
 03:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194646.819809818@linuxfoundation.org>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 29 May 2026 15:46:56 +0530
X-Gm-Features: AVHnY4Iw86EbGmfBF3JCXmbOjYb0zoxBSO5fymJ1DtO6WDRAQAX9g5GxBs0O2S4
Message-ID: <CAG=yYw=T_fXbb+a5T0ot5rZdJ-Ph3vXnfR4bUvJ3zRUiq8=t=w@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256589-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rajagiritech.edu.in:email,rajagiritech-edu-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 86DB4600BD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 hello,

 Compiled and booted  7.0.11-rc1+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology

