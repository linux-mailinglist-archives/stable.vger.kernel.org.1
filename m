Return-Path: <stable+bounces-28123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608287B926
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BAB1C20B88
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78F5D484;
	Thu, 14 Mar 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dal8jdo/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9965D480
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404074; cv=none; b=HMRjpWfQbQloZOcQ2lFt5NldpFYfrmLuh2vvuFGkmVN5a76ZnLCK0hVtlWmogLV8nyZr3jnrWVzRc82G7zPtY1bg9GQ2leB6aqIGFxSRqtHxVqlmP7/jEmkfgR+3adlOicQT/UD2M1+qDfXZhA87TfWDyEhyRv272KU+qkv/3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404074; c=relaxed/simple;
	bh=QJcurDhlqhd4YFgGB61xiCI0XYfhBFKhBVehMdnfow0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKc253wbf5ZBwVdmaMuXXzantjD8P/hvNqndO2F0iqbeE/lFcJyiE18YZxQ/3GTgDTGMcV+j/WarCuOEU5HW6TLoa6EzFWUx7UjpRqyxI2j67cBvNzXkKJZIqhrLu+AxCFTd3VkidesYNDG/y+r2PNjsCkAcHlPoeT55rBMThFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dal8jdo/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710404070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5BKMxqgK8DcYP7YR28rxy8fp44suCGcVHuCxmOCymU=;
	b=Dal8jdo/0zbxDQFO0Lp85D5mM1l+SwIZvp2gHI1WCMAbOC9wBOzqma1VFabnLRuUX7F+ze
	Li+FUBbm37qaevLRa89/0Rcu7umLZzED85VSZIob2QY2qtYPtDWImc8rwblMm/sHqId+hV
	AqKVCh4NGn7gNTSto1VldELXmWObPaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-LuaYna7SMVud2RottWgX4Q-1; Thu, 14 Mar 2024 04:14:27 -0400
X-MC-Unique: LuaYna7SMVud2RottWgX4Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41312565bd4so3489595e9.2
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 01:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710404066; x=1711008866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S5BKMxqgK8DcYP7YR28rxy8fp44suCGcVHuCxmOCymU=;
        b=OoIU2nRElliqmRO0kzds22SVioMLDBtzwfQp4Cdvo70YduyCmKoQL3YlvzPX0Jtewp
         w84t9oNU/fn6rCLJUnZdaCGVFrVvkCKjCBrt/Z5kWnHCOdPNXABIxutE5vKhifi0WPvv
         w6TwkrtMKYiuNpkI44/hweWeEHUJcSEhBt51qFJgaIGjHGa9BBLM/cDEd4hBUowXUwE7
         kRGT2i/En8bqG5lmr9ko5hTFvIyLQDDHDgUqwuP1v6GJE4FORoU3+NMa/srIPMQi9f3O
         yQ99EOWAPfYXVeLmjquz+kejMTxz+67jDBM4V64jPA63CXzUJVFISz0TDtCHCY6187E7
         9ccg==
X-Forwarded-Encrypted: i=1; AJvYcCUWyw0+4TZXTtrit+ChGAYbB90P5hPv8kq6KTV0UAku84ElkMTMUDHl/bI8lxyj+Ejm5zCdIIYI/ylVgZqdkohLTtJvW26a
X-Gm-Message-State: AOJu0Yw//8gzUZqx5KfYqCeSRTpcqXL8aDSRlgYP8vl2d0IeQWNKfLEv
	G5S4H8FBTY5Ui2TafiAvuCz66Cfir/qE3nn0dR01ht2ypjaVxsecsBQQZg9xnHLCzclq/MZZ4k+
	e2WQHUt1LyBR9L1ju/3Cd6k/syztztlz1q2ALukjUcSnY+WySz4owXQ==
X-Received: by 2002:a05:600c:82c9:b0:413:e956:6893 with SMTP id eo9-20020a05600c82c900b00413e9566893mr1004021wmb.41.1710404066765;
        Thu, 14 Mar 2024 01:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+8Dpw7ORtoJWMmvhFrCQjByB/znNGYlVHAzzlBWehAOxiErr8eo03IZPpfW9sVU5/VPvdjw==
X-Received: by 2002:a05:600c:82c9:b0:413:e956:6893 with SMTP id eo9-20020a05600c82c900b00413e9566893mr1003998wmb.41.1710404066469;
        Thu, 14 Mar 2024 01:14:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b00413e8df267bsm1596777wmo.48.2024.03.14.01.14.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 01:14:26 -0700 (PDT)
Message-ID: <0e1ed380-a25a-4a57-9395-56a13bf298c8@redhat.com>
Date: Thu, 14 Mar 2024 09:14:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vmwgfx: Create debugfs ttm_resource_manager entry only if
 needed
Content-Language: en-US, fr
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, bcm-kernel-feedback-list@broadcom.com,
 tzimmermann@suse.de, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, daniel@ffwll.ch, stable@vger.kernel.org
References: <20240312093551.196609-1-jfalempe@redhat.com>
 <CABQX2QN729DjtdOzAS9jeEP_xHXT4zNaOcP59pa-KyXnME=xaw@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CABQX2QN729DjtdOzAS9jeEP_xHXT4zNaOcP59pa-KyXnME=xaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/03/2024 18:57, Zack Rusin wrote:
> On Tue, Mar 12, 2024 at 5:36 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
[...]
> 
> Thanks! That looks great. I can push it through drm-misc-fixes.

Thanks,

I think I only forget the "drm/" in the commit title, but yes you can 
push it with this small correction.

> 
> Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
> 
> z
> 

Best regards,

-- 

Jocelyn


