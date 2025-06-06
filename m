Return-Path: <stable+bounces-151572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F50ACFBB4
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 05:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1EAF3B0877
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82518C031;
	Fri,  6 Jun 2025 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqLE2VND"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2202C324C;
	Fri,  6 Jun 2025 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749181662; cv=none; b=o6Ub6RHg54KKx7306/JMmC8Yi7tfGEsGC19A0Xrdgy7IpRiT1JUi7sBUOeKkiX/EBej8pAbmHWpJ99NaipWucBcGluFdWKBJUwAdTUQAlQqP7T4YiyaDsvOAxzchvEB92Y/sAVCGt8X3mu/qp7hVXLG6+tC3UNkKTb22wlWWz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749181662; c=relaxed/simple;
	bh=2NMxuTL0gu7ifpRUazjZpgZ8fKXD2KWHPJLk3dFMSSE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lZINauX/b6nxeBcTWqYTGyg1ua9DIMc79zNYdQj5w0GXAyC6WdGOKpGakq4J05w53DtP6Q+St9z+uTdVR7+97VnIbqkyLghAiFLPx4ilL/tR2XFZweQrRttSjWAVXXUu+lerXEF7O6RLDyYapj28Swyt8tbjOebBjLXpUyI2c2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqLE2VND; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so2511798b3a.0;
        Thu, 05 Jun 2025 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749181660; x=1749786460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr2vvCKQAF0INUKCLuc8SKZUA7cjJKU+AV4AIvcmXhc=;
        b=YqLE2VNDBN2rB762+sedi22OENh3Arpvs8TEhznklcewuk7R5zraU4AkASJrvYXtL5
         ck1Ub92LRIa1sghAlJ4Ci1pRPhDN81i/v9Y2K9tov4AYFbjIv3X25muOqZ/sTVJLTNO0
         n66EQtwjE7o44dyhGw66LO++koD+oynNDibFZ8yvHdok8V8iKJe2BU4pgvJka/tBtAum
         2e9giwOcXIT5lwWjZTH797PnQ3A47ppDvOuF/GqdYOQRQxs6hgphXvTrSVrjCO5HSxcq
         ncvqvYaMHLpgqMSxelrvNam2ymxFVSWS90FQihovmYv5gEGgqlfmjuIrXIv3WOxdI98L
         LjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749181660; x=1749786460;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lr2vvCKQAF0INUKCLuc8SKZUA7cjJKU+AV4AIvcmXhc=;
        b=EIUnW3vw60XTwEKFcGmuRxATm0HZPJ5maKoOogfJXj+Fdq893ADPOUfli4nYG6SxZq
         OSLmcLH/Ao7fqnypVCRXc71O6ckCmRZgrQdLNijTbmM7R1UgxOSwdvMaqEWR+cLFIQdc
         lkl3Vmv+alBLGDLmaRQ8vl5/zhtUIDuGhICA5B01KT3j9n+OaBqcQfEd2BsI4YSK0ayZ
         H/3Ki9DO5L2UDdLV2kERuR2ogX7uoaah/436YxvUUvo42ljvWlLCV1D6jx6XIYpJEjxF
         3XgU5j4OUtKocNk/JANemAeGYstIzpOckA67smWHn14327eVVpjrt2RNs6K8XrTgUJ/L
         8gQA==
X-Forwarded-Encrypted: i=1; AJvYcCVwI3JoR3SmF4eC18DbrSwnquBJNwzqB9NS2/ljMUjsTDn5TY+88s5O+4eW46y6tVwghPPPPNTi@vger.kernel.org, AJvYcCW2wU/E7TgMQVgx4ldkerl3NL+AZiTDrFlwYUyq/p8i8pybbtMrJoPfujUR1s8rM84vlMnoIjjjkaCsFqvZc9+d2GmvFA==@vger.kernel.org, AJvYcCX8aW8VCEDWNrscegI8FqG9y5Q6cECa96H0Q5fT+vvuwGV0RfnDsoXQd+sgVuVKcMUf/yiqTSxrCD9yZyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy86f5CcEjJCckJ3am2cjc/GO0Y7SNEo52GhNEn18VotbcBt7LK
	xndn+hu3Lqq8x3rI45Ovlovc7Oq2aKW+aW0LKm07UFBk7CRh+LBxZDRH
X-Gm-Gg: ASbGnctSAl94vmaw/7P6AtiMq0+NyjkMLIrvmk2TsXD0S4hGLRN0hgp4QSIEFCptAOX
	3SH/h+OFw8qMuyWCOfjEw4e9zWP9VJCqGhJ4vDDEpYnpudgU734czVBHuku6ra53R67Tfu/zl0I
	fC7p8/IZ80UIPkaJDmqipfKcijnpz8AA7yjdWFmNU4qa+a9eYJsD7naT6NITW7EjFjMsajP1aMr
	Kmie9aeei5e4dfzAXdG2PLbGMugQAsrkeHxu4BAY3A7UyOKxchZRkUGJUs4bXdbmbEVoxb1/+cX
	k8TZDjlj/i5U3VBEnmS148d9ppJ2wxY6Z6ihkN0YJA0EZYW6AATDe5Qj6twUyPUeXA==
X-Google-Smtp-Source: AGHT+IF2sQQ5dDUhEWpDErUQAEcTihmeES3m1x3jmzqV/MK0NFzGtiOQtqp43btFMj4+mW4UJ5XWbQ==
X-Received: by 2002:a05:6a20:9392:b0:1ee:ab52:b8cc with SMTP id adf61e73a8af0-21f21772c3emr1513246637.21.1749181660509;
        Thu, 05 Jun 2025 20:47:40 -0700 (PDT)
Received: from [192.168.1.12] ([125.235.238.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f895274sm386464a12.68.2025.06.05.20.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 20:47:40 -0700 (PDT)
Message-ID: <bc6ea194-d86d-46d5-b62f-128af7016bae@gmail.com>
Date: Fri, 6 Jun 2025 10:47:37 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: i@rong.moe
Cc: hdegoede@redhat.com, i@hack3r.moe, ikepanhc@gmail.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
References: <20250525201833.37939-1-i@rong.moe>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC
 polling
Content-Language: en-US
From: Minh <minhld139@gmail.com>
In-Reply-To: <20250525201833.37939-1-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Tested to work as expected on my ThinkBook 16 G7+ ASP (Ryzen model) with
the following:

- Fn+F4/F5/F6 inputs, more responsive than before and no shutdown.
- Previous issue with suspend including close lid, sleep button, 
mouse/keyboard during suspend cause shutdown has been fixed now

Tested-by: Minh Le <minhld139@gmail.com>

