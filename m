Return-Path: <stable+bounces-200367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC92CAE05A
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 19:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0C33081D5D
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4372512F5;
	Mon,  8 Dec 2025 18:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpfwFjOy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5161E51E0
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219603; cv=none; b=XAWtH0seR9GeekFfvIKi/k9ZzLkRZvzRHRkHobTWbPtwCB2o2v2yokr7udtZEJ/qP/dgpH8dEuf5FXtkMWQ41aixl7KXny2tz00jbJ+Tgz9xN2AkJGbHRQ8XJdkZgAf3ZbGw40uj3LQIHBZu0BDlBTLB5SO9ujuJcRDpWU55hnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219603; c=relaxed/simple;
	bh=PcknLJX/V39QFPKgk1w1Yobt8lM7qGhoRyg9G+Gaf0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6je62QSccmox272nuj4TEWBGCReFEldgFFuxWE1oDLJK52wnLthObk9myz5Nfy0Asxcii8lOBdVEbvhexavSI1ONZUws0cVHF3TSpsG3ke/6Uvge3H/IHHehh47n+KS1G6LOWBzc9CDCbSeA190F/xjPdwr6SCJiRfwoy7VTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XpfwFjOy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34740cc80d5so9364464a91.0
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 10:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765219601; x=1765824401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5dToeUlRsf+OpQ8zJnhFsWGwKC9CjXgbTdhT0bIRE4=;
        b=XpfwFjOyYPd0KlHbzgohodBgsHFvPZbzU41BZ7bA9vq4eP458IM3+9qKTU1TaHIUWD
         wvBRm6YLqZvjaXua/Hy6+yH3z7ZbAjx/6TzNBJRrXXaeSvx8gppEKzxnP7dFOoDTwNIN
         yCjD6rRwhlKxkJFV0lWi1HR+KLmaWarfzUAhTc9NNP57TNlgmz5mQtElYCvdcBbfGm9r
         7STcsOeA6LdngA5EnHYsFHGw+v5SPRCtYzjNrM1rcrNh4i4iOyqabR+WEHwpDp/uBO9V
         K3Wk5fx6CuYH11O9AFzahyR8FjrTInL1sXFNorx7IWgxAYQfU/o2z4iecGOPSiDVoZsq
         5DgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765219601; x=1765824401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5dToeUlRsf+OpQ8zJnhFsWGwKC9CjXgbTdhT0bIRE4=;
        b=fLBd6yO8uuAkyKkv/9Ng/BWYa0vaUVcqPAot/bjgKtW+XMbt7p70ph2A6kqMGfBxen
         QI2/sD2Ow0ZSAqSdnx2fDOq898bOnBnhimZrKR8/Hh1cM7YC07yuqn6A07nD7y/7QGPK
         TEkK3WzDOY+guS/JZoyXPbUtVATKlF6XcCK7N+wTULmLy7FBN7y+6tPtxeyOzcICqsZF
         DlhVBMNFua7RCehS7rePRBm0Z/ogh+9jRfMhURBELmcKziOzP/TwmlMA9MVGEXsfwodX
         01/dptgDhGIk5k60PnSwKBW5qIx51iPvtFHkegZYlwZWtphzvSB0Y8foa3IwR+JoXyLp
         vNqA==
X-Gm-Message-State: AOJu0YzRhK8WfYrvwR4NmrzGc70ZVA8DzN4aJrkGan4hILy6XgxEDr2P
	QmBagbp0CYPmx/zW+lQgBCClsiCau5rTkG/Ry+1yZ8TGf2U0ghdgnHAKX2HMSC0tcKYSmInzOW9
	KAdsndQ==
X-Google-Smtp-Source: AGHT+IG7uz3iQ4UoeoBnIg6I60H5HtLfTkwVJjXiITlvbLFzLGs+C/RINmSfPtvrIggXApIfRV6hcZrdfcQ=
X-Received: from pjboa5.prod.google.com ([2002:a17:90b:1bc5:b0:33b:51fe:1a83])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a02:b0:343:e2ba:e8be
 with SMTP id 98e67ed59e1d1-349a250ef5amr7591184a91.10.1765219601596; Mon, 08
 Dec 2025 10:46:41 -0800 (PST)
Date: Mon, 8 Dec 2025 10:46:40 -0800
In-Reply-To: <20251208061727.249698-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025120802-remedy-glimmer-fc9d@gregkh> <20251208061727.249698-1-sashal@kernel.org>
Message-ID: <aTcdEG0tHMSRbxAE@google.com>
Subject: Re: [PATCH 6.1.y 1/2] KVM: x86/mmu: Use EMULTYPE flag to track write
 #PFs to shadow pages
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 08, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 258d985f6eb360c9c7aacd025d0dbc080a59423f ]
> 
> Use a new EMULTYPE flag, EMULTYPE_WRITE_PF_TO_SP, to track page faults
> on self-changing writes to shadowed page tables instead of propagating
> that information to the emulator via a semi-persistent vCPU flag.  Using
> a flag in "struct kvm_vcpu_arch" is confusing, especially as implemented,
> as it's not at all obvious that clearing the flag only when emulation
> actually occurs is correct.
> 
> E.g. if KVM sets the flag and then retries the fault without ever getting
> to the emulator, the flag will be left set for future calls into the
> emulator.  But because the flag is consumed if and only if both
> EMULTYPE_PF and EMULTYPE_ALLOW_RETRY_PF are set, and because
> EMULTYPE_ALLOW_RETRY_PF is deliberately not set for direct MMUs, emulated
> MMIO, or while L2 is active, KVM avoids false positives on a stale flag
> since FNAME(page_fault) is guaranteed to be run and refresh the flag
> before it's ultimately consumed by the tail end of reexecute_instruction().
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20230202182817.407394-2-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: 4da3768e1820 ("KVM: SVM: Don't skip unrelated instruction if INT3/INTO is replaced")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

