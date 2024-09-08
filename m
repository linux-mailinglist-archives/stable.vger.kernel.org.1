Return-Path: <stable+bounces-73922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F1E97082E
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3DEB21119
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52216FF3B;
	Sun,  8 Sep 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="PQXuKuZj"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC5EACD;
	Sun,  8 Sep 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725806024; cv=none; b=EbqSQLaU3UsbumJr5wwdbQfQ92XYAwlWNfAVRx4Xkr+N8rMD2x70Ul2KZnWzNOINe7MN+3T6cZfEIbEG6zgSuUxhSdtW6oPdddNV5IoE1XuDLr5tKeD+fTDNOzzKHX1EyKmwbCy5g3DABINWViDCqkRXChQAchT0vUMe/1dmpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725806024; c=relaxed/simple;
	bh=JHFP3QI3VqzqYLUqlGEz7Ae9Rh4rc7DT7ewQuDG1F3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AIJWGtnm6fTVXDGopOdrOyfMLTXmvNuYhKBeOv8zUSkbRnxx23acIfE9hkqxMmvmFfWxIWpfJBW9XvVmK/m3typTozPmKWN2cGFsNL/Vzl+OF5MJpt8yiWN/KcPOAi1jjRJgm4YjJhDjS6AwTQOcXJK9zmDEs4F2NXRZJPGMOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=PQXuKuZj; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725806018; x=1726410818; i=spasswolf@web.de;
	bh=c0SC6T5+tahowmLui9CFOBEbCYlTjNSw9EZt/eHQB1M=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PQXuKuZjxOunMOsX1a0U4HqdT6eYL4yGxZrmXRiYuE9LHVrW6oU/bOQe5l2In1Yo
	 8n1s0aug85tLTx5YxeX7btj8/qO6I6z/hUUm6+FZYGLwgeyog9djGnpmhPOHs8ecB
	 PnVJtozZgj6YyxMdgd2XwFPzxpJOJcwxjmMNeyOftndXjmjDS1MTgO4xZy/2wA1vP
	 X00uz20PfSXHMuXQPbKrLUZrJ/7AWQBHnBq9ZPD/gGGLIGhRw2lWi0pKg5bBuN0GF
	 4nupzB8xAmPMpdbw8+6OJWJsVXV1foRlFFyY+pFXHbQis7bdSAadYanVKSyMCQSBf
	 SRKGkmiKl4oQiLnZZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuF8z-1rsrxD3Ny1-015sPn; Sun, 08
 Sep 2024 16:27:50 +0200
Message-ID: <38a42fddfd5b6cde1115b600a40ad4b158b430ea.camel@web.de>
Subject: Re: Patch "wifi: mt76: mt7921: fix NULL pointer access in
 mt7921_ipv6_addr_change" has been added to the 6.6-stable tree
From: Bert Karwatzki <spasswolf@web.de>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Kalle Valo <kvalo@codeaurora.org>, "David S. Miller"
 <davem@davemloft.net>, 	spasswolf@web.de
