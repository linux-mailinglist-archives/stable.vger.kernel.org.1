Return-Path: <stable+bounces-164632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A97AB10ED9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CE67A789A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80F92E92BA;
	Thu, 24 Jul 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NaI2a3ty"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DB279917
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371488; cv=none; b=e9e0uGWKP64uX1HJQglj9ITO4K5zF53+cSY64ZzBIGg3SARzGv9GA7e3deDxnhbyv9oJDQIMPysyHQD2rQiP5F5TAy12ZJKQ942bothdAJG4spCM7aHbWtBttGQTvuMeIrm7wYYWKFCIzvjQxhLvaqKLHSctxusb4t4drWcG+zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371488; c=relaxed/simple;
	bh=+e6ldoiDSOzXtvXTdbQLZ0cpS51ZjEVyhtkw1hXJfsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gzfF2YPxZNBnEp2hoWXMUjqjAzgqpzA2FD9m82tAZOX9dlG/o+RENiipIjbjLuVRBHNBPPuv0QN4zwPYHXtDohIce99XL0Zenh/BC21Ucm4RK8S0TF+0ehJMtSaPszR7Qfl7ca9tNaFCmnjte+ITd2kdObGFdMpAXRhwNQc1ZC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NaI2a3ty; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b31df10dfadso810893a12.0
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753371486; x=1753976286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5+ozOZHqL0KF4z3NIeMdbR9IpF1+bwweLpvpogF61k=;
        b=NaI2a3tyfcudxe+dXrMfsK9X17SIu2k0eW7FkMOou4w3m8DXMiwc96fwiqyTIGHlMH
         J0zf0YRKc3ej5oKD9xxUci4HDALqWhY+u8midyNJ/Ethzn5ftZmlBqvXJi7+vpz3GFXh
         nvr2VR/8GEmdVMVPVUmf1XiVyVOo4ai9u2LIguZNoGjt6NJyiEP6nKquGgUQ+gXfCbce
         MRVjbSJRQ570FbB/iXrVBpa8KDkEIwn0ZpBgdhvsNwOP8uB0ghs54afvq7SSPfCMpcow
         IS7f5W1S8AG+sUIAtL+hAkZ5qwCY+32JfacO9gDGOaMQQOqRJv6RtZQpjzBl38MftJgQ
         o2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371486; x=1753976286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5+ozOZHqL0KF4z3NIeMdbR9IpF1+bwweLpvpogF61k=;
        b=dKzeXyuk7zo25V+69axOjO0H6IpRF9iZi8ZEENyLLGGDMNxtPrHuZjQm6gfWlXF2dD
         1mWBzPqPwLlJomFTKU1qyo0aVUbrHgfCT1ZILym2IJNC08SiJHt7ZDpT8kbMX2J+eKW2
         Ls/kGSz5oCGuU5hJ6iwbB3LiBa5RPo9jWo9dSAPldRaUWXwvApa3Zv/e1OzQvh1OPHPN
         PG0rBKfY1DnBbC6+FcAfO/sV4KztbTvFuxHKPQEK36ZV7HQtUvZ1ddNSK87K9sAocJqG
         9WPvNfdFNtN+7U5QiPzrFkRykFuMOwE/q93atXLOQGTHJZ/41k3aRLy6RneKtQa2Kcuc
         eTUg==
X-Gm-Message-State: AOJu0Yx2iJEMPf2z1/s554MN+W3tPVOcF8HNTUy3DjZkDrvirmYLY4oU
	+V9mQtQ2bEN30OBFaVAmAOLiLpV+lLoPkzRbXX3KEiPMYVV2nmiz+3S0l0YmPtDJ6NIbGxWe48k
	/NSn6Bw==
X-Google-Smtp-Source: AGHT+IH4o7HiPMpzSWwnIdWY6WbU6z6XauqiAb9Bua/JyUfJwCAEsvHkrX3pH07rWEQcmlf6GvkuaJ27UgE=
X-Received: from pjbsl3.prod.google.com ([2002:a17:90b:2e03:b0:312:1e70:e233])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d88:b0:23d:480d:1c8e
 with SMTP id adf61e73a8af0-23d490f610bmr12892904637.27.1753371486516; Thu, 24
 Jul 2025 08:38:06 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:38:05 -0700
In-Reply-To: <20250723151416.1092631-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025071240-phoney-deniable-545a@gregkh> <20250723151416.1092631-1-sashal@kernel.org>
 <20250723151416.1092631-2-sashal@kernel.org>
Message-ID: <aIJTXSsHKPELfChk@google.com>
Subject: Re: [PATCH 6.12.y 2/5] KVM: x86: Route non-canonical checks in
 emulator through emulate_ops
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 16ccadefa295af434ca296e566f078223ecd79ca ]
> 
> Add emulate_ops.is_canonical_addr() to perform (non-)canonical checks in
> the emulator, which will allow extending is_noncanonical_address() to
> support different flavors of canonical checks, e.g. for descriptor table
> bases vs. MSRs, without needing duplicate logic in the emulator.
> 
> No functional change is intended.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Link: https://lore.kernel.org/r/20240906221824.491834-3-mlevitsk@redhat.com
> [sean: separate from additional of flags, massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

