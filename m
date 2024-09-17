Return-Path: <stable+bounces-76545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D8197AB64
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 08:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266EA2853B6
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3373260DCF;
	Tue, 17 Sep 2024 06:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="SWOnID0c"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7026C2EAEA;
	Tue, 17 Sep 2024 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554331; cv=none; b=HRGL30cX3z+iZPfN+bcZjpnxoaYtP8RSChErUuR7iPiOIWbIBsAEER/NkJOJyPnEbZbPL0n/jKVYUdRtBpzRJCXIqA+H1SVr3SCESDVL46xS3uetd4eMXVMWqFeibJ5hJh4hxL329pkN4Wydren4yqIXzGsgmH5yNhlKw/CzYi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554331; c=relaxed/simple;
	bh=HTgR/t1XKv22trRE6z8hqpdlihKbtSm/+x6REtanlgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jaN0tKay4oT9uSeMonSS3DSHacZBTMk198trCzX8hRpu+dzi9B+i8o74VVlkke5qYse6bK/iYER3GuoALpyxriNGlW/ajMO9y1XWOKAvJFIsg8rAZqFt3+KdMtVDahdY6Ubgb3eL+2h7pQfi8mxnd6Ar+GNzPMljNm26wAGdKBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=SWOnID0c; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726554318; x=1727159118; i=deller@gmx.de;
	bh=5TLILeYK7dj0Gote54iZg0/ILywdXSa/p5ih0d2o62s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SWOnID0cl/5VcbZXTS6oa4s0r9OfJpUlclqDNrYJio+WsDKFyYpQy9JL8OAoG7GD
	 YqZudONrlPfVKi/5nCIxQv8egEBpzrgc1zCfl1rzClYtI/A6zuddchKWURpDfaZB0
	 dhyGbJijTe9OSePZlnn95uRr3iP4yiQmxt10XfRdQQBqTqLDtWnFRPWJha9d0+vzh
	 3sNvg5FxZGctQQ2nWGm0VLYP+JgBEjXhV1DU9Z091Doq9Tx+i39Wy1dBycz4GosMw
	 eTTtBfM3K50pnwm9czfDYvnaYliID9frSvNVnUn9vYj+TMrv7tvffLuuIPBfcRnmh
	 d7XFR0WksM+0xobrfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1s7BoJ136r-00ZCbn; Tue, 17
 Sep 2024 08:25:18 +0200
Message-ID: <a57734e8-ffb9-4af1-be02-eb0c99507048@gmx.de>
Date: Tue, 17 Sep 2024 08:25:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: Fix a NULL pointer dereference issue in
 fbcon_putcs
To: Qianqiang Liu <qianqiang.liu@163.com>, aniel@ffwll.ch,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, syzbot+3d613ae53c031502687a@syzkaller.appspotmail.com
References: <20240916011027.303875-1-qianqiang.liu@163.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <20240916011027.303875-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kx4tRjraiBOPk4Cb2steVh2HSmGc/C+9UtsC/P8V8KGdgnwqao1
 JC9X4mQ5sSrDpUdxrX0hTPcnLRN4VV6EF39E7FWEYIqjlGwclRz0TVHRi3gNwZYkGvWILpd
 Jt+JTO10DPHfEyujHYgQH8yiGD07flbfh1UYl/H7HBnPYmkpmSD0tZHAWyAs7LRoJNMxv/n
 47dY7LUsuG+mIzZK2+M5A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P0ao2pqHCeQ=;yQie9ZOovY5ASUka2G4hexjJ0Us
 df0tEsbbpkX+4QtVOp1LLv9dzWRQWMcZaXBrVA5yWzVGoEky4xn/kykQ+bXyoErDHdCsLqrYm
 zEP/CwGpgvjzRydSv9qhEQInLPBdBTkzs2p1PYoP8IEvpyrN2a/FrkDtOU9PK7bbH7yT3IdvV
 N/luM9PycGyL69cS+Lfi18otxm6tMFGcjBhqEKQLmYeBK4T3TYw98Ytbpg9GB7M8yMaxCT4hF
 8P439ywuGTs40gewg5jDhn4XywjGZN8nfLOjLh8mDPRs6HgP2HnY6LLmxbjPkpezPTY+bkFSJ
 7nW7lsaENj4tZgezXlgES/uvAhXLrfF+W2wDzOpTZiKjc0N+eXvn3HDa3m/BJ4QflsQLoj1U7
 wBRlo9odxOC3zPwaf/iysoFyCykrF3CdOGHRF/qCdVOm69a7Kc7he+bfFXJFSFfKWFBHI1gFp
 rp9/uP/g/uG1pZ+CD70AOPLrE7bm7Yzb2EzUiFN9vMGIMuPe1fMvENKNnwRXyTd+1VJAhsUqL
 Ov/i5KekcrhOii1Nmfp9RdA3v+9a296TjcpnLKB+/JC+/XDo/4I0s7lsvT/HTIRrkKUzB+U37
 OhwXZt4ENFBJXXvItxGu0S+aL3ra3K81UM0lHBMBm63t8qBNekQYfgTH0MvwlFz5uHKYLUwC1
 34xd2e9Jat09AOBKaquRvgY9Sa9tjtqGGrhg5ZFaG9Nun7lEh0nn+v7z/m9hoKwsnCmf3sniw
 J5x3+m7ZCk8roqqy4ag0AaoOtbPdrZPBpjH90Z/T1ckxTfNXHfVHT2cOG2Tilr5VPFMjdOolY
 0gYqT9dZyG2q9cdQc7DrIGSw==

On 9/16/24 03:10, Qianqiang Liu wrote:
> syzbot has found a NULL pointer dereference bug in fbcon [1].
>
> This issue is caused by ops->putcs being a NULL pointer.
> We need to check the pointer before using it.
>
> [1] https://syzkaller.appspot.com/bug?extid=3D3d613ae53c031502687a
>
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: syzbot+3d613ae53c031502687a@syzkaller.appspotmai=
l.com
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core=
/fbcon.c
> index 3f7333dca508..96c1262cc981 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -1284,7 +1284,7 @@ static void fbcon_putcs(struct vc_data *vc, const =
u16 *s, unsigned int count,
>   	struct fbcon_display *p =3D &fb_display[vc->vc_num];
>   	struct fbcon_ops *ops =3D info->fbcon_par;
>
> -	if (!fbcon_is_inactive(vc, info))
> +	if (!fbcon_is_inactive(vc, info) && ops->putcs)

I think this patch just hides the real problem.
How could putcs have become NULL ?

Helge

>   		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
>   			   get_color(vc, info, scr_readw(s), 1),
>   			   get_color(vc, info, scr_readw(s), 0));


