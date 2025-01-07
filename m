Return-Path: <stable+bounces-107849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C5A04011
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F07F3A7271
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D91EB9E8;
	Tue,  7 Jan 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="oAAdNDJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5091EF08A
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254579; cv=none; b=NVyy9MZ3OvTHmgJ9E8Dewxp3uGuNzb6nCn/6ik3uBt4pakUsMpM/kmBn3X7wnYSt3gghXNntJ4ZwmVrGhVsaP/KR4K/FekrQsFhL8N0kQDLs9WG5Is5weMU/oifFejNPljrOUXOemumyP+lWt9563dz1woLyMoTmGLeOMrt9FVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254579; c=relaxed/simple;
	bh=mhjI5XJs+wlmeptweqROi6JQ9QOeOFdceKqB0fLjzng=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jb/TuveOfyRBtrSg1XNpmrq7jzvORs9H73ucWbDIdh/oqidcSPeqytw97eNqixR530Fa3aJLHWG9WGmSAzMRVHtGDABRt9qpAbcjgokPmz38k89eXqvpNwlXzaeWSnm1GnULaHfqApRiGEG0UHjpgMj63zC73PCvbbv2hdX0DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=oAAdNDJE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso106799195e9.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 04:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1736254572; x=1736859372; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3ZCQbwToICSm537L8Sy2gP7aNDk3KXPLLCsJPGfnhw=;
        b=oAAdNDJEJ8VtwnjbngputK7jhZAlRPGLevRm47nr5NWcX4W3pQmbLFrSLLL2pEbRue
         t1nHYeufDY0YIMmsDoqKG9r8XJw/03JMsfHIZu1tC0x3paVyDu1DxydjzNuR2PXsThCs
         zCZr0ubOJsetBrE+lMmnMNC9keQjqzGxLB6Og7IHc5iF/tmvVlPMpaB4ZtvnGtvp92oR
         j2+iYg8RsiNrBUL/yLVmlapCgyXtqN1dJpuTthIbSTlelmM3T2MznXakUDsp5vyxFQY+
         hJ/ojDCeHk15UJvDatgAO13Up6/n5hpJefqI/1y483A14q4SsCX8jckDlwTNlaODXEhy
         0JFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254572; x=1736859372;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3ZCQbwToICSm537L8Sy2gP7aNDk3KXPLLCsJPGfnhw=;
        b=eM647DlDh3WLBd6HB+epCD19HQ/Y/Elb8cAfLBxe7i/XTiQij8PC1DaVcb3yUd8zcA
         JHpYa3gImqRUkCOK0Puhnc7LFjQhTMTLTkrtYHZ3lMDrzukMwizC/LtKFK0wyMlQvA9S
         p0sKlp0RGNDpVcBaS34otvK9rhtRiU0IDdk5rBVw68M4Z22Not/kYfEM8SqIxQTktIO3
         JP4Iqd93LMOdTETnLBkruBWgU9OMia4yHwbfTK8i79hzzoBObawJyVEmlnr/LkEIW1Hv
         gJruRqu/VMb1ox51OaW+3PSY1jo339EZB1M4XE8fDzltZD3vDvuvGPFyZkuWKrlvbmhF
         hKSg==
X-Forwarded-Encrypted: i=1; AJvYcCVrPM7Pgq9I8jck6fRchCQH4231+mCkEEphOIpc79K5pXX8+O+sKgT+mORToE02d+gB3rubKTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5O97N3hYv32slWVU0yBi4gzT368S16bvdMFd4jPUq5YfsPFvg
	eycPCvwU8WWDR6QkeZecow9megiQD1hGWqOIFh+JKNgrMy3jDbidwJ7BexDVSW0=
X-Gm-Gg: ASbGncuEgjMipUk4cMlA2n9Uvr/eaCu8qL/ikg0ewHEm0rrbtRspH4OWz8Oj5/Z1DWy
	99mYqdYSJNG6IDmX2JtRqW4RMXj35ymB7VuR3T3rdFl2Jze9Q8kxZ1FqgypszWwjMd/od9DyZjy
	XtRMMwDB8H/Z2mC/8MHggFFjlXnC9JDk1dlL1XBinSh/3vRu0O1Alb0YFwtBDoNavTxXfLN6PYE
	Drpq4LjSwgQZo11VsjfRjGudAU1ybzJtua02jFDlEYR428wYHqfzuB219ai3lb/bc4fB0I=
X-Google-Smtp-Source: AGHT+IH3LnvvjrofmboXcdOA469qCM6U4NR7fF54KLrYPLcSCkDti2tVbLL3RQaJvGouHlnnaL3mEw==
X-Received: by 2002:a05:600c:45cd:b0:434:a7b6:10e9 with SMTP id 5b1f17b1804b1-436686462f9mr571258605e9.17.1736254572516;
        Tue, 07 Jan 2025 04:56:12 -0800 (PST)
Received: from smtpclient.apple ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a546e822bsm24831226f8f.22.2025.01.07.04.56.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:56:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] KEYS: trusted: dcp: fix improper sg use with
 CONFIG_VMAP_STACK=y
From: David Gstir <david@sigma-star.at>
In-Reply-To: <20241113212754.12758-1-david@sigma-star.at>
Date: Tue, 7 Jan 2025 13:56:01 +0100
Cc: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CA61EE6A-F2D5-4812-96D4-4B1AF3B8B3ED@sigma-star.at>
References: <20241113212754.12758-1-david@sigma-star.at>
To: sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 James Bottomley <jejb@linux.ibm.com>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>
X-Mailer: Apple Mail (2.3826.200.121)


> On 13.11.2024, at 22:27, David Gstir <david@sigma-star.at> wrote:
> 
> With vmalloc stack addresses enabled (CONFIG_VMAP_STACK=y) DCP trusted
> keys can crash during en- and decryption of the blob encryption key via
> the DCP crypto driver. This is caused by improperly using sg_init_one()
> with vmalloc'd stack buffers (plain_key_blob).
> 
> Fix this by always using kmalloc() for buffers we give to the DCP crypto
> driver.
> 
> Cc: stable@vger.kernel.org # v6.10+
> Fixes: 0e28bf61a5f9 ("KEYS: trusted: dcp: fix leak of blob encryption key")
> Signed-off-by: David Gstir <david@sigma-star.at>

gentle ping.

Thanks!
- David


