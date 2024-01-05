Return-Path: <stable+bounces-9785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DB482532B
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 12:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D32285152
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39542D03C;
	Fri,  5 Jan 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dloLrNjA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736472CCB4
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso1316872f8f.0
        for <stable@vger.kernel.org>; Fri, 05 Jan 2024 03:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704455966; x=1705060766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUwzG5GAodV255BObcMC0Ee1zGNs3NstGJBAQNhp/Nk=;
        b=dloLrNjAfPfiC6BfHpD9ek6pOj5Mwjn484aZ3kAJTTE2sc0LrhIl9Qpahm/ANBJ3iI
         Uj5+bCq7kORY5ouQSA8Wu0R9iBRikv7Ol9wvAGlZGs7fl5Wc7Vml0vHli2HBDDv6hy6P
         a5TIrlpOZgRhfLi+6AnXu65Q31pr4ly+D68s6yQFa0K6vUr9ZcZQUn+geAIX18xVdH8J
         NDaiOcG9H6X2ok+pA2Y2OdCyYIAR64eZ/ugr0ZtDCTwXru/OeCY3xYmPDblZEtDJyP8A
         bwFgOyIjnfSOBTXRNhXeIIrK/OMyftbDbbUD5YwyiMVuoV+yxyAf6J3ZArys0GtjovRy
         FT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704455966; x=1705060766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUwzG5GAodV255BObcMC0Ee1zGNs3NstGJBAQNhp/Nk=;
        b=GAOtiIuHAVned3O7+1WXaK0U8pWt1zg4fpdFLZQCC+ZyGGkVbxQODiAhPzjn0PLhBU
         JxA5mPcIPbtaLs/OKIZrvGZnBqXLQvVsVvxqSCKQNusSwi4eZvI0DyY7K9lmGDr+uHqJ
         jTGTnm6K02YD70Ir77XDL/xSwPUxC1UQ6Qh3JznLcJAkTcuFWVu3EXF7jK+2fetIG3NC
         yfQdBHL2fP0NPOR34R+DlNqPd77THQc0G4S8O6NBpSzXdm0RxepkQPszGSe32m6ax1Gz
         lgECrmrJHDayP7aWkOkM/kTLhhGu3waBwU4/q/bvvdq3AKEagRrvDMB9Skc8wzMnq655
         Sk9w==
X-Gm-Message-State: AOJu0YwlYp7vVXMMJF6iMyMblDfx/arfdJt03POaXg2jcUoOq4mce5U3
	5ilmfkypoCKJciN0qYh6gz/lr1pFnkCVHQ==
X-Google-Smtp-Source: AGHT+IHypNR3urOgyfI7XDfw3H47tJXj98xYo3KaKlbG8MpMwxjU/6ekG0oMLeWW7Ho6yysYX0KKPg==
X-Received: by 2002:adf:fc89:0:b0:337:5557:acf5 with SMTP id g9-20020adffc89000000b003375557acf5mr917086wrr.106.1704455966502;
        Fri, 05 Jan 2024 03:59:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b00336898daceasm1257030wri.96.2024.01.05.03.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:59:26 -0800 (PST)
Date: Fri, 5 Jan 2024 12:59:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] rtnetlink: allow to set iface down before
 enslaving it
Message-ID: <ZZfvHEIGiL5OvWHk@nanopsycho>
References: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
 <20240104164300.3870209-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104164300.3870209-2-nicolas.dichtel@6wind.com>

Thu, Jan 04, 2024 at 05:42:59PM CET, nicolas.dichtel@6wind.com wrote:
>The below commit adds support for:
>> ip link set dummy0 down
>> ip link set dummy0 master bond0 up
>
>but breaks the opposite:
>> ip link set dummy0 up
>> ip link set dummy0 master bond0 down

It is a bit weird to see these 2 and assume some ordering.
The first one assumes:
dummy0 master bond 0, dummy0 up
The second one assumes:
dummy0 down, dummy0 master bond 0
But why?

What is the practival reason for a4abfa627c38 existence? I mean,
bond/team bring up the device themselfs when needed. Phil?
Wouldn't simple revert do better job here?


>
>Let's add a workaround to have both commands working.
>
>Cc: stable@vger.kernel.org
>Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
>Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>Acked-by: Phil Sutter <phil@nwl.cc>
>Reviewed-by: David Ahern <dsahern@kernel.org>
>---
> net/core/rtnetlink.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
>index e8431c6c8490..dd79693c2d91 100644
>--- a/net/core/rtnetlink.c
>+++ b/net/core/rtnetlink.c
>@@ -2905,6 +2905,14 @@ static int do_setlink(const struct sk_buff *skb,
> 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
> 	}
> 
>+	/* Backward compat: enable to set interface down before enslaving it */
>+	if (!(ifm->ifi_flags & IFF_UP) && ifm->ifi_change & IFF_UP) {
>+		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
>+				       extack);
>+		if (err < 0)
>+			goto errout;
>+	}
>+
> 	if (tb[IFLA_MASTER]) {
> 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
> 		if (err)
>-- 
>2.39.2
>
>

