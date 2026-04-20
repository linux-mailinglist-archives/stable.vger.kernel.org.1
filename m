Return-Path: <stable+bounces-239985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHi7EsJ35mmFwwEAu9opvQ
	(envelope-from <stable+bounces-239985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:00:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6C433219
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68107300EDB2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267AC3BED24;
	Mon, 20 Apr 2026 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfKPRzWB"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B73BE653
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776711613; cv=pass; b=JYx0o6uZaTri1056f//J+nf+RqLDt3chk6tTnsmZa55xn4xAn7E8YIeSKhAlt79hxjvV8UWD8WCRhibrIYFu6ubbTI2IIJxhaWeDdyoXv+cVqFTZi9BrJ5bzGFen/h9UOq/mpkDNQDC5ABs8Ils5VS0LxwPWx/sCYOZbf6+C8XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776711613; c=relaxed/simple;
	bh=1KRYYbOyUpMPEhs9FYDn2NwMRvQwpIj4t0lvICMQsqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1/i9SbGpS3lUFNm2gaXu/ChWo8+bu8/UtxcKpwMF34ly+n0/6eEDmeut/HXetSAZr+1eq8bBiy2yr40Xl+VzLwmfMWBDAWdOIm0whwaWBtfvDLZyghGVSUsv3FZbHmWl7PJR0UZO+R6iuAuzFIKY3Q6nLz1sDsxp9YbYw1SKGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfKPRzWB; arc=pass smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46809c87e0aso122397b6e.3
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776711611; cv=none;
        d=google.com; s=arc-20240605;
        b=TEjDOkoRToQqmq/AodkCGUdHoSTa5CJ9LSHxoDRphGYRswJiXG4Elec6oJfrbOMjN3
         8m81vPUTX/4QECgfxkz9bKtE2ftlJA6xXx1hds/nAHIs+kC72XTvKplXXTsGoTxt3TAo
         C9QeIX2LQGLiSEoIm3+ey41JHID9/I3ncSQ3r6l/xpDOOkAUqO4Foaz7QnzLJqkXExzd
         0k490J8cUcG5n7GcsYZsaFtI9eIb3vy/MwnIhpa5I7rnWUTbSuNTX8PbDpmia67q1jzy
         0gN2hVlvM036GyH0St/HzGgIb3SQsCBdKnGF02AKIgpDzOQkB8vIzaGY5RRQLbyxy7Fk
         1IMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGQ8S6eo0NCGebeSoGAIcjWHTqx/TmEDZ0tG8HBGPxs=;
        fh=53IurQKtZsAZ03hJ4tspqr5tgdzbHCYPxDiehhEJTN0=;
        b=g25NaeXmd3v8inPGGgO/lkIsZjyEIb1T29HXToIK0Hzd+9SDW4a4AKEbLc0oTMufqS
         9atkFhaYyUxg1Ud6p/991B82vyOeY9xAxniuRLkDCapSl32WxzIBdURd0FPqsf8/bZaw
         YX5aFlAevXYrLkFtc8nPQHOWq+i13EVyLFSrKoiQaEWGVOQmIzgaHLg74l7RmQSl2xRp
         KJ5FWM8H/QsZR3S2y9BCLV/Z666QASLtZgqzPEwTKm5NcpBxXkg9qRxNL4tW/Xp9kxwp
         nJma+7Kf+88/bmrjYjURqqQWER6vnZysWebDH/vfyCkr9CgztI1znlfHa3qPbotZcfEX
         4lJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776711611; x=1777316411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGQ8S6eo0NCGebeSoGAIcjWHTqx/TmEDZ0tG8HBGPxs=;
        b=gfKPRzWBunsMh1EzMsH+FddpymT4E5HWqSGB9twTNQ5iCi1oJS/nbILC4fUiz8/9fr
         afaapayoVzhx0E+MAw+zyntHxudgQKDu0w8uCd5FWpwgLutz/zvOsw7zQTfkjipby9Lt
         16/8miW0U9xytFmLwIkJQYGoWAOrvc60CsqquVtTEvsFlp+qbvCtr9+VU2JPwyzjRJLg
         JjQUw3uStuBa5/HkPDehGHseP/tmPr7F+zw4yopXQAlQw/u7fpGnWCA57Mc3sgivFht0
         XY3A22E5X48NQO/n58qYvurOi94QyFQfhjhEoH9NtzexZbQlnMDNBuY2knIMdRyed+9C
         F+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776711611; x=1777316411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZGQ8S6eo0NCGebeSoGAIcjWHTqx/TmEDZ0tG8HBGPxs=;
        b=cGq2I37xd0Tq1ZyjS2oBaW6uk0JrEMOAorxiOFLZ7i4WRNzzMMx4lVjVqXUf8YYXP4
         v/vwnLawqbEik1aFxFNGJ5v+33J3xgtbhvcveZQeRk3+Z+/hoSnK+/j9XejflZIqxPA0
         AkaGHXvIpJYkmkl370UmttwUMbdnA6/Qj038Lrf0kGdvXNT9TLMryKWEvqppeOSQA7RX
         APjYvwH5q+X+1KGfyDUD7NX6w+P9oDmzvHc60PvYcd9eVC3v7CrcmrBCbNkKg0DUcFJE
         42OkXTA4fJGqjZffksFNQn4gPn7iU2fkHFcz/9GenC45tKBpvqVGXElvz/SfGHpEWm2M
         Gl/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Ytx97MzGHgBMLxdWrHzSaxTwfAjURx7L5VQNB6HS60MbLeXh8SJyyKzRnFlNba6GDjk7etaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAt4q2Wppi7hWrPD76gxzwC+YgUehz40AlQlJWDytgT9EhnPi7
	9Q5jjVExvdrZkt66ycvdRls0Z7I9dqOcF86UIRHx+19GDYgWrV4qG+8e/rXrkuVKejJJ6Ef3N2w
	tyWAjsxdQo/cnezJCDlx+qA+CzvsDv00=
X-Gm-Gg: AeBDiet7tuK3T+t6g9QrW+UOYdCt9pFCARkqnmyQ/NMAQkK/srGuKg0DBnAj9kbNnhN
	myrqVm7Z6brCZRSLe4Gg4jBj0Mu7+uy3RN0hcvYtr9wcNw2tIDhsS4bbRACSnFdPfZ9jzZO0zLM
	V/C7bgPlNJKOhZ6RBnpiUlH0uSoEfPs2lw20JnQM5x9thq99YSwejfBcbe6gHhl1kSCntc/zLej
	z7r1Jk0wSKYjBjH/687n9TcPjCMTpeIaZzS/tN3pkd6p6taguGyPD9j0rymJv3YNvappxKReZG/
	4dhLueIqwJ9cpxpVQr7mnu1Jj9g5K0WcDtQHvdY+47IY
X-Received: by 2002:a05:6808:14c1:b0:479:dcb1:dcf7 with SMTP id
 5614622812f47-479dcb1ee58mr1165616b6e.7.1776711611034; Mon, 20 Apr 2026
 12:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
In-Reply-To: <20260420-netcons_trim_newline-v1-1-dc35889aeedf@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 20 Apr 2026 19:59:59 +0100
X-Gm-Features: AQROBzC3Lo9dnnOH6fFmHSHn2qbQoBO1-4MGQQR1nIwU16VR4n-FB33Ywvch5Ms
Message-ID: <CAGSyskVWo7C9K1k1nCjfiyUR4vz41uXMfjidVYfW8Gq72OT9CQ@mail.gmail.com>
Subject: Re: [PATCH net] netconsole: avoid out-of-bounds access on empty
 string in trim_newline()
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Matthew Wood <thepacketgeek@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239985-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavold@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E3E6C433219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:34=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> trim_newline() unconditionally dereferences s[len - 1] after computing
> len =3D strnlen(s, maxlen). When the string is empty, len is 0 and the
> expression underflows to s[(size_t)-1], reading (and potentially
> writing) one byte before the buffer.
>
> The two callers feed trim_newline() with the result of strscpy() from
> configfs store callbacks (dev_name_store, userdatum_value_store).
> configfs guarantees count >=3D 1 reaches the callback, but the byte
> itself can be NUL: a userspace write(fd, "\0", 1) leaves the
> destination empty after strscpy() and triggers the underflow. The OOB
> write only fires if the adjacent byte happens to be '\n', so this is
> not a security issue, but the access is undefined behaviour either way.
>
> This pattern is commonly flagged by LLM-based code reviewers. While it
> is not a security fix, the underlying access is undefined behaviour and
> the change is small and self-contained, so it is a reasonable candidate
> for the stable trees.
>
> Guard the dereference on a non-zero length.
>
> Fixes: ae001dc67907 ("net: netconsole: move newline trimming to function"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>

> ---
>  drivers/net/netconsole.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 3c9acd6e49e86..205384dab89a6 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -497,6 +497,8 @@ static void trim_newline(char *s, size_t maxlen)
>         size_t len;
>
>         len =3D strnlen(s, maxlen);
> +       if (!len)
> +               return;
>         if (s[len - 1] =3D=3D '\n')
>                 s[len - 1] =3D '\0';
>  }
>
> ---
> base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
> change-id: 20260420-netcons_trim_newline-36f6ec3b9820
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>
>

