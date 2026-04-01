Return-Path: <stable+bounces-232839-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J4iOEpjzWkHdAYAu9opvQ
	(envelope-from <stable+bounces-232839-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:26:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BFC37F3FD
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 20:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9B8C304ADBF
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9989E328B71;
	Wed,  1 Apr 2026 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYF6iYVf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613A2DEA6B
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067639; cv=none; b=cW+EaUaTX6OB7LWSgrt5kudxxR5fZrfmd2RZ+et+kiLnV9mBgIx+DoAkJ8zCov7SMaNeLZkKPoCzJg50AA+9ub1CKx3M6V7Y+wEJul2ocG1Wn/SOkvblOb+H4EPyrK50ZMjyQhgKIwaFEE3Vzy0nYpXNFp+4J9242f6xzB4NZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067639; c=relaxed/simple;
	bh=0+BZSA3mYDR/LzPwwVu2/cfe6MfOJaq1pvVv3+j1Rpo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ev5J2NM+Upk1to4YxbukIrjIcxhKtWqQTgwZnp/zpWXS45KgCe0iie0uPpPo3Xf+nAdGI2RDWnN1b6D66baWfLyWvA3Wv0A6P8r+zrtoNEDgKiU/ccqALj0uB2sJo6Pj4Fl13PuBNIeKbGbsHjE+Kqeo8qvtJKZbgpx/AbcaIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYF6iYVf; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf7190580so11347f8f.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775067636; x=1775672436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JfFB1XI4oKlCRus1Z6ZKueDQPDMr7i9ooRJ3XtcgH9o=;
        b=HYF6iYVfRCLf5RDSFTDOSaMpe6yit0X9hUbhOqL7LiT2jhD/4UUE6Vxtm+SipnPEdl
         zxu1q6vkpFQW2YW/zORbrQENOb6CltYZvHJKH1XU7GBrGJaOf4eABHCTV+mCynfxgaps
         NQlCM/kb7ZG1R99tK2ZLhCtVYs+GGAM3T21Lf0K6NwVDAyfUD+ZceHWeYbSRU0e86tUZ
         SxsfK8+Ko1Qk8q3+ZJ1RgdBjffgdBFM53HaV/bO3Lq6HK4v05WAMcKUlFxtsUvzuqsFj
         RxwVDEcBCG7DDldflTmXShNFfNtBve627GaXk2/ja/zZhSDlL3MGLsZscZEgs3KGbIBr
         UfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775067636; x=1775672436;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfFB1XI4oKlCRus1Z6ZKueDQPDMr7i9ooRJ3XtcgH9o=;
        b=CX3WDR3ja9rZMLx2R21Ivc+toBGUAn06sso5FR7l8c60R+JyTLsBUmf/AF4t4gLfvr
         iItnkG0/JHB30ESb+9EJqsUlMJGUiuFYVBGOxLk+kcYpBdt/OVnSbgtB/1dvqbtuERyY
         NEw9/gGL7hW6wA+5U8RkfDkL/h57hGg9ombZyWIgNQv1lxNQ1t8exaThgWiKI79TLtHp
         ZxevMoNL56fb2uQFsc+ybgXkMTvWTBcMQBm3UwTSylUtLAIlGbBsoQcS7Ra58oWAEEIY
         kTO1/cbY79qmDQ0l4dadEEZHWHY2/3D7pHdbD75bTv8KmWM54/wMA6KqDhjetERhRo/3
         zRMg==
X-Forwarded-Encrypted: i=1; AJvYcCUXKYug9v10cAJAFvCz08n6fGpnV7ucOjHRGyffh8Kl6hxWhO+9CCKJdVKhm7AQF96Zh1kP8Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJU+4XopVxERQVzXKqlBoPLhIBu6eRfLCzNERa5AIpviXdHWVN
	I4wUmCkKb2EFoalTJuuqgAdigJZckW58Gn+Z+zkwDlVCIn2ag+8Lg/1l
X-Gm-Gg: ATEYQzztsS7Qdi+bJwon46KN+y7z4MjaHWAlq9teyIQ3QO02oBbsArH0XdQQE2wdIEP
	CBkunOWFsDoYKcRii0TGNCwOEp6GTYGp67pxg62J6APBaLudAA8JAbCUuLWqsqf8/F39WzXgOEd
	IK6Cntis8LpYkZR82NDVMEYkSMl0ORN9pyDwSqWieqA5gLbVKKSRlBr9YuWvT6nNsJDf7MEGS4l
	jyUVFqBkb0AdTVYYlf/dWtXKriXKPpthOiop3eJzBRSIqDs3GL7jfnzIA+LJukwOoacT7FiAxxf
	fdUH51BJK7lLmg8jBU9Yuzcc+NBCrzWfxIVpDnd42qJ9dlUODI0ASeCDuR5j0mAgDMIzTA17Zg/
	GHqyBJfy1c9PlNUvJmS9o0vE292wBSGuOln3mcTTnGle53s3ncXH8qY82J24HRpn2XSH7N9+mMt
	zZhVQcc7dfWIxLkIZzO26MEgjaYS9pltzd4xhMFr4MPbRuyOQL1aUvAgE6rqu1tfWoNlKqXMOxE
	z5rIkRTQePcsRV/6oXxDZ0OHBvL0RoaW00ccPURWDHurdPirztrwMueQ5wPJreVUQSvxe+KkjnF
	cOJzHvwTyL5lSZMcaEV7FCubJ5NPxMQYelzXE2w7YHr7HkZ9asDGVG10SaAURG9HcJXFg85LGVn
	UoBoWyxmspMjjxepkPtKDCJMoJcj3mIGKEbn/
X-Received: by 2002:a05:600c:444e:b0:486:fc61:541d with SMTP id 5b1f17b1804b1-4888355fbb4mr42936945e9.2.1775067636369;
        Wed, 01 Apr 2026 11:20:36 -0700 (PDT)
Received: from ?IPV6:2a02:1813:4880:5700:9afc:84ff:fee0:5961? (2a02-1813-4880-5700-9afc-84ff-fee0-5961.ip6.access.telenet.be. [2a02:1813:4880:5700:9afc:84ff:fee0:5961])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888955d711sm33142565e9.9.2026.04.01.11.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 11:20:35 -0700 (PDT)
Message-ID: <c77392e4-eb70-4f21-b072-e6a6de2f8e59@gmail.com>
Date: Wed, 1 Apr 2026 20:20:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, alison.schofield@intel.com
References: <20260331161758.909578033@linuxfoundation.org>
 <0ab3e776-1462-46cb-996c-f4406c84756c@gmail.com>
Content-Language: fr-FR
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <0ab3e776-1462-46cb-996c-f4406c84756c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232839-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francoisvalenduc@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 45BFC37F3FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>>
>>
> For me it does not work. systemd fail to start the virtual console 
> setup. I am using luks to encrypt the root partition. When I type the 
> password, it is always rejected almost I am 99,9% I type the correct 
> password. I will try to bisect it tomorrow.
> 
> Best regards,
> 
> François Valenduc

I tried git bisect, but it is quite inconclusive. All commits where bad 
until the end. So the first bad commit is this one:

commit 43ee946d8339fb35944b67f598f940814ec139d3 (HEAD)
Author: Alison Schofield <alison.schofield@intel.com>
Date:   Thu Feb 26 10:44:36 2026 -0800

     cxl/port: Fix use after free of parent_port in cxl_detach_ep()

However, reverting it does not solve the problem. 6.18.21-rc1 fails in 
the same way.

Any ideas on this ?

Thanks in advance,
Best regards.

François Valenduc

