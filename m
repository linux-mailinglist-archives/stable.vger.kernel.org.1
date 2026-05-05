Return-Path: <stable+bounces-244022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKJ0JpS1+WlKBAMAu9opvQ
	(envelope-from <stable+bounces-244022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:17:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6DB4C96E6
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C5CD308D18B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 09:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215513C0636;
	Tue,  5 May 2026 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKrgQQj5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F22D239E9A
	for <stable@vger.kernel.org>; Tue,  5 May 2026 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972113; cv=none; b=E9X9e2Mkc+AUzzsoEJP+6hnh5VO6ZDowPP2dzsvhtlUl0l3hZQFZ2pCWAn1h0guA3/YjLfdNXKzB5DQg9OUciusZXJ2paprUKpXAE2IdfsUStZ4Cm5mXzisu49xcI5ZJ2udDYLGMrVE9LZaQHHC6PjBK66YrxuQxGZHl06wP7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972113; c=relaxed/simple;
	bh=kma/sGshPQ4GC/uZHT6F4UhQuiuZFZsIEBUBBjdstMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZO39pnAHwLYoBw7Kb4PCqu8TBykHzq3bgyFjwwuGN62d8ay81mvVCEaTh/XZMhTcyHRd8GwfoHXL7kSLwEm6EUbYNcXh5ewLFFUTzjiclBVKkeVjWxx2HznCIjvOAWGetytEaqrL+eHi3M+8bDEMu4cKu7vF4Nl1baBd7F4Kvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JKrgQQj5; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c566cb519so4516687a12.3
        for <stable@vger.kernel.org>; Tue, 05 May 2026 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777972110; x=1778576910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVObhnI3d5P+GOd8LYV4dRecKq3x9z2S+zHFCnUm1gg=;
        b=JKrgQQj5pBXnY7Q3BdL5lytps64yE/s7Dwta4Kogh1VYpjCnGQe3QeCwJeh0ZGXzci
         9IPjC941OF13ctuZkjBoUOnz4X7w354zzncvPoKufKAtR8S1Qm1GTMw7Iolz+BSwEa3C
         vj9lk+JQMU6u1wEUhJTPhfozTNPaSigeAUB4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777972110; x=1778576910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVObhnI3d5P+GOd8LYV4dRecKq3x9z2S+zHFCnUm1gg=;
        b=im/9NaZC0yiWGzrFibWfAnHTK2yAJWYTRlRRunGAcCS2ALJ6VRmgC65mCh5Nzil3f0
         gBZonk84N7yEDJPYEHliwJLhnljp2+yR/5s2TqCDQt4uhG3YtqZhawaw/kVROOJ/EoQw
         6dtje8CYZKXrlxgm6rnyGTRM67Ioi/JqwD7I+F2RZ2FHkX8ibTXawe7bFpAtHR8kVw7C
         h7Ywg03DsfivGCY0wlBxoJrcZwG01uClnDRJrLse14niEtE/kc0i/mK+l/EL0cwbO0BN
         SR0RWPa4BtAMl/qFhZheXq+KGcBA9BE4BBpxFrW9VzkOro8GFbaLFoenD4Qc0z9cPwGZ
         283Q==
X-Forwarded-Encrypted: i=1; AFNElJ8p/2h2vKS7z/+ZoBUUZWB3AvAjsKhZoHacLTHifApp4mdTQtiA24355bFsbzdmMRMvOhMbneU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpMG+GlIUMPhjIKeDF1q0QBHH9m3aXCv4gZIaWPBC0xQ1a5fFN
	5eWDCkQLpOAcLFwzGWKgkYE5oZoFf+82rMRqFyovlagMF+oiUfuXGBcfBwPx9ku2o8hRvrI9O/3
	9nmpMJg==
X-Gm-Gg: AeBDiesJhfHr7RA/F0ZQUnVrV/Ys0gxn43U/WuXbmu4LeLULMrDSswzfMJDCueaImZz
	t7pU1y69II+QEjiLV3Rw89Ev8wQZ9oJtCUlzCe0KZepiWqRuFNJ95h/VNnt76ITAIengrhlaHPo
	epU31Xktzt4BD83LgUxaGjE04v7caCjIo2quHUrS3laFKc+UQkqXfRcJm7R4LWb7mwPcCMjyI9C
	VW6q2xg2daZqIHLU1hwrpq11mD0v3a8XeCMS8cUsxFAeRCOXJYRg36wf/5FDKYjAz3PvnP1FMa3
	90eVecJSCI+BlCToR2D8+ZBtOmncGcbgf6t7iPEXevJ82qtImnxo1MIOt6iliFKFT6RPJ4Vp+0j
	6D/lm/cVqL4T2AKckmQAoPnZ+LyyMZ2AIN2OQqy6m1yFSCS4lpXiIw4rJtoYTillPkPC2XAUZKF
	T/0RDtfC8NGkEBD3FWQNSXkQudT4z5Uu75uk5keK9djt7LMQ1wJFakq7QVz1CvpAsugH3EjlI=
X-Received: by 2002:a05:6402:304c:b0:670:8b48:182a with SMTP id 4fb4d7f45d1cf-67cca817fa6mr815415a12.4.1777972110065;
        Tue, 05 May 2026 02:08:30 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91a4647sm214178a12.19.2026.05.05.02.08.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 02:08:29 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bad54961385so839778966b.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 02:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+JSsdAO2zUwv5BCj6WbgrEZwPDBEa4AZrmQlvoR0/a0QgEpLdDgYMe3mdBamffpyrfxskztZ8=@vger.kernel.org
X-Received: by 2002:a17:906:5189:10b0:bc4:b9c2:ae8d with SMTP id
 a640c23a62f3a-bc4b9c2b84fmr9906566b.38.1777972108095; Tue, 05 May 2026
 02:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 5 May 2026 11:08:15 +0200
X-Gmail-Original-Message-ID: <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ift3Zu08iVItBFfRjTkel5VOtDKFJZArxG2zIKfA_4FKrlMSGIzZ5bxOY
Message-ID: <CANiDSCv+h_ry7W1e1mFNLhont-1xigEZj6jL3m=FVgv2UC+KzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9C6DB4C96E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email]

