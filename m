Return-Path: <stable+bounces-27142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A787610B
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6CEAB21BAF
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0153385;
	Fri,  8 Mar 2024 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYhvndEG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975552F7F
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890705; cv=none; b=OrMY2UwK39xNdLTpJ6J1SGQwsdJtoTg7PRSaGXTe+apJmbclwVXEpLE5E5pcXt41kNSqUaY0UIcsM0QuDRZCqPGiNmG+w2aPt8hKGEzd0YOfQQb4NKk1l9dzw7j5E5mj5mR6HCYmX4/V4A3Ldfkda1Y1sAixsI37nqxn0JZdo1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890705; c=relaxed/simple;
	bh=+/HVAx3aKK8Z/+INSa5gD7EzyOVi+fKewvgVQBTWoWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKriadOAilJdYUzh+2FISF/LB6T+DkvtcOxpEHOHE5zbRJAQuV5coVljHwIOuu+aLpla4JzyPNDAGMZiiuW6sv78AyJ+ok7tpQazmazWCxc/hyR9/vybGZVKLxYiaGJw+k+B0kJkF0DLHBlJokEN5+sja97HluANlb8R4PqSNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XYhvndEG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2509c66daso7510861fa.3
        for <stable@vger.kernel.org>; Fri, 08 Mar 2024 01:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709890701; x=1710495501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PKd/VhcFY53iCiP36pu/jje43uUTfQtnBk8HAmVkIUA=;
        b=XYhvndEGnjpSgBtLNZgmm65MYiVx8FL+C9KdgY97ip1KKafWvdtHWPvo4kKqTEsQJx
         /xYOPspv3Sd+UxzJER+IN5NRAXm1p6XOb3xQwM8SMvkOUCS4Bzx0lzOzgVIu4k6v2VqJ
         q0tNwkmw0q0urzSZ5m/GMOmcp7HTvVjypmjdeQMc2p1Ywox1As2r+a6ugg6Jl1X5L7MR
         mszm0+cMaj/52q4NcSr1MrGxeAa9mkSWOp7DH2KaN+umq6cicc+NddQKC9gxNCdTqXim
         L1suECLWNc4P/CUKIe6YZvPNK9T/X4RS3Pmhi//dWkt8GlaJm1xtudZtTICxuZ67BSUf
         bmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890701; x=1710495501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKd/VhcFY53iCiP36pu/jje43uUTfQtnBk8HAmVkIUA=;
        b=i713I0Jgs1exvIh/1XmpVfMH0VgkWAyJwfUVP+6Ts/Vkp7SZjSrW4JO2+ImdP1euEz
         kkV2wPqxz6KPyd0hYTL1TBjJ4rdhFLGlMHvDzn7StHYo/sKw0ez8ygvI3Xawc5DZU6HR
         J4EWhuTSvSwIIJLZJvxVPjwOaqKMp4X8kO0wiPKFON0quBxnz2RQxPFTDf/r56JR9mJM
         lU+gFmHIdg7HSjXLHrhQutkEbHNZOfW5LS4fdLfDHbt3j+1IS3533R9kbOw+rohHn27o
         CmDZNmfr+gaT3gwzGt/byMCLaWiX+taq/1a1D4xNAO3GQ9Hue/N44h/3TCj4cm9+aPJI
         tflQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK1zUzxvteB6WW+JV/YN62ZUGAwJPBI/OAZF4W2xq53vVcPHPU2OhWdOoeZ3uBExQfL2SzbeUpU0tIzwcM2glfwTv2v2SJ
X-Gm-Message-State: AOJu0YzkVIDG/BGnHatc9PTCN0pERZfL2lR1Bnxt63BxwhIedGOHHXaK
	EpUifzInwWghgzxjmVYQ4yoN73YslZr1bB86Z2YVy61o6jVUBBScvZYk32ihF/KyCHpKgtNgWSO
	wO/fCUj1VzfteiSUqc7lUBCvnC7UOTi9ztwXvcQ==
X-Google-Smtp-Source: AGHT+IHTQWUAmjOIyhsrTVd8ec69tT/txYhV/PJyxsQds5F9A1hjt6Ug0zxxSF/hd1u7/jSEZwbrP+1SNsyYO2En9iQ=
X-Received: by 2002:a2e:8045:0:b0:2d2:2b2e:1680 with SMTP id
 p5-20020a2e8045000000b002d22b2e1680mr2849647ljg.35.1709890701258; Fri, 08 Mar
 2024 01:38:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com> <20240308085754.476197-8-ardb+git@google.com>
