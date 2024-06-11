Return-Path: <stable+bounces-50170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E97959040DC
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4311F22609
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333852C694;
	Tue, 11 Jun 2024 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F38nc1ew"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E767A94C
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122040; cv=none; b=cotzVsShEqk6mMS4ZYK9+TLuX4qsVAybq8jQ4JqDsdf89yggDsK0aP8JkYtsGjgamsDXvBfoM+y/UhApfF3SzKuNuPyk6QfuplMtjK/dM3jay/c2gj4b+WxMXeAxN3VmSHvYM7LdjCoP7OV1/oFxFwWP2oAr5tr8IHlJkZekR9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122040; c=relaxed/simple;
	bh=w9TLbRGOTLDPs1VRYx423MA09ZxUMd83hTQNdTrenJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9AqvkfDofONrS2pSCD31Lmgaa5lcnaZPem8JtVq+jKXmlUSs2v+d9Qdb2PDcyJCQqxjEn6LfT1tECf/cQgC9O4EAQj6sCFU9VPkLpHhdz3KX5M3rQb0qE+OaF9hgimxieuA6cJgrxMQyhnrlTnH/ZNbMSAP0/yC5HRW+94tW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F38nc1ew; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c5ec83886so14043a12.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718122037; x=1718726837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0dGijFgD5mEIYGYCFChBjRGXYAEUX/53ap4AChkBkQ=;
        b=F38nc1ew6/buPJ+wpCR/sZHJ2P7pDXfqDkZ6yGkKKSuk2FIQ03lTzFMmB/OGN4b482
         G2mGpTpkiWja40S7wtSZrT1roMa12OXnwOYSeJBQZ++rQEaIND/tPh+YeOOpS1GsLQJT
         NYSQz0CL5OTq1oBHW4Ywba6kTotEz4aT+6nU1RjVpbVV2J6AfpePkwwkKtDhCU1uockh
         s0Up7RmwsEgB+Yt8o0pwzcwFoI7NYA4hIY1KZp2rse1IkSG5DkGwYVyZYQX3RtGXTiFI
         +R/BsaklbsaUh+YaA5QEimySB4gurI+PoWQH8LTTwz+bgtGAn3x3zP4oc6gMvF+jmSAa
         5vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122037; x=1718726837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0dGijFgD5mEIYGYCFChBjRGXYAEUX/53ap4AChkBkQ=;
        b=bi4YDFjniACrrImVnbcm8Kvs+GLGFYNg0PWzXjL0mXEcoYXXSBEX/+jlv2bH21p4CF
         odwWROxeNFoeUgGXN9J1O6kun53R5IRBP+yEnqhqEnc5OSCjXHjf4tsDI0yfctdu/lri
         3DlSLIMJwrzB+QKBt2QOJb56r9bjrWFkMN40YCD/PZSliXKS8C50ekLwFR8eIMpDZCiq
         NyjSeA6xBVWtV567IICFkrcDBEx4pFWqLAOuxVhEAm0hrCTCWtL3B7ad7DkaIXi7n0jL
         /AN8XTmFF7nJuxX3fm7yN1kdDyJN2vDg1YTbw+kQib0PYQECifQY3mPeIniI+/TFxrm/
         ihgg==
X-Forwarded-Encrypted: i=1; AJvYcCUAX3KgixJQwg4f/PVPEBB6ZM69q5+YFRnDLq6zr4Wt++PCHmEGGvndrzquhKMWPJOWlzmwVLxIEJauc4FF0MTpi0znIVkI
X-Gm-Message-State: AOJu0YywbCO9CLJky0GdZGJ1ckUlkF44Lh3NyoCv5QzFJG8r814kqMH8
	GVl7s9LXnkuA0WrFvrF425iYIbRfLBaYfXLFNslopdNpo4M6qef4G/6tSNs0D2Wb7/kr2k6PJIr
	HZ2EiDXyNTSOQi0Gf3m5ZMB6z7SmXvLNDQja5mf42INFaydd0v83c
X-Google-Smtp-Source: AGHT+IG3MAiUUhBwVpcVc7zUt2PS8V5nnFBSHN4RuoJojBlKM8EOy+t6gmsIVZdy6htQa4T/BfefPolvHXhQVImxbIg=
X-Received: by 2002:a05:6402:17d0:b0:57c:a4cb:1c5 with SMTP id
 4fb4d7f45d1cf-57ca4cb02c5mr27614a12.7.1718122036516; Tue, 11 Jun 2024
 09:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611113110.16955-1-tzungbi@kernel.org>
In-Reply-To: <20240611113110.16955-1-tzungbi@kernel.org>
From: Guenter Roeck <groeck@google.com>
Date: Tue, 11 Jun 2024 09:07:02 -0700
Message-ID: <CABXOdTdVh4eyEfq+5bfUs45_0Y=ZbVrrnw1i0pbcn2bJ0uazPw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: fix wrong EC message version
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 4:31=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> ec_read_version_supported() uses ec_params_get_cmd_versions_v1 but it
> wrongly uses message version 0.
>
> Fix it.
>
> Cc: stable@vger.kernel.org
> Fixes: e86264595225 ("mfd: cros_ec: add debugfs, console log file")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform=
/chrome/cros_ec_debugfs.c
> index f0e9efb543df..4525ad1b59f4 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -334,6 +334,7 @@ static int ec_read_version_supported(struct cros_ec_d=
ev *ec)
>         if (!msg)
>                 return 0;
>
> +       msg->version =3D 1;
>         msg->command =3D EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset;
>         msg->outsize =3D sizeof(*params);
>         msg->insize =3D sizeof(*response);
> --
> 2.45.2.505.gda0bf45e8d-goog
>

