Return-Path: <stable+bounces-67719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB669525B4
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 00:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0E628222C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2A1442E3;
	Wed, 14 Aug 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WUqBU7c9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA012C484
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674625; cv=none; b=Y/r2Jd561Yg+3g/OXgxu31gU8igeyxiPlFUbqwG2w9uykngKSTx4rz7jEftNpO9vUEy2xwI/luXuIDE2q/QM9a/BaEiPIpymGU/rHR3k4LrTIi0+FcEYAmAq5IAhPv6h+wgrUHfXk2G2YO1CAGBO6+KxL+dd9aTfl6FUCVTxDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674625; c=relaxed/simple;
	bh=lMzMmu7/geMeGZ+ITURZhEGMgIJMB2wbKSxaJzA6Xxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiSf7ujdfg1soLzfyar+7e6EaOMRtIFACoPaSAcv386WGSiaAUZHdnTixD/HTQ2SGaNUwl2yaRijW5ATCAUUs1Ax6KIz/5cjP6v26DH91yXmAL4cAycle9bV3UycrfbCkBsGt0HuCIEx80Cr+4unDF+eLETGA+qAKrn97A7XOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WUqBU7c9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd640a6454so4135155ad.3
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723674622; x=1724279422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYU6CxH2Uz2B/FnYGmoLWU4ESLYRFSEUwvofd3Trumc=;
        b=WUqBU7c9pFQG7X4yMlkP11Es+UmGKVYmxfUnZP4g5Lg+h7bZP7ph+QsO/lPBKESgS5
         6nfITQ4d7my8YuoXcy2H9YjUfok7FRWDobRHTdpXJUpYi3A22gSThcLh9fNUY26RJjVn
         srHz3MCwlsaOMG8urjthzSypes8374yNTjNbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723674622; x=1724279422;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYU6CxH2Uz2B/FnYGmoLWU4ESLYRFSEUwvofd3Trumc=;
        b=soygpzNZfrdhXMJVv5MC9FcEXIExfCpB/bKgmS+KNxEBdejBgf48dwcLQwp1qqsPhO
         0nVMWAjCTqLnRGCXpB/xWq3oV7hHmwu8xG6X+oA66ENb4vIaIyOlTQQmFn0WB05O54i9
         uMwjCbmXB5byo5v3iCGb/xm7AqHuf7iH7UDWaqy8J5vkh+XanAcxyCS3JulJh3dosSGn
         jV+QaM0BugMnlreGBOTiZ38x2pNc1dnX9nXSvKMwODDCtpfsPVxwF4UFVhE6Kcae2Ymk
         ymv0Mr3Q7a5loXBCRwk5P1doPYho5Ud+hrNCfFeX55QbAXjCBVAvCEB4SsgT4j91VI37
         qYDg==
X-Forwarded-Encrypted: i=1; AJvYcCU+eB3bi4XkGuA7GvBdi5eXBFyPvUeoRricdjvbiyJecQQdKPjJW+frnIAqGGhcDiZ3ZTqQtQOrN1bkZkqDpkeumgpAVKv7
X-Gm-Message-State: AOJu0YzbtDViBtBo/psknFXH0WxpOOXvLSgTbFYQRsDVMluWsbU5C0Gt
	VFN5tGuZW/mwGxTimz7mzZpYEj9T3NbbHTG8Muq6TeIf2kX7zi/JgQTrgKhgMwnhgaUBWyWmRM0
	=
X-Google-Smtp-Source: AGHT+IEMxr3zez02t+9RoMEBcsBOwW5JyM2yv6F4Th7Xc3ZptqlzM6/Ic9lOR9fLBY5UTNn7trkoiw==
X-Received: by 2002:a17:902:e743:b0:1fd:7097:af58 with SMTP id d9443c01a7336-201d638df2cmr49857855ad.11.1723674621766;
        Wed, 14 Aug 2024 15:30:21 -0700 (PDT)
Received: from [10.211.41.59] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a3607sm1162755ad.250.2024.08.14.15.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 15:30:21 -0700 (PDT)
Message-ID: <d9f35bfc-e0e8-4470-aea6-33cb29b06e84@broadcom.com>
Date: Wed, 14 Aug 2024 15:30:20 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com,
 martin.krastev@broadcom.com, stable@vger.kernel.org
References: <20240814192824.56750-1-zack.rusin@broadcom.com>
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Content-Language: en-US
In-Reply-To: <20240814192824.56750-1-zack.rusin@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>

-- 
Maaz Mombasawala <maaz.mombasawala@broadcom.com>