In-Reply-To: <20240308085754.476197-8-ardb+git@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 11:37:45 +0200
Message-ID: <CAC_iWjJgV+wrgKUQsVYvCdvE5Qer2B-ieJC894b+wjKVhdDH8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] efi/libstub: Use correct event size when measuring
 data into the TPM
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ard

On Fri, 8 Mar 2024 at 10:58, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Our efi_tcg2_tagged_event is not defined in the EFI spec, but it is not
> a local invention either: it was taken from the TCG PC Client spec,
> where it is called TCG_PCClientTaggedEvent.
>
> This spec also contains some guidance on how to populate it, which
> is not being followed closely at the moment; the event size should cover
> the TCG_PCClientTaggedEvent and its payload only, but it currently
> covers the preceding efi_tcg2_event too, and this may result in trailing
> garbage being measured into the TPM.

I think there's a confusion here and the current code we have is correct.
The EFI TCG spec [0] says that the tdEFI_TCG2_EVENT size is:
"Total size of the event including the Size component, the header and the
Event data." which obviously contradicts the definition of the tagged
event in the PC client spec.
But given the fact that TCG_PCClientTaggedEvent has its own size field
I think we should use what we already have.


[0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
page 33

Cheers
/Ilias

>
> So rename the struct and document its provenance, and fix up the use so
> only the tagged event data is represented in the size field.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 20 +++++++++++---------
>  drivers/firmware/efi/libstub/efistub.h         | 12 ++++++------
>  2 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index bfa30625f5d0..16843ab9b64d 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -11,6 +11,7 @@
>
>  #include <linux/efi.h>
>  #include <linux/kernel.h>
> +#include <linux/overflow.h>
>  #include <asm/efi.h>
>  #include <asm/setup.h>
>
> @@ -219,23 +220,24 @@ static const struct {
>         },
>  };
>
> +struct efistub_measured_event {
> +       efi_tcg2_event_t        event_data;
> +       TCG_PCClientTaggedEvent tagged_event;
> +} __packed;
> +
>  static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>                                              unsigned long load_size,
>                                              enum efistub_event event)
>  {
> +       struct efistub_measured_event *evt;
> +       int size = struct_size(&evt->tagged_event, tagged_event_data,
> +                              events[event].event_data_len);
>         efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
>         efi_tcg2_protocol_t *tcg2 = NULL;
>         efi_status_t status;
>
>         efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
>         if (tcg2) {
> -               struct efi_measured_event {
> -                       efi_tcg2_event_t        event_data;
> -                       efi_tcg2_tagged_event_t tagged_event;
> -                       u8                      tagged_event_data[];
> -               } *evt;
> -               int size = sizeof(*evt) + events[event].event_data_len;
> -
>                 status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, size,
>                                      (void **)&evt);
>                 if (status != EFI_SUCCESS)
> @@ -249,12 +251,12 @@ static efi_status_t efi_measure_tagged_event(unsigned long load_addr,
>                         .event_header.event_type        = EV_EVENT_TAG,
>                 };
>
> -               evt->tagged_event = (struct efi_tcg2_tagged_event){
> +               evt->tagged_event = (TCG_PCClientTaggedEvent){
>                         .tagged_event_id                = events[event].event_id,
>                         .tagged_event_data_size         = events[event].event_data_len,
>                 };
>
> -               memcpy(evt->tagged_event_data, events[event].event_data,
> +               memcpy(evt->tagged_event.tagged_event_data, events[event].event_data,
>                        events[event].event_data_len);
>
>                 status = efi_call_proto(tcg2, hash_log_extend_event, 0,
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index c04b82ea40f2..043a3ff435f3 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -843,14 +843,14 @@ struct efi_tcg2_event {
>         /* u8[] event follows here */
>  } __packed;
>
> -struct efi_tcg2_tagged_event {
> -       u32 tagged_event_id;
> -       u32 tagged_event_data_size;
> -       /* u8  tagged event data follows here */
> -} __packed;
> +/* from TCG PC Client Platform Firmware Profile Specification */
> +typedef struct tdTCG_PCClientTaggedEvent {
> +       u32     tagged_event_id;
> +       u32     tagged_event_data_size;
> +       u8      tagged_event_data[];
> +} TCG_PCClientTaggedEvent;
>
>  typedef struct efi_tcg2_event efi_tcg2_event_t;
> -typedef struct efi_tcg2_tagged_event efi_tcg2_tagged_event_t;
>  typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
>
>  union efi_tcg2_protocol {
> --
> 2.44.0.278.ge034bb2e1d-goog
>

