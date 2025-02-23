Return-Path: <stable+bounces-118681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D249A40CE2
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 07:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0C43BED33
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 05:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99EB1C860A;
	Sun, 23 Feb 2025 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="BDKiCpJZ";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="OG7RGScJ"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF528F4
	for <stable@vger.kernel.org>; Sun, 23 Feb 2025 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740290400; cv=none; b=mh0JZQ0j6CrX4+fULl5m747Y9jd0+AQVMVqX4Pn2955tTdJJKauQD/OIDTBID3qJxIFbrLe3qc5j/dZ2tRwFHO7XXNzXax+YIfcYlUJ/4bHcd1jRgHKjEFGb3L82rse0TEY1DdWPskXIyvU/bIXBM0uDCKu7fulJSeYSg2PtErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740290400; c=relaxed/simple;
	bh=fj7RisvRvN/Ru1b9MEQfvgWitMFnjkTjvreUFCCxdfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwN4H5phY5shzfIGntiGiua9hvamQRQhP6n20aejtbEUZeeujBIoqDHbp4jun9JWzGvcrmtQ9ktOidunAiTl99oL/ivXp+ESXI7cideLfr9PPPLsR6ucWQfujzs1H3xoFR7VKXR09gLtJygZFLGRpPIeSIZ59j9C6gOV3VlfgnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=BDKiCpJZ; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=OG7RGScJ; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=tL+mVeQMxkFXhPRf8l5PyJu7sCPJ52EsfXLbcrTR+QY=;
 b=BDKiCpJZcHVNtp9XhIZUjCzWBmNxRliQMBGWvI4JMHvuxv1LWDeJ+MxP/hc5OP9+gGr6H7POsveQG6FYx7O6FDEGEll8LRjmos1viL2GVUI1yuxAqO0aBmvC9aRK0FmNPDhvm3CdwOw9od61u24oRhJ3jpK9q9aEyQgJuhKSX2uby/W4iDl2cBmwNmZwFcJYXumd5xeAgPTJ+4rd33dfYhfrl0QKxuhraXjW1w1y/M75NQkcfMWBu3BlC6qaLmdmL48isPiMSYmeGfeqjdy3cIznWW77VYg4qyZFEIchgvi/8UtTMNVmihQo2Cm5K/dNJCl/C61wk7GtK9cggDm/bg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4A409340061
	for <stable@vger.kernel.org>; Sun, 23 Feb 2025 05:59:50 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-47220fab76eso1648651cf.3
        for <stable@vger.kernel.org>; Sat, 22 Feb 2025 21:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740290388; x=1740895188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL+mVeQMxkFXhPRf8l5PyJu7sCPJ52EsfXLbcrTR+QY=;
        b=OG7RGScJRnYQGBhwXGz5eDRRr/yj4bYmojxWXwesOfPpoeV0i4m0ePKVHYL6RhwQj3
         js+TGB/nxMRX8Yt13VKmSNcWz3Pp5eoDSeyVpvt4E0SqO8kXagoJPn52LPDADckyYX0G
         qqEA/SoZa+AKkc7+G2QBbEzyRwqw+Wi/HSed92bEDX2DjrO4MGM7YfJTDq7JzmhdyvBw
         VfCYHWO7eBAUvSLX7Wy1wjzWqyxdibsHDVz5OR5ywkt1T2KMQs6s0Ys5kHMsj/lsQgdR
         yNRUmcP6Jz0Zuh18N3PFe90+qSjMmybZJFG7kiO6ljR9cuiWhcUaiLTwlyfJsGJn9x7R
         U2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740290388; x=1740895188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL+mVeQMxkFXhPRf8l5PyJu7sCPJ52EsfXLbcrTR+QY=;
        b=iTIJPnwElhFlsHrL4/ZNk/HsqwYzWpa8/qArocI1zPh5sz0q4Yyl7MYw0Xm0mrvcli
         ZpScVMi1GgUzJiZEXdRbTIPVxvddFUua6OrRH6c8G1NF3YUiYCMWHqsQA2zAB5S7lRr7
         NxBzOA1b95cvaVu9m5nHM8UHF+LjohgqaqY0AWKJ9aMsCWksHJ0CkovipkXbyM473XUI
         004SaCUdPCksl9FW5x01r9iM2dvZm0N8YoVolzM7A621Tyfpodu4OSqEuVLQNYj8WKsP
         /1WbPC17n205RDZEJmR+3ePuij4msUPz/ZOFrIaMaQFWnSzs97TGOw13ijlLlC5Rrv/W
         khEA==
