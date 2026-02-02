Return-Path: <stable+bounces-213013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fEduO0Dqf2nU0AIAu9opvQ
	(envelope-from <stable+bounces-213013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 01:05:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08344C799C
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 01:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 262AF30057A6
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 00:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DD29A2;
	Mon,  2 Feb 2026 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOE+KyYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CE1FC8
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769990710; cv=none; b=ceK/zZZJsrrnEuoJUVDg/A+njWK+89vFLuPYpRvE712pYI+1QQdKAsNaIy57z3zV3Hmo52L0nsiIJxU/rgjd6nvvJ7awmZ02RNICQV48GPl9OywR5SSFoLft5PNzXTAtfNnNbF8htWNnjxxVU4JRvXMJwOcq3ESRWr8mmNjbFq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769990710; c=relaxed/simple;
	bh=Dnrsu7e8llQWO72v7zXc+Arhk+y/Tuhg6viBGyo1KeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaoq4dPH+ZXwEyLzrXG/ziDw1nSkRY6zL/0FwmC3Fq55Dp/cyNhPFXmafQaB5L9bEaTDGyjvWmK5I7KnccKSocR7vIOGyQoBKCNWNegPwQNm0EpiGSzO0SoX02jkzpIdCM+i5nGbHQyWJcU3nAv55IK5VQdv41Psqs7VmGyDrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOE+KyYK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3545cf80e1dso312642a91.2
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 16:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769990709; x=1770595509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jChbwAD+zWO8CByFHiqQt8kcpZGT0+zEA0U0OKmxeN4=;
        b=SOE+KyYKvl8lm0KP5lcBImJ6bVWBYjH8N7SdW6A/7HxFq9HUrizec4f70ZcFmTXzRr
         P2YwlNMbhNQaM+jqzTS0Xm2WB1AVsJJBqKsob7sNZiNkgZPx+jZjZlIythZLJG0uHYyU
         kYfFFPoulfTJ4reAsfaPFUcaqQ1Hd6uzMDdxTF8uT79tDvOWJQBe0VT0gFWiBc9BynfY
         8qZE3tAbuiforaPPS+k1JOt5gCAHfpFr82wvcj757EllcxaXOb428RkpeKoNs7fU+BPp
         MULUWz8QKspdd8XeiOcoocLTFxQmz8C1ghQrDnUYAOEsq5pY8zUSCX9l2Xduk5tnxuwR
         IEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769990709; x=1770595509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jChbwAD+zWO8CByFHiqQt8kcpZGT0+zEA0U0OKmxeN4=;
        b=R+GnpoH+siXVky7cqMOzXze2gK6+2owK9mvO6yS9wfe79BVR2KoHtyzzDR9n0waIgg
         rpyTDxdUEbJ8YqCV3DFeaPcTMfvF93yr3sdXtZdy1J3vdmtOXPfGDMQJE8iajnziug45
         v8kPXPcGY6o5frF4FabmXVF2tsjQCpdsaoNPvBPr+qRm/P/xGs+W8WXx+DyzYZC1fe+v
         Jt+d6UZBm048B6uyxudrypMb5FAzMfbKF7cXTQ2s/2V5Rt3/v4yba4G3cANYaFg/RTgl
         224viIizn+nwYkL2Y1eJyNXnImpl7t2AWuR5NW9t3rGXDB/rw84uua3qBH4xBy3/qkr6
         LmHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfBS7xuY0/axT07D4c2H90jsYvaH3OJlRWaiZxryOI0IgQwpWteRa1HJ9Y457NvTc9mujkXxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WbMw/ShavM6rpuNHcjFtYVYICEAoOGAHB4uUxPHPNKPrIZmq
	9MCRIavVze+M3YAYOhIomIWZJACTSWAE/jvv2vA62B1s2u6WAvi6klw5tRnojQn/
X-Gm-Gg: AZuq6aLOoPK+dkAP3F7zFZjyWny2lsIpwcfhrVORthYV0igh5sdvypgsDpsO21yO7my
	po9kt9Zgzwck4CsEdxKhL4efysW733DNURjxEnmV1xatQSLbvJvuFk4Cd1QYYoxcbP1d8QGJEoS
	onyePbGIjrXaweLkTvVBH2dUKcW+OY9ruM7r5YuelKxPgcWK+aPTWQtZcWlEfLqf0wkyq8mB0HE
	QXir59xPwID7e3e0g3Fm4VN1go4Q3a4LlcY8C56A+YDiLLNxzM0ya19SBvclukbzXoggfAE8lsg
	OlIP5MUQWyO/DH9XJoLGObTMH8n9yrBqM5Auo6jU7dja7bFV0i10E4LFJTYEt1K6mS+nA09IaZK
	jNHc4dbyeX3lnRaJmPPAtk3jt8bHkTEh9TlMrmsQZl9j31KdNgqO5FOiqqL+0C7W5x+Jovj8d9L
	01786wk8LX2rlsml8O9pOMbVej
X-Received: by 2002:a17:90b:5446:b0:340:9cf1:54d0 with SMTP id 98e67ed59e1d1-3543b2ebd00mr9605243a91.1.1769990708647;
        Sun, 01 Feb 2026 16:05:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543bbfcddasm3241706a91.1.2026.02.01.16.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 16:05:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 1 Feb 2026 16:05:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: gpio-fan: fix set_rpm() return value
Message-ID: <531f3bc1-a02b-4286-b692-b171a7f70222@roeck-us.net>
References: <20260201-gpio-fan-set_rpm-retval-fix-v1-1-dc39bc7693ca@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260201-gpio-fan-set_rpm-retval-fix-v1-1-dc39bc7693ca@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213013-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 08344C799C
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 09:35:06PM +0100, Gabor Juhos wrote:
> The set_rpm function is used as a 'store' callback of a device attribute,
> and as such it should return with the number of bytes consumed. However
> since commit 0d01110e6356 ("hwmon: (gpio-fan) Add regulator support"),
> the function returns with zero on success.
> 
> Due to this, the function gets called again and again whenever the user
> tries to change the FAN speed by writing the desired RPM value into the
> 'fan1_target' sysfs attribute.
> 
> The broken behaviour can be reproduced easily. For example, the following
> command never returns unless it gets terminated:
> 
>   $ echo 500 > /sys/class/hwmon/hwmon1/fan1_target
>   ^C
>   $
> 
> Change the code to return with the same value as the 'count' parameter
> on success to indicate that all bytes from the input buffer are consumed.
> The function behaved the same way prior to the offending change.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0d01110e6356 ("hwmon: (gpio-fan) Add regulator support")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Applied.

Thanks,
Guenter