HI Dmitry

FWIW this patch looks correct to me...

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

But there are a couple of things that look weird.

1) The patch line (1503) does not seem to match your tree
https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/tree/drivers/input/touchscreen/atmel_mxt_ts.c#n1503

2) The sscanf just before this check has two conversions (val and
offset), but you only check for ret != 1. Should't it be ret !=2? or I
am missing something?

On Mon, 4 May 2026 at 20:54, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> When a configuration file provides an object size that is larger than the
> driver's known mxt_obj_size(object), the driver intends to discard the
> extra bytes.
>
> The loop iterates using for (i = 0; i < size; i++). Inside the loop, the
> condition to skip processing extra bytes is:
>
>     if (i > mxt_obj_size(object))
>         continue;
>
> Since i is a 0-based index, the valid indices for the object are 0 through
> mxt_obj_size(object) - 1.
>
> When i == mxt_obj_size(object), the condition evaluates to false, and the
> code processes the byte instead of discarding it.
>
> This causes the code to calculate byte_offset = reg + i - cfg->start_ofs
> and writes the byte there, overwriting exactly one byte of the adjacent
> instance or object.
>
> Update the boundary check to skip extra bytes correctly by using >=.
>
> Fixes: 50a77c658b80 ("Input: atmel_mxt_ts - download device config using firmware loader")
> Cc: stable@vger.kernel.org
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index d62bf2c95578..28b2bd889c70 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1503,7 +1503,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
>                         }
>                         cfg->raw_pos += offset;
>
> -                       if (i > mxt_obj_size(object))
> +                       if (i >= mxt_obj_size(object))
>                                 continue;
>
>                         byte_offset = reg + i - cfg->start_ofs;
> --
> 2.54.0.545.g6539524ca2-goog
>


-- 
Ricardo Ribalda

