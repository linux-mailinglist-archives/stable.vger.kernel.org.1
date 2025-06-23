Return-Path: <stable+bounces-156137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902A6AE45AD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEB4441625
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9DD2517AF;
	Mon, 23 Jun 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRHL6+AT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB42581
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686571; cv=none; b=nQJA/K1EF0VIuoE6u/D/N9HmvuiXI4PhLG4sSu0c5w3q6SK53J5TuwzkmP9yS+hndH47Px9n9SOV+okWu2mUBUka/F2Pn6uGvMr9t8SPSkNnvcKmV6ZVxzelie0syPWe41PuQO9skvSGvGdvobUIUYm9LVANa8Pg743P2VN+dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686571; c=relaxed/simple;
	bh=ApXMGC7s2QVLwduVNuTqTcEm2BUNxA3LVDmQvfFW5YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVAppSwBohbDtrmxxLO9jvltRDUFbKe8EFXb79ClLtOxeKqzq6nT1FrnoJ9J2ExLQNhn+ENKyRLqpth5fbaTWZAf3JMGVgpPdLCi+wPfpX79KVpIQPcvHyGoUuEq6DtgO4Uqh+DjYdKjZDo5CFjRUV+lepwva8xWD4Nj8ZtNHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRHL6+AT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so22032395e9.3
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750686568; x=1751291368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7seBYxZ0rUqXY2kxJDY1wUd+HiGClcayRxu17r7nTGk=;
        b=BRHL6+AT9a76fcdXAR3ahrlYzmOiZOeyq6UiyUg0y2Y9/roM+u8KXHiHROfbsQZ1Ai
         IN08mWt93gBklJrMlaQiKG6C3H3iltntPkVOc4YIVvMvxy/DHS0MGYuF1fTIA8cQL7ZX
         7rDnIJkA5NN845lZambp4UzS+1EfNSf/sACcq+adkKfucI+HYBPW5WjWC6Q9XaT/uQGF
         fPWVFt1e/59i94IH9xvqYnQkasNSYvP/YjJQsJlJwWOy4Z57uS3iB6OdUB+R5IRMESEM
         oTJOGYlHqBZESVawWVjbfwldH66xaNDGG2698DmzpJUiaTQ0CpRhcr44khKmXMvLat0h
         MQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750686568; x=1751291368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7seBYxZ0rUqXY2kxJDY1wUd+HiGClcayRxu17r7nTGk=;
        b=YiWXo9nnYP8Trluf9H3+YnJkJRUK41jC32EnW4Ci7adbqGPdDW3da+X7m+w9olP6zl
         Fzt6vtJRaNoUeKpRzKc8doGzRiQVZGONnTWVPpdbORt7JNAJvlxHi3rXFdcuKtbYXaAl
         8mjmPC9TQ0h3+tRXT8dheP86uNLWqKX9YqP4SEwADa/bRQ9S+lohun6HUWbvCYtRA928
         cDPyPzMj8QqCSS0AyJMFm6W9Dot9XsUpu2NyKb85G3hZgDin7Tq5zSxuyK62hbuFVuXd
         743tYhZ/atdhQxMh5MXSVzekSTAajmXRX+yULncWwjhCs7W+3AYdpk2LCcPmtWcU4BjO
         it/A==
X-Gm-Message-State: AOJu0Yxb/tjdePHYA0l24heo51EQZ9NWJ1UHDnilIv7OK20xDUuEYVOO
	JeUKQw4/BmCGKrC2/GHygSAONHMYKMAhvpJp4ccKJpMHhzxBBz8/BdhS
X-Gm-Gg: ASbGnctppljkqbvCvAwt16couaq42fIaFFs87a2eUDONFMJLc0yukt189O1qTUM3Lw8
	0oJJ2NE0htols8uq998AT/dD0nVRh1pl1/9r+Kbfv7w8xOyVtJ8ipEAajPiEmo7z0JG/4aoU8U+
	LBeNXjDuf8p1EaCwCpkv9M+91btdNtMyDgPAOH9RwAbC/0bET+7hmA2D+aUK79K7lUrL+8qOjZi
	jbMFCEIYVgesrtow1ZH8H0Djnhd1s8vjTkwd25tOSpOVhoMh4in96xfLm97Z9JKkKuODynNu0J9
	Aw2l6JVjSWoe7/wF9hzorgfSFB0eTiVmFlB5bh8+AAh3P9tOfyQF54HBN74t3Wn6Ui/p4bnKjQ=
	=
