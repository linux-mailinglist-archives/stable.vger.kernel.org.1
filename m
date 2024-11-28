Return-Path: <stable+bounces-95701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC829DB670
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E402B21B60
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20451195980;
	Thu, 28 Nov 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oDrB7OT4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95962156641
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792974; cv=none; b=hii7HTJZkjOPi0nKCIREXWoc6EDn8f5N7FUvVrghkZHKW173NsjKOJGwI7K2JOcmcDakaJnZukN661I7/GNdj8AfRqmd+Uhn7GSdyxGKMjITn99mwOwRs55j58eI7666DmuTFCQfJawaqAnExjK7rP47gohe1fDPY+Jvfvi7CJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792974; c=relaxed/simple;
	bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhwOgc5z31jy25sLeDK3raS1pBSsrcwJB4LUYa+ySiav5r1GCfTYWAnITSs6+bvZ9cgTtM1AkBcsquODlUnNaUj8EAqIybNoyQCzoN7DIMhf6hG+I2gT0rEnQL7VWckpXmcgJ3TXBO+SU+uaPQfvpgo+jVXDuHxohmIWPhD0Cg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oDrB7OT4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbd70f79f2so635863a12.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 03:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732792973; x=1733397773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
        b=oDrB7OT4QTXjwXMLO3vsChNb/aR8LxQYNtJ0RXEmS7r93D7TvK+0j4RlB9EJiwzWUy
         gffrqlzRsxAPuLSEUJybAvVcAR9hZm19rG9m2MbSKqywK6Lo7T6C6WSvGTmDhV2UBLGy
         /+kpQZAOIcBBklEQ1IZCo+hvSgTkV7Z6pnir0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732792973; x=1733397773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+FnFOZIluj4zPhoTI/4zAptkY4TE3BF6majq5p40Qg=;
        b=vrr2fBW0gds4OlbV2bYL3fvtpe2tdkGYh4QdGJ/sSBqomjQ/uO7S6ZVFggdqUhcSx0
         z5GdNOKRc6hH5B43QiU95Q5R4EARG7IIIWs/IHdwI+RZ40qMoEyvijJMJ5fEgODbAPri
         KZpLzi5PdKkF6v11HQt7wLHXatrthfVJhja+GcbNhuc1pQ9lFPYAchlftpOJc9A5Vjoq
         Yy3/Egqqvq9brBf4uGy41krRauW7oddqnBEfYVAeeQHjlOzmExWwfHd0gRuSeC+YGSnm
         0dquW+g7wZs/ut98lCTxxOW0evxeJUf9e+V2p+CdlTF7fTq3ovEvxlaXCM3xQnZoA8Pv
         A3Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUn+xJwR7RplLqLvFl69IHDtut6P1t4ImriUssTKq0CreHcM/vHZiXtY0JsXzfOoE8ZZR+Ni5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHw8zvZbhOc7Vga2PYVkIpret8k6QDDH8WPahmbkmDJZ9R8v4
	IntAQt4oHxWRQ4sJWEY7hXYTS9BUFhIihEN8Z0vShhljnJ06h738YbZ2cxyKcw==
X-Gm-Gg: ASbGncupBwfT3gI8nFgEjouGeH3wR6OfhU/PAmZroWTZDreHEaIKis02PANVThrvTdY
	AyzMIzIShAZMCcDDZDQVzxNnoRpj0SemFp4+NrlhuOZiFOVWJeHiRxwTrqzNHyyGlYSywAXHkIA
	KipM44xDcK1KaPE7w07rtTbI8B+8wevD3vFUSld0Q5WNbBtKLyZ2cIQ71+tleJ38/qFFhk3Dqlj
	rfaew/SD07Ww4ng4tKzZbANv6utxaPSbIa4O3hALhKu82AdbyPrjA==
X-Google-Smtp-Source: AGHT+IGSK/XvZKOFB2ex4RHOYZmrSnGwNNSIjBIo7jknMLWkQqro0Oiu2YcbIKyXVIhkOWowiR133Q==
X-Received: by 2002:a05:6a21:33a7:b0:1e0:be48:177d with SMTP id adf61e73a8af0-1e0e0aada5fmr8200732637.3.1732792973006;
        Thu, 28 Nov 2024 03:22:53 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e87e:5233:193f:13e1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm4336945ad.52.2024.11.28.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:22:52 -0800 (PST)
Date: Thu, 28 Nov 2024 20:22:46 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Zhang Rui <rui.zhang@intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, thorsten.blum@toblux.com,
	yuntao.wang@linux.dev, tony.luck@intel.com, len.brown@intel.com,
	srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	rafael.j.wysocki@intel.com, x86@kernel.org,
	linux-pm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: bisected: [PATCH V4] x86/apic: Always explicitly disarm
 TSC-deadline timer
Message-ID: <20241128112246.GF10431@google.com>
References: <20241128111844.GE10431@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128111844.GE10431@google.com>

On (24/11/28 20:18), Sergey Senozhatsky wrote:
> > Disable the TSC Deadline timer in lapic_timer_shutdown() by writing to
> > MSR_IA32_TSC_DEADLINE when in TSC-deadline mode. Also avoid writing
> > to the initial-count register (APIC_TMICT) which is ignored in
> > TSC-deadline mode.

Upstream commit ffd95846c6ec6cf1f93da411ea10d504036cab42 (forgot
to mention)

