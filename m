Return-Path: <stable+bounces-127299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5538EA77702
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD99F16A1E6
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D11EC006;
	Tue,  1 Apr 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ECK0v/CU"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5551EB5FC;
	Tue,  1 Apr 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743497868; cv=none; b=GmHPJS8dh6o0satYc9eQ6N+X/NjlCedAx8Y8z7RBrkYRVAuA7Wx6R7VKZvetIfre553IMNrjvWDPwEmAZkUOQuwggKopGxqRJ+YukXOpipu5m5N0dwbvUi4wkAy8QU/grS7vSbv2C8IKg7RCSPNEVUlvj4CxWnoz7JfET82nqPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743497868; c=relaxed/simple;
	bh=d78V2SRfd+yrCnP+CSQdEt2iDe09S12xQHysnYKYb54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXJIuzF7tnEP72F8BwKHuA7YiZiO21EesHicz59rszdwwQYe7XZMBvqrlsJnuAUYzUp8sTvvtMZ8d7goMVA/93mp1bck8hm0Ch/Aj/fwMXDiWPpOEHb2n1OyNtxSu46ncusBhpHJQKduM9f/9dBgcQqnhy/WgGz0mR4xdaqsz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ECK0v/CU; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1743497344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WL4H1/n+KU4vDHV20Jk9Fts6NmwKIU67Olt2xVADMKQ=;
	b=ECK0v/CUv5HYRLgRT7DeRHtoMrKwucrsQs2muDt0Obk5vr7SY/cKmt4bHi8EwKH/q85qbt
	fUhcG6kxBrmOcGnQKl88z/WlbIjL8Zrz6gPGvmEmeawsmNKCG1lt7o1TsCV9me/frKXqK4
	j/gQq9Bb/OBzjPpc4dkI6SGFs+j20pY=
From: Sven Eckelmann <sven@narfation.org>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] batman-adv: batman-adv: handle tvlv unicast send errors
Date: Tue, 01 Apr 2025 10:48:59 +0200
Message-ID: <22646445.EfDdHjke4D@ripper>
In-Reply-To: <20250401083901.2261-1-vulab@iscas.ac.cn>
References: <20250401083901.2261-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7787093.EvYhyI6sBW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart7787093.EvYhyI6sBW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Apr 2025 10:48:59 +0200
Message-ID: <22646445.EfDdHjke4D@ripper>
In-Reply-To: <20250401083901.2261-1-vulab@iscas.ac.cn>
References: <20250401083901.2261-1-vulab@iscas.ac.cn>
MIME-Version: 1.0

On Tuesday, 1 April 2025 10:39:00 CEST Wentao Liang wrote:
> In batadv_tvlv_unicast_send(), the return value of
> batadv_send_skb_to_orig() is ignored. This could silently
> drop send failures, making it difficult to detect connectivity
> issues.
> 
> Add error checking for batadv_send_skb_to_orig() and log failures
> via batadv_dbg() to improve error visibility.

This looks more like patch you've added for printk-debugging and nothing for 
stable. And you ignore that it can also return things like -EINPROGRESS. Which 
is not an error.

You can also see that this was just for printk-debugging because the error 
class and message has nothing to do with the actual code.

> 
> Fixes: 1ad5bcb2a032 ("batman-adv: Consume skb in batadv_send_skb_to_orig")
> Cc: stable@vger.kernel.org # 4.10+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  net/batman-adv/tvlv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
> index 2a583215d439..f081136cc5b7 100644
> --- a/net/batman-adv/tvlv.c
> +++ b/net/batman-adv/tvlv.c
> @@ -625,6 +625,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv 
*bat_priv, const u8 *src,
>  	unsigned char *tvlv_buff;
>  	unsigned int tvlv_len;
>  	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
> +	int r;
>  
>  	orig_node = batadv_orig_hash_find(bat_priv, dst);
>  	if (!orig_node)
> @@ -657,7 +658,10 @@ void batadv_tvlv_unicast_send(struct batadv_priv 
*bat_priv, const u8 *src,
>  	tvlv_buff += sizeof(*tvlv_hdr);
>  	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
>  
> -	batadv_send_skb_to_orig(skb, orig_node, NULL);
> +	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
> +	if (r != NET_XMIT_SUCCESS)
> +		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
> +			   "Fail to send the ack.");

No, this is definitely the wrong error class. And why do you think that it is 
an ack?
>  out:
>  	batadv_orig_node_put(orig_node);
>  }
> 

Kind regards,
	Sven

--nextPart7787093.EvYhyI6sBW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZ+uoewAKCRBND3cr0xT1
y2qlAP9WnQgyuTR1ObdOwnfoccPeZM0k100Xsm1CijZC5WAcyAD+NywbzgD5+yMk
e/XenInlVjSxcxl696zJLzJxWyD3cws=
=d3Hb
-----END PGP SIGNATURE-----

--nextPart7787093.EvYhyI6sBW--




