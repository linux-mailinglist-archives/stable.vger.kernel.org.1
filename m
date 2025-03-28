Return-Path: <stable+bounces-126921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2343FA7465F
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 10:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64FD57A547B
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E86213E74;
	Fri, 28 Mar 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="sU4xkTDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D1213E77
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154193; cv=none; b=SkqOXOWo/ktzCnxTug3GuigDDraRnk6lvjiIkocwEWzv91AU6acXNxHK0PMy4XQR2mfLrST9nHd2421/UyLQAtqGEaGhefwbFekqZxp6Ql12nB+MfH23bm8T+xFX37O/c4o0LNcY2VwEMwFv0YC8f0CxPJWp1i5I6y8gD+E/kP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154193; c=relaxed/simple;
	bh=YFPp9WWr4Tv2T63WZi3Pvgti8ml4lgh5//Cy6S6Rb+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8YzTtdsxVXwHcSoSFlC7lCsa07Hko9EyuU6xVOv0p7DQuH764gs2iLhHQb5hxxKnGc/4u8LWoUZOMfTccczawaHUBXn9xJ3O4MMuXtwq6PeBOofQM0dobMIwwalTmyJ3mFN8lSrXCj18+JNMl6mQCkjGMMpzt9c2CFprkWB+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=sU4xkTDc; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C12A3F6CB
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1743154181;
	bh=W0DQXE4Sz8iAfts0R9aUVRwmGkJey3qq2CZOpEhXzA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=sU4xkTDcfTW8JHeMxU1BfmxHlnvndchLBEuRffGwYH0LBy4Flx5HpayNtyRGO51SZ
	 DeryvzcM+0VjzClKS9X8kMsA6zJITV7tlnqwHpJ8QhPHDqwDeoHB4L3HlisJ5Mcbqv
	 orZWuHMddxEYvQmIxemeTcmfqFwMOb/vUFWXRvwrLNMfp9a+vMDdoBHkmOlhp09ZGN
	 DRSQlV1BthX6H4auPqR5RUflB+RCRYF+Op8B/iuR5ao5+C4Giqk228aHD813aTZQ09
	 Skp4Luf7NQyHELuBsgnloYwP2BgfF+JLmlCnNE4JjEZiV9tQ8LcnaRaWVQ+EB71nuf
	 r+EXqi/O2sJlw==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so9995965e9.0
        for <stable@vger.kernel.org>; Fri, 28 Mar 2025 02:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743154180; x=1743758980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0DQXE4Sz8iAfts0R9aUVRwmGkJey3qq2CZOpEhXzA0=;
        b=pW+wXIh15iiSvuyoNRO6aK6B2QDHX+qVq/POwjt/zFnV+3frWUdZiDNSFAEwUxKRmx
         ngoZPa5wj30+brb0ERGrLdxhHnvcTb1vM30YtI8CEU7ohtZzSGcM6C79bRlobFkwaXSY
         G4D+arcqnGLQYWzPIdVAJIGwzpxwZf2RdmDwlIJy119b8EeSLb7Zb3hnqyy4EJ8Kpx6s
         0akXAbLsPmkedG64B+YNmbAvp7d9OBMPw/OhcYFMskrVOIuPYRYMdZpyhAV6JSsQ725h
         u1ILm2xQHHldZRXMQGMEJBM8EvYE/9rUCTZgG2IFN/1ypuX1xObOaY6/si5m54vXeDwR
         jr+g==
X-Forwarded-Encrypted: i=1; AJvYcCX8Kv97WS5p33qoukaOZFKspksY2f15lAJ/EeWDbVyKFqn6iIYS2+0ZYlf9wc7RvakK8zG/JJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypXJsr/it2jNMW7W0fH+pX/5B8XuvIphxvGtKBN+U5Hpl5lppW
	IvM7zj0yVVI91wn4MrjCnHIAVroZ0OFSuP3ROyEd09GRu6NNNZ5BmJEHEQX04JtvV+eTtpjj+UD
	7XNBHlMroBB8ISzSytRkhopfOm6gmx+OTeXUcHHPBrw3+jzClojyd937Cc8irNf4xYw2iOQ==
X-Gm-Gg: ASbGncsdo6za2gzvl+YEejEx78Nsk34zCSCJ5gFTVMYS2dDYGKD00bEoLc/Ms3tL+fA
	NS9V0gAoydDX/rVSwYzZK9p9BuJhnh46aLL5rMETFO/eR6+WavoZAYOpW9zFfsqBd1zMkeqoEjs
	qw2XzSRPN89pzX7Rhn/WAMrJHhiLKmwR3Y6cEJfcpGv8529y3/D+AN7SrBBAgYIoxji/1cdsWlv
	oXeQb6YP6RC2AL0j53nh7BXmFUK7uAVw6KcTYnZGflpXbK/Q1vAiSdANIrIcXZKzldDmnpB5Ysx
	9aave9CWQH9EJqz5BgmRjFYtIUl9/RoZ2L4XUoxEQo/F81xSgv5UbWTEUgRKsg==
X-Received: by 2002:a05:600c:6a13:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43d8522cc96mr65306155e9.11.1743154179921;
        Fri, 28 Mar 2025 02:29:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRHH6+C7f9WxPlfoclpQ4muAxjcE3H0jmeXlyq7TyVvgI6TU6FiLwynF58/TpV7N3SAbOGGQ==
X-Received: by 2002:a05:600c:6a13:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-43d8522cc96mr65305975e9.11.1743154179563;
        Fri, 28 Mar 2025 02:29:39 -0700 (PDT)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f9csm21538575e9.26.2025.03.28.02.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 02:29:39 -0700 (PDT)
Message-ID: <7afc3a7e-1dd8-4dbb-b243-75bd554c00da@canonical.com>
Date: Fri, 28 Mar 2025 10:29:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to 7-bit
To: Ben Hutchings <ben@decadent.org.uk>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Mulhern <amulhern@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
References: <20250305022154.3903128-1-ming.lei@redhat.com>
 <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
In-Reply-To: <3fa05bba190bec01df2bc117cf7e3e2f00e8b946.camel@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> We shouldn't mask the input character; instead we should do a range
> check before calling isprint().  Something like:
> 
> 	u16 uc = le16_to_cpu(in[i]);
> 	u8 c;
> 
> 	if (uc < 0x80 && (uc == 0 || isprint(uc)))
> 		c = uc;
> 	else
> 		c = '!';

Sounds like a good alternative to me.

Would a conversion from utf-16-le to utf-8 be a viable solution?

