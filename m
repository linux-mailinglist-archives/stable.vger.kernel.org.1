Return-Path: <stable+bounces-89358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B929B6C11
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 19:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775A21F21BC1
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0C1CB518;
	Wed, 30 Oct 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jztXfXL2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED01CB333
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312765; cv=none; b=CYFx+ruzSHKHmT53Ue+AgCT/FpeICjBZ1qhHoipi2lcDMvjkLWrx0UCS1ZfkK57cEOxapJ3dVnHiikoP7/FLSn5yjebcS0PQEMc/FAzGspHToYcq4iFJY3g+MjdeZ+N87Lk5/w1sG4riWWD4bqbq4PGe9IMpYV0tqJlSb18p1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312765; c=relaxed/simple;
	bh=G3YGB2i7Fqd9ihHSxO8Pi0dveD/nQZafEDr02VMTORQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pv7i4xZURoEhP5MlqV2A0z6OCtvrdqNlRwPQWq/cWfcHz3ceRDn0j/e76ldLx0CDbWJItAsidxSftS8JLIOZ26DOoA+NILlg5jiSUMgNnsaHunHyrAZj1udkuYoD6mcG8hOyKu/CI5c+yEPaL/oC6fJcxCEYsyspGeveH1JM2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jztXfXL2; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460963d6233so1200521cf.2
        for <stable@vger.kernel.org>; Wed, 30 Oct 2024 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730312762; x=1730917562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbjE0LVey+AU8nkE8GiAZE2/PJGlPEdVxDqptqhMLAI=;
        b=jztXfXL2NFrCWvUzjZhCHvDX0JlqjFDX1+zqO0ZNzrhgBYvt//AOvLqle300cVLtTd
         zDn2qhCRfH36OnGpDnnYp9Y65amjXRbITRBKDVw4sHfhmkbGg3fH/EujKrtntXEmHRbr
         9X21j9FoRs+uHixntfxZiigg66F81eR0OFS6QTb9dV4y2q/4zVbATO+frXqwPP/D5Vf1
         jc3pSpH35PiXFDGMup7/YCNFsTrtMo5BblgHwZJReQsmI+N2oAi5ZlM35pZFh4nGSh+o
         heXHiawO0eObTA16OEOnvnLZqDB7WVmjdBHt829lES2ncRtia1RpoDyRT5RfX5jt5Bdy
         mJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730312762; x=1730917562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbjE0LVey+AU8nkE8GiAZE2/PJGlPEdVxDqptqhMLAI=;
        b=DYKOJVQJaNvdHDqyG+wJAhp3xLHf2hl3MPfKQc/BggjqSoTxlzysDLGUDcEXYMVwGg
         SX6Ok2l6cWCcC2++3857m5hvIbayUjlUReIYrC9IQz9Q+0BDioIZ8o73ES4FNV1xqtu9
         XAo0Bbq3D9p6W1tE1+wsRhHS74yNRtxhLl7VDx4+mlYJwiNl1ziOWzYf6eqEtvy7rCwg
         RhD/uVVjNLwN3E/FnaTvl9M/OG7wV+sPpKqYjxLLa0bhAaFpiXXQuhlkFq9jvJz+H4vx
         OaCAP+yAHnWmPZ9WiHOOOEYGGcHB6VQhOtLxFQSViCCtJxQqRt8kgTUzQxMZNi2+Glom
         CPfw==
X-Forwarded-Encrypted: i=1; AJvYcCW9B9YrbMXM+evNk24vCAYQ9zlLM+JShmqHTPZN5AnKEzqssZ/LYhj97p/7/rRDlrGF9YbGWNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nJTv7H8wG0cmUJO84jzV/6EzS5kYOL7L+vXPuRZ8tw60612Z
	aNKMksqIvf/LY8q3xfYRQrAIh1geJyktBh5WZbNqF/RAdif8LeCkEUmXX32EXzo=
X-Google-Smtp-Source: AGHT+IFYDQQKS4cOudgXSyZkOKT8naielk8Nl7dGnc5cJxXyNsgI0H5LFNiELyY/pqK62ZdYy6tkVg==
X-Received: by 2002:a05:622a:52:b0:461:43d4:fcb4 with SMTP id d75a77b69052e-462ab280929mr6249451cf.26.1730312762497;
        Wed, 30 Oct 2024 11:26:02 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a1fbesm56805021cf.82.2024.10.30.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 11:26:02 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:26:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
Message-ID: <ZyJ6QHc9FetDckqo@PC2K9PVX.TheFacebook.com>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
 <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
 <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>

On Wed, Oct 30, 2024 at 05:13:14PM +0000, Usama Arif wrote:
> 
> 
> On 30/10/2024 05:25, Jiri Slaby wrote:
> > On 25. 10. 24, 15:27, Usama Arif wrote:
> >> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
> >> All of these should be just be in the dmesg.
> > efi: EFI v2.6 by American Megatrends

Tossing in another observation - the AMI EFI we've been working with has been

EFI v2.8 by American Megatrends
or 
EFI v2.9 by American Megatrends

We have not seen this particular behavior (cold boot corruption issues) on top
of these version.  Might be worth investigating this issue.

you may also want to investigate this patch set:

https://lore.kernel.org/all/20240913231954.20081-1-gourry@gourry.net/

which I believe would have caught your "eat all memory" sign extention issue.

This is queued up for v6.13 i think - but possibly 1/4 deserves a stable mark.

~Gregory

