Return-Path: <stable+bounces-91785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D99C0370
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB035B21099
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68E1F4263;
	Thu,  7 Nov 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="jAola1dZ"
X-Original-To: stable@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A51EE00C
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977732; cv=pass; b=XoMulj0BgWujz1ra84vEGLK3zw+w1mAZE2CHyCjYG0u/UUYnYkLTJvaQ9QC/ldgiDJE1wu3kWKZ4ushunOO/ikmBEAtHMSQmrWX6c00tUVcHlic2nvSFyVu9tqdjcSwNQoTk97861uDwVeiH8uGTVplXqPytxViymDjik3fNmEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977732; c=relaxed/simple;
	bh=JkHvu85HJlQ/TrMLj2dhBxzs4doiMdJ/hIMmVZnIpV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVi0zs7h76RTsEQbIZG+LIu06iSkHQHtWNLnaHKFuB4hOidM7yIaXHlnqRk3Ktqn2MqF7Vw5ILt61u9Wy02uuw0P8QYCs6UjppAzkS9Cdch5H+J45QsjLojZat9TV+Wdk0OM/1ydFrlotvn24ufPYSrJiawoQSKs/C5UJEAuAr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=jAola1dZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martin-eric.racine)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4XkfT54vl6z49QFQ
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 13:08:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1730977721; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzyxtAbtNG6GyT9iqf9QZI/qjZ0+BnzsW2+Prr6BSVQ=;
	b=jAola1dZ/7/Okd34RSkihYd6Z+F+kUMav9I8NsZnmXv5cKShgZVuz/eyg62RShdUXa+FtF
	s0GcYdIs+bC9aIqCBT4LvEb93FuQpb93r/FdIzhj2zrlWq/1MUQWgMryDukRnAud745J65
	xO6yw4uzPorpH75AcmYqLwhdJ/Ul4ixwaGC/RxG1KDzUu+mtAtckq57ttnuGPggubq49Lr
	njKdYfcBJFohJkECJ6BlkKvo7Is42+QLUE+Bbb0QqVWEr+Mg0PGyCjOuVfj2XOuRjwSamk
	xeWQrl++yjDb7Iu6k7xRUMwZaPBncxa7zABgXGBCJAhU4dkaSPdJ+SlpbpHJaQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1730977721; a=rsa-sha256;
	cv=none;
	b=Z+rEMDCmCO47tA/MG/8EP5cpCFoX2+/sAwzM+bE6x5Z0WbXjxRGKskn8wcOMojsSuIPXjr
	w3zvh73SVE1n0QW7F5gxA1jT+xqHL0/+Ae7dOk2gmDiPsdwcqIyEM8ls8bTp1Ujc90WVHA
	h2vA0p8kxb0FQ+8baNw3aTR1saV6OAFZ5lxmEMki8jiqMXYxZDPrf3EIlu24268CwU+SAF
	Fil5we0OUGfcgC5FvljuEewZ6rq/n6pFNg8brcxFP5KfBJca2/Xt0XkZ6nvj+72LmfV72I
	7tAzfRw6ckre8l23ZHLU1QXJbGJWFh0IXhtrQ5us5r2xHf3hgCy+P2/U60MVcg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=martin-eric.racine smtp.mailfrom=martin-eric.racine@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1730977721;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzyxtAbtNG6GyT9iqf9QZI/qjZ0+BnzsW2+Prr6BSVQ=;
	b=WUtE6pvfnuY3T/qTpeQUocGH97GtlMkNmBrdwcAbaSiLBW4WTkqEDwbQLN0R4SklQz2+hx
	fBoVkH4mmyuqtGCqAzyTRnyQ8kxtK7ztj8uJfgwfx3QobqBjW/kjJMjcU3j5GrXjr/9S0e
	chg7N+yBQlhysLCsNXgv3p8wh+HQ891PzDhCbmJ/FSxuwfB/nV//QkWd0LYvxpRP0LBx56
	8Z1gnSZ01LENj2tYwuZg9veTQvSpdKUXIasKNjeHBjvXlodur972fLQQ2zkXbBgSahpCoN
	y8j/YkXlmeYKF4rPylfAT80A0Xtmc/+NNYimN+Wcc5TkFBbttmng/wVSVVnQKQ==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so7435335e9.1
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 03:08:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwKU14ITCzDMGl0qQtn7YQ2G6bPmC4IbIGR8MjDeYm6eaidD4rJ
	ooaPfqsC2rqJk7rFfnclw1PLwaTYEdhOT7j/tq+kfLiQ8XFIlcOEO2BfX00QzArUyJrECD0syBr
	rldAplDNZGPEuuuqPIe7p2nErP4w=
X-Google-Smtp-Source: AGHT+IEC1v/bHHqQvzS7SMppJ6Vp61ZWG0NG33xBhJlhNJvSvPAIWpt0NOho6ZGAz6Ltvzjlgf3lc4NBTRCiI0NUB64=
X-Received: by 2002:a05:600c:4fcb:b0:426:5269:1a50 with SMTP id
 5b1f17b1804b1-4319ac9c15fmr358610065e9.11.1730977721129; Thu, 07 Nov 2024
 03:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120319.234238499@linuxfoundation.org> <20241106120319.473879944@linuxfoundation.org>
