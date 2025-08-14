Return-Path: <stable+bounces-169625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0883DB2702D
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF95A5E6DD6
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866B258CF7;
	Thu, 14 Aug 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AzAsS6St"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D6B1FF60A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203377; cv=none; b=gxIH6F2ii2Ij9HWUvziaIG6wzD9n3WWd1viqwkYfuROOrF5mqYiBODAlMVXkWbO2ZW+k0rKEeNfMo/lvoWIu+1O0ojd/JE9OxMyqNtmTnPpxhi6kMjTWWZyiv43lBhKOxv0kP+YtJkZIiXy5o35m3me0PVhFzL4z7M8Tpc4Vqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203377; c=relaxed/simple;
	bh=qm4sJIAbvHbaMYpcH+1Lp87YAMKK3OmEhn43nB5qoAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dTxb+7dXdnzzEa9PUGzlrrO0BZNbTvw8PeSgliyAkK5Mpn+q64ExIBr1toc1roQzI7okDCj+8h/+5afP8d1JPTpFs/SeFMX/hDuT4p7EvPEVvSYrQf7jGS8Jh5447CjET47kblX0btMRU7rdroOTdBboFoEnWFFzfJQj0V5j5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AzAsS6St; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581953b8so15112965ad.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203375; x=1755808175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=AzAsS6Stkf5gVX4OnMdejFfpEVwhHzsraqiFrcALAqEw1kLlM/AIMLXC1FZYMAPruD
         LN0135vMNVxiydke8TbWgE21IeUzBhhbU41w46iB+SyDEH5USksHIcmtVU/xCcVQBF79
         WZp83gwvhlfMNscPAIgQ7Sh7k5nd00a3oDcxgem2+mKvS2VXxpWy0kufIS35MiLWPLhD
         9W+fWBcztjPQONoMrrYTD2Uj1Ls2rSN0u6HNDxDQhKlHuf9Js5fuDRGqk1xpi6IIhQRk
         P3ZaNlsL4C8NYRYXhvtdCce9Ou9kNN4x+OtSb6ZbOVDyrx4c06kqtVKEB9eTv8E/l+bk
         8LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203375; x=1755808175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ib1aMJQeVnxOBq2+znYic6DVJjnFLkElsxAP6tuqDCk=;
        b=H/e46OVTy3byBaJDEz9fvve2BEVA7PXpiWJetT9Y2bceqmRjCX9GWcQO/NCcSzLfUu
         9gtyFPhj30DYDyUb/AyrT8D9OgSzJB/YTvSlxKrKjPOAIg/+UVORnyJW36m5m2T58Zu4
         QAfUrJxybn+qz4F6XROO/B/O07hnatJ3JLiwjcATBklp4z9ptnzc3iImOO1LhRId7ocp
         INPpnSZJfJy8i+0k75VW4AbaomAQx2I8ODJs+51HhcrJnVRLRXXY5c07R5M2fgbdQx03
         6JeXcySEWmdB9JUJmL2aqrmihhFL1ymwd70UWWWZoZprpqdKrCMluRDDp7xJSc9BqlD2
         d83A==
X-Gm-Message-State: AOJu0Yyx9Pd/J5Z9agHdqDhHW9RyyPXxTpuMm7K222xIy9LaIkpSxSdo
	6fNVWWWsTWTqUOxwAEtsmFVuN4r+laf7tDu9j/IrgfJ7IbNxkpTFBnBHw+pOQrSmytZAl0MXBg4
	8PdEj7w==
X-Google-Smtp-Source: AGHT+IGHqehXJDMbboyeYfCqL4laukVIXwJYUwQOYaM5n3dMxVCgpI//bSlzHVtZXb6s85Z0ccXVhczSC8Y=
X-Received: from pjd4.prod.google.com ([2002:a17:90b:54c4:b0:311:c197:70a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b8d:b0:240:3b9e:dd4c
 with SMTP id d9443c01a7336-2445868b515mr62091045ad.36.1755203375175; Thu, 14
 Aug 2025 13:29:35 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:29:33 -0700
In-Reply-To: <20250814132434.2096873-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081215-variable-implicit-aa4c@gregkh> <20250814132434.2096873-1-sashal@kernel.org>
 <20250814132434.2096873-2-sashal@kernel.org>
Message-ID: <aJ5HLXUufn3JLh96@google.com>
Subject: Re: [PATCH 6.1.y 2/4] KVM: VMX: Extract checking of guest's DEBUGCTL
 into helper
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]
> 
> Move VMX's logic to check DEBUGCTL values into a standalone helper so that
> the code can be used by nested VM-Enter to apply the same logic to the
> value being loaded from vmcs12.
> 
> KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
> VM-Enter, as hardware may support features that KVM does not, i.e. relying
> on hardware to detect invalid guest state will result in false negatives.
> Unfortunately, that means applying KVM's funky suppression of BTF and LBR
> to vmcs12 so as not to break existing guests.
> 
> No functional change intended.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

