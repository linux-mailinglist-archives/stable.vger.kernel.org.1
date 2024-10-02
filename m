Return-Path: <stable+bounces-80573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBAD98DF54
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533341F27048
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6101D0B87;
	Wed,  2 Oct 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cpn2ewxX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F91D0E1B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883346; cv=none; b=ZbuOzBYe6UHLgXmsGWFaQbwf8fX0PpPu6uFJoYbHA9+zuNEnnIsdtV4QlyLOo8qIa657/sY1fHVnV75kuJOSo0Vl3ealEJ0/x5e1GJJftSPV0a+QQG82sNs4nh+VTLwVg+EKwUsQSufSY0MgjGgJwOry0HQT5+BCpdtuHhNfsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883346; c=relaxed/simple;
	bh=/T82ZBHNKOiqS6QgrGyPfq3j1c08/n/R932sr6t7O4g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=aifZh5Otwc2mcX855oqKI7Cf2je5tbLOfz6Tgmpyqx5SOp9iKxsXmwoyeJUuhj+K2YCKo7VtAtSSNqq8PDh7E1McRxO9qybYE2LT8Xg0VpT+1lOwurPQv3aSRl0eodqBI3XseHPll+dD7gxY39Qev0NnFb13nC31Cttg12tq82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cpn2ewxX; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82aa6be8457so35993439f.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 08:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727883344; x=1728488144; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8a5UprsfZnVpKb9fT2kDrurhIm9j0639eg6PzaQzp5o=;
        b=cpn2ewxXvRvsCBbT7jzjsgCVh2+Ba/wDjcQ/YbcJCu8YtaqqnuxmSGjXsRQ0EI6dGS
         eyveHV2/W5zbtCGRJNXB2ab9OQyGYqy7WcYaUMwtykDY7S/mOYZVOnRu2CZuRCelysJy
         uer/Cp/G2kPJxWrDz0c3hklfQ+rB7MDzol48TSRC/TCxZGW1l7iCP68Rf8SZG5S8AMPU
         IRONVRdETv8gfxJPOk6F3Uacxg30CbUA73cajci4aC9QintJPDFzX+H1ajgIoor8osgZ
         5gHJAFu4QwfSRhRQW+kAKOqENpMxPeVXd3Zyl8enl5XCq8D55WMcYxa/MBrnXi1N4Gqb
         dHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883344; x=1728488144;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8a5UprsfZnVpKb9fT2kDrurhIm9j0639eg6PzaQzp5o=;
        b=H/sx2iQxbydlhWWfwbVxXZdRD2+VbOmhIQ0lui5gCmWs+mgFHet5Xoq3mFWDWg7Wio
         RZyqw2fVrRq2rEU3oy9eD+2fhUckwwuYzJgItOT+whrE5dlJfroZRxYQJg3GMsmSE5NJ
         BzBU3Z+iDmQl01AZ/uGtX8PmDpjx4gvEoGU9GXjWeW5JhwLc2+4WTMAxuBY6Y1tQv/Fv
         BkkGERgTlVOde4PWGBUKqflw5aoUgAb8+4zaW52JfRQ0uASKXdu7HTjChLlHPbTwekcy
         7hzpKGqUOAOutvQ8+8SNy/nadCKfOIBDnXkPOv0o6/8cOMugpXjOa+IHSEorZF6gcA5Q
         6IEg==
X-Gm-Message-State: AOJu0YwLru9d685bzAgFkeI2suVi1e2nkplQE/Qb048lDUADqL4Y91ex
	oEc48+EmSO4JOVYwQnmiOIvg1kmwRGx+l+mAzWriTL15xefXZU/QDRgj0r2Vvd9/ANVVmqecfdd
	UCv0=
X-Google-Smtp-Source: AGHT+IE2Nt2s+kSv7a6xDw5guMNHknOR/PEQ0GG/HA8oShTOtSoB0kY5D4Km3IwVS81EY8RUQUszXw==
X-Received: by 2002:a05:6602:1514:b0:7f6:8489:2679 with SMTP id ca18e2360f4ac-834e76da85cmr1443039f.8.1727883343856;
        Wed, 02 Oct 2024 08:35:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936e34acsm335485839f.32.2024.10.02.08.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:35:43 -0700 (PDT)
Message-ID: <4cdd1f7f-a753-40af-bde5-11bb584a052b@kernel.dk>
Date: Wed, 2 Oct 2024 09:35:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: Missing 6.11-stable patch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Arguably the most important block stable patch I don't see in the
most recent review series sent out, which is odd because it's
certainly marked with fixes and a stable tag. It's this one:

commit e3accac1a976e65491a9b9fba82ce8ddbd3d2389
Author: Damien Le Moal <dlemoal@kernel.org>
Date:   Tue Sep 17 22:32:31 2024 +0900

    block: Fix elv_iosched_local_module handling of "none" scheduler

and it really must go into -stable asap as it's fixing a real issue
that I've had multiple users email me about. Can we get this added
to the current 6.11-stable series so we don't miss another release?

It's also quite possible that I'm blind and it is indeed in the queue
or already there, but for the life of me I can't see it.

-- 
Jens Axboe



