Return-Path: <stable+bounces-89270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5E9B5682
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16ACFB21694
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668220C03E;
	Tue, 29 Oct 2024 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MaN2mMHf"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90B20C33B;
	Tue, 29 Oct 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243228; cv=none; b=cJM506wIMatalKOsV+tRO1gL0xRRwk6yGpCQIwb/DaQED/QeTCudlYXD1ZSfmIqYOS/gGtMjw86gtDMu9oyQQk6tqPK1E2IhoAnVZQY/cjCOwPtxXUaFl/HtfJCI6Cga9t77VB75hoFocmG5gm4qiDG7L+d40px7MFUmB9W1prQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243228; c=relaxed/simple;
	bh=LS0YRJHu3A8iH7JzTPwiZAZ+EhA61ZxRflL9vEOtVmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJhEZmP7VsgyYQRk0yxmRyuma1Htytfnnrb43NJ6L0K5+WXl+tinvcVMnpRKSJv3cAIh2vOIrpaBfsVWk4H16udY+gM/OwkyqmPF6du2UBL6B1YLMJXTcG7wUOinwpaZBYgudCYeaBg+EquIRJudAIRJqzQ3LFI6UuINRTBE9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MaN2mMHf; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730243208; x=1730848008; i=wahrenst@gmx.net;
	bh=r+KwVTsesl4ttQu80egOPD9HHxdn/eJS50zewzoUDf8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MaN2mMHfFFdIHzCmLobfG4sbJyNOlWbv3oiH8f+sBpVdKyQS60fStgoPs0EqcdVK
	 G/2E72tOav65bAUoHJe8/US0PbnJBLr9c1/+PF2pIRxG+h+sd0HM8IibwpCwR4N1G
	 lge0D0J8JNIuHBTU/WHp5w20gogn7ATDqMLCaaHARdoVveurCh4d9ySoKGb33ZmiR
	 4UGPzSgjlo8USJLsh8M+OnWEfX5rx7CQhffJRYA5Owno6+hzvXuCgzLTpgsxnuwYU
	 5WXEyO3IY9CB/l+nuS/OcFCbBgX/NnS8FGtBvw0XGOVic8XJaQGBXAbPHVTDVJ0wm
	 czerNiy99uy4kKSA6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1t7qAj1INt-00FTPv; Wed, 30
 Oct 2024 00:06:48 +0100
Message-ID: <ea4842c2-7c65-4d45-9964-1a1274d29ea4@gmx.net>
Date: Wed, 30 Oct 2024 00:06:46 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: vertexcom: mse102x: Fix possible double free of
 TX skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Simon Horman <horms@kernel.org>
