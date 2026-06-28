Return-Path: <stable+bounces-269456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V3k2F7GbQGp6ggkAu9opvQ
	(envelope-from <stable+bounces-269456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:57:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B24BF6D3169
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269456-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269456-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C22C30363BC
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641EE24BBF4;
	Sun, 28 Jun 2026 03:55:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A929BE63;
	Sun, 28 Jun 2026 03:55:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618909; cv=none; b=LQabKyKk21ahGhrM6gIJ6jxfCvMnXDBg9DvS38hQ/CqjXNpQUuM86aZ/hRgJxB/Bz74f1Xxvjvw5BZt61euqXS0rzZ1ev0F1TFoVawLbF2NuYIqwEyg/puKQPGhnmIFXlgx6D3n3JBOFHpOAfMREp9aecX2jGqWg5WbPydtFBOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618909; c=relaxed/simple;
	bh=SHoLFQU2D/IfHQWNUt92JvP/1EoWsmj6+/TbrdG6eZw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Dg5dh3X6FYGBL2ON53q8Uvtv7RLQCxbkQhHjnOauwrbHOxwt3gBzRmvdwAth19WId3OgquIMt7eewM3/A+3svgiIOul5+Qr34CaOJPayFrn0E06WTgGeT0rwmKmdukUfZ1ho+mL4pBzigZ9jckUlHuHLmSzYyBFHgCY/6v26DBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S3;
	Sun, 28 Jun 2026 11:55:05 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: net/bluetooth: iso_conn_del: extra iso_conn_put on
 iso_sock_hold   failure path
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626115312.33528-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:54:54 +0800
Cc: linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4DD84C4-BB14-408A-8760-B3CA55CC3BD4@iscas.ac.cn>
References: <20260626115312.33528-1-vulab@iscas.ac.cn>
To: marcel@holtmann.org,
 luiz.dentz@gmail.com
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar18CF4rWrW5Cr17WFy3Jwb_yoW8GFyfpF
	W7WFWftFZrJ3sakF4IkFs5XF4jvFsxuFyIkr1kKr4ruwn8t3yUA398WrWqgF45trZ2qrs8
	JF4DtFnagFWUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxeT5DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIMA2pAiNkd5gABsV
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269456-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B24BF6D3169



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 19:53=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> In iso_conn_del(), iso_conn_hold_unless_zero() acquires a temporary
>  reference which is correctly balanced by iso_conn_put() at line 279. =
When
>  iso_sock_hold() returns NULL (sk =3D=3D NULL), an additional
>  iso_conn_put(conn) is called, dropping hcon's reference to conn too
>  early. The caller (e.g., hci_conn_del) will later also =
iso_conn_put(),
>  causing a double-free or use-after-free.
>=20
> Remove the extra iso_conn_put(conn) on the sk =3D=3D NULL path.
>=20
> Cc: stable@vger.kernel.org
> Fixes: dc26097bdb86 ("Bluetooth: ISO: Use kref to track lifetime of =
iso_conn")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> net/bluetooth/iso.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 3abd8111dda8..99755671e469 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -278,10 +278,8 @@ static void iso_conn_del(struct hci_conn *hcon, =
int err)
> 	iso_conn_unlock(conn);
> 	iso_conn_put(conn);
>=20
> -	if (!sk) {
> -		iso_conn_put(conn);
> +	if (!sk)
> 		return;
> -	}
>=20
> 	lock_sock(sk);
> 	iso_sock_clear_timer(sk);
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=


