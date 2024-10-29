Return-Path: <stable+bounces-89257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F19B54CE
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1742B1C226BF
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 21:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FE209664;
	Tue, 29 Oct 2024 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="f+8cK0yC"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEACC183CD1;
	Tue, 29 Oct 2024 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236533; cv=none; b=YQiI48TekZv3NXETC6boManY+z1XkwOWKQZHULfw+SV6WslXaYc+vo8Djzmst7w0VvptLgFK4LQwUDjDgAO9I0Pw1rTA2l1Q9hhspwfLXcwMcSAmrJu2E2fqy9ysHTX2E5lFeRmJ3QYBdeKPMpq5EMLzd2mDvY1y9Eh5tDDHZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236533; c=relaxed/simple;
	bh=g1jEdbLV6aZ5vrSeCtCKjDXncliCBAz1Tl/5g483z48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTw+/K5MomQ74q3a1hAFlMw2tnTP0EWypHCdVEjJJGEGQi0l3BUAIUwxJJpuqnpUbBXY+Iqb6rnjGeaITdoZDrxsN6vaEaLSupTTNDuZ2CX7qoHPdawH12dsOB3twfXi+Gt6Rd90ZlJ4ex7zgbGNy3ZlW6rPhUFOcvP0qeWGvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=f+8cK0yC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1730236516; x=1730841316; i=wahrenst@gmx.net;
	bh=RG1i4lQ78d9OJfsfAWh3U/u88YT5CuUOUixW0R8cyLM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f+8cK0yCVZKsJX1GXHavfPT1wHTqSbqYIk4txHriKUic6jDUvXT2fhr/EnwwEKu5
	 KwTSfaYt5tYSyMyJVPXSNGaY1+4Zt+Fsm0T90EAkopF8iAX+He7H7f63FBUAtL2wc
	 3frMksd17zJxY6QnDVkZfTJXLG/A94GLCl3S8EKiZgjoZ4N7BhL/t2IJ5Z05x9msg
	 OGBvDCS4gYY+gLgwA+TOExD0wieaSCGpVbrnUyI3mgqoDrXOCCjprUtE/VoXKUU3F
	 W+ySUeobKh8BwJiU9/7X4uyyUe9/dwlChIXg9dpKRZw3k9zX51OBecmtjTs7nT8Hm
	 rTJz6CUzQTcOLu27/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1twUFB377B-00wRP9; Tue, 29
 Oct 2024 22:15:16 +0100
Message-ID: <10adcc89-6039-4b68-9206-360b7c3fff52@gmx.net>
Date: Tue, 29 Oct 2024 22:15:15 +0100
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241029121028.127f89b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2s+4FthblCjweeWPqCC45CSJDqCnUnZMCKae43F6COH6ujmDsym
 ETdXlHwLPPOX0katbq7gMXVcqsDCnXzBHiWhoHEHIwWJ6rP+6StOgE+GtqRhNx9AW8JiBB6
 McYXzapF/WBv8Gw8B1hjLCz6Q7IFXYVa6ZLqCRYYWcbzMTVoE3dEFqxfUVE9Atjd9Srmu9s
 Tqqlw1sFFEmGFwQm2/S6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1zR6FLu8518=;y+ZgU9K3lvgFmd+wvm6BnsFGbVI
 rGMizsMW0tk2jMSHmXBvDpEjt3P1pVujhV2ORkyt9DnKv7cQKMMuxDGoGO2yMU/xRNlUaDV5k
 alEqCL9DojWxWkmUJlbFX1II1nJnT1xlG4l84EDFENI4mSt1mTMuIEl0eOKXd4ytxuL2NFrcO
 iJd4EsCb8Yjl6Ke7X/rogb6wi6i3iTtbwsJaJAM2U6p2hwaxzmB5VFp5uQyIlMt8xep0QDUkN
 BK1vsXNQ/SPdHv4ShVq64DBTPPg875RX2E7tnF9s7Cknz/MqqWg9PQ0G+gF0MiKQ22HWXN99Z
 lPo3V37fvgfsxCQp5nWHoKJUWLNo2IUrD3sFDAQCMSQalj1O1CFP5XHxLGPduFTMyUgsZ+ruO
 G80WSplaOeLESpTjt7FEnL/0ZZZCWf9wBUv3dIJP32OL4GXpHjjsIAyQRVEG3SGSUAEbUVeah
 6bYXOp0w3XFX28RsIwXMEwI3VfosM8atXsn2S3bTmeEwvkDlpfQH1l9dM8VeZifWpbpVns3mB
 ZWMtU+VUUvJqryHx7c02tYD2w0p4G4bwIqFLO2wBoOLtfqiW2bN9OcUXghuwOinfEs4AAIdYy
 t5AMucH4MYfawI3xW/3h1uYUtuCaikPWejt9avbNihHa4nEubRAR4x+UNhWD/ae6IMlelJmIx
 sVH6rbZcZ6FXZEPTDB3c6sVH+nf+M/WBldZrIYg6LWqa+jtPsXpRzllpm5OH7eYhYh9LOvxzM
 hACW2iCl92oe30kdEYcpgkEIdOsDS0dknJBuppRqK5t9bcAD1s8BJ+B6gDwYR3jlkYHaM+Jmt
 P2LCcHQtwQyXDO/aCSO29SQQ==

