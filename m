Return-Path: <stable+bounces-272708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pHBqFryGTmp3OgIAu9opvQ
	(envelope-from <stable+bounces-272708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 19:19:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B07291F8
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 19:19:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hkNIeQG6;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272708-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272708-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1E8C301584D
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455641CB2E;
	Wed,  8 Jul 2026 17:19:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449337B03F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 17:19:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531186; cv=none; b=qApPvNoFD1TqkfowrSvXyaJIAqaEonC+iwAFlwkVyDfiexZzABm9x1AsX+nIpVRb5z0L1PSgKIc5r8ux2QmcLyCZ8BeDazjJkX0Ssp5VefxCv6o8RXLhKs7xLHJXodn+ig/Y89qaZFLwCTw3BlkZRjwrKv6U8ZeOe39z5nKUe20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531186; c=relaxed/simple;
	bh=nYArZr/ivOQF0A7iQjFdsVD5vyBnmzldNwqEJH3RES4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Spzai4v4dGVjJxApf1XaOoeGastwdTkJKN1Sieog3mEZLJ0Hj93zhCXshBYttjcRWHSyGLTAB+QrtAyTgQDIeO3iiCz8ACb8wyFRPFFfluLQkruKvWt3xWVoHhCgxXGxBZw0E15TPdl28soGqVgyvmI9kJ131g3Osh25xD685WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkNIeQG6; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso667508f8f.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783531183; x=1784135983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RnsIaqmcg7oc2NYtCjzbTOj7OJolFMsogq7yyBNf6d8=;
        b=hkNIeQG6jhOH0/a64lEmkw9HBdremThmzmpzfemtRquj/sR5U2ioHD9fEQSxY7KvFM
         fdFuL4P2jqRhmNAi7OfaWX0QT8m7fO3YXn8kIaoDhoHzE7//ZsRPBUCgIwpEBdonRFdt
         B3ReVwIOO1heMtEnziBt/eYZOqujGr/tnmZGNvjWqaBIaXu5ZsY8k7oiEZ5JvgmDZUaJ
         Ulg1YPGOnHlGALu2c327lP+0J/nJBHxIBzuOtTVakiqqMeL4dGc6up44bxVwMQNBy0ly
         TtB8dWwM/iQ55argBJ6H5/tSaR/By3Oqz2Gn3w/ukE6LM+tZdq2M7/w1is1pWOMZywrO
         o9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783531183; x=1784135983;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnsIaqmcg7oc2NYtCjzbTOj7OJolFMsogq7yyBNf6d8=;
        b=K5VM4NV5aFCGsMIlDX2gvbyGSWKtlpxj0grkEa7f5D9S3+fHZ2MihffR5J4IlgBbzq
         6yJOMnrK0jD+zRx4w0ya9z3GVWw3gB7VDkgfPksd8Og6HnSPB5yjZIq/CWq/3SnvRK9z
         E4ilMm8STyUU+zAKNx6PsiV1k6EKkMly07fxt+kOiFtHSn5QXEN6THyjTBajt0hlTUZC
         qEhk4AzkqdsbHgtKvp5khmQg3+JYA17ZlYHK7/VC4swBtFhs588yBXI3H0bOr0Bbk/BC
         rKl6Wn1YIEX4y8VCP2HvfvscozPz82kyjG52JxCQFWjn2lWSYLx7Q/Z/4DqNxkZ2zZFD
         a13g==
X-Forwarded-Encrypted: i=1; AHgh+RoY0b3nde0VNoxFYixLGGCZq/rDGmLbUV59WFGgsYUHDG+t9WIIgBJdzsEq6Twj9YOOhsiL4+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH1sAROzxJEyYiFJq/qd1GyrsVJwIF2mfTGGGwMw9ChyzixiO
	E5w1nuUWsZ0OONYcTUqzhsNL1yA9cJCRlURYmrLU6x2J0f0DQJkQcLRu
X-Gm-Gg: AfdE7cma++YYoNqxR383iJofGkuLn5CZTBxwSdVxA0xSQdQWVx5QXifOq1fSV88NH3o
	R6MZU22WbRzJYmIYSNsGzFuo0gDKxb9MPc0ToMnvulQ0MvFlT/2Om56g0YU2Hv2mYqyUrFal3k4
	0WVRHurwS4AA4uQj9EKpVuOWWTJEb+Jp8q7jt2zq2N/rGeLBMnee3O7zIH8Fxq8VSiztKkH/5cJ
	TjPwz/0VLBKe0PPznFJD9oOX/zhhfQMtQD1V02QKYL8Cfo5HGNCOodbuGgQ+fKOVFwSwbSXiJdz
	C7Q5wJA3QcM0sO3jexq1F9GDVBJXYhdPO+QmrotpGfTgr9fhYYhwYDICaYhaFP2iP6TOwuBx8Y5
	itEU288HhLJmVkoN3JkRu4TMDEIuW60Zi+kEySBdbhOK6PlXtxPAniEatSE4d7/EllQ0p0+XkRS
	GISTNaWSBloc6szfod3ZD3oP9g2kcK8UORgbxOdyaE8LH/cQ==
X-Received: by 2002:a05:6000:4010:b0:470:13e1:9908 with SMTP id ffacd0b85a97d-47df071c1b2mr4096508f8f.12.1783531182946;
        Wed, 08 Jul 2026 10:19:42 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm47829139f8f.7.2026.07.08.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:19:42 -0700 (PDT)
Date: Wed, 8 Jul 2026 18:19:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: <Alexander.Chesnokov@kaspersky.com>
Cc: <xuhaoyue1@hisilicon.com>, <lvc-project@linuxtesting.org>,
 <Oleg.Kazakov@kaspersky.com>, <Pavel.Zhigulin@kaspersky.com>,
 <stable@vger.kernel.org>, Wenpeng Liang <liangwenpeng@huawei.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
 <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RDMA/hns: Fix arithmetic overflow in
 hns_roce_v2_set_hem()
Message-ID: <20260708181941.1ad1e112@pumpkin>
In-Reply-To: <20260708092146.3325855-1-Alexander.Chesnokov@kaspersky.com>
References: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
	<20260708092146.3325855-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Alexander.Chesnokov@kaspersky.com,m:xuhaoyue1@hisilicon.com,m:lvc-project@linuxtesting.org,m:Oleg.Kazakov@kaspersky.com,m:Pavel.Zhigulin@kaspersky.com,m:stable@vger.kernel.org,m:liangwenpeng@huawei.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:wangxi11@huawei.com,m:liweihang@huawei.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272708-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pumpkin:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kaspersky.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F01B07291F8

On Wed, 8 Jul 2026 12:21:46 +0300
<Alexander.Chesnokov@kaspersky.com> wrote:

> From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> 
> If hop_num is 2 or 1, then the expressions like
> i * chunk_ba_num + j are computed in 32-bit
> arithmetic before being assigned to a u64 index field,
> which can lead to overflow.

When does the value overflow.
Yes, the expression can overflow and the result is assigned to a 64bit
variable, but I'd have testing this code would have showed the problem.

So what is the customer visible impact?

	David

> 
> Declare i, j and k as u64 so that the address index
> arithmetic is performed in 64-bit.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for the contexts in hip08")
> Cc: stable@vger.kernel.org
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> 
> ---
> Changes in v2:
> - Instead of casting the operands to u64, declare i, j and k as u64
>   so the index arithmetic is performed in 64-bit (David Laight).
> 
> v1: https://lore.kernel.org/linux-rdma/20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com/
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 1c180a6b1c07..3469a9a68d3b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4238,7 +4238,7 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
>  	struct hns_roce_hem_mhop mhop;
>  	struct hns_roce_hem *hem;
>  	unsigned long mhop_obj = obj;
> -	int i, j, k;
> +	u64 i, j, k;
>  	int ret = 0;
>  	u64 hem_idx = 0;
>  	u64 l1_idx = 0;


