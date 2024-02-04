Return-Path: <stable+bounces-18777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A8848E2F
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 14:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B37C4B20EBF
	for <lists+stable@lfdr.de>; Sun,  4 Feb 2024 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC66B225A8;
	Sun,  4 Feb 2024 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzFCO8kn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780C225AA
	for <stable@vger.kernel.org>; Sun,  4 Feb 2024 13:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054501; cv=none; b=S50vBJkxnHuie337g/p/ykvdiC5YPZrS5rkC5tnH8OQ2b+mnUEcHo4zAgRTTNC0/kYrRGcETQOXrlXfnnkAkFGcdY5TEAnxWB9a9vNhfxJyy4G8LGLPJ7/Ro885/4hWoDZBAgID0EJl2r8M77ZpfUdz8fxWQtC1ONYJahgs6TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054501; c=relaxed/simple;
	bh=dommXLpkhW5rWBJGGIywT82Ro1CkiMhNVTxvfzq4Bzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s429ASvc1AsgiqdCWja3OC9+x9x0V8Pe2DOAy6Ow1dkGp0s0UXOH9X8FpZbsm1CfyKpi1Hz2R9ZOhNP1h7lCYsOKcetr99u8waol6CsXM6Pdt8j6Pe6wkmwAcKITwVoZSwPviLV8UJourdLn4XropLic3xqZMpGZAFtKGV0D+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzFCO8kn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6de2f8d6fb9so2639995b3a.1
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707054499; x=1707659299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBqZEhMQayOVKwBOR8eZbUcOV1plLyIzz/XGKnc3OzU=;
        b=TzFCO8knm2iah3cLKBYERAVecxsWFvkt/7RiVYDV55GCIhDHWnKTgMrD7cqi/tfboZ
         fiJfOtpFyj6XgQcpEY4WCztwtfb/KmFLr96JhmS6SqNMylmQf9BntvAavyjIr/ob3mDy
         vPjjVpDn+H5F4nYKfPzOE65lnwRrf7vpFcNUmg1kPCnGPTESDtVwWMtslQ6x3RHkj/nV
         uuaYD8LwKh6OyVmyn6FQ91kIGTnAcfowyuxlGDhbSwbmZUyQZJU9GU7wbRVrhEaV881z
         A6lWUabsbpXdQlZZdvym+XpJerGa/bY1mnZY2hqA6qzP8d4RZsNAeQBt47Y656MX+B+O
         OBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707054499; x=1707659299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBqZEhMQayOVKwBOR8eZbUcOV1plLyIzz/XGKnc3OzU=;
        b=wJ2/eRj/Bh1PFil5Wcza7BKiwqdQetQtk8+/ye6NJjdpQ7S1iiRtkxNpvPYIuMbMpF
         JmSgzJwpOEq5quoUTnAy7wc2OhtJMrA9YehcaeVb5Ng4TbSRTThAJXflJoHdIQRivNvc
         WkubuZpw7Sj9b+2P7d9Dl7npBqMkGLr/ggfbznk3/wBNT5UO+6TiD1rIDKDs2+K7rmPz
         fOcmrpQmoAhq3n7X7WyhgHoN5uaqkIngtNcw2frv7vItiq4XudpTdsCoZmBwoGBC4DSj
         w/qt3oApKUQLB2NDWOBs1ezAQ7dfio46pD7PBK2HEBNOt18MJRvdlofv5GGNQ01SfOgB
         NSmQ==
X-Gm-Message-State: AOJu0Yy50Ccmt5ht3HNDTMfgD9jZnNF4sSg1xd1of+dUo8dMQuav6/1l
	Gpc3FXHyRE1/F2HiX2SrrtA/0+s4bD4ARfJZ4myewwC1Lb0XHkrH
X-Google-Smtp-Source: AGHT+IFTCFMJch9TPz7Alp9rH6qAqDDW6cjpUQrxMx2kzs6jj3hAx+mfiIAE9XxwF4J+dhwSlbwl3A==
X-Received: by 2002:a05:6a00:812:b0:6e0:3d87:813e with SMTP id m18-20020a056a00081200b006e03d87813emr1610387pfk.25.1707054499623;
        Sun, 04 Feb 2024 05:48:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/I8YSEZUfabADaGdBAyr5bzh5da3zh8r0xhfgipYrtEnqHDU1WQ8sLK9jcu4HompjrH6/0Lg6GVS1GcUaSAnjWpd1rkRZA05AiIUFQ+a6H2pyhEluOV2c1qZBXaSXagfcyzIkODBediKwzPGEC4LYG3WRreQjVZGprndSFdR93sC4b8ohib7zlpach68aBihtVdMviXi7JIt24hR8hUU62LwTyU02z6Eu5tn/6z3ICI0zprZIPqbPgDmPMgR3hoaxHvbd0GLRt/7xC2u/vTIhUWaCZhul5hNfNbEviagjtOEz8z4=
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a0010c900b006ddb77d443asm4780453pfu.209.2024.02.04.05.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 05:48:19 -0800 (PST)
Message-ID: <741fdb22-4570-4432-bc9b-8ac7221aa0fd@gmail.com>
Date: Sun, 4 Feb 2024 20:48:12 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 295/322] netfilter: ipset: fix performance regression
 in swap operation
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 Ale Crismani <ale.crismani@automattic.com>, David Wang <00107082@163.com>,
 Jozsef Kadlecsik <kadlec@netfilter.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?B?0KHRgtCw0YEg0J3QuNGH0LjQv9C+0YDQvtCy0LjRhw==?=
 <stasn77@gmail.com>, Linux Regressions <regressions@lists.linux.dev>
References: <20240203035359.041730947@linuxfoundation.org>
 <20240203035408.592513874@linuxfoundation.org> <Zb81_PFP54xFYQSd@archie.me>
 <2024020441-grumpily-crumb-03c3@gregkh>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2024020441-grumpily-crumb-03c3@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/4/24 19:48, Greg Kroah-Hartman wrote:
> On Sun, Feb 04, 2024 at 02:00:12PM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> Стас Ничипорович <stasn77@gmail.com> reported ipset kernel panic with this
>> patch [1]. He noted that reverting it fixed the regression.
>>
>> Thanks.
>>
>> [1]: https://lore.kernel.org/stable/CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com/
> 
> Is this also an issue in Linus's tree?
> 

Hi Greg,

The reporter had confirmed [1] the issue on mainline.

Thanks.

[1]: https://lore.kernel.org/stable/CAH37n11rbpaxzmt03FXQpC0Ue=_J4W4eG12PxvF3ung+uLv8Qg@mail.gmail.com/

-- 
An old man doll... just what I always wanted! - Clara


