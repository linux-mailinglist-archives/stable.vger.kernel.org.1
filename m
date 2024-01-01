Return-Path: <stable+bounces-9154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CA78214C7
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 18:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142B8281B28
	for <lists+stable@lfdr.de>; Mon,  1 Jan 2024 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF409453;
	Mon,  1 Jan 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="PbxiwItx"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83C8F6A
	for <stable@vger.kernel.org>; Mon,  1 Jan 2024 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbce1202ebso3334886b6e.2
        for <stable@vger.kernel.org>; Mon, 01 Jan 2024 09:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704130925; x=1704735725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rwq03bF37E2LhP3H9ZX2p9o+zrikQSxg1rxg3ok+1KU=;
        b=PbxiwItxZ30QTpRWchlqa6N9a8LRbsaG9vx/zuEg/NVWjUsNm8zhs0jr/hnVg88ct4
         gmG9Nn6dpQzH9tMcPEporPivJLdujey5CVaWTUiwewhL8Xr+1sjxZv7j6olfPbjlTY11
         edptXcrW3BAknXeWFcbdsKf8SkJckfz5CH2S6BFpSIJLgSGrLKUDrZf4HAhoIlnaJUuM
         SaZKoN8a9TMTLnVz8Ttr1rh5PjefqUq4696CbziPb8B50kWaTqDTtMnDHp+KMTwQgzxW
         knIe9NwJVckZ1/YOctf8SfXrzQndZdc/21sQ/uZw61vmVRHXE9ntD3+SI6Y0ey5qaxkW
         IE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704130925; x=1704735725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwq03bF37E2LhP3H9ZX2p9o+zrikQSxg1rxg3ok+1KU=;
        b=HP0zNbo2C0nl/NUJSZO50tLFDKsmRCQ+RT4+E07ZrlyvE0Tf79KxG18IrdNtMa0hZN
         xewCpep0nAXbDn1+c6/K06v+fnBebtlcTaLwdlf/OO/JGAan179xzO7gzvJYh1r2XJZr
         hHYLFc9IDQSwo+sPv24FLlFjISwM9Cg65o02FJSzt7H72E7OiOjttSiCE2JB0wGTKgAf
         4V6cB7IvkHOQZ2fG9FEcliuq+QsJ99az39nKX+shZUvpLbW+M+OIsw8f5GVJmaNnW9tU
         BOkcK7+GfYLryFwUWBjT5sGoEMCVrHozwo3X5vCaccTuYRMUghJO4MDX7GlR7Ro5Bu/8
         GIbA==
X-Gm-Message-State: AOJu0Yy0/whrmunDVtekIOEWwlGCVmpZbCiIz7yr+l+M2lcyS2Zu4D6z
	Z0HjWGs49YvNeY+oDfXXwtkXKi7y3qxK0d+t3++ERIHujVjgsw==
X-Google-Smtp-Source: AGHT+IFMOF0BLeOW8nFKg0/5J6GiIi0ViC/1pl+6p+GuueIBLfgewxrx95xhLP30PWcb/JbQg3r+rA==
X-Received: by 2002:a05:6808:23d6:b0:3bb:c480:30f with SMTP id bq22-20020a05680823d600b003bbc480030fmr9502697oib.26.1704130925010;
        Mon, 01 Jan 2024 09:42:05 -0800 (PST)
Received: from ?IPV6:2607:fb90:f21e:ce05:3ea9:f4ff:fe4b:aee8? ([2607:fb90:f21e:ce05:3ea9:f4ff:fe4b:aee8])
        by smtp.gmail.com with ESMTPSA id bf33-20020a056808192100b003bb789dd623sm3260270oib.13.2024.01.01.09.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 09:42:04 -0800 (PST)
Message-ID: <93564d28-5c56-6c8e-3052-0171c2bef43b@landley.net>
Date: Mon, 1 Jan 2024 11:48:25 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Content-Language: en-US
To: Askar Safin <safinaskar@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, gregkh@linuxfoundation.org,
 initramfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
 <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
 <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
 <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
 <CAPnZJGBdwSBeKUK-An8n-eDJdrrA-rnKPMX16cFDfwx8wxQiwA@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAPnZJGBdwSBeKUK-An8n-eDJdrrA-rnKPMX16cFDfwx8wxQiwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/30/23 18:46, Askar Safin wrote:
> On Sat, Dec 30, 2023 at 8:01 PM Rob Landley <rob@landley.net> wrote:
>> You want to add a new capability requiring a new build dependency in the
> 
> Rob, who are you telling this to? To Stefan? It seems he doesn't
> propose any further changes. *I* did propose changes (i. e. adding
> rdrootfstype=), and I already wrote that I will not pursue further

I was trying to make sure we can support the motivating use case, and that there
aren't any actual blockers with the current API.

I don't ask things like "Do I have that right?" sarcastically: I am periodically
wrong about stuff. You all know your use case(s) better than I do, and I may not
have understood your attempt to communicate it to me.

I get a bit exasperated at "this thing that's been there for 10 years could
instead have been like this" because I think changing established kernel api is
_conceptually_ expensive (either we broke the old one or now we have to support
two), but "I still can't figure out how to make X work" means somebody still
needs help (up to and including actually motivating an API change, but more
commonly some userspace design work and/or a documentation update).

Thank you for clarifying. It looks like we're good here for the moment.

Rob

