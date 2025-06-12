Return-Path: <stable+bounces-152527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07438AD6755
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 07:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE7179670
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 05:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799B3157A67;
	Thu, 12 Jun 2025 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlpsVI04"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4461798F
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749706303; cv=none; b=EqF8G0i7pHB3Cbjn40o2/WETqYxUEMKr7KaCcmojW11uujRv5j5h9fFn1e3HftVD82/H+V9GogI8L0O4XhEOwq6KJ5BrYHoua04vg2hhoE3p7QVok4xeJJHqHUx09fp4VHGMUwDPSvZbyL9KWJ1uDbwAIOgzlXI0on1+7zLR/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749706303; c=relaxed/simple;
	bh=pAfmlx+BmQK9NfGv87moPKxCj/f16d42B9nzOXBCu8s=;
	h=From:To:Subject:In-Reply-To:CC:Date:Message-ID:MIME-Version:
	 Content-Type; b=j4rTZW2TvDHuy5i162auIXJVsd9VcYvsZgJQ/SCJPQrzb/lPsRwn4thpGo2AcmZqXDNh+15IfDuKxYOd/uxsMnwSQGbag64WAZ3YeBDpmY+otk5D90gUZ7tUl9GnLhjN12nHMVsmneBZL/umXH9AAuUixx2UlxWTqWP/TMy1t7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlpsVI04; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-afc857702d1so385869a12.3
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749706301; x=1750311101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:in-reply-to:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lktWUmLs7jEqAY8KuG0D/bvZrVGge8j1xgCjT537Crg=;
        b=VlpsVI04u4YpQDljO8WmAPKDoLDq4D2kesd12NFDm8Xsw4opBEERAPi4vtXKA/ZWvN
         dDNRsD6hZUy6nYLIYf2nWuzhWOVFLlQvlklIWtBp/v/q7Yd05JCoSM9uQau9KdwAwUFM
         k5bmBwO1c0BcycIUWdy6sdK9oMGRIr+pdc9mpxBk5Sk4T09ioszLODnP0r4iGff0mPwD
         vg1dPb/zrT/FGU0fpQhHxGBu2gxQeMLfG8CbwXH35Umv8C+CXM69b/oZAVKtgA9+WHhF
         2AyQJjBpKc7oNWMNbEpehLLmbYqQ9hGZmPRx3UR9BXVT4sx+/FuQyN/g4ITV/atFLXZf
         HqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749706301; x=1750311101;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:in-reply-to:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lktWUmLs7jEqAY8KuG0D/bvZrVGge8j1xgCjT537Crg=;
        b=WZpuz80xfqe9GFNegETXAW2Pl+lKCq/trwDLCfcLEQylMcZGjrUq2BcOgBjCQWV+xZ
         TMKfX1mCelSmvIPXbKDDbE/emTuyoNMRYEf3XpLQgkewMF+O0hzm2abMoE7D9VdrsRAH
         0/xVEsa03S3oxrTqBt+Ek842RcvTZF6DR1bIgpoOEBBcIvRjPXPb1Bz/8hHJDZQBg9wO
         JcQyruawrT+uCg1kPILmhAO5pSAWAa9B5D0S54qsllPDAqfISkJdpf/a/VGYK4BqJumZ
         +mA/ZS5YqRPUtzz+EhW9js8jDAy3lC99zF3NJd/7s61qO8BZ8hbJR+moj0wvmE3SuRUt
         vVxA==
X-Gm-Message-State: AOJu0YyW50aO/USHhS6fHR4owZfWWhW4KdFrIIY5fq3wzAd7LsgsFzcu
	b+Qbx9tT7Z1WNc+j7Izqcl4pQ73OStBI4ot+lG9JqvV2ZKnbrref3cdk
X-Gm-Gg: ASbGncvlZsTt1d21tHxU3fK3WcFMOlsDQKee7WBJ3oSG4oJD+UVDUvxY37aBnKhkiTu
	qUBxu3+iqgkNwOJbFbawEXaI27aRpTlH7j1AanD2lBSpd2bUgCzBhhe0pBAa2wdfS6GZDYO4LPR
	iSfRudSDZc5vooOuhw76yuytvjsPH+TMo/4t5YCU2MuruNGme+4OORTy3TBAW7fwOd4igwjlJvu
	yHgPqY5FE6s0ABn9Kx2NV4dzO/bIBxMqSp53qFSwoqHq/OP1nDzMt8Zv4XCmm9XNOK9oqFVgxGr
	Z3evT1n6OZnmCP/u5SZHHpwNyjl436uihRo7Dk6bgHA=
X-Google-Smtp-Source: AGHT+IHbLbkgVhnSojZtMqsW60jbudxe8NiIRj6orFZ9tx3bDS3G36H3CLu+xO5vv9pkZu0JCakBpg==
X-Received: by 2002:a05:6a20:cd8f:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-21f86600925mr8143315637.5.1749706301046;
        Wed, 11 Jun 2025 22:31:41 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809eb0easm545681b3a.113.2025.06.11.22.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 22:31:40 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.15 05/34] ACPICA: Apply ACPI_NONSTRING in more places
In-Reply-To: <20250607100719.931637473@linuxfoundation.org>
CC: stable@vger.kernel.org, patches@lists.linux.dev, Ahmed Salem
 <x0rw3ll@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Jiri Slaby <jirislaby@kernel.org>
Date: Wed, 11 Jun 2025 22:31:39 -0700
Message-ID: <87ecvpcypw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Sorry for the exta mail. Accidently put CC emails in the subject...

> --- a/tools/power/acpi/tools/acpidump/apfiles.c
> +++ b/tools/power/acpi/tools/acpidump/apfiles.c
> @@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
>=20=20
>  int ap_write_to_binary_file(struct acpi_table_header *table, u32 instanc=
e)
>  {
> -	char filename[ACPI_NAMESEG_SIZE + 16];
> +	char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
>  	char instance_str[16];
>  	ACPI_FILE file;
>  	acpi_size actual;

This one seems incorrect, as I was alerted to by the following warning:

    apfiles.c: In function =E2=80=98ap_write_to_binary_file=E2=80=99:
    apfiles.c:137:9: warning: =E2=80=98__builtin_strlen=E2=80=99 argument 1=
 declared attribute =E2=80=98nonstring=E2=80=99 [-Wstringop-overread]
      137 |         strcat(filename, FILE_SUFFIX_BINARY_TABLE);
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    apfiles.c:106:14: note: argument =E2=80=98filename=E2=80=99 declared he=
re
      106 |         char filename[ACPI_NAMESEG_SIZE + 16] ACPI_NONSTRING;
          |              ^~~~~~~~

The 'strcat' function is only well defined on NUL-terminated
strings. Also, there is a line of code:

    filename[ACPI_NAMESEG_SIZE] =3D 0;

That also makes me think it is a string.

Collin