In-Reply-To: <20241106120319.473879944@linuxfoundation.org>
Reply-To: martin-eric.racine@iki.fi
From: =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Date: Thu, 7 Nov 2024 13:08:29 +0200
X-Gmail-Original-Message-ID: <CAPZXPQessspMxh1Lc2EeHEwMFLsvWF71waz2=LjZ4W3MVdWx2A@mail.gmail.com>
Message-ID: <CAPZXPQessspMxh1Lc2EeHEwMFLsvWF71waz2=LjZ4W3MVdWx2A@mail.gmail.com>
Subject: Re: [PATCH 6.11 009/245] wifi: iwlegacy: Fix "field-spanning write"
 warning in il_enqueue_hcmd()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Ben Hutchings <ben@decadent.org.uk>, Brandon Nielsen <nielsenb@jetfuse.net>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applies cleanly to 6.11.6 and fixes the kernel oops.

ke 6. marrask. 2024 klo 14.26 Greg Kroah-Hartman
(gregkh@linuxfoundation.org) kirjoitti:
>
> 6.11-stable review patch.  If anyone has any objections, please let me kn=
ow.
>
> ------------------
>
> From: Ben Hutchings <ben@decadent.org.uk>
>
> [ Upstream commit d4cdc46ca16a5c78b36c5b9b6ad8cac09d6130a0 ]
>
> iwlegacy uses command buffers with a payload size of 320
> bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> describes the default buffers and there is no separate type describing
> the huge buffers.
>
> The il_enqueue_hcmd() function works with both default and huge
> buffers, and has a memcpy() to the buffer payload.  The size of
> this copy may exceed 320 bytes when using a huge buffer, which
> now results in a run-time warning:
>
>     memcpy: detected field-spanning write (size 1014) of single field "&o=
ut_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (=
size 320)
>
> To fix this:
>
> - Define a new struct type for huge buffers, with a correctly sized
>   payload field
> - When using a huge buffer in il_enqueue_hcmd(), cast the command
>   buffer pointer to that type when looking up the payload field
>
> Reported-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
> References: https://bugs.debian.org/1062421
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D219124
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()=
")
> Tested-by: Martin-=C3=89ric Racine <martin-eric.racine@iki.fi>
> Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://patch.msgid.link/ZuIhQRi/791vlUhE@decadent.org.uk
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/wireless/intel/iwlegacy/common.c | 13 ++++++++++++-
>  drivers/net/wireless/intel/iwlegacy/common.h | 12 ++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/w=
ireless/intel/iwlegacy/common.c
> index 9d33a66a49b59..4616293ec0cf4 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.c
> +++ b/drivers/net/wireless/intel/iwlegacy/common.c
> @@ -3122,6 +3122,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_=
cmd *cmd)
>         struct il_cmd_meta *out_meta;
>         dma_addr_t phys_addr;
>         unsigned long flags;
> +       u8 *out_payload;
>         u32 idx;
>         u16 fix_size;
>
> @@ -3157,6 +3158,16 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host=
_cmd *cmd)
>         out_cmd =3D txq->cmd[idx];
>         out_meta =3D &txq->meta[idx];
>
> +       /* The payload is in the same place in regular and huge
> +        * command buffers, but we need to let the compiler know when
> +        * we're using a larger payload buffer to avoid "field-
> +        * spanning write" warnings at run-time for huge commands.
> +        */
> +       if (cmd->flags & CMD_SIZE_HUGE)
> +               out_payload =3D ((struct il_device_cmd_huge *)out_cmd)->c=
md.payload;
> +       else
> +               out_payload =3D out_cmd->cmd.payload;
> +
>         if (WARN_ON(out_meta->flags & CMD_MAPPED)) {
>                 spin_unlock_irqrestore(&il->hcmd_lock, flags);
>                 return -ENOSPC;
> @@ -3170,7 +3181,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_=
cmd *cmd)
>                 out_meta->callback =3D cmd->callback;
>
>         out_cmd->hdr.cmd =3D cmd->id;
> -       memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
> +       memcpy(out_payload, cmd->data, cmd->len);
>
>         /* At this point, the out_cmd now has all of the incoming cmd
>          * information */
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/w=
ireless/intel/iwlegacy/common.h
> index 69687fcf963fc..027dae5619a37 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -560,6 +560,18 @@ struct il_device_cmd {
>
>  #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct il_device_cmd))
>
> +/**
> + * struct il_device_cmd_huge
> + *
> + * For use when sending huge commands.
> + */
> +struct il_device_cmd_huge {
> +       struct il_cmd_header hdr;       /* uCode API */
> +       union {
> +               u8 payload[IL_MAX_CMD_SIZE - sizeof(struct il_cmd_header)=
];
> +       } __packed cmd;
> +} __packed;
> +
>  struct il_host_cmd {
>         const void *data;
>         unsigned long reply_page;
> --
> 2.43.0
>
>
>

