Return-Path: <stable+bounces-204916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B6CF5862
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 21:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD9530A73FF
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 20:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74612338590;
	Mon,  5 Jan 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFEJ2WOH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8133B6F3
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 20:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767644844; cv=none; b=OWrv/jpGTRqWUFdAM43eFzkC2JspfWpOQIty8G4MlvHhNUo5pvwlZqAbKWr4dYd3SvSuuBU4YmGBFe0LHRGgfc4BAnAckukAJxa+01nanaAoL1Epk0ld/KNyaMEvP1LNHUMJHwCv8hbM44Z51kESQEeFpnyRQE4uaieSWrRz4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767644844; c=relaxed/simple;
	bh=99XgHkb9xtLNw0lvUzzxqljDogjyd2EWBM0m9Ga3hjY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DmdSiV2CGc4hAu8NLGVrJOtAUiaZ7e77runPMefDhcDTYnboxRL8G1cPQLglu7Qi0XwG/h2GVfsvXq6FjjRa49ELcwXS1ZhEN+Nfy/kg/rmeT74mCxjYwEer/EtUaBeYvlYZ8Uqna7bU+2yEcGHTAWesMEtYa2dKGjlLteSJDOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFEJ2WOH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c66cb671fso420027a91.3
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 12:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767644842; x=1768249642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=coCQXFsW4QzSYdsgP7Nno/5f4Luh9X7Ld9L25fMWKz4=;
        b=sFEJ2WOHt1QRfUNEyAn8aZxB4DuVtCZcQ18Kw5isRiJf7MpXOejqPMEvCDGW4qilKd
         3lTjyCvcyrSbG9+aleOfi51ofrS18LarBzhmbjvHb5H+GCtjgAzvTKgqhAAwvVmG0waG
         3uaFVdlfUa97Yul68cEDpVoMxQCICv7RJ3K0h5WGcS/xQDtsyfynhX/pa8mtP59U9hx6
         HTiznQGX3JC+/8uu8TWf/XQUL+mNgmFJhPShDEW045H9P17lsQGVrR5BSxOErY5+lFqh
         F2rQkV1fyCLDM6Xi3NG1HcR9KGzhs4rXTthPwlt5BtpsQLbHF2L/zrCwT5wPyICg5nim
         Ye9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767644842; x=1768249642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coCQXFsW4QzSYdsgP7Nno/5f4Luh9X7Ld9L25fMWKz4=;
        b=BdrXIJUW6UHdQ6zKhL6Cl8aef0HN4sb/GFlXeUQb71lEpdkvc8Ovs1UQvQo3yn6Q3h
         5TVOGRlTgRJUGqKZHHYj/aPGXIPfA7g+9vd5FoO/luIZIgNAnVzyi55NJd3u+YGPhy27
         7MZJoDs+hqJaF+6f2f0jtz+dAUNZvP/Rfq/MRYeWiqU2500Dk52GedYymFfBfhFqDrSL
         vk/aIfYi4IjEazNMGS19F59zqhYmrrScFdd30jOzGFraBXe5XfzGWly07W79PCj63wT+
         xuGIpyxk0eWtb8ep588rgaJUwQ5fgDZrAHUuxMKb21P94kPf5svZERSR9WMR8hk65567
         jHBg==
X-Gm-Message-State: AOJu0YxxXJv6zHC7k5ryDyV2nurUJftR8vASqPD+aaGuatvOZhyxpSjT
	hOJkhxgvfAo/5vdxIBNfAGWPRc9aQ25ZMS40a3KDdySlrlSJtF48GZxwL8yZqu4A2V2xFnwxvHt
	lKTZH2Q==
X-Google-Smtp-Source: AGHT+IEvHNM2W33zsnHwPhWUaQE/ktidO6r9B66TOhtWT/8EfLBNSFNyL4LyR2wpVwpjIkSdKQByCu7DmjU=
X-Received: from pjbhl15.prod.google.com ([2002:a17:90b:134f:b0:34c:2778:11c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c6:b0:340:4abf:391d
 with SMTP id 98e67ed59e1d1-34f5f2a9f44mr408942a91.16.1767644842025; Mon, 05
 Jan 2026 12:27:22 -0800 (PST)
Date: Mon, 5 Jan 2026 12:27:20 -0800
In-Reply-To: <20251231143917.3047237-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025122929-riveter-outreach-a5e9@gregkh> <20251231143917.3047237-1-sashal@kernel.org>
Message-ID: <aVweqPzM9j0xDcoe@google.com>
Subject: Re: [PATCH 5.15.y] KVM: SVM: Mark VMCB_NPT as dirty on nested VMRUN
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 31, 2025, Sasha Levin wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> [ Upstream commit 7c8b465a1c91f674655ea9cec5083744ec5f796a ]
> 
> Mark the VMCB_NPT bit as dirty in nested_vmcb02_prepare_save()
> on every nested VMRUN.
> 
> If L1 changes the PAT MSR between two VMRUN instructions on the same
> L1 vCPU, the g_pat field in the associated vmcb02 will change, and the
> VMCB_NPT clean bit should be cleared.
> 
> Fixes: 4bb170a5430b ("KVM: nSVM: do not mark all VMCB02 fields dirty on nested vmexit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Link: https://lore.kernel.org/r/20250922162935.621409-3-jmattson@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ adapted vmcb02 local variable to svm->vmcb direct access pattern ]

FWIW, I double checked that vmcb02 is indeed guaranteed to be the active vmcb.

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

