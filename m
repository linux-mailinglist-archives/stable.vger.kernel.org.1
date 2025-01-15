Return-Path: <stable+bounces-109147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2398A12807
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F25166C42
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1B14F12D;
	Wed, 15 Jan 2025 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LHA5zXzG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9614658F
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956934; cv=none; b=TwPlFoZC74NJCDvGYUe8mUXuyq1iJMHby3dA1TCL3rJ/UDlrA0b2vB+DogTnxL/BzyBOs6S/uHg1NZFzvgnB4ixA0ZIvZU2AVNO9FKRu1xiGNvpav8Ri9sxTnz0DDLsttm87pislukIYSN7e7JPIUmWteDZ7fURWMQilvs3tQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956934; c=relaxed/simple;
	bh=ooYSt/USoEcRsL+E5RG2pqHwAcATH4QY2Zlex2YNDyU=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=n7EmoJ0cpYR6pdQsWFgc9dfgtrnNY0JIxi4NENDPXs7msVt8g9PooNnJoDirLaGOWIZVgES9Akp9Rm52GKcd2sMc+Kr4yjjNLvCHh6IgBP0oTeIj3X6xY/E6PJqodgVZUz6pEToydLNgOpyzM+sAYCy5yqTadVZ11VFdhqCjcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LHA5zXzG; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1420428366b.3
        for <stable@vger.kernel.org>; Wed, 15 Jan 2025 08:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736956931; x=1737561731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glnRRdkwbnhhqV0Qbje3TwYkcW6HGVA3+UV2AwzHbCY=;
        b=LHA5zXzGR5dGh1iNySB4Q0LAUOvmQ53lOxOMSeWY2P0vB29VO3QLje0Sx6FKQbPEWX
         nXmmCWeRcetrHk8kHQ+lxrJ8ABJtNE//kIAN7fXJ6lwH/nTd0rSFVk14HLKKt/s+bbf6
         Q+0b4ElUcCi5eAMtEdRBoebzTkG09n0oLji0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956931; x=1737561731;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glnRRdkwbnhhqV0Qbje3TwYkcW6HGVA3+UV2AwzHbCY=;
        b=QcYUdAnfaRu3dDF98GWVsnOW62zhaajCkE86GN+LxsTDUdGPL+pCkJnKq11Frf7PFr
         BdigOciK2vv2ghPso+qeYpBn2r2NeOHp8dxMSq2YgGTxlotI4+AM2eBA0RvEicWJW7n0
         P5MB2JM3gzwaB4KNDAqo/tg3RSsSoETBqnRBjYL833nr5iKZcMIHoKW834Gtc2ad64M9
         Yp6sXY84QTGbtGD3srfM5F3c4DSaFr/4R+DXsBHEFuSTyUX1qT4MDXwjCGnW4DWx4jI0
         2Gei4emjhIupYfFWWWQgS5N6X82fxN5zPpvB4dUHgcZs1iDkZLMPWqleIkxYa4LZ2UJo
         aoXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg7Q+Va6uy9e5UeKX8oQsONJNSrXAs4plAdpdGb++jgiP90EmBpyl0/DGCWDrWZblhfKO2PeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwebvJixTAtwa0SZUgZz8E7V941F//HTTeouwHl0GAFdDVTdR8H
	elRlK7KhdSYEpAUtTFXxfPRHcpVpPMZfOlPdJtUzEqMU/UplUanfO++xUGNwmw==
X-Gm-Gg: ASbGncu1cML/fRf0rPw5l1xeuEACkOfhUCOy65PUZVeBs6M9gR4GToASKOtL3QfOQ3f
	g9iE770PQ53lLN62axNQJiDkayx5Zhyt6T9joa4d38N2OguWRifIihWfSBp78rwFRmYAwDrw5QA
	wUKkIvtnnMmfz9hc2Z4FGI84+SGKhtFOBIcdbppytwAC8FqgPOuY2HhAlo8u1lZrsKr4ySNxIXM
	G99aCcgiTGqOcEPHQ9CRgc33BQPYXc7yeT4R9OFIkf9y7ALH3XP4lcHKJYU9jZaRRFwYuUsqbjW
	YTZe50NnfT+krlSbxKA=
X-Google-Smtp-Source: AGHT+IFU20YNTPDooQLRDInr/5Zuj/4IAWibdx9co9oKVemVTrW5HRL73n26bZC66AHFuZXIoMEYzw==
X-Received: by 2002:a17:907:36ce:b0:aa6:ab70:4a78 with SMTP id a640c23a62f3a-ab2abcab441mr3116490166b.37.1736956929567;
        Wed, 15 Jan 2025 08:02:09 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95625a5sm768900966b.114.2025.01.15.08.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 08:02:09 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Kalle Valo <kvalo@kernel.org>, Marcel Hamer <marcel.hamer@windriver.com>
CC: <linux-wireless@vger.kernel.org>, Marcel Hamer <marcel.hamer@windriver.com>, <stable@vger.kernel.org>
Date: Wed, 15 Jan 2025 17:02:07 +0100
Message-ID: <1946ab35c18.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <173695421441.512722.1081406482312817540.kvalo@kernel.org>
References: <20250110134502.824722-1-marcel.hamer@windriver.com>
 <173695421441.512722.1081406482312817540.kvalo@kernel.org>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH v2] brcmfmac: NULL pointer dereference on tx statistic update
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On January 15, 2025 4:16:58 PM Kalle Valo <kvalo@kernel.org> wrote:

> Marcel Hamer <marcel.hamer@windriver.com> wrote:
>
>> On removal of the device or unloading of the kernel module a potential
>> NULL pointer dereference occurs.
>>
>> The following sequence deletes the interface:
>>
>> brcmf_detach()
>> brcmf_remove_interface()
>> brcmf_del_if()
>>
>> Inside the brcmf_del_if() function the drvr->if2bss[ifidx] is updated to
>> BRCMF_BSSIDX_INVALID (-1) if the bsscfgidx matches.
>>
>> After brcmf_remove_interface() call the brcmf_proto_detach() function is
>> called providing the following sequence:
>>
>> brcmf_detach()
>> brcmf_proto_detach()
>> brcmf_proto_msgbuf_detach()
>> brcmf_flowring_detach()
>>  brcmf_msgbuf_delete_flowring()
>>    brcmf_msgbuf_remove_flowring()
>>      brcmf_flowring_delete()
>>        brcmf_get_ifp()
>>        brcmf_txfinalize()
>>
>> Since brcmf_get_ip() can and actually will return NULL in this case the
>> call to brcmf_txfinalize() will result in a NULL pointer dereference
>> inside brcmf_txfinalize() when trying to update
>> ifp->ndev->stats.tx_errors.
>>
>> This will only happen if a flowring still has an skb.
>>
>> Although the NULL pointer dereference has only been seen when trying to update
>> the tx statistic, all other uses of the ifp pointer have been guarded as well.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
>> Link: 
>> https://lore.kernel.org/all/b519e746-ddfd-421f-d897-7620d229e4b2@gmail.com/
>
> If you submit v3, please add 'wifi:'.
>
> ERROR: 'wifi:' prefix missing: '[PATCH v2] brcmfmac: NULL pointer 
> dereference on tx statistic update'

While at it maybe rephrase the subject to:


wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()


Regards,
Arend



