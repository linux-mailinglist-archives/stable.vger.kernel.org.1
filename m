Return-Path: <stable+bounces-239999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vBICK6KP5mlWyQEAu9opvQ
	(envelope-from <stable+bounces-239999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:42:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1A433C57
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4BE300EF4B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858838737D;
	Mon, 20 Apr 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY8xmSGa"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE129386C39
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776717725; cv=pass; b=LKL4h8XF9XqvRnXpxxrMovRtTIanQc/jC2xb0kHFMpggq9M4rvgLz6cbotbQo7XulSWNU4/Lz1KmgBfr4tJp45PCUsAF7uAdLmkXlkBj8d5o2Jgien9DlYjXSAgLxLGL1HmrXQ7JVPSXzYHthTnkqwbwr8xMCGiBWUg7ICS9I1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776717725; c=relaxed/simple;
	bh=nLyhM+fp7riYQqgGoSuy0oUnaxYHgMAHlrwevd5S3dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qe1+5PnZiWmU8NYymCWH/PJyd0ndVgMpMoPcJbLe4WQhZn4/2RDLOyms58e8KQ27GAH7wRuwwE7wLLRI9Nvu+FYjAW9/dClSHYFjTOX1gaGhF+81K04kjFb+IRSwoN8kKo2FUuHCCI5fu0IAVwKdz7CQW9h0CljlOL1E30jd8do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY8xmSGa; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6501c9903edso3540446d50.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:42:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776717724; cv=none;
        d=google.com; s=arc-20240605;
        b=IeO6+2BgqBu3TwIMVU4h8dcgJzukwnsJW8O3F3ahXJO6FNtBIwjtRCT9aGKmkrh06y
         z0pWHQ68FmVoQEFHiGEZXN4IynrtYXGoolWwtMR8fOpxc/Q1kFEEyQixkKsxRcVk9bUp
         ub4IK80Q8syua73PNW8tdmLJ3weBh5SKof/uitC7GqEF+iFYkYH7bw7SDAzJOIcRC4tD
         FuvCq9f245+dpVUsEa0Jc8k7JNqhFLm41S09voHtVGbMDRvIC7PboXIT414mBzIDjt7U
         Ea8I7/UuEWLKTs+gvpAB0dsCAVsQWsRsHtShGiij2oME/OOx4xjo2rBGYMaodc32qQx/
         25pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YPMesXK6zWWUdv1z0+n4FdWvrPSk0fKkgxZCyXQ+qGI=;
        fh=hWCc2SJFXs6LMO28WBefAg2x2gow3d4SU0unui2pEEA=;
        b=G5NLDq6LynhU3CU+vJqYESkfru5rDh9FodMl7VUdPWrGbVDEE/wlRUGBjKLyurC7QL
         wXh1mCek0j4O1ttUTJSYgc6RzNHTw5hY0/CmWC0YECnebrFBlqtTUlo422JfSXB0Xw6b
         FLX717viXabjQbkJc0Rcv2tJkDofA/vN8DuLD49mk1adCZ0yv+PmiTD1yQHC7aotvAVL
         oWNDVQ1QexbD7TJqpBkA9/xrhumrPTDfzlWQaiilQ5279gyGAsM9pggZQ5EXlnwwBPHH
         2TEQWruJ2SBNec52rqa/EYWNtvSbz5VgpCFjdSFbj18dnv5pFZfCx6C6C41CPjC4RiCw
         USPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776717724; x=1777322524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPMesXK6zWWUdv1z0+n4FdWvrPSk0fKkgxZCyXQ+qGI=;
        b=VY8xmSGaL3UX8utF/w5kQDYF0MbC7YtY2KTprkBs9rq4rgXWMa2ZDG/4UYwzVvqw51
         6qGVPy6KXfMYOd1dZ63bLJ9gI+0RguGWTtZ/71qncHFAVPh5aI5QgVEapRAKSjisjAGx
         m0uxGUiKfySV8HygoBi5OhJWBWja1upUiCYxHzzJgVBpfDR8zxe9XrdLBY1Drk8b/IqW
         5p+sKwsYnhIvN/JSb5u8CnZljvu+A2TAqQ76SUlrl/sqltMzqxf7toXwrerQ36YPc1lY
         /6O1Rss51o6+3pV+g9vozeSHaLZgUKuP9YcXavafrrdbTb6ouyHHn8K5rjPJWieN85S3
         34VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776717724; x=1777322524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YPMesXK6zWWUdv1z0+n4FdWvrPSk0fKkgxZCyXQ+qGI=;
        b=iDYawFPsAPlUf+axMLD0CM8qjcgcYEsF6HLZgIWKfYyD9doUYDV6oNyCx+15zLcQ5l
         /NE7GsPYP4IChYcCX50fRJ9NXdelU7IY6zSAZZSW1KiR68B/IQH0OuMzOQes6qohUzp3
         5rs4K8xC4m8SBTIBztpcpiSHstzOnsRRvETT2AMwr2NPaikEawkaUCew+dOyj5jm9ZBT
         YrImJ9FKJg1Qsbnx6msGf5GkbstSQuPpzKwxh6dVp7VUvqtH+S9QpNZL17VDxnSP+Jmt
         310Vzb/t+8XZY8GekvH4cUsqfpSNQeY2XLSZkYKqx0+xzmxK9OpYvh1vnTLMOTrIJs38
         gv1A==
X-Forwarded-Encrypted: i=1; AFNElJ8s5RtGQHYfyiynEyOJHW0yTGMUISqfO5Nnr5P1QkKtyTK6/Mj3Ah974Zg/TxtZNFRQXuvOBHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0FFhyNKk2RaLkDvPhWmrokPzqn4hsrG/Ot/Fv76WIjsxUWOb
	x3TawUVmXqPQfd1IAxBf8QkaIrZkXUy8NfV9+AhA3W9sxL+UQQMARtLJNLsm/v96fFJx9TAYVUp
	HgwkpNWo0mY+C9nktDYgolGNqFmCM9Pc=
X-Gm-Gg: AeBDieuNk0YYKM56D2xVy4Dd346xNbCtIygMO0YB7WzdpEo7gf6jKKgpaSlQOcyaiV7
	WzU9DaC70fXQ33Sm9P6o/Z1C4l+nrs39LRYPUW3fIYHzMA5zVYM/Pcj4KdGD1n6SqRL9r9v7+cT
	QU0yFXiSUY6bnhXbL4MJQ7p83CE/q6tVMxqEnHTqZ2UDu+sBmWop32N+M55inX6Lhpbzeibt0w8
	W2/rZpXuOJUa7JZG/ApgaG8ec7MiTNzoPyN88SRx65tgMMu+zkrleVFuaUFRVKlJAUwALe1yIcb
	OqdERNsbmj+hsZUThpXChYADqe5u8acwrOcRSjiQQtSvi+pYEQ1+XviaP53Bo76ZVBQ+JTxmQ4m
	2qTIF
X-Received: by 2002:a05:690e:1688:b0:643:1a5f:aaec with SMTP id
 956f58d0204a3-65310a71a75mr14572943d50.47.1776717723702; Mon, 20 Apr 2026
 13:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417102919.2549352-1-tristmd@gmail.com>
In-Reply-To: <20260417102919.2549352-1-tristmd@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 16:41:52 -0400
X-Gm-Features: AQROBzD_GQxwoxVdlYB8b6d_zTcStlFgzMZlZcqFbSiUktCCzUOkh_n5AZI2Cjs
Message-ID: <CABBYNZK5dsj7oTpXAgJ1mOBYBvN+haDK0okR7ed33QC=Td18JQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btmtk: validate WMT event SKB length before
 struct access
To: Tristan Madani <tristmd@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	sean.wang@mediatek.com, mark-yw.chen@mediatek.com, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-239999-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 01A1A433C57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

On Fri, Apr 17, 2026 at 6:29=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
> struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
> (9 bytes) without first checking that the SKB contains enough data.
> A short firmware response causes out-of-bounds reads from SKB tailroom.
>
> Add length validation before each struct access to prevent OOB reads
> from malformed WMT event responses.
>
> Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to bt=
mtk.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/bluetooth/btmtk.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 6fb6ca274..b1a96ebae 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -695,6 +695,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hd=
ev,
>         if (data->evt_skb =3D=3D NULL)
>                 goto err_free_wc;
>
> +       /* Validate SKB length before accessing WMT event structs */
> +       if (data->evt_skb->len < sizeof(*wmt_evt)) {
> +               err =3D -EINVAL;
> +               goto err_free_skb;
> +       }

Can't we just use skb_pull_data instead?

> +
>         /* Parse and handle the return WMT event */
>         wmt_evt =3D (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
>         if (wmt_evt->whdr.op !=3D hdr->op) {
> @@ -712,6 +718,10 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hd=
ev,
>                         status =3D BTMTK_WMT_PATCH_DONE;
>                 break;
>         case BTMTK_WMT_FUNC_CTRL:
> +               if (data->evt_skb->len < sizeof(*wmt_evt_funcc)) {
> +                       err =3D -EINVAL;
> +                       goto err_free_skb;
> +               }

Ditto.

>                 wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_e=
vt;
>                 if (be16_to_cpu(wmt_evt_funcc->status) =3D=3D 0x404)
>                         status =3D BTMTK_WMT_ON_DONE;
> --
> 2.47.3
>

https://sashiko.dev/#/patchset/20260417102919.2549352-1-tristmd%40gmail.com

We should probably check if the comments above are valid and have them fixe=
d.

--=20
Luiz Augusto von Dentz

