Return-Path: <stable+bounces-169375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7BB24906
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7985F3B10CF
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77C2FDC37;
	Wed, 13 Aug 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3CgdtUvN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2622FDC59
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086467; cv=none; b=Ih5WDVVC2oNgSZA+xadopKue+kmZK6zMqEp5pypyUq7S1sXfY0fNj8tlPKsMg3BNAqL017to2X/TlP2m1oRl/SJAU/mQ3VeyO6dI2IG0xt4oPUyDJ0sjMHcfsgAoFAkCSPx+5J5LGczq82Ms2z1FEaUXtVhmSkzHAPc0IBE9E8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086467; c=relaxed/simple;
	bh=21uThjRFNAFsflTR+fbg9LLfAhuNOCf8lYl89FYFvPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P19yjdL20P1X+dAZuaJKcbQ3EmKS+5ci1OE0oT8VQRAcdJKp2Q0koX+/jfxapa1g1VPcRy7S1WZwOGN+lB6bmD5JGukp532ThbnoQ4CvcOLFZzj9cOb5R500xQIfAJjucQEBNUlJGqhgHWq6I+l8dk9Zan8vgY4vSgEtyLpjKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3CgdtUvN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24063eac495so51511745ad.0
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1755086466; x=1755691266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHAMFL+QvUwvR809KrjC7Pfdd1oqWDB417E2cPRN3Do=;
        b=3CgdtUvNQdoEi9/k0FypYsChhiVMub6+mDZ+8Ld3Wvs7JQQOAUOTJQIeH6I6Nt/4iK
         l+r5bdp0PGq9tL1PHrvlOblfEdOu2XpjKv7MKUr8HMtALywWCLkqpY/HjjZQAIk+zHrC
         I39Tc2jkjEXOVdlPaZaYDPJ+/4flia1XIpJBk9GDe9lg9lTuqIO3A5JD+2O6UlK7bfc/
         2vgAacMbOQMBWq8Cl6DlW7bI5HUXSxyNRx3rmM6J5uLYUmubFPmPCtfDO6NxvZwrPEL8
         Rwm8hsbeywhCrqV4iTwj3VJRcijNHUpNFMkW+GcUWdeJEqEkZBXE2vrIbamM21jOIY/p
         dS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086466; x=1755691266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHAMFL+QvUwvR809KrjC7Pfdd1oqWDB417E2cPRN3Do=;
        b=Gz2knf+HZpSLsYrjFlFsMNrCteQsdIToa9OHrk4ewwTXGjnIOzskJICZSpHtNVUO2m
         e13BGkhbngv3QypSQAEa9dmtK3/xrAUtcEbppgYICJNerJfnAjMe5ujePgUm6VhfoAPI
         sRhyPYZAH/2Gm8GdNWIQa8F4CpSUS3lll8tswkWzcL61KvV9kWccA16psCnWPJDTunhe
         1WAGHgZhyBJXG6S0IqDReascCpAAZklIa8HiM33TQ9g7TZCCNWjLKfmm5LyldpPdilQu
         ygJ4bWRjHXYB79SPyFP0IMXrRLSUs4rgawaM2SKUxveBuhb8YAFvpbInuRuaEON/4rJY
         OaYw==
X-Gm-Message-State: AOJu0YzejeHDqf02l+1mFPSpcx16YJlcAxrcxxXf2CpxZpz7IhyI1nRv
	3xfYK10NSrd4Zcw7udr6lZy5OpwQhWY3Hsv8eUTbsmKY+AWMGzn/SDR6xrzAz8pSWQ==
X-Gm-Gg: ASbGncuyiy9m1BThJ1YAaS/GYuRq5RVfS3OcvdGxt2j9FsH50XTCdEOv2rHfV9auepU
	1mMmZsjN/D2ypbcSN6UA6n7Ulz4bX9yKGLPdz2G6vCUmusLNiJzly+zvGKB3cgvNa6/uGFM7wd1
	hysgYP/pSOtGJuZbQNj8PvFUwQNwffgXn/GkPoJO5UQJGgQnfHud8Z1C68pqZ08MKTA7ClepX6i
	Kdu0xpGET1CX4pUy/YLGJ6T2wIoJvd1RJr70hhGjBHKfhXj6Q/t1rcZDQD4vaK+BMugwKlr88hM
	eJEolR7H3otxkGi7tg/SMSZ3v2HJk+ShUiXSEc0MgVy6x+dzqhRVpTpOX2YYftza2pw930iNOSL
	wVh2nOVg7gwwi9twPusm9b0KnUiMR2SBOYJDoGBIYXheLbdFaJsYZlhlZXppBWVUtvdQ5
X-Google-Smtp-Source: AGHT+IGHJuWaV+FD+QDrxC+U/4b+aMqI/qdu++bCKwWu4Xu4dpSPZ/7FiJccNWtZT0ccGveemJpAoQ==
X-Received: by 2002:a17:903:1965:b0:240:3239:21c7 with SMTP id d9443c01a7336-2430d1cdae7mr41229705ad.37.1755086464176;
        Wed, 13 Aug 2025 05:01:04 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea? ([2804:7f1:e2c3:a11c:ddd8:43e3:ca5c:f6ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242b0934d33sm160769535ad.46.2025.08.13.05.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:01:03 -0700 (PDT)
Message-ID: <7d3108e8-93f5-416f-8eaa-e63af851756d@mojatatu.com>
Date: Wed, 13 Aug 2025 09:00:58 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] selftests: net/forwarding: test purge of
 active DWRR classes
To: Davide Caratti <dcaratti@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Lion Ackermann <nnamrec@gmail.com>, Petr Machata <petrm@nvidia.com>,
 netdev@vger.kernel.org, Ivan Vecera <ivecera@redhat.com>,
 Li Shuang <shuali@redhat.com>
Cc: stable@vger.kernel.org
References: <cover.1755016081.git.dcaratti@redhat.com>
 <489497cb781af7389011ca1591fb702a7391f5e7.1755016081.git.dcaratti@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <489497cb781af7389011ca1591fb702a7391f5e7.1755016081.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 13:40, Davide Caratti wrote:
> Extend sch_ets.sh to add a reproducer for problematic list deletions when
> active DWRR class are purged by ets_qdisc_change() [1] [2].
> 
> [1] https://lore.kernel.org/netdev/e08c7f4a6882f260011909a868311c6e9b54f3e4.1639153474.git.dcaratti@redhat.com/
> [2] https://lore.kernel.org/netdev/f3b9bacc73145f265c19ab80785933da5b7cbdec.1754581577.git.dcaratti@redhat.com/
> 
> Suggested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

LGTM, thanks!

Acked-by: Victor Nogueira <victor@mojatatu.com>

