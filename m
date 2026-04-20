Return-Path: <stable+bounces-239990-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKPfKFx/5ml0xQEAu9opvQ
	(envelope-from <stable+bounces-239990-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:32:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF543356F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19ED03020A6B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FA39FCAB;
	Mon, 20 Apr 2026 19:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mega.nu header.i=@mega.nu header.b="Gr/qGNml"
X-Original-To: stable@vger.kernel.org
Received: from mega.nu (mega.nu [108.65.49.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E4EEC0
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.65.49.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713498; cv=none; b=kPZEbIdKkHwxYdqSoqfj3KiOqXuvAMt84XMc6EIFDXaJIxV9UFPvVmIUZ0O4tTRRkCKrdA2Ma0hqwSv13MfK5D82e0wQheF7lzFyE07ISnEZCBM3IPXqsVNSlJatBWIQfeTd+x2F8mTVP1un7I13GkQTWjO3oOaT0sNZ72bamTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713498; c=relaxed/simple;
	bh=qlUZsPlGXe7P4xzV4GNXWM21doqptpn7WFrD1e3JHFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eZVpwYhvf7KZiD+KK1260smiTpH+WP41/czETml2hvPj5nuVyVpL0n3teEmEcXwUSv3D5dTUEPsd5MAYUi8y4uRgdxekwCK+ZlFU/AyvHl9yihXmzpemey09xX44YrYiS2RPRwZj1yZjmk/wYZOZOa0pnzYJ2MqG4QNYAzeP1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mega.nu; spf=pass smtp.mailfrom=mega.nu; dkim=pass (1024-bit key) header.d=mega.nu header.i=@mega.nu header.b=Gr/qGNml; arc=none smtp.client-ip=108.65.49.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mega.nu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mega.nu
Received-SPF: pass (mega.nu: authenticated connection)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mega.nu; s=20180922;
	t=1776713472; bh=ZNE93TcCr+LtUEbKaMkHqTE32uwhkdXnbHLFznJfjq0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Cc:
	 Subject:Reply-To:In-reply-to:References:Content-type;
	b=Gr/qGNmlaqgSgfszuWhWS8emGBYvOhTkhtT9nlwMUaecZBTqYAaDZ2pEfofIQ7nbP
	 QDci7NAUmjpFrWRclwHH//Xwwfbxz5M6yNb5V2C2memXhfu/TD0oOE3sXzxOMKUL0r
	 Zn//7Kq5h8x5nDaxpTq230OrYP9sHRWeBnUD1E/I=
X-Authenticated-User: douzzer.mobile to mega.nu using PLAIN
Received: from douzzer.mobile (localhost [127.0.0.1])
	by mega.nu:587 (8.18.2/8.16.0.41) with ESMTPSA id 63KJVCd1013122
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 20 Apr 2026 19:31:12 GMT
	(envelope-from douzzer@mega.nu)
Message-ID: <4ca0b8a4399db5b89e2164f52246f63723daf49d.camel@mega.nu>
Subject: Re: [PATCH 6.12 085/162] crypto: algif_aead - Fix minimum RX size
 check for decryption
From: Daniel Pouzzner <douzzer@mega.nu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
        syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com,
        Herbert Xu
	 <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Date: Mon, 20 Apr 2026 14:31:12 -0500
In-Reply-To: <20260420153930.113240857@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
	 <20260420153930.113240857@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mega.nu,reject];
	R_DKIM_ALLOW(-0.20)[mega.nu:s=20180922];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239990-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[douzzer@mega.nu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mega.nu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,aa11561819dc42ebbc7c];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Queue-Id: F1FF543356F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

LGTM -- tested (libkcapi, LUKS, WireGuard/WolfGuard, etc.) atop 6.12.82, wi=
th
and without patch, with native and libwolfssl.ko crypto, and all 4 scenario=
s
were clean.

Assuming same for 6.18 and 6.19 backports, having bracketed with 6.12 and 7=
.0.

On Mon, 2026-04-20 at 17:41 +0200, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: Herbert Xu <herbert@gondor.apana.org.au>
>=20
> [ Upstream commit 3d14bd48e3a77091cbce637a12c2ae31b4a1687c ]
>=20
> The check for the minimum receive buffer size did not take the
> tag size into account during decryption.  Fix this by adding the
> required extra length.
>=20
> Reported-by: syzbot+aa11561819dc42ebbc7c@syzkaller.appspotmail.com
> Reported-by: Daniel Pouzzner <douzzer@mega.nu>
> Fixes: d887c52d6ae4 ("crypto: algif_aead - overhaul memory management")
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  crypto/algif_aead.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
> index 7d58cbbce4af2..481e66f8708bb 100644
> --- a/crypto/algif_aead.c
> +++ b/crypto/algif_aead.c
> @@ -170,7 +170,7 @@ static int _aead_recvmsg(struct socket *sock, struct =
msghdr *msg,
>  	if (usedpages < outlen) {
>  		size_t less =3D outlen - usedpages;
> =20
> -		if (used < less) {
> +		if (used < less + (ctx->enc ? 0 : as)) {
>  			err =3D -EINVAL;
>  			goto free;
>  		}

