Return-Path: <stable+bounces-177888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C35B46408
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 21:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F616D64B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E4283121;
	Fri,  5 Sep 2025 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ql523HgQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933EE55A
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102334; cv=none; b=eLOTZvNa3CVJJ1hdCfgfcIT7BGshy5SjzeTHEoO6j4N9scrZdgog9mcq73VV5EnODlj6hcoILI7OLU9cFKVpxqNuAqD5T7LgwDuEmlAsQR7LayQFsLl865K7Roro8+BhUnnctsqdnbIhh7ZwinA4cBe7bw3OwY/sde8oA/jN4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102334; c=relaxed/simple;
	bh=iNdSyDejzshlaj9Zw1X3pvuMAqTuAUgjJDLVld+JHyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIEzAn2PV3UNG9ctl/sWI/Fml217hITySqQQqZnfotprL2KkX8PVqMMYEET2QxQKPUWL9FqBDDxntsLzgaq75YPR8fZdZCODBByoyBCC3QmDowo/WZwmz+ZTjqp4a4awRESbzH0HN3fKAAiyf2iLAUpEEN7ActvfG3Pjy5XI1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ql523HgQ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-601b1535047so155116d50.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757102332; x=1757707132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehx7g91KCn3SyyhBVCzxIh0lsM8Vttpa6Qh9BKhIDZc=;
        b=Ql523HgQlT43ect6/IntwO3axG3OROx0odyew24EVkFq0u0qHImB+pL4CS9pLuTw43
         2kXGG8ZEEHvJ1v49W8pjLZzpnWfEMSL5px6vZBTx+G7Gk0fkqe+z8Ci5d0N5uS9yYy50
         PXer2P6dF5mTLMdLQ/VDDsJ4nIycXpwbw00s0h9T6ax1BNsRfB1bbNkVrcBD/UoAI9j0
         WErNwMGaAfN6co50tUzP+a499UsAqHix74vmsrMCA3szaYh1yqGXJNTvj1d8IpgYZ6qF
         i74o03/jyGksKM4T2Br90kWDRXzOLhKVexSUJ/2Oxc8oX1//T1jTPKs2z48FoMnhPcpK
         pBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102332; x=1757707132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehx7g91KCn3SyyhBVCzxIh0lsM8Vttpa6Qh9BKhIDZc=;
        b=jBVKeEqtd90ujmcR+MNPxNFmPUr5PPHrNKOY4DtVHWqT+y0JKOsmDqLvrFj2wiSdkh
         SdUTqz+bOlFXKvAxm1pBBHgGlCx99oR8fk3XXdQfIxCxoet0VhvaYSnEiNoA7AyinCok
         rj3lZFUwOdLojoqu/fJnGfnbG84hGbRpQTIx8Eern8X5aqJLVqpviljF5/fvFsiRu7R0
         mtUycJpB1fS7kcNCd/GXpKh6W0WUzRR9wNCVcQS2o8Na2KPlXpR30bqTsspCPubDSM8w
         KPQtsl2PyPwpzmYw/cake9SuGprKYrsy5EncrO/QfOo+RTRb19qHMsaQQ/fEjTZ7WTo1
         2SWA==
X-Forwarded-Encrypted: i=1; AJvYcCVd7/lGOWq658UYaL1nNsQcLgO10mklxXLoZTzBw7RNv5LXDE+aAIx1napCPLRPlv6PT6H8OLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdR+puPjH1oheEwH2SYrJr7ebMkLaD7Hv9GQvKd4M/SYiNu+QQ
	NLFM2x+LQBduSCZ3Z0LUmZa4WgnWEEdHXQHSsbn1gIPyINzQQJHAjHcpwQmwGvek4CM=
X-Gm-Gg: ASbGncsJzpY96Hm1ZGPGUxFNrkCvNjvzkj6O8Djfvs0LTMivpmtw/osLqFOyz/22HBR
	rPDI6/mkhY7HhJ7M5WAIB362JfoYl7e1mQhKL8VAQA6vwuGSDl2GdxUbhsE/JLmIoJgFvRdHhxm
	wFDkX7r79ZxuGcvhnr6lXzU1o3ytc5fZl50spEXHU8zda/sRcC8rRYPEre+TpTWAfiuH++Q6l+L
	pozxe4lm0EaMXVU+4ryJxL1TJph7mvKqSKMg6nMXsUHGHFTwJjxcLu/QeUsveqIqDVWrB9psN4F
	QRbAb6YbwOPMdkYeX+g2zgOAq0jrPUKEp9rsQ+hn2f7kbounEaFlKzkBSFLdlVdLCFZ4eAMsbYM
	jEwycox4LxLGn98YW+aAFTXMIOP3T4A==
X-Google-Smtp-Source: AGHT+IF0YG269PD1kxm9h1z56UglbWN0AR2Z4gUkNF8/nvYEZASXFqHqthUEY3y/R49lPBhxVgpbvg==
X-Received: by 2002:a05:690c:3804:b0:722:875f:2cb0 with SMTP id 00721157ae682-727f5e45ec8mr862137b3.49.1757102332315;
        Fri, 05 Sep 2025 12:58:52 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-724c8ba45b2sm12366177b3.53.2025.09.05.12.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 12:58:51 -0700 (PDT)
Message-ID: <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
Date: Fri, 5 Sep 2025 13:58:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
 syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
> index 5ce332fc6ff5..3b27d9bcf298 100644
> --- a/include/linux/io_uring_types.h
> +++ b/include/linux/io_uring_types.h
> @@ -648,6 +648,8 @@ struct io_kiocb {
>  	struct io_task_work		io_task_work;
>  	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>  	struct hlist_node		hash_node;
> +	/* for private io_kiocb freeing */
> +	struct rcu_head		rcu_head;
>  	/* internal polling, see IORING_FEAT_FAST_POLL */
>  	struct async_poll		*apoll;
>  	/* opcode allocated if it needs to store data for async defer */

This should go into a union with hash_node, rather than bloat the
struct. That's how it was done upstream, not sure why this one is
different?

-- 
Jens Axboe

