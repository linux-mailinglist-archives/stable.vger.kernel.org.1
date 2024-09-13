Return-Path: <stable+bounces-76037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185039778D0
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 08:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8748BB2314E
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 06:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728231BA299;
	Fri, 13 Sep 2024 06:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c5o8ga0h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888A187FF7
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 06:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208896; cv=none; b=q9y4Y4r8J6xH+KQmB+fMZNxFWhO6jDC/nTwmuL+quVnANrUEEEa/ByTjoeR/yk9vfCSmllbFMWAGqGdsnGScjvVpznvEbulnKqlIonz7fGGHhvitrOFNet19CF1XOmmzs+AL5jK94ovtOmQYz9AjJvcVlntuzlOqmDsCvRJ5sfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208896; c=relaxed/simple;
	bh=x/Az8mOIx6xCh9QaWyogQuSUaXizbzH8pdV2aJhLse0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEXeOAt6JJJgrUMBvPgQThMtftpJr/gfP45pfFFyDxI2Bic0GwLZhF2z1bg4RKuSjnSt2vgi4jDYCn33TPr+o8ekq7wBk/63nhcxAVBoelPgGPczPWjtqu0F+gC/jlRn+sa5fUjxD5q0eDAd2Djgjoq7601MYEyS5xYbSxDeEdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c5o8ga0h; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-656d8b346d2so334776a12.2
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 23:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726208893; x=1726813693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+aurCislgZb8sZalAgSWWZjYMecXAeXVb8GYqztcliU=;
        b=c5o8ga0how06UFh+QCW1/SfHXXC3dq831sSk1dpM3omFmL4XchjihCtZ89kIQzgrfP
         HwKr4TV2pAOmH6jkR+xcmrQAmHu5m57wHVLdXonIoPO2KWcNSIvzCUsfkMeacZnEx5Nq
         UXySasbP6xjyAANkKacNc1NNfXKBlvr6bxbIkaPv15GYoKj/Wtsqgtb+Z9niBRVEl7lI
         TkJLh3TeJd9FO9OsBkKvTnWxk2aJ9WFf8SLYgn1fthFtvbPeBMg1NWyx6Ov8pKDEe68A
         DhC5N1JJ5jMlg/1cucoDh59g26ScvPiWZs0LzCDOqLV6IFKgXZKvo2zOrrnoNMSwmRJN
         0Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726208893; x=1726813693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+aurCislgZb8sZalAgSWWZjYMecXAeXVb8GYqztcliU=;
        b=nTTP0I7bkZQ79WdH8u72+BIjFRw9x9g0fQhfoJNMcQ3Jb1enyp0Hbbh/7XUcdXeqJd
         woQJVYEpg0E3W7gROKtbDCuQI+tw2UUdmR9zgNLSmaLnwJoib2FUVLdufsjpgRCWL80T
         u42YqQHnEE6JWck1nm0F94pyycMRQ4WTzQg0ATVCb7JQgq2QCKUMJSui2qU6o4eUDO6G
         JgxLYaIf8yvTHM7wrGvOTntE8MX1XBA0Rv+FsfRLqzjb+gMfMx+pWS3o05saIQTW3c6D
         OAyHz4gY0ia20wnRHPFn3/xcRg0vexNjJplJtzp71mcwS7C1czthGy3cGh/ST1GOond8
         lj8g==
X-Forwarded-Encrypted: i=1; AJvYcCXqVIheM3txD5qx1aIS/lCr4ZPJGWNGX4CCWeRLx5ofJh2VZvg1+9CFQnWUJFRmAAFm+OTuWQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbl+6prkdPUC+XoSZwXKR3qa+LLSt6rXDK/t9oaGIw+CSsOpr
	j7Wn5k9UDMZK/vxI5SMwYUBT8WBodktMiSORSs9YljLmxGVv11lH06yQwn63kVLHa2UJQdcdRdu
	dbj1FCAZWY2CkfTE2FQqjmXDi9TGBzRTb7nccsg==
X-Google-Smtp-Source: AGHT+IHZLlzD3eQuo84QD3nKDHwfqVrbh6iCWwwh4mJK8NL8ynrj7arJaVAk3bzgxxOkNZduZMot64FtEDU01bvcGnU=
X-Received: by 2002:a05:6a20:4394:b0:1cf:2988:c34c with SMTP id
 adf61e73a8af0-1d112db26e6mr2866959637.22.1726208892551; Thu, 12 Sep 2024
 23:28:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912155159.1951792-2-ardb+git@google.com>
In-Reply-To: <20240912155159.1951792-2-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 09:27:36 +0300
Message-ID: <CAC_iWj+0pXoRwUeGuuGXZJ-sFhtuxBFidyZJpAOB+Do4-PKXgQ@mail.gmail.com>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org, 
	Breno Leitao <leitao@debian.org>, Usama Arif <usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 18:52, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The TPM event log table is a Linux specific construct, where the data
> produced by the GetEventLog() boot service is cached in memory, and
> passed on to the OS using a EFI configuration table.

an EFI*

>
> The use of EFI_LOADER_DATA here results in the region being left
> unreserved in the E820 memory map constructed by the EFI stub, and this
> is the memory description that is passed on to the incoming kernel by
> kexec, which is therefore unaware that the region should be reserved.
>
> Even though the utility of the TPM2 event log after a kexec is
> questionable, any corruption might send the parsing code off into the
> weeds and crash the kernel. So let's use EFI_ACPI_RECLAIM_MEMORY
> instead, which is always treated as reserved by the E820 conversion
> logic.
>
> Cc: <stable@vger.kernel.org>
> Reported-by: Breno Leitao <leitao@debian.org>
> Tested-by: Usama Arif <usamaarif642@gmail.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/tpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index df3182f2e63a..1fd6823248ab 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -96,7 +96,7 @@ static void efi_retrieve_tcg2_eventlog(int version, efi_physical_addr_t log_loca
>         }
>
>         /* Allocate space for the logs and copy them. */
> -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
> +       status = efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
>                              sizeof(*log_tbl) + log_size, (void **)&log_tbl);
>
>         if (status != EFI_SUCCESS) {
> --
> 2.46.0.662.g92d0881bb0-goog
>
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