References: <20241022155242.33729-1-wahrenst@gmx.net>
 <20241029121028.127f89b3@kernel.org>
 <10adcc89-6039-4b68-9206-360b7c3fff52@gmx.net>
 <20241029150137.20dc8aab@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241029150137.20dc8aab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RbgypJ/eQcQqQ2v+0ap98pZEGXQnozJHh8a24hlbBKSR4BLY30d
 B+G9k5qumGJD52gYrEJWV/jrPwUhaWZrSgp/QyivUhCacfXIGKbQCnWo92EP/SLmJNTBtQH
 kliMHveXFX+a6x3Jc5pm1Mr/ijjIP2xlkuRicB0jYNea5KceHPeRVvIBFQUTpRdkFEYkbpq
 pB0R+xiDiK/Dmmxn3MOLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ejx3F0vDcbI=;jcDdBVKAqfs4nq8UddL/nwcw0p1
 qRYSGBqZh9o3aNt94olvvGpJVm9L0HX8gtK8ktRqsI+2EdUJh8DBguFqkKM/gSKj9Xxbv4cRz
 XkHR5KmGn9K34bN5b/ErnaUUMkInAI7Suv9xapvQvpvcIQE9Zh8rzP/B1PPdWxudgiAbjSXxi
 OtEOiFWEaIaqtGLlr4gHv4XtXsaz8n2sg1TSs6gMRtEA0fjmU8gkhDg2P3D5pF0n7zcOGdoPU
 hpcsa5PpKsA5R5Bck71lx/0e+WKXCFkjzGDglH2FltbR77+E6i4sYxrBeD43+jAVOoZ2S8713
 O6h8JVJII7XINH7iaUNMfjJfh2zVpH8c7dz2vRD4CGS/yQ+Zk4dOg5bmppyF8gQeQFaZsrJnP
 0l2JspNkTy7TeMQkL2pGjfblk7lY2tPfx8lmpN3YUfKv6Hp83G8yyn0ibvDSHnUDBBwOvgqh2
 D5tpqIb9xtF3Sg6bRU5YB11eWTfhWz5Q3BGHGYuBVNWyPU1Lgw9ZEE+2mo/gka9TQR6Aw3ccx
 QAuue+pcD/AKDjMXo8s1tKg1rkkW3Iik2e1HC+kZjYqCouldEo12K2ORS10nd6tYnjIUqBc7c
 kaMEGI5i7JIovjsUoVsIJpslKCy8VmjObBnMShg4qxDW9aGAH0ctuGu2X/xPsnKwwtjl7D5JY
 Nv70jap6YmKs9lUqtV7VRl0kIRAGxpO3dblHHpNhazoJJGdZLThYkR34ohwtQQUCl59L85qOK
 xP84xBat15/Sl913s7DoEylb4Ee1uIcK3kGEkQBEOkNKWRM2iNUNHrImRqRpPJEhV5DmHBE08
 hOKnFQH1up4Z4X/xlI7yJ1XA==

Am 29.10.24 um 23:01 schrieb Jakub Kicinski:
> On Tue, 29 Oct 2024 22:15:15 +0100 Stefan Wahren wrote:
>>> Isn't it easier to change this function to free the copy rather than
>>> the original? That way the original will remain valid for the callers.
>> You mean something like this?
>>
>> diff --git a/drivers/net/ethernet/vertexcom/mse102x.c
>> b/drivers/net/ethernet/vertexcom/mse102x.c
>> index a04d4073def9..2c37957478fb 100644
>> --- a/drivers/net/ethernet/vertexcom/mse102x.c
>> +++ b/drivers/net/ethernet/vertexcom/mse102x.c
>> @@ -222,7 +222,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net
>> *mse, struct sk_buff *txp,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 struct mse102x_net_spi *mses =3D to_mse102x_=
spi(mse);
>>   =C2=A0=C2=A0=C2=A0=C2=A0 struct spi_transfer *xfer =3D &mses->spi_xfe=
r;
>>   =C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg =3D &mses->spi_msg;
>> -=C2=A0=C2=A0=C2=A0 struct sk_buff *tskb;
>> +=C2=A0=C2=A0=C2=A0 struct sk_buff *tskb =3D NULL;
>>   =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>
>>   =C2=A0=C2=A0=C2=A0=C2=A0 netif_dbg(mse, tx_queued, mse->ndev, "%s: sk=
b %p, %d@%p\n",
>> @@ -235,7 +235,6 @@ static int mse102x_tx_frame_spi(struct mse102x_net
>> *mse, struct sk_buff *txp,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!tskb)
>>   =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return=
 -ENOMEM;
>>
>> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_kfree_skb(txp);
>>   =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 txp =3D tskb;
>>   =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> @@ -257,6 +256,8 @@ static int mse102x_tx_frame_spi(struct mse102x_net
>> *mse, struct sk_buff *txp,
>>   =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mse->stats.xfer_err++;
>>   =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 dev_kfree_skb(tskb);
>> +
>>   =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>   =C2=A0}
> Exactly, I think it would work and it feels simpler.
I didn't test it yet, i need access to evaluation board before. But this
change will behave differently regarding stats of tx_bytes [1]. The
first version will include the padding, while the second does not.

[1] -
https://elixir.bootlin.com/linux/v6.12-rc5/source/drivers/net/ethernet/ver=
texcom/mse102x.c#L445


