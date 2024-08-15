Return-Path: <stable+bounces-69262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99DA953D95
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 00:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5F11F21A63
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E1A154C11;
	Thu, 15 Aug 2024 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GUWZFXJh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A18154BE3
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723762332; cv=none; b=pG285m8LenQ1TuLGKaeNSV5G5wPa6bcoPYPkOrt3UxBs5RYRrM2PGhN/bLfO9bX1ovRqK9Afyrs5RfVfWRZbSTjHru9RiUCXmx8kYCay+O0Z5PnMyHRKiQYq1G0oOlz1FP8v+viusBh7JJ0TY86m46tfSSdvRqvUzV4gxmeHdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723762332; c=relaxed/simple;
	bh=lMzMmu7/geMeGZ+ITURZhEGMgIJMB2wbKSxaJzA6Xxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMHjOnBf7o2/4EzvCi9K0rsjbpg05Pk4WOgWg/utkzS1G5sbfYZ1bgQ5H9UV8Z4N9LnXET0nS+WCfBDlodLCXKnWSGCfH7KRoATYnujszUn8/vuIpbWI7gX8THdAKutbq7eIqTmXFYvPvwBiIPELrddfeoyqZZZfOm8eXXWtWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GUWZFXJh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd640a6454so14416705ad.3
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723762330; x=1724367130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYU6CxH2Uz2B/FnYGmoLWU4ESLYRFSEUwvofd3Trumc=;
        b=GUWZFXJhHiyEfCgnZS7HW2ZsG+ieMXgSIKcSWpNEThp97JLsxOjCI2QdBO0aSBjthJ
         /b2Qm4X/JuSsUf9oLgoM8S/1ius3Dsyd69fOxKgXHs6SsU0zUHJx8SvythWX9PNJcdZ0
         E238vqc5dmU66qENZpaBBJj0yVjQrXYykaZEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723762330; x=1724367130;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYU6CxH2Uz2B/FnYGmoLWU4ESLYRFSEUwvofd3Trumc=;
        b=rcbMolM7HGp0VMErbf+OoFKr8WcnJDK4wn7MJqQRWnceXPzqCwatw4mvAzbj8HXxwy
         MGnGKMoPAKFSjaugRwuMRuOoCbK5LfHZXsir+WKaIljW9AYljHNXUigbgp+NdwusuwKy
         2xNIRKwJlpgOQhH29iT+u5jsA8/3DczjQlFZWjUpPrfwRfl9GdxVZIg92VWvNgQkejJs
         ND1BT/MIdwyu+XlyGSTpX7WDLD+IDWXKmCEAGYG/BcqRmXAFAgMkXFtzeBKKVU1qZQDW
         OdOE5MY32X1iH9y7D5oh2vR7fyEf2IJdQG3IcR6MslLFVnmVB+MOCncHGok49K1aFB8z
         7nYg==
X-Forwarded-Encrypted: i=1; AJvYcCVRNYTW+t+157TbgtikVV6L9UgSxfww12Ecr5UvrWJKYXqc9/gp4llIuGAELzVT38ZlVZqMNDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvkHQhIOg3VOFp5qx1XrkMWQwKhKQLsrsPgsuJTxRjAs3EhUNN
	LYN3fmcbGHlK1wCKORcKIb4KDQDa2puSFstTrtZnrc3k3Z3HbBC9xudmEwBrXYEkGZS52aLhUNQ
	=
X-Google-Smtp-Source: AGHT+IFoXzdZ0LnPXw0CcmtZGwlL/hYChyGfUbp5CmzQ2zLtfbvysoQzI7hzeaFAGMMlFaW4C+dQIQ==
X-Received: by 2002:a17:902:ced2:b0:201:ffcb:bbcc with SMTP id d9443c01a7336-20203f082bamr17668265ad.39.1723762329798;
        Thu, 15 Aug 2024 15:52:09 -0700 (PDT)
Received: from [10.211.41.59] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f063ab6csm14750485ad.77.2024.08.15.15.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 15:52:09 -0700 (PDT)
Message-ID: <90fb16f3-f9f0-4541-926f-f4b620f3d5eb@broadcom.com>
Date: Thu, 15 Aug 2024 15:52:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/vmwgfx: Fix prime with external buffers
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com,
 martin.krastev@broadcom.com, stable@vger.kernel.org
References: <20240815153404.630214-1-zack.rusin@broadcom.com>
 <20240815153404.630214-2-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20240815153404.630214-2-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>

