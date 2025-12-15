Return-Path: <stable+bounces-201026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415FCBD726
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06283300FF98
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3932FA0B;
	Mon, 15 Dec 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce5arYXd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803F32FA0C
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797048; cv=none; b=MH9dRg0WcxkQJ7uOQuAPQAsbht7r9GM0M38sVB7Wd3+vjmJycB0Eg2LgEPMJ7l+Vxis/L/jOySmFzXVaAe4JmNM618ODDJKONlgjOxcKzfq0ZP9fWbovdKoNDUI+JQWJhSkniMguTMk+mhvPDzfhqWdBL3eq2QMzTrp0UA8myp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797048; c=relaxed/simple;
	bh=IS90JsqH4MMWyUQv/aAoIFZIh7k56CwQUM4HBWhrvtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/8NOPKd3YsHcDqfuiBhyeXWzkxAE5gsNT4dfrLk/LMNNVJWarGqC+kvqHx4u+IboWZ81m3ZrBe78nGOejHrTTBUdltNZvNwmwNQlGItk/VWhxrWy2yBuTH85bMTMIHJnEJjalXQ/JmLLDMPh+LB4UVcXiiAw02XFsAKQr8UOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce5arYXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1A7C16AAE
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 11:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765797048;
	bh=IS90JsqH4MMWyUQv/aAoIFZIh7k56CwQUM4HBWhrvtk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ce5arYXds6hNiR4PxuNykliJcmKHovf7gBrf5rDe4xAlBNL8dF8cq/5xOGnvMyry2
	 dmrPGxc5WXOGlwWSRonTA7AbVbgvDBKHmfH3ZuDneArlIJ7asAt4TqbxGajPhquume
	 zOEXmSs8b5uu1s8bgkxLvsnAhIo6IUGnyIqW/IVIzqpYhKyQfW67U2vjUhmchQZ5+V
	 KteHbndxSnm+Vj0Y2pEIpGrXvplBiEyqVmsYz3Q2FF6PEU3wi/XeR0CgU6HbyVZpsL
	 wDp+m42t7h4+Bo6f4DmUyV/ixnJBqMQo/5+KKbyRplDMaGjb6ZSemqlcKZ4Bu14ZqT
	 s+8e1W2zS+oqg==
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7f89d0b37f0so392842b3a.0
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 03:10:48 -0800 (PST)
X-Gm-Message-State: AOJu0Yy3W+FP9cKfVr2+M8uNUByxYwvXyj8A9zO9D/cG6ZMqwW6qkXVq
	1KHV1+LSdoBL1XedlJuaYt/0nYwq1XuVXchiQxIekMagpB+umt/V0FyYeBkErHU9Fn5IQ1G2/8/
	72K0GpkKT0guPNzAH7z3CjTH67RlNwwM=
X-Google-Smtp-Source: AGHT+IGNSlNpuR6QddIOqTuC4fFv3+r7eMzbVxRQ7FMKaBb1+m9sf5IBadUu1aONtnYMAVr53jlHaudJviWZw6nbvck=
X-Received: by 2002:a05:6a20:a128:b0:366:14b0:4b19 with SMTP id
 adf61e73a8af0-369aab23fccmr10356209637.36.1765797048165; Mon, 15 Dec 2025
 03:10:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215110819.3458104-1-sashal@kernel.org>
In-Reply-To: <20251215110819.3458104-1-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 15 Dec 2025 12:10:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHwuNaY-Z=K2othSEYSQJQUeBdbbmYJs2q6tc_SHUU2JQ@mail.gmail.com>
X-Gm-Features: AQt7F2oxuAjn5yke56KMVYcX56wYyHSbX6fNW_onS6W4XoJ6zmqLlX_zXdQ5Z_A
Message-ID: <CAMj1kXHwuNaY-Z=K2othSEYSQJQUeBdbbmYJs2q6tc_SHUU2JQ@mail.gmail.com>
Subject: Re: Patch "efi/cper: Add a new helper function to print bitmasks" has
 been added to the 6.18-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, mchehab+huawei@kernel.org
Content-Type: text/plain; charset="UTF-8"

Why are these patches being backported?



