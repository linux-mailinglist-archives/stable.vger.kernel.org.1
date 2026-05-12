Return-Path: <stable+bounces-245390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBObF9iYAmoauwEAu9opvQ
	(envelope-from <stable+bounces-245390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:04:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F037651924A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 05:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2BAA301E762
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDA137BE97;
	Tue, 12 May 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEx5W0+e"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400642745E
	for <stable@vger.kernel.org>; Tue, 12 May 2026 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778555090; cv=pass; b=OtgBz1LqBKDoNmuSfhjultWHW7EEDnUdpPV6DaEqt0PMB543D2Dv5z1IsAupI/RdyUx7s7vgrPqaTtH58ozxAKaN+elRNXU9w42WY16ggy2LB3782UmSn481EZW/0SA6i2G9+rnMauRaE+qtGb+Ha0GCct2Nq+HhQe5dlGh2aio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778555090; c=relaxed/simple;
	bh=KGM4H38V1VhM50YmPJFDh7rV9exoqk2h9zQII6DsGfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etukzCUi425Fa9r+6wieBDDJufndAIcBnPqEnzip1JbpeX5akUBfJVKCy2QOP+xl0Sv61765v1CDqK3182rQpBkSk23SRiTN0f7NkfX3gskj62MHLzSpHXX7YjlBPzoIj32iOpI+nxguni10NOstBx3kADlahu4VZ1c9svj5wzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEx5W0+e; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ff5472f263so920300eec.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 20:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778555088; cv=none;
        d=google.com; s=arc-20240605;
        b=Ey6S89sqlxvev7EnLtCPkz0uEdavhYdKnDGukCak7nEzFnze7GRJz2Jp8cj0MgA3LG
         nsLHBy7P6C9BFUrynibQYL0LiRxJYw8iYQGojoZUPj3FQVqwuHCyPZBchc0Ht/O5mopk
         hERQGvQFvoX50d1+uI0+sA12fC+WoKRvfy23/TWqRoua+choLTVjyHhxo0PP3xsGyX8S
         1PSICzhiYYI+GqjyvazeZDF73QNWCnfBcgVUu9JmMJa4lLcLhGXHQvgI38Ymi8okRn6Y
         X2fPJk0+LqJ8DssbQjTqf+I7rM7HM6k+SZsDW2hcg/NAcNc6058xH7W4BfHJcYm+PLLi
         pKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z5dsVQxXpUN0BDNJxioyfWobuq/s5zY+DAv7AecFvL4=;
        fh=vHSLccdbm5PtdlfDNhkk57Fxaon1qkdbav0YxouT9rU=;
        b=Hm0BZI+rSjCjPgEA3+ZrAANwrdCTjUowrjP4iJDvnbWuLa5ij2UvriBb81tm1yuYEL
         dKNNREi/jttZmcEWBp6oMYGglrmT6QlikaFDShMoRC6a1uSDLxSqlcWXyNk3Q8qaNSLW
         9FuKS+DVV+a57mqw+lujHz30y2Ihqs5LlOTj2v+tMJtr1MngzM1kdTOupKl3bMtge65N
         7Ps5HDWKJn+rZF9yoKSSeKQZLmnwiT8Sa0VjuDk/4EeIgg7meyyh0OOlDWuips5oci2M
         V9sSkeEQQiKVcjpk7D+SYR0JRnocER14ZR7P8fV64B1xRsH7hzislDtEg0nBHhSLOEnW
         LXbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778555088; x=1779159888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5dsVQxXpUN0BDNJxioyfWobuq/s5zY+DAv7AecFvL4=;
        b=IEx5W0+ep7tWELcioHfA4Avb1ohj/jT6CWMFVBhnKiZdq15UfzCCpvM8IgyYj0gFTA
         GQDpklFexCg44/pSZM1Gx3x8XAhVwDRqx4hA19wkvNekgNtAsR8W+gFloa7nfD+OMb14
         RyAOurUucDzZZnIxqtT4q7cJOHH5vm6SJnG+auovVzP0yRMfO5Dc/lcv0vSrQ/XRkNj5
         5V1RPlMekIsOJ2MjXqnSqC2ns/3jNQebLTiWu/TmdSvypYYc9UUN4ogYLNQkP7RVlQk0
         Av+A4EVdb5s1rPx174xXTBVOR6a74tEBsx8NswCP0/Y82KYjeC/97QpTyt+AzLL9Yd1Y
         cMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778555088; x=1779159888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z5dsVQxXpUN0BDNJxioyfWobuq/s5zY+DAv7AecFvL4=;
        b=sQZIq/aGhYORqcjP5R2tO+oqDRxJAv9s65MJ+5lNavoPCJ8X+5m5r6UD0SavggdNVB
         inaMcDn3s0wIDnMQbvA0rHntlKjpm7gkioTWZmP7SrmF6McdrRpxMcpHGuURNVUwEedW
         FpLBkjIQyX1u95eV32B75Vco0aPF/LxQPrpVWFLXnIfxpAgOU9CXo+kVCDbqz9nJSugn
         JGk60Nqr9zq631WDmoaIxg/0G44GeymFB0PLwB3ifLmfnVnj6gDVjf06ki0IFFNb3Wkx
         eO9LqD7nUTo7n78iAXFI27IjeL4pTInf5Rte+P822RqOEgXiF6w0KqKQk3kPKq9bS8+K
         Bi4w==
X-Forwarded-Encrypted: i=1; AFNElJ+od2RmoENPOwhgoYrFFXpaSha6EO0mY7SgqWWF0o16fOzrk+8Mr+VoMyNClhCX5YSYlvupsjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2kIkGrS8Kz8olwye5MExXfTn7axplUD8c1AYNsk83j5iH6jt9
	21tUHVM5EY+OtkiusjzjGXYtXo+7PMT0F+FbB7//3SPmXLPL2UX2xk6MdNPeoO1wzp/1dY0DVJ2
	1CzY8zbQHPQztxlLr6Bx1rXUtSeXu0QA=
X-Gm-Gg: Acq92OE8Gk+zo0aE43Xp67CBzQWHzLd+XSfpxS5cOG8HH0RO7Jd3K1u8X54PXd6toTE
	EtlGBmYRKtqlC+r4U7nS5m3jCbZFQccYmYnRpkNJRtyBqaG5jin7S0/ANrttWGz8bqFvkJsgl8O
	5Rpe1tM6dCxQRw1h/68Xr2+BVFqDHdhowX/LtyP2BEeogJMRJ/BxDB8DP1Ll3UOkWsQBMFMxdmZ
	jZ8V41+YxiYND0ZM0HKwBiPKGf8KD0NHZz54GLnPknQ5idhJ++j8H232SBG8ndPL9qjzGEi1c8Z
	dBUf607j5iwCQzsiEGpIGSNm/2/xxN42OuLfl8FicTMb8pPI9ZaJy75/LpfwnbZw0iI7YQIXC+X
	r+hXyxABALTVUwY81LsvbXdTa
X-Received: by 2002:a05:7301:686:b0:2ed:935:aa33 with SMTP id
 5a478bee46e88-2ffd53c1bf2mr793539eec.5.1778555088393; Mon, 11 May 2026
 20:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512025715.50645-1-chalianis1@gmail.com>
In-Reply-To: <20260512025715.50645-1-chalianis1@gmail.com>
From: anis chali <chalianis1@gmail.com>
Date: Mon, 11 May 2026 23:04:37 -0400
X-Gm-Features: AVHnY4IpajOeWEx8eNkeiHuf_j3oAGh8rVjTVXr29cceh-dUscPbaqNG85SZqM0
Message-ID: <CAL+1fyCxfU+Ci5mifCsJH5MxCqDAL7T4ajAbWwsPnBovi7xNfw@mail.gmail.com>
Subject: Re: [PATCH] nvmem: layouts: onie-tlv: fix read_post_process assignment
To: miquel.raynal@bootlin.com, srini@kernel.org, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F037651924A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245390-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chalianis1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,cell.np:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Please disregard this patch.

Le lun. 11 mai 2026 =C3=A0 22:57, <chalianis1@gmail.com> a =C3=A9crit :
>
> From: Chali Anis <chalianis1@gmail.com>
>
> Assign the onie_tlv_read_cb callback directly to
> read_post_process instead of calling it during assignment.
>
> The field expects a function pointer, not a function call.
>
> Fixes: d3c0d12f6474 ("nvmem: layouts: onie-tlv: Add new layout driver")
> Signed-off-by: Chali Anis <chalianis1@gmail.com>
> ---
>  drivers/nvmem/layouts/onie-tlv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/oni=
e-tlv.c
> index 0967a32319a2..0242f64fe713 100644
> --- a/drivers/nvmem/layouts/onie-tlv.c
> +++ b/drivers/nvmem/layouts/onie-tlv.c
> @@ -124,7 +124,7 @@ static int onie_tlv_add_cells(struct device *dev, str=
uct nvmem_device *nvmem,
>                 cell.offset =3D hdr_len + offset + sizeof(tlv.type) + siz=
eof(tlv.len);
>                 cell.bytes =3D tlv.len;
>                 cell.np =3D of_get_child_by_name(layout, cell.name);
> -               cell.read_post_process =3D onie_tlv_read_cb(tlv.type, dat=
a + offset + sizeof(tlv));
> +               cell.read_post_process =3D onie_tlv_read_cb;
>
>                 ret =3D nvmem_add_one_cell(nvmem, &cell);
>                 if (ret) {

