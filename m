Return-Path: <stable+bounces-169622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB5B27028
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FC4E390C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDE25949A;
	Thu, 14 Aug 2025 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsvWxrhc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD82259C98
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203147; cv=none; b=ER8fEWWyou5ZDzUaRmFG1t+pdduEGnFy/ircRh5gw7qHjfBcDvpdBnPgybEVpfpP5mcG8Sc1sIVWYG0h1TTf+uG+POddPlm8tD5nJlJRxZiqs2KkYXVZiM9pcPvHt00x1QKYTWXBM0tNmZl+D2tnt5g5BwAVDIhrR2hRUGShlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203147; c=relaxed/simple;
	bh=1x3wlLSBkl3Nm4IPnmC1K+ECm/V2t6q369q79jnV6Is=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XPW2m98RFPPQymff+yVjnfEstIJgeoyn0v5imWRLHfgRLtgt5U3LPQ+k1umerhI+ES7k494uglCUhJBCQ8Of8cKF9wfaIvmal3fK+iFnyFbm0mf2wda76DfxG00jbnYrPO1ATAekyNb3MxfNb6RWFi3pNxrQ9WDnjc6e4jzCKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsvWxrhc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266a1e87so1368105a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203145; x=1755807945; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrW19kH4borHEig8Orw5IwDu1jMWW/rjwhDsw81/SG8=;
        b=ZsvWxrhcDN5txSa4IWz5Z7zpEmOqLvyxdXWd7l23ewrJqpmiSlDQWNMIlrs6uSinYa
         3nEgXD3vlwsayamRDbqjz7T1eIOZo5PFWw33N8+Wy/c6LkmTGMyaOyJJoWTGbzhbYBSk
         fxsluVec1x4ECxPwC03iPe0x2kghGrvMXOXDiVSUOsyLJCbC/S96RRTicqvNxd6l5ox/
         3emrkKMtyCGnrjrOYgd5zjemWa6pMJVWlDMtsH+HkTHPdjEyJo3Fusz8f2nWNh9RExky
         TEL7AAs9R6E0/UJXcI8wovkqVZYXvchj5IjerhexV3njQ3MzQmgVY2bsS0psKfBUmbuZ
         B47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203145; x=1755807945;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrW19kH4borHEig8Orw5IwDu1jMWW/rjwhDsw81/SG8=;
        b=Tn9eqsAwoKZ3fvrnjSvnClpa2eyytsbIlYwPisKrkH6vI2lvM81ofu89uUngcLzzRk
         IpkE++iCyANdhn9wpYCTMCFCC03R/ezPbnpwbGxROYwaFQCncwd3Syo0nWqi188B1eHQ
         yoq1VwPF1bJ7bzG7OKKwIGVx8aM/pcurPK/NibdIAchvvlaKQsjD/MS3DTa/hKsuu6b8
         uXAE3EPzYOElV1/fAvynDTfrHcv5+ECZlzGujJGUmZ1wcfjmUVY166Xy7YGlxqm0Uxi/
         rmpm5Cf7cSvJHTaWXvm0BQTVWzJt5SQp5bHPzpCozAknA1lCeAL7JFNCM2C/2PVnwl3Q
         FtnQ==
X-Gm-Message-State: AOJu0Yxc8h4DZNXWERPsOCLteNpnyS+lOX33DAbt936r89PbUdfpm74S
	NaqXOeI01Zgb8Gy0l+HyRqd8LBHjJ9IzDERyYyEZ5hUdiumrqwxCD+K9vB7OV14b52U8ykukt81
	HynCaIw==
X-Google-Smtp-Source: AGHT+IEAvVf2+mVKL0tPHsqMx/A7rogS4hHZVHpbKiyetrgRiS6v2D2pbAn/dcTI6w5wupn2ObztMWrewok=
X-Received: from pjbos14.prod.google.com ([2002:a17:90b:1cce:b0:31f:3227:1724])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc7:b0:312:1ae9:1525
 with SMTP id 98e67ed59e1d1-32327ab39aemr6963687a91.8.1755203144868; Thu, 14
 Aug 2025 13:25:44 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:25:43 -0700
In-Reply-To: <20250724170725.1404455-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062034-chastise-wrecking-9a12@gregkh> <20250724170725.1404455-1-sashal@kernel.org>
 <20250724170725.1404455-3-sashal@kernel.org>
Message-ID: <aJ5GR_BBiv6GGxCa@google.com>
Subject: Re: [PATCH 6.1.y 3/3] KVM: VMX: Flush shadow VMCS on emergency reboot
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 24, 2025, Sasha Levin wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> [ Upstream commit a0ee1d5faff135e28810f29e0f06328c66f89852 ]
> 
> Ensure the shadow VMCS cache is evicted during an emergency reboot to
> prevent potential memory corruption if the cache is evicted after reboot.
> 
> This issue was identified through code inspection, as __loaded_vmcs_clear()
> flushes both the normal VMCS and the shadow VMCS.
> 
> Avoid checking the "launched" state during an emergency reboot, unlike the
> behavior in __loaded_vmcs_clear(). This is important because reboot NMIs
> can interfere with operations like copy_shadow_to_vmcs12(), where shadow
> VMCSes are loaded directly using VMPTRLD. In such cases, if NMIs occur
> right after the VMCS load, the shadow VMCSes will be active but the
> "launched" state may not be set.
> 
> Fixes: 16f5b9034b69 ("KVM: nVMX: Copy processor-specific shadow-vmcs to VMCS12")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Link: https://lore.kernel.org/r/20250324140849.2099723-1-chao.gao@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

