Return-Path: <stable+bounces-230324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIukLE/Sw2lXuQQAu9opvQ
	(envelope-from <stable+bounces-230324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:17:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31AA324B0F
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 733613316989
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0173A1A44;
	Wed, 25 Mar 2026 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+x0XmLf"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2763CCFD2
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439714; cv=pass; b=qpiJQo8ZVnyx52NxevBMqZSiXxqzEBssx8JigbMpyZu5rp7RpGjm2cgPeft4RaKKL9tO3sK8zYYAFWip0vpBAocOCnv6sQuGq/ttG4/PjQl+2/50AsJqfPgIhfdmPc7+zkhCydZ0Zskk2iROMn47KBesA6xjuwHWlz9bROIs1/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439714; c=relaxed/simple;
	bh=/4W9RE8z21QjkAb0jO3bHGuVegorEkbX+UlniHVigxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6zE2khpWdWbY7g/tN4cT6gYxVhVdGMa6b7QIIBcTqvs9dO3vCjMb+YlQk88RYu4YK7HBQsV4ESmMUiRr35msf+W7qLzFLr2As/jZ1jM0OsGxygfTyDifq981ecFK6wb0flxsIYeFYAMzLmxCwhWgev/7YSEicHP0sxVOQsrvIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+x0XmLf; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so12305263c88.1
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 04:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774439712; cv=none;
        d=google.com; s=arc-20240605;
        b=W2Tvuoi/i8yplZFFzNO9jzSUEvVevB9KzB6MpCn19+TrrXyjxFok2ljav6oMGZ8HSt
         df//K0yb1oD4oG7FaC9lUzumLd9AJNk5EHweX4GAIyXFEodbJfcuFMvKb1eAQUj5YvGq
         0H9FwhsMMVjnK11VP8s4ldx87z0QI/FCPOagJ+he8JP6q0mo1E+en1hscb3ad61SjlK7
         21xO55sXdD+YFb57HV9tUyzH0PXegU5xWKHPQWfMWXWtFIidquGA/DFM1QDf3G8ooREI
         FyG/sZQlRl2igWgb/LJNkyoJk8nW24OafGYv4vpHEwc43X6cPN9BIHFR26Hl/YILIkVp
         wGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2tSPIXsOhsxvev4wetUjiK1cG61mtTHq7qYf68HDLCA=;
        fh=41DKx8zKXJJu8q1yqhMp3E67BSghoDy/qMrC2Ibg6Gw=;
        b=RByOfxM308s71b2nEQoazc76Y/kdwN/Srh2lUI2QFl643QHQDEbK5/HXp/4QO2ICN1
         D801Zt1bCFhgdeUrEgAl2Zf8v9fHL6Gn7cuHJOiK2CUFPFxMpDRRKjY7j+CtcV8icvWf
         KAd/wMN5680T7YBWi4EzaM0t7LrBTZXR3egEJ5fM4ZdGAKIlq4GrR3WyRfCExoY9OPtL
         xMFNfM/zzTX5EqW7PHoltW07OMM/So2ChILkmoJMaJXk7Uq5Fz8HCMiggh/7HO36Uypt
         8cgKeInQxq8ucR6HO42Zbol9vSdBIsi9luFz7+/HSQtPI1WZhKaZ9fFfcDSeGJUnU4z1
         ro3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774439712; x=1775044512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tSPIXsOhsxvev4wetUjiK1cG61mtTHq7qYf68HDLCA=;
        b=q+x0XmLfUxENP+VpFR9OWfQphoggsulItHTzscjxKkf53ROnFeRtoP/fCzUolSIAGk
         a+E8gGXFkSZS9RXMR6CL89/OkrQ9e22Yoxk3DVh6cx7zw+nLNnTLxMvIgN4M0Zd3uC9k
         SFI6lzNOi+nwzYnCDXkTsMN/wsRLDFHovEnVwrJxYg4lQ/AXI79gwItZnel3bUe/I7YK
         SgyCrnQcLzo1XuEShNlZPcNzxECxwiRvIhNrCKLkeDnQ2MwXbHeJpQdFHI/6mSlNUl7J
         YqQCOGfyH9kHThOOBY7xHQUIx04ixA7W4MjNTgxchPuw6bwoKhqpFz62eEus1FZabt1c
         Mraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774439712; x=1775044512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2tSPIXsOhsxvev4wetUjiK1cG61mtTHq7qYf68HDLCA=;
        b=tHylyg3FisUEaWafsaIiUD7jDksoIOVDkevhGYAv2OyPIEpxw8sQsh9FvMR4+WsxaV
         bvtuIx9RfReBsPIuHZS62zdf1mUkKDOD3XK2kuzsTN/QzTz5TPHVczYmkAw0OBA8Eapd
         2UY86618p4aLNDzm9tQrrDDUyN1Mm8y4s3jcKd1aY2BIuL9P9QNddiKGPk5000XvzhUR
         0q10whF+c69uhODw4hUUctUe0260/IAOtpa/bKyu9cXWMldXIFKupZVH/70HBG7XktIt
         /uXCudZFM8LRePlmid1qFF+2OU9dEwjiZjh6ml+FNGMMON2BW1ejJGnc/OzyTrg8yRLq
         gj3A==
X-Forwarded-Encrypted: i=1; AJvYcCVgNEmO+hQeGFMV08A2LlvWlKjHSGSFRNoc4CheUDWrubt3MKOOPJdpVxtwvR0AefrQ66xSxmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xyCiUpIcMzBHWPq46Jewe7vjWt+2GqEbO/lWYzil4f7q4UzM
	CrCzChGukJnDuHQxHA9jAxdhfL/VJ67tnAIqwftBl5l/6gwUcJy+zd5FzZJOETNqejjdgj1v9rX
	eusTPJy+/SGuhKZyOgOFjZYbmAp3Q56U=
X-Gm-Gg: ATEYQzwdAN/yd6QpPs2TJ5YNSjY8D3vICZsXXkpr1UlycV0rw8ygC0QdGzEGD5ibTRd
	aWWamGclWZExZjmFeb851I0R5qyIOAwqA+77o1dz0uq2jx3pxdUnpGw0+G3XVJqspjdUk4NLDHP
	4K7rw+rEWUUqItgGYl41VaWXxhscS2YQmqhD/cVTcEb22PhNYmlGCK/rwe/B6f5gmGZZCAm6igF
	Lci25TzYgXpEfSm1Ys5+qrzMfatWRcND/NjVvBzPoJlJfL9/JDazIgvvVOEP/DTp3HYhgA6HZh1
	td3ZFaI=
X-Received: by 2002:a05:7022:78e:b0:11b:9b9f:426b with SMTP id
 a92af1059eb24-12a96ed357fmr1626314c88.20.1774439712218; Wed, 25 Mar 2026
 04:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318023733.116789-1-CFSworks@gmail.com> <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
 <CAH5Ym4i_Vbu88yHr5UG=6=kOS_jebsSaV3B-AvZjrn+jk8h-xA@mail.gmail.com>
In-Reply-To: <CAH5Ym4i_Vbu88yHr5UG=6=kOS_jebsSaV3B-AvZjrn+jk8h-xA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 25 Mar 2026 12:55:00 +0100
X-Gm-Features: AaiRm52dih7Y_7oYw7_JM8EEfbKO3eAvCioYFA-s2Ei8UUpBTgqfSuvyd4F9rTw
Message-ID: <CAOi1vP82GXftssgpm3VQgcQ5N9yQV+eYN8sdswJtMhy-NETYRA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230324-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: E31AA324B0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 3:56=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> On Wed, Mar 18, 2026 at 12:42=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> > ...
>
> Hi Slava,
>
> > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> This looks like you gave "for future reference" feedback and provided
> a R-b tag for the current version of the patch; is that it? Or is this
> a tag to roll forward to a v3 with your feedback applied?

Hi Sam,

The patch was applied as is last week:

https://github.com/ceph/ceph-client/commit/681a6d350eff104294bf8aceebb627a0=
8c037298

Thanks,

                Ilya

