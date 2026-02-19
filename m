Return-Path: <stable+bounces-217484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI9iCEJJl2m2wQIAu9opvQ
	(envelope-from <stable+bounces-217484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:32:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3EF1613B8
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A00302DE60
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272734F279;
	Thu, 19 Feb 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzMtlic4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA834E774
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522362; cv=none; b=pFwUA9/WRkGL98oy0smYbgeV5gaFky4GorRQhGgaPwX4KTyuLUMR4tGwqwRDSB55Jn2VXYFEFFaNGu30iKmjyaSPg+uO0GXHWQwXSf1jiiA0lOr7F+V3SiiRDAWhoz/6uACC6XYVIpgqToiDxxchauhGZQShbde/JnhJ6E2mL38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522362; c=relaxed/simple;
	bh=Bb/7uka0raO5CVVj/T4WrXDnULjXxJE5UN2ijVO7yLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThiHg+UtO/qVzGRxtqSOtM05B+pGENAKUg/Ua2hHdDY48msj7Qg+PWLcWh3saD33VaCTc2A92y7qn/3/phOX9VIhvONRP06qsXQveoQjSHxVkYQPt6mRmBTEiWA8pmeUx1qS3ksNbc0Q2/DFozHWnaDZLQlXewVhE8AB4cKIy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzMtlic4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBB6C4CEF7
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771522361;
	bh=Bb/7uka0raO5CVVj/T4WrXDnULjXxJE5UN2ijVO7yLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bzMtlic4r+DBbiXowx+IsOWdlTf82QO3pZBJfCKTJF8x4M1Hs9lNh5maZFdpmJklh
	 m1ByVUBzCRN5EonA4sZzv/+XpV3fi/9sxHUug22pG5GY4PMIRZ4vyVgvAfHt7Q8ow4
	 0DEUfoNM0oi20VC3FW4kWjxTaBWzCptk/A5957uGpCec33pT4f9XUXFkH3xTKPBsHG
	 ytI/EqaVQIx3Wdn/6+QVPbdeyaqBRbD0L7JpmyhKcllSn4OlK3ihHCAcguhVaIRg1a
	 J0QwjCa5GQypXnaVE+CQjk4yqo/nuBdnQaGX5qjVmpWzxHgziySeOPkgzuaZGJaWGM
	 tif6JiaX/FWLw==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79801df3e42so17872107b3.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:32:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlHkDHiWPq9UA2jnXvDL8UrYTREtELUDOCVuFc3UUpxIGJt0OtXSvGeHqzBWmuJN6geVZQ1fI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7i8FVGrxv5PZjsFv3oL9lAUzE5dlGafFIhfuCYSBnWBU49zz
	rCkYx8HZY6fdKiQdyE2j3E0OpMc5k5A1OBepCW5n0xO2NZbLPoEsCgqxrdYAA0CKr8rWxdD2WmX
	tFjlzCiii7S0YKBziuIth+TFPmod+vd4=
X-Received: by 2002:a05:690c:6303:b0:796:3858:a084 with SMTP id
 00721157ae682-79807cf462amr19793217b3.19.1771522360836; Thu, 19 Feb 2026
 09:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
In-Reply-To: <20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 18:32:30 +0100
X-Gmail-Original-Message-ID: <CAD++jL=x1cYPQWL9VEv3ELR3wyBDY3FV-8MZ6m1gDb16hPNCUg@mail.gmail.com>
X-Gm-Features: AaiRm51ySc8zVy0QGkwVpo7MjfK_OR1vBU1SHH-FoDbbCu-gpTY7cn0HLt6GeNc
Message-ID: <CAD++jL=x1cYPQWL9VEv3ELR3wyBDY3FV-8MZ6m1gDb16hPNCUg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: normalize the return value of gc->get() on
 behalf of buggy drivers
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217484-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: CC3EF1613B8
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:51=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> Commit 86ef402d805d ("gpiolib: sanitize the return value of
> gpio_chip::get()") started checking the return value of the .get()
> callback in struct gpio_chip. Now - almost a year later - it turns out
> that there are quite a few drivers in tree that can break with this
> change. Partially revert it: normalize the return value in GPIO core but
> also emit a warning.
>
> Cc: stable@vger.kernel.org
> Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::ge=
t()")
> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Closes: https://lore.kernel.org/all/aZSkqGTqMp_57qC7@google.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