On Mon, 15 Dec 2025 at 12:08, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     efi/cper: Add a new helper function to print bitmasks
>
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      efi-cper-add-a-new-helper-function-to-print-bitmasks.patch
> and it can be found in the queue-6.18 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 06d39b93424e64e47244b0ccb97a3c6b2c033cfe
> Author: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Date:   Thu Aug 14 09:52:54 2025 -0700
>
>     efi/cper: Add a new helper function to print bitmasks
>
>     [ Upstream commit a976d790f49499ccaa0f991788ad8ebf92e7fd5c ]
>
>     Add a helper function to print a string with names associated
>     to each bit field.
>
>     A typical example is:
>
>             const char * const bits[] = {
>                     "bit 3 name",
>                     "bit 4 name",
>                     "bit 5 name",
>             };
>             char str[120];
>             unsigned int bitmask = BIT(3) | BIT(5);
>
>             #define MASK  GENMASK(5,3)
>
>             cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
>                              bits, ARRAY_SIZE(bits));
>
>     The above code fills string "str" with "bit 3 name|bit 5 name".
>
>     Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>     Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index 928409199a1a4..79ba688a64f8d 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -12,6 +12,7 @@
>   * Specification version 2.4.
>   */
>
> +#include <linux/bitmap.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/time.h>
> @@ -106,6 +107,65 @@ void cper_print_bits(const char *pfx, unsigned int bits,
>                 printk("%s\n", buf);
>  }
>
> +/**
> + * cper_bits_to_str - return a string for set bits
> + * @buf: buffer to store the output string
> + * @buf_size: size of the output string buffer
> + * @bits: bit mask
> + * @strs: string array, indexed by bit position
> + * @strs_size: size of the string array: @strs
> + *
> + * Add to @buf the bitmask in hexadecimal. Then, for each set bit in @bits,
> + * add the corresponding string describing the bit in @strs to @buf.
> + *
> + * A typical example is::
> + *
> + *     const char * const bits[] = {
> + *             "bit 3 name",
> + *             "bit 4 name",
> + *             "bit 5 name",
> + *     };
> + *     char str[120];
> + *     unsigned int bitmask = BIT(3) | BIT(5);
> + *     #define MASK GENMASK(5,3)
> + *
> + *     cper_bits_to_str(str, sizeof(str), FIELD_GET(MASK, bitmask),
> + *                      bits, ARRAY_SIZE(bits));
> + *
> + * The above code fills the string ``str`` with ``bit 3 name|bit 5 name``.
> + *
> + * Return: number of bytes stored or an error code if lower than zero.
> + */
> +int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +                    const char * const strs[], unsigned int strs_size)
> +{
> +       int len = buf_size;
> +       char *str = buf;
> +       int i, size;
> +
> +       *buf = '\0';
> +
> +       for_each_set_bit(i, &bits, strs_size) {
> +               if (!(bits & BIT_ULL(i)))
> +                       continue;
> +
> +               if (*buf && len > 0) {
> +                       *str = '|';
> +                       len--;
> +                       str++;
> +               }
> +
> +               size = strscpy(str, strs[i], len);
> +               if (size < 0)
> +                       return size;
> +
> +               len -= size;
> +               str += size;
> +       }
> +       return len - buf_size;
> +}
> +EXPORT_SYMBOL_GPL(cper_bits_to_str);
> +
>  static const char * const proc_type_strs[] = {
>         "IA32/X64",
>         "IA64",
> diff --git a/include/linux/cper.h b/include/linux/cper.h
> index 0ed60a91eca9d..58f40477c824e 100644
> --- a/include/linux/cper.h
> +++ b/include/linux/cper.h
> @@ -588,6 +588,8 @@ const char *cper_mem_err_type_str(unsigned int);
>  const char *cper_mem_err_status_str(u64 status);
>  void cper_print_bits(const char *prefix, unsigned int bits,
>                      const char * const strs[], unsigned int strs_size);
> +int cper_bits_to_str(char *buf, int buf_size, unsigned long bits,
> +                    const char * const strs[], unsigned int strs_size);
>  void cper_mem_err_pack(const struct cper_sec_mem_err *,
>                        struct cper_mem_err_compact *);
>  const char *cper_mem_err_unpack(struct trace_seq *,