Hi Jakub,

Am 29.10.24 um 20:10 schrieb Jakub Kicinski:
> On Tue, 22 Oct 2024 17:52:42 +0200 Stefan Wahren wrote:
>> -static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buf=
f *txp,
>> +static int mse102x_tx_frame_spi(struct mse102x_net *mse, struct sk_buf=
f **txp,
>>   				unsigned int pad)
>>   {
>>   	struct mse102x_net_spi *mses =3D to_mse102x_spi(mse);
>> @@ -226,29 +226,29 @@ static int mse102x_tx_frame_spi(struct mse102x_ne=
t *mse, struct sk_buff *txp,
>>   	int ret;
>>
>>   	netif_dbg(mse, tx_queued, mse->ndev, "%s: skb %p, %d@%p\n",
>> -		  __func__, txp, txp->len, txp->data);
>> +		  __func__, *txp, (*txp)->len, (*txp)->data);
>>
>> -	if ((skb_headroom(txp) < DET_SOF_LEN) ||
>> -	    (skb_tailroom(txp) < DET_DFT_LEN + pad)) {
>> -		tskb =3D skb_copy_expand(txp, DET_SOF_LEN, DET_DFT_LEN + pad,
>> +	if ((skb_headroom(*txp) < DET_SOF_LEN) ||
>> +	    (skb_tailroom(*txp) < DET_DFT_LEN + pad)) {
>> +		tskb =3D skb_copy_expand(*txp, DET_SOF_LEN, DET_DFT_LEN + pad,
>>   				       GFP_KERNEL);
>>   		if (!tskb)
>>   			return -ENOMEM;
>>
>> -		dev_kfree_skb(txp);
>> -		txp =3D tskb;
>> +		dev_kfree_skb(*txp);
>> +		*txp =3D tskb;
>>   	}
>>
>> -	mse102x_push_header(txp);
>> +	mse102x_push_header(*txp);
>>
>>   	if (pad)
>> -		skb_put_zero(txp, pad);
>> +		skb_put_zero(*txp, pad);
>>
>> -	mse102x_put_footer(txp);
>> +	mse102x_put_footer(*txp);
>>
>> -	xfer->tx_buf =3D txp->data;
>> +	xfer->tx_buf =3D (*txp)->data;
>>   	xfer->rx_buf =3D NULL;
>> -	xfer->len =3D txp->len;
>> +	xfer->len =3D (*txp)->len;
>>
>>   	ret =3D spi_sync(mses->spidev, msg);
>>   	if (ret < 0) {
>> @@ -368,7 +368,7 @@ static void mse102x_rx_pkt_spi(struct mse102x_net *=
mse)
>>   	mse->ndev->stats.rx_bytes +=3D rxlen;
> Isn't it easier to change this function to free the copy rather than
> the original? That way the original will remain valid for the callers.
You mean something like this?

diff --git a/drivers/net/ethernet/vertexcom/mse102x.c
b/drivers/net/ethernet/vertexcom/mse102x.c
index a04d4073def9..2c37957478fb 100644
=2D-- a/drivers/net/ethernet/vertexcom/mse102x.c
+++ b/drivers/net/ethernet/vertexcom/mse102x.c
@@ -222,7 +222,7 @@ static int mse102x_tx_frame_spi(struct mse102x_net
*mse, struct sk_buff *txp,
 =C2=A0=C2=A0=C2=A0=C2=A0 struct mse102x_net_spi *mses =3D to_mse102x_spi(=
mse);
 =C2=A0=C2=A0=C2=A0=C2=A0 struct spi_transfer *xfer =3D &mses->spi_xfer;
 =C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg =3D &mses->spi_msg;
-=C2=A0=C2=A0=C2=A0 struct sk_buff *tskb;
+=C2=A0=C2=A0=C2=A0 struct sk_buff *tskb =3D NULL;
 =C2=A0=C2=A0=C2=A0=C2=A0 int ret;

 =C2=A0=C2=A0=C2=A0=C2=A0 netif_dbg(mse, tx_queued, mse->ndev, "%s: skb %p=
, %d@%p\n",
@@ -235,7 +235,6 @@ static int mse102x_tx_frame_spi(struct mse102x_net
*mse, struct sk_buff *txp,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!tskb)
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EN=
OMEM;

-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_kfree_skb(txp);
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 txp =3D tskb;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

@@ -257,6 +256,8 @@ static int mse102x_tx_frame_spi(struct mse102x_net
*mse, struct sk_buff *txp,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mse->stats.xfer_err++;
 =C2=A0=C2=A0=C2=A0=C2=A0 }

+=C2=A0=C2=A0=C2=A0 dev_kfree_skb(tskb);
+
 =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
 =C2=A0}

