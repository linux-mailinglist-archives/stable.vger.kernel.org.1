Return-Path: <stable+bounces-127006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE549A756B1
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 15:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF3C1892877
	for <lists+stable@lfdr.de>; Sat, 29 Mar 2025 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE41D6194;
	Sat, 29 Mar 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LiSogFoV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5F322E
	for <stable@vger.kernel.org>; Sat, 29 Mar 2025 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258757; cv=none; b=g178cDHRWN/700sBitYptiOTyO3P+EUbJ3D4ZVZjAKELg25PLUkm4oxAT9RoD+uRlRN/hhKh5bNsCKTSEBjIwlizCOTlRQhryDgdQKvE2HNQg3hfQBwVQ85QfbdwjOb6dDWCM4FuDyq2JU5RPqznthfvMUObsOnefcRul5wO/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258757; c=relaxed/simple;
	bh=Cf8QRuBHzGTj3EpbgfOpI8Dc180sRYRxMhwtcFoAbHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BquufaW7G4jpkkzYnE5X1kZINkCMcewP3IQRwPGOpUgBZVD2V/MZ8W+PZ18PZ20/OZVfM1MRiWyhOUQmQFnrC8aiye5l4q0tZa/d9DPSoFg0DZV1lDcTL+RdpuPQ5o3rlzeR4mdzc4HZ2N/Davfw/pILrAbzB+DFF1xkU3B/3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LiSogFoV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5e1b40f68so356894685a.1
        for <stable@vger.kernel.org>; Sat, 29 Mar 2025 07:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1743258755; x=1743863555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cf8QRuBHzGTj3EpbgfOpI8Dc180sRYRxMhwtcFoAbHM=;
        b=LiSogFoVXFIl0+dfIjFBFpSHXHlPQFOIraqW/LNm9dhMhK6Ylh59+Pbvqgl+qWhbI4
         LqHFJHozYoaoX+ARyXD39qf/0mhY4lBwHIig9wBu/URxp1Y/oBFYNVVV5n7yQEsZ4VMm
         m6QmATA6fPyEKdSDk1vlRif2bCLx6kj6566aK7Ndq5bxxkZZqzs3DBcpsPX1u25gxKUo
         48cUzpYVLmu/VkveSZW0TGllESo3Ao7IUgE2j0/IfmWX55gmw9665V+7KBKs7gY/SAv6
         5Geepe4F2+wHyCvH42SXgtgQET9gzVFz8XJS534kICmNQGB7DyefzWUvBP7/MiXr6J8I
         eKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743258755; x=1743863555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf8QRuBHzGTj3EpbgfOpI8Dc180sRYRxMhwtcFoAbHM=;
        b=CdNwe9D4cYa62EEU2HW3DeRIvID1jq+CbKoVxUc5T/rryfSO/y3QVyEarMe0P7ihQd
         /qaDFTd4IsRnZITsx6Eg8K4/RsRTSRyaeEKSxtFj0vaY/3P+2n8EKPf2dyf01FebiDl8
         j90CYs1aV6bYI84RwNGqAVKPxn8YhNNBwtGS8U9C51YUnWZ5wOFSdKW/Msd9elYXZLba
         FF6v3bDS09mVZGtN7IbLx/fy0xrj56npF8HfmSud+VmXlbjfHIRhKIESkmIuc0ugKuRJ
         jq9VQeodZrq5pxdgtrcMLjBI+2LstFa/zQ7NDGYkafF+f4URNldUnNOTPWWytltTXe39
         Ztaw==
X-Forwarded-Encrypted: i=1; AJvYcCXH9Byx0jeslUjmzq7FWUu8/hquCEBfiBtMi9ihnmtn5xbs3iJamvHOg580vzmeBVFdYRrIQFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgopL4el36xbKnhX/i3KXvUxETx7hyurg2bBv2XbUzzwkne8uk
	2ZQ6VcHo0FKg6fQ+WF0VJE7vEPfd1CNF4qb9X8A7UCU50IKt/tfBNkWrUB9Z7Q==
X-Gm-Gg: ASbGnct6cRpD1t/nVYtotWzr4HW2nnGGMCSJKDgAZq6AneP8EV7I9I5c6knWsWobuSn
	w6zpePuzEpQFuYyJcFL+iiN+2U1ZrN9rUcVadiOi4ILbial1YSW/ghXgOmSTHajRIfN++KiP5Vj
	qAxXA/flcYs7anPEQKuQF9Jy1OvJagZetsyb8CBbb6eYyLv7U36rO14+Yfxu15eIyxU20mFN9lb
	HHTnxRnTlzpzGld1ueg0sbW9iVVsKQHTz92wrTW5mSllcP759WzXIuzX6KczaW4udUO9/kOj+7p
	WGi3QCiBFkqE3VAc+krSwMcLWBOoq8jQ1RShLGYDbyyNZYpEE5uRxOM=
X-Google-Smtp-Source: AGHT+IF0cQy0jr4KMVVkh8U0F52O1lJsPAgFLz9t15YfkUtmvE3yApsTmKKf0mX9v2iGYZlTkuZukQ==
X-Received: by 2002:a05:620a:19aa:b0:7c5:5d32:2612 with SMTP id af79cd13be357-7c690890ef3mr378710685a.58.1743258754701;
        Sat, 29 Mar 2025 07:32:34 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::df1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7659ad8sm249276685a.22.2025.03.29.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 07:32:34 -0700 (PDT)
Date: Sat, 29 Mar 2025 10:32:31 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mingcong Bai <baimingcong@loongson.cn>
Subject: Re: [PATCH V2] USB: OHCI: Add quirk for LS7A OHCI controller (rev
 0x02)
Message-ID: <4bbbf646-318d-4805-98df-67eecf040de9@rowland.harvard.edu>
References: <20250327044840.3179796-1-chenhuacai@loongson.cn>
 <208f5310-5932-402b-9980-0225e67f2d66@rowland.harvard.edu>
 <CAAhV-H4aitynD20EEWQhF_uv79+1nw7sKxzd7c_+009oY63tEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4aitynD20EEWQhF_uv79+1nw7sKxzd7c_+009oY63tEg@mail.gmail.com>

On Sat, Mar 29, 2025 at 04:40:59PM +0800, Huacai Chen wrote:
> Thanks, V3 is sent:
> https://lore.kernel.org/linux-usb/20250328040059.3672979-1-chenhuacai@loongson.cn/T/#u

Okay, it looks good.

Alan Stern