X-Gm-Message-State: AOJu0YwmjY/Ph+QZU6e+KwQdapAufl/B9+fslf11Paz7Rf4SXtwmLhRg
	JlOupSbL6BqLK/eWo1bjJRXQ1Lj/1Akj5QEnyP/3Pkg+Bn1X6YiUz3p+ZDRnZjI9ijwVhPR4FZx
	T7q7ANFBgOu+7nrz8Q4XcAnLiLbNcaaV1uq06zUSFlMween7HNXbNwETVH6OibTPfoElmLii2g7
	nZ7hl7dQo=
X-Gm-Gg: ASbGncvaW8kLujImYQ38PpP1MoSF3gJ170wRpl/hzmNNpw0qb/LBOPbEt39+9HtKtVK
	1v5E904NWfuiFIStkotqDOoe79Onr5jf9450jC0D+ePSVV2D7hiOjXhJu12RmTL/1lyG5gG7HL0
	NKwyU5t2R372oFsQyevFg3CsZAJCb5jNzRAFSI0aQIC9U02NREL+xONiNoaSS8G4RkQbFk+aM6p
	mb7mLdBHsFQe3lUpQipjbp4kJ/TTm8B3Z3QoQesm69olMf6/oBE4+u6/Xw7yfiO7U4+MS04p2mV
	MVxjC5rNsBU9BDq+opFEmJG4nhJ8VBd+A19xbydDfgO+o4wKIrcE+CPiKp0RKCdXUmSVKU4zAzy
	j+B4=
X-Received: by 2002:ac8:5943:0:b0:471:ef27:a313 with SMTP id d75a77b69052e-472228e0cd8mr132522311cf.23.1740290388337;
        Sat, 22 Feb 2025 21:59:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHobZoEPNEVbzAjy+6qRcpI57LJnIrUU7nIRUOKBrAOd5qMdLhrdrimMqYyYbwOoH1p1MYTJQ==
X-Received: by 2002:ac8:5943:0:b0:471:ef27:a313 with SMTP id d75a77b69052e-472228e0cd8mr132522181cf.23.1740290388021;
        Sat, 22 Feb 2025 21:59:48 -0800 (PST)
Received: from [192.168.86.23] (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47207d1dc11sm53927831cf.6.2025.02.22.21.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 21:59:47 -0800 (PST)
Message-ID: <4569fa6a-cee5-4499-964e-b1e9e1aef474@sladewatkins.net>
Date: Sun, 23 Feb 2025 00:59:44 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please backport "drm: select DRM_KMS_HELPER from
 DRM_GEM_SHMEM_HELPER" to 6.13.x
To: NoisyCoil <noisycoil@disroot.org>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de
References: <bfd2258b-9bbe-42e6-89aa-1bd77a58983b@disroot.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <bfd2258b-9bbe-42e6-89aa-1bd77a58983b@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740290391-rBDwgWUCl4b2
X-MDID-O:
 us5;ut7;1740290391;rBDwgWUCl4b2;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/22/2025 8:20 PM, NoisyCoil wrote:
> The build (actually, linking) failure described in [1] affects current 
> stable (6.13.4). Could the commit that fixes it in mainline, namely, 
> c40ca9ef7c5c9bbb0d2f7774c87417cc4f1713bf ("drm: select DRM_KMS_HELPER 
> from DRM_GEM_SHMEM_HELPER") be backported to 6.13.x, please?

+Arnd?

-slade

