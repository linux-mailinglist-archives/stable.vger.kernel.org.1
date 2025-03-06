Return-Path: <stable+bounces-121207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76155A547D5
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E3A3A5ED1
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD192040BE;
	Thu,  6 Mar 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqBAh4k/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF62040B3
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257249; cv=none; b=e4nIJa0H0bhYUSS5MixkbifRDEnLtrq4f7ACXKo8jV8shyf4ePERZrQreOdhFSzm3tQFjAuZTF4DiiekHZ5S3+hk0rMsxdiUGV2i2mFVShqUKmXRiOsCajCAGV3io2hzhs4U2tknNBB5qsHaRWn1aXWc+DKz0Y1/PB3RRmN46lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257249; c=relaxed/simple;
	bh=yGURFn+ZCkmJD51bbDa8/B6nnJ6U6/HiBGmfOCuuyeY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EAvVWfDHuwI8ppEQaQT4i4k2GH8/vUat4MQH8y4tgB8KSumz8m/GpjxA2PYXqZLWv45hGLJs+U3BdZp+38FsZ+HbuSjT+Uj2tI38U9kU36B3qMt/1rcXlSwVLaZIckE+3DSpq/5EcEnzUosiv1c3AIok55xbywkCyqrs4X13lLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KqBAh4k/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741257247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGURFn+ZCkmJD51bbDa8/B6nnJ6U6/HiBGmfOCuuyeY=;
	b=KqBAh4k/f5s2PU40c9cj8/Dofw7RvZbArDrXo87gWnHtLDyivbYDO//S+0UjvFdssz8FOg
	NmrR49WN0D48rEOf1GYpTsfQzb5aJWeTnkq62ncOeCtiGnSC/MsnEjo10qYhg5KD+HEfiU
	0iyLM6Obf4sWLGSA0BY0iGkIMOWCs4Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-WwVnRFLsM2GcEBjDEeBpwA-1; Thu, 06 Mar 2025 05:34:06 -0500
X-MC-Unique: WwVnRFLsM2GcEBjDEeBpwA-1
X-Mimecast-MFC-AGG-ID: WwVnRFLsM2GcEBjDEeBpwA_1741257245
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390f3652842so291251f8f.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 02:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257245; x=1741862045;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGURFn+ZCkmJD51bbDa8/B6nnJ6U6/HiBGmfOCuuyeY=;
        b=eWQGBI7ODPtzGtu9leQA+oGEZczPu9TOao1rsMMd8MN9S2zESxSDNJHzeRqgYMZN24
         S4323s/94+ZZEv+pbw0qW4XYXSwDMXZcaYAb6E/MKlVcNIC7UKRmJIjRELHwHFOKnXLD
         vm6NiPTGzGmjJZrOm96GCNyee7A+0vs8V09tfVOgWDDlG4K+v4sJoDZ0TtxTlcowx+Ko
         S7Qt1cZvakoGCQHw69sJ8AnjvRV8CQAo6sPDoFWYpmGLOHH2Fq76ZYR7g4Ppk6or3d9H
         D3NTRBY2hky9bPtRWYHqzXy7m0chaIUKE2OBYPi37ZLqW9xv6r51vahsqmAtkFyDDqPz
         DU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZGzJ5eLUKdL/LK200UU3djfspPdqhymQF1A9u7vQVRDD0FCI17ZJctNyb3oRiS7xN3ptkCYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmulX/obFM1hzBQlXoJ040rAA5JQu6aOuAXJwpfJHzRYuy11fo
	441b4YSsqlFMYqKCsa7APBFjJcoo/ljSK3adxmpbB7I5jAXyLuP6Ari2aeRRgntV9A6Jx7z/mDX
	wAVSVx9mU3YOkbmoomCw+s1Ze49QVGZ9zsjC5CdvvBm/RIC0pUCDvgA==
X-Gm-Gg: ASbGncsiMt5EQfYcaA2YsEPMyJVzJAQoKIHwcNPO2LwvrsT6CoUNQD7IErbwGamGbWB
	kotNXqr6S7vcQnZbBQOYK9wp723GfN2hxWEtmQaq7RY9/1NZYF+NFykk+tuHfzDc7c6bOTcKWJl
	xpqjjzRW9kWYH0CzuUf6E/5QLB/8R57Z5FZOhUt+9mIz32IgM7qPYDK3q1cIe22VIWPn1aW3LDU
	aQZEozOdIsLRJF53b9KZOUWyoojzQo4MZYhfGL8ZT4uf+QcLXiEECHGK6r9AKI1lk5ew7csUyxn
	EM9MQwmgs5EVIQeRUqdyFddxOyc2QZm2C81Ilo9or0z8XQ==
X-Received: by 2002:a5d:64a1:0:b0:390:f6be:9a3d with SMTP id ffacd0b85a97d-3911f7b8a22mr6853154f8f.35.1741257244840;
        Thu, 06 Mar 2025 02:34:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq+MJxfnZRYvsITHoOciv/ZW1/W7jceOGjq4qcg51CD9xCJz2rRiNw+0Xk/FSde98uIta9UA==
X-Received: by 2002:a5d:64a1:0:b0:390:f6be:9a3d with SMTP id ffacd0b85a97d-3911f7b8a22mr6853115f8f.35.1741257244480;
        Thu, 06 Mar 2025 02:34:04 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm1629808f8f.93.2025.03.06.02.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:34:03 -0800 (PST)
Message-ID: <0ec568a7-709a-4251-9f0d-7e57c12ce809@redhat.com>
Date: Thu, 6 Mar 2025 11:34:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qlcnic: fix a memory leak in
 qlcnic_sriov_set_guest_vlan_mode()
From: Paolo Abeni <pabeni@redhat.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, shshaikh@marvell.com,
 manishc@marvell.com, GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 rajesh.borundia@qlogic.com, sucheta.chakraborty@qlogic.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250305100950.4001113-1-haoxiang_li2024@163.com>
 <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Content-Language: en-US
In-Reply-To: <8ec75d7c-0fcf-4f7f-9505-31ec3dae4bdd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 11:32 AM, Paolo Abeni wrote:
> On 3/5/25 11:09 AM, Haoxiang Li wrote:
>> Add qlcnic_sriov_free_vlans() to free the memory allocated by
>> qlcnic_sriov_alloc_vlans() if qlcnic_sriov_alloc_vlans() fails
>> or "sriov->allowed_vlans" fails to be allocated.
>>
>> Fixes: 91b7282b613d ("qlcnic: Support VLAN id config.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Whoops, I forgot: please include the target tree name ('net' in this
case) in the subj prefix - in the next iteration should be 'PATCH net v3'.

Thanks,

Paolo


