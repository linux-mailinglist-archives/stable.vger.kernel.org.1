Return-Path: <stable+bounces-180556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C550B85E14
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A2D3AEA4B
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D8D30F529;
	Thu, 18 Sep 2025 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsqzyRB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2352F7AAA
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211141; cv=none; b=AwcI89qJuAKkISSlMkXaW59FiXG8wbt5UkRNKXHd3qmb0sQznknCBRsGyf3qakIvQISXFLnCBlgw0BKlW9JU6oSEHF+UtsvGJWxVJuuNKvS+o6+Gx9Ijkr/9HST9xGx4kQLqXILTW3je4PE3giLAv+CZf+/8y+9ssJGaTMZGnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211141; c=relaxed/simple;
	bh=BnbygAsl8Dx4wWRa3lp7WuWFbtimSRJj/t9AgFbug00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqn095HdQdEn0E2Nj275LtOYuTo5Pk5ctcJbdY8RbwihU4ftFyQCfsEpjvhrXA2Tece5rG8RiXGpiCQR3GaoF67m5E3xmOGt1FT2yCk1J7yzSI4JUAOBegSvWms4g7qfvGKPLRUJHiiY1CV6AklhX8AAhdz6hDTm+SqvKC4dQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsqzyRB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so168694166b.3
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758211138; x=1758815938; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnbygAsl8Dx4wWRa3lp7WuWFbtimSRJj/t9AgFbug00=;
        b=YZsqzyRBtcfXCtInhkTfj7m/xHgfM7zY8+8NgqtJN0qM03InLM560Z9/vynYn1jgm0
         6mPsvETmxhu7V0yxApReU8NzKaIAMhJFhuJ8dgfzmD3W01lZopug/wTezzAP/mICec27
         O8xnEkcGe0OxfjvOq1teac6tTWkb3FyLmkjU1DLy8w2D3ntMmQ6OM5zIfu0N7vmsEfV8
         4GK0jeH7W/FUiQ7+Gq3klWr0mpsujUxkIjbTXh8qPyCf8oTtCgt3leTYt0Dm6A5Cy7J8
         7LdRVUxG1AEGW1LcPXU3org7j1QLM1RJ8YCv5uNU63y+WgjQKimMxqoDgcBkVSahGxiY
         M7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211138; x=1758815938;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnbygAsl8Dx4wWRa3lp7WuWFbtimSRJj/t9AgFbug00=;
        b=wzHhhHJDpcTfk3JCnJY6wFIscWcnwxs1/j+uj11P9xy+Zqzy2W9mw5xhgxT+ATF+Pg
         9JX+dkPbdfnhlMjSa1upRKpSl+5yKGZQpxwMqzNFui06zM9yNXd1izehe3deE28YqaaW
         c/MDHiRB726Xb10Aa+r10FvMVRCUMNZjoW0pwDUCbw/lxmgVMmoCs3CARL1+8uzsMRRN
         H3rk/edVSSgMztPhGQeN3YBB9tY2qFXRPydwiNKvIYd6275BX8qm3irBHM3TXvaiKXy1
         9PakSsVdsxl0An6+m+PXiV00Z09In7IIBDG6sy+bhDNPcN4XZB76syMIqJlhnydBy5x4
         BFPA==
X-Gm-Message-State: AOJu0YyIq7CAMcVLPGx7u2RPqEsgBS++gl8znz4kf2rkw2IOqghXQYFG
	rzAyUvwRvZ5Icjkx/n6FeBHLU5V4Br+eHAQNnc3EBgnypv8ENOM3zSeM/bu2Ejq7
X-Gm-Gg: ASbGncudSV00wQ6BXglVG0xP3CaHYYxm0pjKrILl9imZ5SuDT8QXd44BB9+kurm68DN
	eIzHgscxQ7cwshXAJQLIvhY1y3QN9XGa4dQ7WVEzMpurpOGarDfyb1Mf3g7/Lwm+NUkfqlP177f
	mSGLAS7iKtNU4cg8C97Mk/gcjZ8FJek97JdJYy3+tvDt8UOKRq/va6Rou7HI9NVCKGB56NkSEsT
	7TH273eZogIEXOvuqOfy2FIHpHLoAIeYmGbV7t5+lLN2cLJOGMmZqMe0f/iXpDysN1yXqFVZnbw
	1SpEyuzt6Lh5rV9PYEKd4qkr5gG2uD2NO5KC4XlUQC7MY+QyfHdDKWKdHqnIHvu7/jiR0CB4u7P
	3bKT+U5+UOfGMlY2+lpj2RaaKjNVW4qwXjvGM6Af6bJfd5rUFN9+BVv8dUz+9hFA2R9fC
X-Google-Smtp-Source: AGHT+IEamsg+VBhCg1Lnmf79ffLdz+G7xL4OSv0lxnsoJ8h5Ioo+r205TSmpJSHOPFxqKmgywIfMwg==
X-Received: by 2002:a17:906:6a1f:b0:b04:2252:7cb1 with SMTP id a640c23a62f3a-b1bb086959emr787373866b.12.1758211137544;
        Thu, 18 Sep 2025 08:58:57 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f4390csm216682466b.10.2025.09.18.08.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:58:56 -0700 (PDT)
Message-ID: <5a9aa16aafbcd8235a70f25249b94de6a897fc14.camel@gmail.com>
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: stable@vger.kernel.org
Cc: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>, Daniel Verkamp <dverkamp@chromium.org>, Amit
 Shah	 <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev
Date: Thu, 18 Sep 2025 17:58:55 +0200
In-Reply-To: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 01:13 +0200, Filip Hejsek wrote:
> Hi,
>=20
> I would like to request backporting 5326ab737a47 ("virtio_console: fix
> order of fields cols and rows") to all LTS kernels.
>=20
> I'm working on QEMU patches that add virtio console size support.
> Without the fix, rows and columns will be swapped.
>=20
> As far as I know, there are no device implementations that use the
> wrong order and would by broken by the fix.
>=20
> Note: A previous version [1] of the patch contained "Cc: stable" and
> "Fixes:" tags, but they seem to have been accidentally left out from
> the final version.
>=20
> [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ibm.=
com/
>=20
> Thanks,
> Filip Hejsek

Sorry, that patch might actually end up being reverted, so please wait
until this clears up. We are still debating whether the Linux
implementation or the spec should be changed.

Best regards,
Filip Hejsek

