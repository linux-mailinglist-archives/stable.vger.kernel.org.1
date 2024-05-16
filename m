Return-Path: <stable+bounces-45331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958198C7CB1
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 20:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC861F218F1
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E92156F3B;
	Thu, 16 May 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaacrotE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CB8156F24
	for <stable@vger.kernel.org>; Thu, 16 May 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885705; cv=none; b=h8iWpcs2GTYhUO3YrCru7EVNjauJF6CBB14dv22GuF2/VDQXXxTDAqTXGMacdb07C3pjwrEjkQN5fXeXPDxkRjPHtoQ9V9gSf3o+zFbhCC2pES7zZxIuYla421kyBSAFZOMeq9LHxKaXLnK7cPXzviz+mUxH2yHcdCEbb1eIvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885705; c=relaxed/simple;
	bh=cn+rbKU4Nj4tQx9dF4d/u1kehcthPaTDE6iwoDSE9v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLFMm73TYlAZR5w2hOIEA+u2OOFdA2WMKrwkpnxViiCPTxHzwcHqimlOTJ4m/4ldNPCtKnNg8rOMcVpvKgksZJw5/IDk6a3Hp7N9WViwHfLIbevvthvWiqiGaHbIpggJ9paVcvHzNL5qMWPaDg6x7A7S5f3YYLOvZejtTNO5RfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TaacrotE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f472d550cbso523119b3a.1
        for <stable@vger.kernel.org>; Thu, 16 May 2024 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715885703; x=1716490503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLvVPaGthcsDeYUgK994Dv4j8E5kvcQxmFSF+94OK3U=;
        b=TaacrotE3yRI2+W1PfJbx76HN2QVcQn1ZSQgnd+TV0/v6LMASLZ02GHbeFlOsMGW5V
         /gYhFcWsXOrqPQSBoN7tt59QmZ0pFfI4jJ9DOBuDdBJW12227KcqAv9fg9jmtwJpDick
         ftLD+Eyhbb+P6eROO593YJlnLhDJfqoXCFwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885703; x=1716490503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLvVPaGthcsDeYUgK994Dv4j8E5kvcQxmFSF+94OK3U=;
        b=TtJ+XFRmsZSfjSUMwAOUUZ5RPwFhw2ypJJSg8JPOxaDIBJJnsgYjY+dvlGrf6OY/yr
         JcumUTliYi6e43Qusr0Mi7COd+FhSfGp2GihnOk9umEp/lsfbMhTcpOH9NzDWzWudWpa
         OdgKnwbLp9Oqh9aET76/UlsSJukkvC/RrIA8sNis1TIEcliO4v/UiMQgsyfGa3Oht7/f
         sWxPNmSD2EdRcbUDegcncr3tWs84kT3M9zleU4/U8+lrX4dL6aCMlABfaxQW6sTA+bL7
         2OgS3bDleOq50szcBgPiX7FoUQdYC1aNqu1JLWfxKYpKa3DM2lO5BJDIO4W74ZVK7lJb
         /rxg==
X-Forwarded-Encrypted: i=1; AJvYcCULfXQRXTZvfcBZ1Y08lFBFjNjDncdBLeqO9AMCCQ2G6FINzJFzjSJAG9HQ/P7A2Rb6pggcBTdnoK2BscUrCrgdUiqt90L+
X-Gm-Message-State: AOJu0YxYvPAhQt2sSebz8KmkwMhbBEKoErmWfl/uberkMQkv1lEtxUO3
	V85aCyBfex/Xnw9WGtBariqkWama9uYYXtk4VudmV7y56QbKR9ROOsX35XxFq9Y8lY1/1qChGLU
	=
X-Google-Smtp-Source: AGHT+IEpt9Uv771YwNLuJA9hxBAARhf3uGQBrVyf9F01Epq/h6k/cCwGA6ef+W8TDQy63/KEqTvc+w==
X-Received: by 2002:a05:6a00:1916:b0:6ea:9252:435 with SMTP id d2e1a72fcca58-6f4e038539cmr30136708b3a.30.1715885703535;
        Thu, 16 May 2024 11:55:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b060f9sm13399031b3a.182.2024.05.16.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:55:02 -0700 (PDT)
Date: Thu, 16 May 2024 11:55:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ben Chaney <bchaney@akamai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory
 reservations exist
Message-ID: <202405161154.01864575AD@keescook>
References: <20240516090541.4164270-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516090541.4164270-2-ardb+git@google.com>

On Thu, May 16, 2024 at 11:05:42AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The legacy decompressor has elaborate logic to ensure that the
> randomized physical placement of the decompressed kernel image does not
> conflict with any memory reservations, including ones specified on the
> command line using mem=, memmap=, efi_fake_mem= or hugepages=, which are
> taken into account by the kernel proper at a later stage.
> 
> When booting in EFI mode, it is the firmware's job to ensure that the
> chosen range does not conflict with any memory reservations that it
> knows about, and this is trivially achieved by using the firmware's
> memory allocation APIs.
> 
> That leaves reservations specified on the command line, though, which
> the firmware knows nothing about, as these regions have no other special
> significance to the platform. Since commit
> 
>   a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> 
> these reservations are not taken into account when randomizing the
> physical placement, which may result in conflicts where the memory
> cannot be reserved by the kernel proper because its own executable image
> resides there.
> 
> To avoid having to duplicate or reuse the existing complicated logic,
> disable physical KASLR entirely when such overrides are specified. These
> are mostly diagnostic tools or niche features, and physical KASLR (as
> opposed to virtual KASLR, which is much more important as it affects the
> memory addresses observed by code executing in the kernel) is something
> we can live without.
> 
> Closes: https://lkml.kernel.org/r/FA5F6719-8824-4B04-803E-82990E65E627%40akamai.com
> Reported-by: Ben Chaney <bchaney@akamai.com>
> Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Yup, all good by me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

