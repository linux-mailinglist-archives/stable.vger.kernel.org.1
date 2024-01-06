Return-Path: <stable+bounces-9949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D4E825F53
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 12:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAAA1F22B22
	for <lists+stable@lfdr.de>; Sat,  6 Jan 2024 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF86AAC;
	Sat,  6 Jan 2024 11:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CRK+cz/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A57468
	for <stable@vger.kernel.org>; Sat,  6 Jan 2024 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d5d8a6730so4050035e9.1
        for <stable@vger.kernel.org>; Sat, 06 Jan 2024 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704539283; x=1705144083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWNd9mvw6oMITRZ4IAvv1mLJ55zWRxmegGbywalgIkY=;
        b=CRK+cz/ka0Lh1xF4IQEKkNXLwiXHvTpEEc6/tlRSq4qX+/eH0ijijHKpA9r3uhRMiU
         qmvtGTC1bqaWiOIBbYmL+2NQ3LH6yrvOiyeb1EUEAyK6Tf67JCT0pb8Rw4xDK5l6zNGD
         le2ydcmGNuj0UpCJBuCho0LJH1DMnO7kFX9pOugj5Dv541LHwV3LhT8nYX3qTTiIy383
         obK4ddbdr/XSpgezviPUMsdnUUlfXoYO2P0gi/KLGos4k/8sE2Bik5T1KHy07026wBpK
         Vvi2gdYBFU6UkpzX4FuPB1OY4gkAr4wgpmdYznyAgyyXGQfKlwE5PFrKgbpNU1dgh6WL
         0hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704539283; x=1705144083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWNd9mvw6oMITRZ4IAvv1mLJ55zWRxmegGbywalgIkY=;
        b=VDDf8spM6GvP2515mMVg9vGRZ1O8Y2ZOgpaVIQhN/+B6qyGloxT4ICABmavkDIwxud
         5W+XYu9U9i2Y8PtAZpmOzzCDK9HjsaRbX1eeWZPPumnpywZMh9lOX/wIShuGC2z1aUcH
         NbY85krGcCr31mNBZJYxS2We0xhGYA8lAsslNtHEL9cfZkNsAmPggGP+/XyQJ7hA9LVJ
         ohU7Ddw3wPCNdzjaNTBRLSdqU7Y5YSnCWK7oJfIfy5tXryaFq2DrpECuFFEJP3/L+T8D
         xT+y/4pn+0EK+Sxyj7/MaMLBh9HVvUxBBIdssAPKtL7nDCNYIiLi38D72dwHBHVCaVFS
         HQuQ==
X-Gm-Message-State: AOJu0Yxtxt+RwCBABeYvYPDTIwFUTO/w0oYDWXqbLxo0/rJaExcpa+5M
	joySILbwcHKKGgLkESbvHqHerQhG86ztdw==
X-Google-Smtp-Source: AGHT+IGKQ1htQU+sceZkr5KKoT5wx9Gx8kMk1NtN5Bm4e1RO4ZGJZZC49YDlTjEHTj4mx7BmDtXVNA==
X-Received: by 2002:a05:600c:2a15:b0:40d:6e73:cb15 with SMTP id w21-20020a05600c2a1500b0040d6e73cb15mr373581wme.168.1704539283139;
        Sat, 06 Jan 2024 03:08:03 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0040d3276ba19sm4318775wmq.25.2024.01.06.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 03:08:02 -0800 (PST)
Date: Sat, 6 Jan 2024 12:08:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Phil Sutter <phil@nwl.cc>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] rtnetlink: allow to set iface down before
 enslaving it
Message-ID: <ZZk0kMoPjL3ch8kj@nanopsycho>
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-2-nicolas.dichtel@6wind.com>
 <ZZfvHEIGiL5OvWHk@nanopsycho>
 <ZZjJvJY4facvIu8a@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZjJvJY4facvIu8a@orbyte.nwl.cc>

Sat, Jan 06, 2024 at 04:32:12AM CET, phil@nwl.cc wrote:
>Hi,
>
>On Fri, Jan 05, 2024 at 12:59:24PM +0100, Jiri Pirko wrote:
>> Thu, Jan 04, 2024 at 05:42:59PM CET, nicolas.dichtel@6wind.com wrote:
>> >The below commit adds support for:
>> >> ip link set dummy0 down
>> >> ip link set dummy0 master bond0 up
>> >
>> >but breaks the opposite:
>> >> ip link set dummy0 up
>> >> ip link set dummy0 master bond0 down
>> 
>> It is a bit weird to see these 2 and assume some ordering.
>> The first one assumes:
>> dummy0 master bond 0, dummy0 up
>> The second one assumes:
>> dummy0 down, dummy0 master bond 0
>> But why?
>> 
>> What is the practival reason for a4abfa627c38 existence? I mean,
>> bond/team bring up the device themselfs when needed. Phil?
>> Wouldn't simple revert do better job here?
>
>Ah, I wasn't aware bond master manipulates slaves' links itself and thus
>treated all types' link master setting the same by setting the slave up
>afterwards. This is basically what a4abfa627c38 is good for: Enabling
>'ip link set X master Y up' regardless of Y's link type.
>
>If setting a bond slave up manually is not recommended, the easiest
>solution is probbaly indeed to revert a4abfa627c38 and live with the
>quirk in bond driver.

Okay, lets revert then.

>
>Cheers, Phil

