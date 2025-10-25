Return-Path: <stable+bounces-189742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D944C09CCE
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6458597E
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 16:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B823C50F;
	Sat, 25 Oct 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1yD3BpW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7110C1A5B9D
	for <stable@vger.kernel.org>; Sat, 25 Oct 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410870; cv=none; b=aH2h5ULUQ3BqOzYRSwv/y6/0R7wtRLhhlZLcyk5PYIicAeBnW/SpDNvy7S8LzKn2oNM3m6cz4hXbUKuxc4UPsAM2SEvrVuPfojHaT6ii1ZDbHRNH8FgebsLQN+qI52qIbtr4cQ53OJuD+fYOLQsjg6MRDSFkXu3QZdIjp8H74ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410870; c=relaxed/simple;
	bh=MjmsUVHr6NMRcRBnZl5oyGiiFbM8seOg1onkjxTlhSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6eftasaWNh4BqvDuBln9WG9PepFJSC7ci5ZcGnTjvn6vu6U30WUdAwJvm44mQl8YpTaTw7jJZSjB5NsI0JNQcMDSDjWAC+zR+qaTr0+FX9yy9NydfMRwN5ci6n+5hwTWdwl3Bvz9bQAYkSKmELn/LOmMgSlfPe8P32rbM2K1Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1yD3BpW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57992ba129eso3983670e87.3
        for <stable@vger.kernel.org>; Sat, 25 Oct 2025 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410865; x=1762015665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdq0pmLhJNTjhaDx3mb1Ru2H4viWHvHrb5MIRLM0trs=;
        b=B1yD3BpWREInVsoFWsNdd5FGmLjZwzxHjQdIIkLxolP3DlslDdB9sZ9MPH0kwpFWkd
         brwj1foCqFmcIWk3XYrWu2N89e3zOuOpSpKforui6TqHj/+iRPujvFEGxhs4k9jcem3n
         asCwX8eWnl7FNs8muY8GJ/VDC0a5VzF2KJ/lqnR1/czbTMAj0sCWhg0uJA5oKnnlFYBT
         0S6D1zuiU7ZdhNehW7h2hdTTEUklak06QYn0FN6Mk1dhby89zV8/fVHZWB6dGLb4aUNO
         5bPJX6LYBHqF+HJN+dm2iLVhAsNsGxc5rKbyfn26CK5NYo8M5mkIlvdx0YTe9W6C7RH3
         DL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410865; x=1762015665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdq0pmLhJNTjhaDx3mb1Ru2H4viWHvHrb5MIRLM0trs=;
        b=ggoeJ6suHG3VacDoAsWcD+b92X790AT4Un3UwRXLxqrmoxLyB6B3ibLkJCcoDY9l3a
         zZadTf4O14NQ6mLbuuIpevtiEVw0t08EzNFGP9LfJQpIWcrgqB7plB/H6wtVZQ7PBUcr
         3+NwfszhuuQOKLQUMPp7AqAh55rQK82EQ2LOQIMhMbwTuKn1NYYhSxZwO7TyIQejEK4A
         rWOqQeU0awMhId0CNlgLHk8tHx3XixuSaNF3/AsyZcxXUUwdQjAuTi7ndrRCuaWbTDSw
         EEJLRk6DdKxnAJCLodJHfNRrEZXWR0s8njLkm5xz31yuPbGJXFmCBmfjQEZWa40Yd5u4
         dFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnm0BcXwL+a3XEehHnSaGGypw7Wj+GGcnkQ6MvAa4iNldfeuK2fKge9ycrT10gkrSdO4DlTBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBRnDKpj7bKh9FMhwNtW71MTYGAsub9yvxrUtAiNfkdhqkRbJ
	oPoJEJtS2Dpy/mBwdcNYzknXOkT0f/h3AoM/V7VRoH0I6p4R6Vj+vZoy
X-Gm-Gg: ASbGnct6cw9hl/VUNBkCNXL+Ask5nJDHTJItkGSuYd8i4/kcYdQKt75RDmsm/z4z9Yz
	A+ioXOWZiK3oNzFXUTctu+PXP/sk2w9eqFOGdtXuKMA/ea1dSSfVA0FAgD92HHr+zcMUr+NftIT
	1e/6mCC2ew1OB9Ea/itx5AIQ4lRh8yF9G08LAJ18/P6s4CsMNt5BSj9X1mCELqkX52BKUiDw3aJ
	V1xo60UOJzW1rf7GNRqHJldWQyJGjiOG6IRdiaEJ8varlLUubZuTdsvoidoNkHisglRT2vPWPYS
	oTQULzuKPqXJvfxLdm1pTr9YAGuLYZC5QljqjhyFp5GOq+Xz8LRHFp8/VIpblUzE6lIbKdxuSDO
	IQwJkBklsNzmn4uzHn/9SeUvnM04EpYo0wF3/nyNwW0f74dN2FfkuaeLgcHmR7Adj0EvtChGCEt
	UHwoJweysLxpjWbiT4
X-Google-Smtp-Source: AGHT+IHmiyWgOLaCOggvhZPPIwoORQ6P44GeIcmP22SsJkQdAGjOfRUpAYo47TvsrY1gKVuQYt2uuw==
X-Received: by 2002:a05:6512:b95:b0:58b:25f:cbbd with SMTP id 2adb3069b0e04-592f590541amr2974425e87.2.1761410865269;
        Sat, 25 Oct 2025 09:47:45 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f74ba6sm792838e87.90.2025.10.25.09.47.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Oct 2025 09:47:44 -0700 (PDT)
Date: Sat, 25 Oct 2025 18:47:40 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, Niklas Neronin
 <niklas.neronin@linux.intel.com>, Nick Nielsen <nick.kainielsen@free.fr>,
 grm1 <grm1@mailbox.org>, Mathias Nyman <mathias.nyman@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] usb: xhci-pci: add support for hosts
 with zero USB3 ports
Message-ID: <20251025184740.15989ebe.michal.pecio@gmail.com>
In-Reply-To: <20251025160905.3857885-36-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
	<20251025160905.3857885-36-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Oct 2025 11:54:27 -0400, Sasha Levin wrote:
> From: Niklas Neronin <niklas.neronin@linux.intel.com>
> 
> [ Upstream commit 719de070f764e079cdcb4ddeeb5b19b3ddddf9c1 ]
> 
> Add xhci support for PCI hosts that have zero USB3 ports.
> Avoid creating a shared Host Controller Driver (HCD) when there is only
> one root hub. Additionally, all references to 'xhci->shared_hcd' are now
> checked before use.
> 
> Only xhci-pci.c requires modification to accommodate this change, as the
> xhci core already supports configurations with zero USB3 ports. This
> capability was introduced when xHCI Platform and MediaTek added support
> for zero USB3 ports.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220181
> Tested-by: Nick Nielsen <nick.kainielsen@free.fr>
> Tested-by: grm1 <grm1@mailbox.org>
> Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Link: https://lore.kernel.org/r/20250917210726.97100-4-mathias.nyman@linux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Hi Sasha,

This is completely broken, fix is pending in Greg's usb-linus branch.
(Which is something autosel could perhaps check itself...)

8607edcd1748 usb: xhci-pci: Fix USB2-only root hub registration

Michal

