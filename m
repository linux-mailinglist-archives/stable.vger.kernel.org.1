Return-Path: <stable+bounces-125802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21AAA6CA18
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 13:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254D6880C08
	for <lists+stable@lfdr.de>; Sat, 22 Mar 2025 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FCC1BB6BA;
	Sat, 22 Mar 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxRdBHkK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80E7136E3F
	for <stable@vger.kernel.org>; Sat, 22 Mar 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645824; cv=none; b=kDUOXm+6ocfOXqftHpk1pgCwiFPXgn5dm9prfvWO0MssuQCiRWBjsCABLij78nqrkk9JNzjqSLZrwho02Ga2l7MlH/CyB1QCiCt2uZux+49reTye1U/JPfAPUudwyjx7P3lyENTW8YdNgbo1iNQkkbCaXBAyzQTG3EWPSv6j2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645824; c=relaxed/simple;
	bh=eVJ0RY7/HruE8y7lD8tIcRM1MGGUIGXHcoO2vA5mGxk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=R9xJ1qSqldCA/Z1hM81PfA0Bq959PhYDyr/ZDRwcDj9epSL/FtWz4s+Qo1vjSW/3y0U23mlL/zOOLvRj8m+Cxff/Y5U1Xwq2Wyyf1mTijnNnMnt+1s1PUy2SeqovrRYS+WTMsCMwczTKXJl80W08KHCKEqyg3giTbNrSbZWPYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxRdBHkK; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso4967036a91.1
        for <stable@vger.kernel.org>; Sat, 22 Mar 2025 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742645822; x=1743250622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ocw3OMdl6chCOpCo7WoYRuIutvtImxhwxOvvkDx7O8=;
        b=HxRdBHkKjhMRR9zqiDw1FU4ZrLeBFQ4hVLBfZpf4/gSFaH+6XSdl+ipFJiCVJ0XyUi
         akJo7wFwhu+Mu0vgpUOXwHJpz+dK0zRVOSedfxRDoFlRfc/4jVBc8KkyBkkS3bwWheUs
         okffWIGaflXI5Cskaf9vHUTVTdYewsLfNrD2CXWZmW6juW4tzIgGvf+4TGefI1CAOUBa
         oJeisHhdLGnHMvvP3r8bZZJcIK2TyTt5T1U3RtvAhySlpAuSULfU6IWTBZuUMg4snC1E
         2SER7RConmRawZhK5LxqIWHT7Tf3QvOst5yTIg0leGicdX3W/+oIIgBsOS2UtXLMRLz6
         WzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742645822; x=1743250622;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ocw3OMdl6chCOpCo7WoYRuIutvtImxhwxOvvkDx7O8=;
        b=bhwlxRGI9qYlg/p3G0Ni9oUh9zOhG6R9k0FNKpOK282fxI5UWz3ShdiUE0aBGLlE/V
         YE2t8rL85Clrale0bJNCKW/xoI58DlSsgaNo/gzDaWTRhw26U4E/eWF/bCy4GfwxfHb2
         eMFZQmG/aUls83b4S/lppezEAp9ydz8Hb9tQgS2wBgUd0lIswnHssBYW0AgztT5el1Xx
         U9jQW+hkByLS9BeKhbSclFFs4/kdef6eyhs8VyH5tLvKvNuMDrfxKX4M5tfigYGTTWA5
         5DUQFNwzBf4uIauqg0Nxn1fcZxBVwF12+BN4HJLevyvtWQoMjM2qXMg86gnqPiTgYDYU
         u4DA==
X-Forwarded-Encrypted: i=1; AJvYcCWv5TLhVygbsZuXmkQc9YPT6R8sXZk+4fuJxzqKx4HFB2U+ax524z+eg62j7al5cM2yBTPCcvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOTyHNEAXaqfR5ObHl7qEoq1cY24zIsOvfkqqhFW/WX2N1/wV
	9vTqZ8DZzANwvc1WPR5DSzIf2Pqm1ea/c8fPNNKC/0LPGNMOC82H
X-Gm-Gg: ASbGncsJlhg2JuboojkQTzFgVk+VKKOGPtCKyXej3XCGV2F5ltfrmZti3blNoXrqVt5
	eqQ8D24Xu7Z2+F9oQh8k90/oo2Xr95m+u5ePN5DYRqnGaYzfqtJn7Ei6AgV4e2OPwy2OH7hNVtv
	9zPvIrusHvfoI5gYVCPKfV1a2RJqsSK17tP5qVCUb2A846TVdcRoX6fVu6ldfBzCsr1b5DamXTn
	nwWSvHz09/MarD6fNas4B2b3X5Nbg+EibtKjlmPF7ha+TAN0d1uQoLsSdgyjKquWBKJYAEodhj7
	2SEzAzbHbW+xPmNTewhQaJOSrP9TODp2z3NZSa5b1NljwouoxKrs41p8rbuTN8A=
X-Google-Smtp-Source: AGHT+IHZHlbYaOzvfgEi/7oOPSkAGVB9rfwRZ+XrSMxXp2o5OJinuivVxYiAyQRCpFTXDpu11WkWXw==
X-Received: by 2002:a17:90b:3b84:b0:301:98fc:9b5a with SMTP id 98e67ed59e1d1-3030fe856e2mr8438450a91.6.1742645821854;
        Sat, 22 Mar 2025 05:17:01 -0700 (PDT)
Received: from [192.168.43.144] ([39.144.124.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a2a479c1sm3469473a12.70.2025.03.22.05.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Mar 2025 05:17:01 -0700 (PDT)
Message-ID: <5e7ad224-651c-41aa-8d9b-b9ac43241793@gmail.com>
Date: Sat, 22 Mar 2025 20:16:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ryncsn@gmail.com
Cc: axboe@kernel.dk, brauner@kernel.org, clm@meta.com, ct@flyingcircus.io,
 david@fromorbit.com, dhowells@redhat.com, dqminh@cloudflare.com,
 gregkh@linuxfoundation.org, kasong@tencent.com, sam@gentoo.org,
 stable@vger.kernel.org, torvalds@linux-foundation.org, willy@infradead.org
References: <20241001210625.95825-1-ryncsn@gmail.com>
Subject: Re: [PATCH 6.1.y 6.6.y 0/3] mm/filemap: fix page cache corruption
 with large folios
Content-Language: en-US
From: Yafang Shao <laoar.shao@gmail.com>
In-Reply-To: <20241001210625.95825-1-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

After applying this patch series to our 6.1 kernel and enabling XFS 
large folios, we encountered random core dumps in one of our Hadoop 
services. These core dumps occurred sporadically over several weeks, and 
it took us a long time to identify XFS large folios as the root cause.

Reverting commit 6795801366da0cd3d99e27c37f020a8f16714886 ("xfs: Support 
large folios") eliminated the issue. However, we have yet to determine 
the exact cause, as there are no warnings or errors in the kernel logs 
when the core dump occurs. Additionally, we have not found a reliable 
way to reproduce it consistently. While we have managed to trigger the 
issue within a few days on our test servers, this has not provided 
significant insights.

At this point, XFS large folios appear to be unreliable in the 6.1.y 
stable kernel.

We would appreciate any suggestions, such as adding debug messages to 
the kernel source code, to help us diagnose the root cause.


Regards

Yafang

