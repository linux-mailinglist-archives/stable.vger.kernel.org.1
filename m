Return-Path: <stable+bounces-244329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB15Mf3o+mlIUAMAu9opvQ
	(envelope-from <stable+bounces-244329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:08:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9424D705B
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6ECE930094EE
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 07:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A382036DA00;
	Wed,  6 May 2026 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eagb8zGW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5E305E32
	for <stable@vger.kernel.org>; Wed,  6 May 2026 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051318; cv=pass; b=CKWmv6A3NvFeJ5yN4kqZ+wn+Vk5QKV+Wm1CgOpta3ndmD9oLPnICL0aPKUDf7epofNuOYk/vLihx2cR8RIzeHzW3eYQRfS2T1uk2YWFfw6JKm+BpUXpmU+v66V9lLMabs8kBEEtxk6TT16T1YDDcBYgLKfFK5ykX/rvSB100CxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051318; c=relaxed/simple;
	bh=b3SZgmuL+IPrrTMBnzb1r0MioA9hnQBcJd5OUTFP5gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDILoIkn43GFmlcWMM3qvy0M3vxCUoanMud3t6/ih+Xi7slwBpG982/8PZu8xxLPR9NB4+eoooIN8WgfxqkCZAYcG+/xXHUR+bfPWhpKZmg5u5GQbFoq8a2YF4F+OtHrTMLVKw6FYy+jxZu/u94kDlNvYb9N56NsmHSoTzD2g+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eagb8zGW; arc=pass smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7de44ed7a11so4920942a34.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 00:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051316; cv=none;
        d=google.com; s=arc-20240605;
        b=M9fQQ9eR2oKGvKg4w5y0Dqhd2VJ7OPvk/vmpzPyzI4RzrMxOh9MqoVbvv/Rjooxw9h
         OMYQq1bJBr3NWcUSwjg3Ndv2Hir7MA9nWyy3e+4+RJmDzFbqV+DUMGRo8zHPpiCIz8Cl
         6tmyWJfxr3d7ycMGWGzCdgag1NXXkQvIF4OJV7mGQxpeEfvW/0ycZpkdaZmw/IibmZCn
         jzgcClGrvutqu++DoxLrGkW3J3pA09eW6/UD40P3G3jag8buppmGq96j5S/1E79Tx06Y
         fUSoLsiz8tALjmO4QsssaGQcdO5tzW/awSS1ORS/SlVOTqWivboSHcaQKar/m3WuMt22
         7wFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bTea3asrgXOh+BgvWpxUdeIOPyJu7AIXp4MDPcsDBrM=;
        fh=pIw9TRLls9Yih3IJ4BKOOeMHq8VzqFQuVoDnQ2TP/0o=;
        b=aYvPxExQHwsm3KcSp4AV5otVdrezx8qjyMFOa6V6rABHZSX7yBcqYRk79V0IP1C7MM
         ggf/mjs8B5Bm75TG0ByV34pF6LtlT2938eV6+BzfKPi9h5kQIol3N4SRVJsMdYYhL7fy
         R/Kk6bJkILYOBmUe+ArkPZkfjoUPHk3CZzvt1kAJSGtpQ+3mkNr1OmTMDpLiC/ns+4ZR
         KyN7qY9IndaZv4TKxbgdAoSKzkwFcfeFZky33+dhJDcdIK9mQl3RvrWNpF9J9cZZGI1Z
         KpTz2TBqnXoTnlhr0BfRasPNReFIxBjlirlvDmbr6cv6+YeazJEot5SButDzUwA/N2Cs
         OXew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051316; x=1778656116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bTea3asrgXOh+BgvWpxUdeIOPyJu7AIXp4MDPcsDBrM=;
        b=Eagb8zGWVeWieD6tIrgESZIFXMyi9PHFSdyvLQzHzESl5YL8gFA+Sy6ALNyEBbJLj4
         dhc9L9FH3juIV4dqWD63oJp9e85J10H5cv0xV9J4cm5XFUH6+O+V58Dc3ly5avCG16cz
         lqJ4R8Pc47fskTR6bB/DKf1Clvv0DOsEOmTSywc8tDxyVI8VNF1VYswGJZuDbxoIw+cA
         asUwLKmJiPBeU/s4iOkxvSRDYExDoFS2NJkb7sPfZNZq8cPom8qw5la35oGJhgQ16s82
         BKbx/5PkQ9zvViA8f+u6rDU9t8zVE6e4F5RC876GiPiBhzS248fzhsW1UxtrObflsHwL
         USlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051316; x=1778656116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTea3asrgXOh+BgvWpxUdeIOPyJu7AIXp4MDPcsDBrM=;
        b=O7yXW5ZjqI2wCfj+G8x3Ch8Phf5mcVV3aQfliV6Ck4ydXelKwSlpWngxBqxHYVKU4+
         TCJ9BVZ0lE1aCHSbqOI5qXP13cE/Hda4U9iKkCx3kHb4fisXIO7GchbNhbbuzhZ97ZAb
         1QscceEqcH5skD1R0SHjkvyz5iswrwKUTf6MWq5qhCRkCObs3RXo5fIEr4CH6pNRRnUC
         /F1YzmwzWhNddVdu4ZFKXuHHruKl2Z16KWEm9Ys8Yf4CyQ20GZYLgAkqGCZrUrs2LdGv
         Y5cQwgQav30dT0R5voSAr/Z2U3X0OEoFwOKGPNYWYWmiTWKkEoMPOPn18R/k6ZEzj3he
         cz8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+7TnqkoL0cFyrC6gMoyLF5NRgmExC+3Q3PRZis7Epyl27mVURNCnRHWo8BmkSxxVi8Tor3VkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHT9HdfEo4ALt8KVrDTbFQTRB3nutFuAg0sCYeCouw98h8bUE
	XIe9dbrO2Cr3hgOKrTZZT0UKdHiZvVb6L/gIJx8KjNciSK7SEhu63/K7x7sHFp2XNIhyHFoSxRk
	mOg7pqPO6o06ah+N1g/mrhune9NJKWKf2jNP1fb4=
X-Gm-Gg: AeBDieu2Hvhvo3jEKLVHJmkvsZGHVEQIM1Z5H5r7NfnlzVrr/S8fxsro7RXNJfWPTVZ
	GbrduyKgfDs18TIGpQjlPP7sQbKOLIWm3wXb9BSieYbddqfl4mfu7F5jGVNPN52/hsZlIBhT4U8
	oPgGY+W0ZATAGD97z793k+GBESpTvKzrs9MltWEaW1gSq2p9wkVDx8MPfe2+OXzd5JdiZEJhNP4
	sHxMn6B/kqB8EKtYDk+5qUmKbm2LEtFK15HUwdxPwFoCZHIIuSzHKHbIQZHPdTabpJG6ONVkvz+
	Y9QZKUUaYaOsEgfn8R2fnLuZ7RmfSCH/9iZiEsNJpHDV4jg3
X-Received: by 2002:a05:6820:f007:b0:688:c97d:bfc3 with SMTP id
 006d021491bc7-69998d095f7mr995678eaf.38.1778051315984; Wed, 06 May 2026
 00:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505133748.51355-1-devnexen@gmail.com> <afriNDbCrUsXwV2a@ashevche-desk.local>
In-Reply-To: <afriNDbCrUsXwV2a@ashevche-desk.local>
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 6 May 2026 08:08:24 +0100
X-Gm-Features: AVHnY4Iy2Ls6WXMOqLU6Ra0Q61pO6ttLMlyXLGaz6OVSYbk91OAxucA8qW7tSNI
Message-ID: <CA+XhMqy=_dwpTz9c+kZ9tNJz-dHDRuPyc6TsoXWKODKgxqBJ0A@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: itg3200: fix i2c read into the wrong stack location
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7D9424D705B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-244329-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[intel.com:query timed out];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, 6 May 2026 at 07:40, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 02:37:48PM +0100, David Carlier wrote:
> > itg3200_read_all_channels() takes `__be16 *buf' as a parameter and
> > fills the i2c_msg destination as `(char *)&buf'. Since `buf' is the
> > parameter (a pointer), `&buf' is the address of the local pointer
> > slot on the stack of itg3200_read_all_channels(), not the address
> > of the caller's scan buffer. The (char *) cast hides the type
> > mismatch.
> >
> > i2c_transfer() therefore writes ITG3200_SCAN_ELEMENTS * sizeof(s16)
> > = 8 bytes into the parameter's stack slot, which is discarded when
> > the function returns. The caller's scan buffer in
> > itg3200_trigger_handler() is never written to, so
> > iio_push_to_buffers_with_timestamp() pushes uninitialised stack
> > contents to userspace via /dev/iio:deviceX every scan -- both a
> > functional bug (no actual gyroscope or temperature data is
> > delivered through the triggered buffer) and an information leak.
> >
> > The non-buffered read_raw() path is unaffected: it goes through
> > itg3200_read_reg_s16() which uses `&out' on a local s16 value,
> > where that is correct.
> >
> > Drop the spurious `&' so the i2c read writes into the caller's
> > buffer.
>
> Very good catch! I'm puzzled if that code was ever tested. Do you have an HW
> and that's how you enter to this bug?
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Thanks! No HW on my side -- found by inspection. I had recently looked
  at a similar `(char *)&buf' / `(char *)buf' mix-up in another
driver,
  so I went grepping for the same shape and itg3200 stood out. For
  contrast, drivers/iio/humidity/hdc3020.c::hdc3020_read_bytes() has
the
  same signature (u8 *buf parameter) and assigns `.buf = buf'
correctly.

  Compile-tested only; the analysis in the changelog is what I'm
relying
  on.

Cheers !

