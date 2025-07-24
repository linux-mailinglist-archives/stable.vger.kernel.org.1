Return-Path: <stable+bounces-164633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDFDB10EDA
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9931C28525
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4E1285CA6;
	Thu, 24 Jul 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qR6U1qOT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDB21D584
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371499; cv=none; b=ZjM+xHog0sRdYUVFMY47UKgheHlC/w/kvW/qZQSbxExZkzQLcZjI8nGCtomfDMO/ZlUO4mN+6Gh1z6cckWWn+jwoQvEiVSqbwRYd5bUAhoQaJHzyp0iMPVRA7SXB4RRtacDu/jba48fAYyiwen+3AcRIyUvY0QkV9by22aZ6Hiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371499; c=relaxed/simple;
	bh=+sbtH6I99O4QocTimGWyGaL+mP7l7FRBFS9hzMu9MR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BnnLvLTwukFTgdcK0+rt6HvRTb4DBRg1KHRYuZ0hmPXSOl2h4RNNxPlOJPPKHeh1pIEFDKtbzXikCYPKPOc4fhgd2s06i4n029oTMpuuBBOl4P8eJshZ5L+X4KrhLwyicA/mbzUrn+AVE9MjLuGJwfUJ04QSMgWDKUwAEgdZMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qR6U1qOT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso17039155ad.3
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753371497; x=1753976297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGqEJrq3HhrDOawzm652eskhNI+musB9Ara41Evz0ks=;
        b=qR6U1qOTtkuRKSJ2auqI+toRi1ezov8VQRVg3IBA6Fh7DP4/Yor6yyQvuc1qCllQGp
         A/ZNx6m4KAvVarP/WgjaW+7MjORVjPKn9/xr3+1QWpN54uB9dql5B1v17KM5J1V9eez2
         E6xeE9NTG1xeB5Yx2dG5vlyOuAOLNDLMfNbyccBQqIom0XX0cCUnOFy2lPIRaPLSLbj3
         ua1CqZrVbDo/XIL2TZpmXeDj5nIrZgnsKS5GRopQ/whUbx3WpPxTVUfLy525hiYeqSx8
         SB/CqiXvAo/5EQHe13QeVkVtMtxg0zvEyPA6yw/eTijyrJKExvZftqoA9siMF/b+UOi3
         39lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371497; x=1753976297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGqEJrq3HhrDOawzm652eskhNI+musB9Ara41Evz0ks=;
        b=Qgb/Gd89P2/JqmhGG+6tAelpz18yedpM0Y3GYQHwQisn8S1prwJ2XV/fqE6mN5gfBR
         fmvOXH2lELHR8ulhd6O330XT44MrCQteBk/00Soy32NzJmrTKZRM3jcKp5DlE+iSnuWc
         xr/X8xPu0ChlneJ+sK2XC25e1tWc4jE+azLrOgvzUjBrnzAoSEz7Cg9/hIeYr2BhuqMt
         T9bwa6zZg9r9f37uObUKZuonk+1jhcLxzIRx9j2I3yLf8aPR0WK+qTw9DmuYQKLzDeIK
         QCUiAMPFAamhQBhRq5/VB4MnZHfRBs9dkPGVugEPmh2in5tmhy0G3jVDtZWlYK24ck9t
         a8hQ==
X-Gm-Message-State: AOJu0YyDBWAme/CkWrjk90dQ5p2VAQi1pl5ZxEOi7WwGhOcU6s6COs6R
	JG8NXRCBamdOIS3TKY0oeHDgpq4GgJMFfu9sWiPk3/xpcnuScJhMCiDXA5/7uD8QAwhR01QXjQS
	FOtwx6A==
X-Google-Smtp-Source: AGHT+IFrR3Uf5yw4DCNwo5ii6cKGdM0hGrEk1O3RzHdvJi8djZBxW1JGaPSba1hu6zP9Hkk/Y0dtm2IQCKc=
X-Received: from pjbnc3.prod.google.com ([2002:a17:90b:37c3:b0:312:1dae:6bf0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f693:b0:234:d7b2:2aab
 with SMTP id d9443c01a7336-23f9813e993mr83240655ad.14.1753371497342; Thu, 24
 Jul 2025 08:38:17 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:38:15 -0700
In-Reply-To: <20250723151416.1092631-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025071240-phoney-deniable-545a@gregkh> <20250723151416.1092631-1-sashal@kernel.org>
 <20250723151416.1092631-3-sashal@kernel.org>
Message-ID: <aIJTZ9j1v0k_GXMa@google.com>
Subject: Re: [PATCH 6.12.y 3/5] KVM: x86: Add X86EMUL_F_MSR and
 X86EMUL_F_DT_LOAD to aid canonical checks
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit c534b37b7584e2abc5d487b4e017f61a61959ca9 ]
> 
> Add emulation flags for MSR accesses and Descriptor Tables loads, and pass
> the new flags as appropriate to emul_is_noncanonical_address().  The flags
> will be used to perform the correct canonical check, as the type of access
> affects whether or not CR4.LA57 is consulted when determining the canonical
> bit.
> 
> No functional change is intended.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Link: https://lore.kernel.org/r/20240906221824.491834-3-mlevitsk@redhat.com
> [sean: split to separate patch, massage changelog]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

