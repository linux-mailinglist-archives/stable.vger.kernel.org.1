Return-Path: <stable+bounces-216750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H5zEn9xk2lq5AEAu9opvQ
	(envelope-from <stable+bounces-216750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 20:35:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7211474F4
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 20:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D685530238F3
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112702E03EC;
	Mon, 16 Feb 2026 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xOvG0rY7"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC01270EDF
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771270522; cv=pass; b=cD457MXaKa05WHH71w39YbJsw6/dMbtbLeY+9OIjSlGDxy2lBhWf8LwnJb31a8OeQHnsubHpCjRqeH6Ds397d1BK5fge6VatruIBNzJkAtUTw5eS8X55Kk7XUK2v6KjA4sfvPmaqnrB5ZN1hNGuDYuoS1mB8m8vju+hnD7d4j9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771270522; c=relaxed/simple;
	bh=lO+bK9Mu7MYuKeo9UdHDyn6ieBIT5VFZ66T2AkNb8CQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIQLuVWw2nIqBF8iVjMTQY82UkNFFKYOZgTM6bucKloyEarvqX941r76TsaFDVOikIPmL7BLDbmqbP+p5k9WzWXmyBqQ7b9q87Cylcfl3SbsjyVUdu0EOhD3LIu2GVCA+5z64wEmnSxOxrDTDP3E7VD967oS2K90ZVMAPNBbgeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xOvG0rY7; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3e0093e3so343426285a.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 11:35:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771270520; cv=none;
        d=google.com; s=arc-20240605;
        b=KHo3RsMngIzDAgIstPh5uMeydOk8zW0YBQngTmX1Lc4kOlu3rnpikUF5sYvwZ3rozx
         m4Lny5zHY41zaoe6JVTaLRervtL+34HO3ysFJf5XULnUWU5pKNgnr/bn+5/jikwnzNmg
         FjeEc8O8GX5w2+JGlOduitnD2JrbLXqFvEApA1pHY3puD9NGGjYSKBMxRE714IDnNXLj
         MuOw6w9m/6mn3a0znQ2nWwZ2mmBn18KCypfb0sLZPK1ZgMYSAvQnou7v/0USPpMq4nNN
         AZdE2fkoyXzpIVR/AeKHDXlaBCx/v4fpBg8FblD+Eaj2TGky6GvDTc+FZ2fW35RABE93
         l8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3/4pYCOXiv022CJVxKfr6DPQdE+zuRGsnBhvnTlxe/E=;
        fh=wFrJ4xAX0w2LUeSINof79vRO9gB3FFyAA1TxKDTbFSM=;
        b=kja7jnR+2UuAzBbDFtkawLxyD2kTGDZ40RycVXXyZ53DrPv9elhOvz5VKNQuuwYQwl
         0ZurEXLWHRkN+jcf9ZOJw7BisoN44vWvQW3/w59bFLryohQ+iQMeB+oY6D8sQdCgwY7Q
         Oato8zYyu/m/pF8qCaFxgMTbMuSdCzSxm2N8orD9vLqkqIrg0jkJEL/NZsbONdR9u4Dq
         0S1Uwi633W4n5i4QI53/uFBqPqSz7RGpLYj7JBvwOm68OYJvxL05e4LSlwRkPdAc4VQ1
         R7WNLxwt74FZ2WV0moChBhgvUGSEtyasyXm88r1Rg+TAoIPgLiPbbDj8AFSTk4c/1JrB
         aO9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771270520; x=1771875320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/4pYCOXiv022CJVxKfr6DPQdE+zuRGsnBhvnTlxe/E=;
        b=xOvG0rY7IXpAUGFBVer4uYmxjj9t5AiuauUd9I+yZ3w37fcKHAcqPBPDXjG16VNFLv
         BVw4Jmx1p/MJY9tlQ4rDyCI9MtiazvSCjp24P4jkVm3XcQj941CLabbUQs/fSH77lm5n
         OHZlllQBhNSsJB0Tzyc3NfJHtsICv1jpdatLIXhVToNO3lPEN00NVa+UAapxLAeOwACe
         BjbUcsQ+nITSi3GFjsPk5kkI2WDqCZA+BL8ITTdx/cGAr3N5LzQ2bUFjLpO4KfRhlkbw
         9YOf4Z5JI2a2gaH5RJ+R/VSj9pjYg1f74Ic09zuXjuABU9dfKED9mxVlknkLAIMJlXGf
         OlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771270520; x=1771875320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/4pYCOXiv022CJVxKfr6DPQdE+zuRGsnBhvnTlxe/E=;
        b=UaZilg59J7md/OhWBXARf4KwmUxt/SEFgiLxuIabGYfqMudJWYuUl2SSmD9/SlU/vm
         9CQN/wUVSQQlwyGa0DHkGasP+4LBGAzCoHEjkl6USZNv5Wok0aahK/x4xDvXb0eb8T+U
         0iyukj+5e7MlH5b7RzoNL6W04PPcbLadbPv4fGqFPc0Q7oTGEt24/D2HuOxSEDF54cyQ
         dKDRVGZZNy2hfVDG7PDvb4A/258CNDaJofjMgZfmVGq0UnOU2+Sblb6U/4ip7VBaqi1H
         XfakLmZIPG8WsS3n+P+cuGxGUiWuB20a6r7xEq5twHT+ieoh+SlzrG075CXvpd8VHVNL
         BPZw==
X-Forwarded-Encrypted: i=1; AJvYcCUiOfFnr36ngr4IxlcCvSVDGEJYA41mEI18k4wE8Dhdu079f4SM50GtXbwBohVoyKeWuRkPeoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBF1E4WOs1F1dqoo31Qqje4hbf0UiLQ2oQiZ060Mz9k04ccMgA
	LJdTfQ9fXF45vZnkLwc4fP0zYNs4fpFmlSVp06OWIHjP7futz6LvdpmqrD+B/uigE1TzUOLdAv8
	6pVFJ1OVkg/UllU3DP2O6kbL6t/FglDq/z5/dlTAy
X-Gm-Gg: AZuq6aLz/kDoCDFYuXPprZd00Y5wON3aE5PXnKZXJnOEkZIg+xNX6i3mquAdHXO4IkY
	hYHNCFzjAVUamVDTzh45+1TGzuFYOYottsrraUjTnkSK0Hogj7bhuN1JxoLUo+fU7P0BM+2WJ93
	vWd7ZaSiXO9EVQLpNsPtePDIs3MXBD0cGB3HM/V2N8VcQ4N5tEdtCrMyt62nxCU1ps4NLvjYPRC
	9AVH1ngRWS2IZAMbnzgzFVxEGLfQhiXkEuv2LfuWKQLWEmN0/P6g19OwaEFmt02yvWSY++PvTVs
	JI15+w==
X-Received: by 2002:a05:622a:452:b0:4f1:b6bc:5833 with SMTP id
 d75a77b69052e-506a8339f20mr138771171cf.54.1771270520092; Mon, 16 Feb 2026
 11:35:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216185245.182450-1-fabian@druschke.network>
In-Reply-To: <20260216185245.182450-1-fabian@druschke.network>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Feb 2026 20:35:09 +0100
X-Gm-Features: AaiRm527v4bN50uqJaTKPZnLghfuSIQLXbcR_aKPBlVFvua47bkhjT9D0EIuN2E
Message-ID: <CANn89iKemBSmj=e4Zi5Otitop+kYYBNfGzVDRPk1jv8rJxsbtA@mail.gmail.com>
Subject: Re: [PATCH] r8169: avoid OOM when allocating RX buffers
To: Fabian Druschke <fabian@druschke.network>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Fabian Druschke <fdruschke@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216750-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 8C7211474F4
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 7:53=E2=80=AFPM Fabian Druschke <fabian@druschke.ne=
twork> wrote:
>
> From: Fabian Druschke <fdruschke@outlook.com>
>
> r8169 allocates order-2 pages for RX buffers during rtl_open(). Under hea=
vy
> memory fragmentation this allocation may trigger the global OOM killer,
> causing unrelated user processes to be killed.
>
> Use a GFP mask that avoids OOM killer invocation so the allocation can fa=
il
> gracefully and rtl_open() returns -ENOMEM instead.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Fabian Druschke <fdruschke@outlook.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethe=
rnet/realtek/r8169_main.c
> index 3507c2e28110..3525e889ec1c 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3952,7 +3952,8 @@ static struct page *rtl8169_alloc_rx_data(struct rt=
l8169_private *tp,
>         dma_addr_t mapping;
>         struct page *data;
>
> -       data =3D alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BU=
F_SIZE));
> +       gfp_t gfp =3D GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
> +       data =3D alloc_pages_node(node, gfp, get_order(R8169_RX_BUF_SIZE)=
);
>         if (!data)
>                 return NULL;

Control path prefers to wait a bit so that the NIC can be setup, this
could be used for instance to enable swaping over the network.

Note that this is GFP_KERNEL here, not GFP_KERNEL_ACCOUNT , OOM seems
reasonable here.