X-Google-Smtp-Source: AGHT+IHxmpE/gGIOEjTriO6olumF8IddjuRCLhtG/90jInmLS3B8CGPV+mADMuI0VcSaCpHWvXYQXg==
X-Received: by 2002:a05:600c:1f0e:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-453659ec182mr108475955e9.21.1750686567694;
        Mon, 23 Jun 2025 06:49:27 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d11906d6sm9440850f8f.85.2025.06.23.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 06:49:27 -0700 (PDT)
Date: Mon, 23 Jun 2025 13:54:57 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 044/355] libbpf: Use proper errno value in nlattr
Message-ID: <aFlcsaJuwG9HQf6S@mail.gmail.com>
References: <20250623130626.716971725@linuxfoundation.org>
 <20250623130628.151124578@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623130628.151124578@linuxfoundation.org>

On 25/06/23 03:04PM, Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> [ Upstream commit fd5fd538a1f4b34cee6823ba0ddda2f7a55aca96 ]
> 
> Return value of the validate_nla() function can be propagated all the
> way up to users of libbpf API. In case of error this libbpf version
> of validate_nla returns -1 which will be seen as -EPERM from user's
> point of view. Instead, return a more reasonable -EINVAL.
> 
> Fixes: bbf48c18ee0c ("libbpf: add error reporting in XDP")
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20250510182011.2246631-1-a.s.protopopov@gmail.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/lib/bpf/nlattr.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
> index 1a04299a2a604..35ad5a845a147 100644
> --- a/tools/lib/bpf/nlattr.c
> +++ b/tools/lib/bpf/nlattr.c
> @@ -63,16 +63,16 @@ static int validate_nla(struct nlattr *nla, int maxtype,
>  		minlen = nla_attr_minlen[pt->type];
>  
>  	if (libbpf_nla_len(nla) < minlen)
> -		return -1;
> +		return -EINVAL;
>  
>  	if (pt->maxlen && libbpf_nla_len(nla) > pt->maxlen)
> -		return -1;
> +		return -EINVAL;
>  
>  	if (pt->type == LIBBPF_NLA_STRING) {
>  		char *data = libbpf_nla_data(nla);
>  
>  		if (data[libbpf_nla_len(nla) - 1] != '\0')
> -			return -1;
> +			return -EINVAL;
>  	}
>  
>  	return 0;
> @@ -118,19 +118,18 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
>  		if (policy) {
>  			err = validate_nla(nla, maxtype, policy);
>  			if (err < 0)
> -				goto errout;
> +				return err;
>  		}
>  
> -		if (tb[type])
> +		if (tb[type]) {
>  			pr_warn("Attribute of type %#x found multiple times in message, "
>  				"previous attribute is being ignored.\n", type);
> +		}
>  
>  		tb[type] = nla;
>  	}
>  
> -	err = 0;
> -errout:
> -	return err;
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.39.5
> 

The patch ^ is ok. But the rest of the letter below is unrelated:

> 
> wer/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
> index ba0d22d904295..868e95f0887e1 100644
> --- a/drivers/power/supply/bq27xxx_battery_i2c.c
> +++ b/drivers/power/supply/bq27xxx_battery_i2c.c
> @@ -6,6 +6,7 @@
>   *	Andrew F. Davis <afd@ti.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> @@ -31,6 +32,7 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
>  	struct i2c_msg msg[2];
>  	u8 data[2];
>  	int ret;
> +	int retry = 0;
>  
>  	if (!client->adapter)
>  		return -ENODEV;
> @@ -47,7 +49,16 @@ static int bq27xxx_battery_i2c_read(struct bq27xxx_device_info *di, u8 reg,
>  	else
>  		msg[1].len = 2;
>  
> -	ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	do {
> +		ret = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +		if (ret == -EBUSY && ++retry < 3) {
> +			/* sleep 10 milliseconds when busy */
> +			usleep_range(10000, 11000);
> +			continue;
> +		}
> +		break;
> +	} while (1);
> +
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.39.5
> 
> 
> 

