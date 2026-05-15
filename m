Return-Path: <stable+bounces-247623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOOHEATlBmoHowIAu9opvQ
	(envelope-from <stable+bounces-247623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:19:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A34754C42D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13C9B309943F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A34279E7;
	Fri, 15 May 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A52d2FKi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF1E3FFAD8
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778835633; cv=pass; b=VabdcBK7GMobn9dPBxJfs2VyzteRau7vwpUglvrHfmD5amUwvDt0CrYrnWkM2QOVGL/RuTmTYisgx6S/YcCVed7l1YDCFjVnAKAl6IP6JBHYMoeZ9dddDNL2Tj+P7KmfksHLSevmh8+bl7PYAe4pYFonyAfhg68azQOAzfulXME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778835633; c=relaxed/simple;
	bh=F/X+K7mq57LanIUzere2hvolhecmdp/IaOj+v5+0pyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ava53oYyf+nVjQazA9+YYQv6FhyNFLXmY5fFoP5UH8cN8jAy/ET802c9Cs+Lr63AJelIheM7ZhTepc6mZ8ix68iSR1LitrmQSwRnEp4JMPx3CWMunLG/CTicmkXK9S3JGlLyR063eIf+PZiwLwYS7WwYeB8wxshU4lR/5Jz6KL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A52d2FKi; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d734223e4so407645f8f.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 02:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778835629; cv=none;
        d=google.com; s=arc-20240605;
        b=X2+WBYtdsvYrL1+234X4IGpvDKRnQmgnKXrTBROTRUKErq+OGoLE8R6n/L5TyMatY2
         yjDsest8KgtIH81md6wlAuoQq3qM90tzIDWgFo9M1nEBTHghsiwVHg4cYcHghdT/DYKo
         cI7qR1lehui6KVzb5XqEpH1Y0fPYhoB0QfzAXTHoYuKDUGQPdv3GTbL9LK7yq8jm9wfF
         GBOt8M6I/vRkcKQqTKjk2tFXNNQ/MDO6vCHgsTIl87y1SSdSUtRLNOTclINx36lAE5ye
         RFcO5ViwOWZO6GJULc3cyntNGV1R3cVGbHRXItJm/SXdab5W4nBDRYZ96Jua0YSzpaTS
         cKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fSEW1HYxOL8S924kl6mfYFM2UkEZu01y2bHFTxrJdTs=;
        fh=ZFdmri+DIMJOQQeEA+H4ylHw6n8prWxLqyow/hfrE0o=;
        b=AZ5nr21OY4zn/4/hFhpTHvi8I75nYAHYYpRnes7m9TI86KHo5kwrl88NWsQVTQVo7h
         2itP2sBRRVjzwJUbKSui6aOeBzDOeHBOS1MjgOjkHVeXB6qKFhI8Ji5T1m1uQA0i3ZjE
         6A8MBz9gXpuMEwBaBQ6sOSfPksrzV1uneTB2Mdfk4ujEatUSLGzyAGChV3s+4nqdDWyW
         /cQI37c9DFpl+QP9vEJfBzZv/eNMySbCoBn8IMa3qz3yBr/G0W9sn0FnhQI4ozv4jdMJ
         s0M/1tqrHiePUzV5u/g2Fpd1sawKzxhs6+8E0V6x48EByZ+Q+/Rbx30SSiGQ+tAKTKY0
         zRSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778835629; x=1779440429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSEW1HYxOL8S924kl6mfYFM2UkEZu01y2bHFTxrJdTs=;
        b=A52d2FKidQ+wv+Wcf6Onyqbl1WlDBNfXRttqanqgV3M6Yo/WiwrQ9nG9vx/5am4LzZ
         2RZAGuHlkuyCcySPaK/pSGtyMi/KFhWCQQIGhVWJZeLl/qGgj/ERQinNLmiC4h1M2Ttd
         QCPwtc3aTD4rjHoSRy9/ZTJoK2/1YKdX1+54jvHj4gxXyPnw+yjV6FoEYbEjRJg5BVqf
         QZ6//6diwYJ3YAcBrX/1aFBLDOwY4hdiDhQXWvfALmWXrp2yRqMhO8vlD2dAdTAjK2ib
         Hn906ioEHLFLkV1DLmUJPs/jvGfROrO/Vc0MZJaymNcVBhqIdgcmU3IcdAeeUPNKICTq
         fGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778835629; x=1779440429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSEW1HYxOL8S924kl6mfYFM2UkEZu01y2bHFTxrJdTs=;
        b=OG9FO7XicprVYaEBs2OrtwWZ+87+EX6e1tN74zyWNVhNpadUg8dJ+199J/Wvp3OC+f
         kyyEaS/YJh4me4fcR1j/jwO7ZcBbNJhNBtUECMvWwO9dPn0Ac0c8jVXxjIh1eYyirkdy
         E6AgoDC3tl3BvKIFSIAusSXAOd74HQe31x/sTfeYcr69ysLiJ0WPFxTq+HqhcOX6xxHz
         dXjmz4uYExX/DLwgxU1iLTHLqvqNyB1PpkQ4dPoVJbNeIUAqeyAT6HbC91B1gxFNCh2Y
         Ejj1QXN7qASQR4TEGb9xkcvKQz4rYLBw4kbsgkakfGQR8Xcb3dIKOkXiAvFsH+bUfc8D
         cIuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8N0EKeP8mwisV6/ntiktgxk3/WSk372O51UaBNTODv0qwm2nkfDq2rMcL4h3nfMldNcmV19WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZHdA2Y1fIOmj3XfXBXXXX0Di37YCG4b5w2oS2ZSr1zLt6i2r
	/7cmOUSnnf7+OGN30zSd15t29dnkYL6oJkeWGIWPqTa5wumpyGk1jQkOJXbjDSToBE9SmNg4bFz
	zjPZKtITgrA506PNCaO0QjgzJ8oIMW0I=
X-Gm-Gg: Acq92OEIWMLxi1dBk4Q5U+m7xqlWhatCXkQfSp6Xk+aeb1c+9p5YQQoK+0EB2UQBvuy
	MFRDIRZHEB+lH7I1utN0W04aE6ZKy17Bnm1JEJwtiQomnHBcieY1Fqz/3hjr2NfuN3nK0IGKqda
	F4pMFQyWlbL7xRibbiYtyyEGgvrcb+LhTkiUAJB5V1A2ljDcAhJ0t7pPduFOqHHrLv5C0r38KkM
	RSjUyEoTJlxY+QXQGrClnYGezIrFs6xcuqQfClU8x0TQAr3HN/S6sVnDfcQZhUUfk9IIccZRvj5
	z1AD0ektdfLOTit0F+GEqYlFOuOLuqhkoS+6dmesPM7h9uVv3wnSPdlEVaOTT63F3txDzkKECwP
	rxkzyBlEfJ4vzmXRYMdQeqbW/1iANg6ylGbdZiX6BQTJfyz6v0f3xe6acPQwI984cduQc4XdRaP
	+Umy3upg==
X-Received: by 2002:a05:6000:186c:b0:45d:2efc:dc6e with SMTP id
 ffacd0b85a97d-45e5b895b4bmr4803889f8f.20.1778835628703; Fri, 15 May 2026
 02:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
In-Reply-To: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 11:00:17 +0200
X-Gm-Features: AVHnY4Kp5BeexoywxD3HdfQW-xQ6iB-Lgl5_DxsLl3wuKsZ5H5iqQcVjeUTYCwY
Message-ID: <CALoEA-x31YdsdCtubOw7o1GBakCBcc4ha_KvuP=W5URBHyZDtA@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3A34754C42D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247623-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,parrot.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Thu, 14 May 2026 at 13:38, Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Currently in the AK8975 driver there are two instances where potential
> uninitialized kernel stack memory leaks can occur. If
> i2c_smbus_read_i2c_block_data_or_emulated() returns a value less than
> the size of the buffer, uninitialized bytes are retained in the buffer
> and later the buffer is passed on to IIO buffers, potentially leaking
> memory to userspace.
>
> Fix this by adding checks whether the return value of the function is
> equal to the size of the buffer and subsequently if the value is
> lesser than zero to distinguish from a returned error code.
>
> Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260513-ak8975-fix-v1-1-104ea605dd54%40gmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index b648b0afa5733fd7a54bdf2b8f92f00e924c074b..9d23c8136291a52ca9ab928d81332aa32933fec6 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -756,8 +756,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>         ret = i2c_smbus_read_i2c_block_data_or_emulated(
>                         client, def->data_regs[index],
>                         sizeof(rval), (u8*)&rval);
> -       if (ret < 0)
> +       if (ret != sizeof(rval)) {
> +               if (ret >= 0)
> +                       ret = -EIO;
>                 goto exit;
> +       }
>
>         /* Read out ST2 for release lock on measurement data. */
>         ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
> @@ -871,8 +874,11 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>                                                         def->data_regs[0],
>                                                         3 * sizeof(fval[0]),
>                                                         (u8 *)fval);
> -       if (ret < 0)
> +       if (ret != sizeof(fval)) {

Hmm, Sashiko pointed out that I am comparing a signed integer with
an unsigned integer, which would result in type promotion and subsequent
mangling of any potential negative values... will fix in v2.

https://sashiko.dev/#/patchset/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf%40gmail.com

-- 
Kind regards

CJD