Date: Sun, 08 Sep 2024 16:27:49 +0200
In-Reply-To: <20240908133703.1652036-1-sashal@kernel.org>
References: <20240908133703.1652036-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sBolGSEDr+P1Th1W4gunMa3U1zN14m2yRmwQoPFHDbLd2joL0ds
 x7wrZw2ilfjC3U+hsdL7VzGYBFWrQ+x+/7ZbySXpYGO9e/dPNEH41J4YuFNLHWANNGz16w9
 jk1FHhTWBaPirwfPsl5pUaMevqseT7ZxVDJfQUpjKhVDWOnxF4A3cq+w0mS1v7ZrFqGmA+s
 kMjPeacv2XIr3Fd7JsF0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EBkYV7aRfCI=;Tu5r2z5Mc1vtG1Gq7Wa+wrbjTiD
 ded+ge0iS249tIfTY0A4lBqAXXJ0OLLFNvjLLfCahH3CF7fUZIbs6zX2lx3nQeURGnnWfcRTx
 FzqnL+0zrgByj85ESE+tpIgmKQg4vY1G1a6Ylg5LOZSKrwg4BR2ueRdoGlpQQQQGLYPLoxDu1
 7LqFlab2WMAsfzPd49JDtsStBf2ToCKuRhPY8e4V13rydfJ0QNPuYAJk7Jstcwen3l7/b4D8V
 RH3GkQkK+pl51eMPnZ9N84QOq3rQPVf109z7BKvQpDuc+zY7H+lfz8jtNdp/rz5adE/2XhxV7
 ThkiXPqPcTMYhU1kpoHfh10icMsItTU7K91CFwC53IIPtCz0owjqcdl4wGIe+WNK+4h1HrZrm
 4NVZu73kF6M6vK9QDsrTImE98s/FYSpRX5Jk2dviY8LFvtnaMjlEVYMQm/qvsFLrw/dlF9ILf
 xb/CwtXNGInT7HyQAXOSPiDZuPBRVQDUTto/5D13tpaR3e1IsxMUbvcWa9FACu4aN1t4SUIQc
 ikBZTUe2viUZnV8QVlk8/jCpROSozwKcqo/9EO91kBv+dIvuNGrlgvKcZRifxn9/YKSNVERjk
 Dth7KvD8CT3VUnmPEOSVKfCKBjQYC+9eoUaa1d/KU+6lrOwWCdxmO/tPdZtB4cVKI1EM0pDEo
 MslZVEcAyXGBLse4leQ4yBqwcoStxCXPC9IrNeAgt/9/fuI1BYd0wl0yBujwNHGojg8A0wtg1
 7SG3zy49wUZGk7AYn3KO0n3ZH/gftaFRv+DgkGn2X33eW6eIbhA572V2LZ/+N9TsmkuExy7Qu
 07LXUl335SYZtySWFVkZwhUw==

Am Sonntag, dem 08.09.2024 um 09:37 -0400 schrieb Sasha Levin:
> This is a note to let you know that I've just added the patch titled
>
>     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_chan=
ge
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.=
git;a=3Dsummary
>
> The filename of the patch is:
>      wifi-mt76-mt7921-fix-null-pointer-access-in-mt7921_i.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 857d7854c40324bfc70a6d32c9eb0792bc7c0b56
> Author: Bert Karwatzki <spasswolf@web.de>
> Date:   Mon Aug 12 12:45:41 2024 +0200
>
>     wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_chan=
ge
>
>     [ Upstream commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3 ]
>
>     When disabling wifi mt7921_ipv6_addr_change() is called as a notifie=
r.
>     At this point mvif->phy is already NULL so we cannot use it here.
>
>     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>     Signed-off-by: Felix Fietkau <nbd@nbd.name>
>     Signed-off-by: Kalle Valo <kvalo@kernel.org>
>     Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@web.=
de
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/main.c
> index 6a5c2cae087d..6dec54431312 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1095,7 +1095,7 @@ static void mt7921_ipv6_addr_change(struct ieee802=
11_hw *hw,
>  				    struct inet6_dev *idev)
>  {
>  	struct mt792x_vif *mvif =3D (struct mt792x_vif *)vif->drv_priv;
> -	struct mt792x_dev *dev =3D mvif->phy->dev;
> +	struct mt792x_dev *dev =3D mt792x_hw_dev(hw);
>  	struct inet6_ifaddr *ifa;
>  	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
>  	struct sk_buff *skb;

The patch is only fixes a NULL pointer if the tree also contains this comm=
it:=C2=A0

commit 574e609c4e6a0843a9ed53de79e00da8fb3e7437
Author: Felix Fietkau <nbd@nbd.name>
Date:   Thu Jul 4 15:09:47 2024 +0200

    wifi: mac80211: clear vif drv_priv after remove_interface when stoppin=
g

    Avoid reusing stale driver data when an interface is brought down and =
up
    again. In order to avoid having to duplicate the memset in every singl=
e
    driver, do it here.

    Signed-off-by: Felix Fietkau <nbd@nbd.name>
    Link: https://patch.msgid.link/20240704130947.48609-1-nbd@nbd.name
    Signed-off-by: Johannes Berg <johannes.berg@intel.com>


In trees which do not contain this the patch is not necessary.

Bert Karwatzki

