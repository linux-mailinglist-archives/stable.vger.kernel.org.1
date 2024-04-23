Return-Path: <stable+bounces-40716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381A18AE90F
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB071F22BAE
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A6137752;
	Tue, 23 Apr 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0yEoq0A"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534280040
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881157; cv=none; b=nhbLmBpQXpjJZ+eoXNqZLwWV2x9z/68Z0YREmeN/UHpTYQMG2qAZkrLdRHZg6oQxLXn5QfboSsa44iqbrGZ+3ddLG2RpEP98ZHIaR9kacelNWyyVnsJmGYM4+mauc8nj4lPH4pj7Y9zaTz4hl3w2J4VAASmevle19TE/sN+5Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881157; c=relaxed/simple;
	bh=d9Bm1WhOQdr4Rta0AMWh7LzeJO0HpgVpWy/bbXjQwQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ABwv3IHxOnOkDOVPQ3xKcJ5c4kbicWmNlyf2BLkdWbLPdUTw/lIrPTra0dAy6hLZuufoSr6Ovw7NhpWtms6jWVp80LABXjmB5H1v4vpAbdhXCi/VcgmQ2ULtdobH1x0cbMrs3yFAQJ60RbedTz14EKZguAtXhNOLkohWbX0EpiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0yEoq0A; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so11453009276.2
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713881155; x=1714485955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywoHegdckyc2kc9q8KKYzLqn2Hlpw+/QiT0Zcc0zz+U=;
        b=H0yEoq0APPu5Eur7TnOK5jLzVJUGbT9DO8Dg5wsSPbLsid38hWhCvoWq3MUomjQQoT
         OVHlY/0VfFgwtXRfRG2pdWTeFoYBr5u558iiFqzqa3Zcj+VD64+6CaaOnIgmgtn1gN7J
         JuJT4qVJSjQ0aaUXhUMFYaDJvwvBLwDS0vQZLz8XgNF0O+flLKHYGrcjjRpMshUpa9UO
         7g8IzGMXjh+11UlNkHaNnTxzvPXJtX13xeFuyNB4QIEyQ231FZ2o42m2p4ZNk3VGMUud
         pq0Fp0PqcLBIxDRYc/Zk5Pr0U9M6ph0vG4t8K2ozXCFarnihlrBW9j2DwdS8xveEy+++
         G8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881155; x=1714485955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywoHegdckyc2kc9q8KKYzLqn2Hlpw+/QiT0Zcc0zz+U=;
        b=Uu+MJ+Xh/PeTD/dQbCAUByyzoPqa0hi70LFOd/XCNKgOYXrEsqJNIMYPaTJJAHyQpR
         QzzbhSd+o8FhQNfNSxoZuiaoo+ZOJzwtvsCz7uRfsV7aPwP+eG3GEWJWFA2xPImUB2/a
         Kg0/VqcVwglrbRxkyx4PaTKmPamoJEKN10h01++QkQL+eFD/81E8SXCW+idwTuTTcqB+
         ZeZtiKvlWyb4XcsULAjFFCMZ0V9qO0zPfMbK9PDjuRqdPH59wnXFkXEAWEGs+maG9Vpt
         nGGyxVUH7wdKiD0MIr2yYUvIudMRYOuNjciNezhGBS6ntffps0Atg4KIro37br42AFhS
         RQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHpe7QdstfmrZ5IpXPwrV3/u2OrALBP2FYUcCZk4Zv9LCRfeSWRR/6lUdrvXTOFm+BK3rRBUbSstqpIEsKtqVNy7uoj+4a
X-Gm-Message-State: AOJu0YyuQngLVQB1A51gUU2OifYyhCadTOeRci8ZOpwoCBv7TFRe+uma
	BJXuErSy/fmBdH3jdlE9P3TmfQCY03yUNoQlBMxKBaCM1jRc9/Z8E5ODVDGblrZ0ymC2GGwc9o5
	TAA==
X-Google-Smtp-Source: AGHT+IHbDuY06ri7HefBWokNt0j4rfiXvA7toVdltviloE4D4hhhUr8Fo45UnsV6yWKsY6PE8yzd9/+srAk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c03:b0:de5:2b18:3b74 with SMTP id
 fs3-20020a0569020c0300b00de52b183b74mr1794704ybb.2.1713881155316; Tue, 23 Apr
 2024 07:05:55 -0700 (PDT)
Date: Tue, 23 Apr 2024 07:05:53 -0700
In-Reply-To: <20240423045548.1324969-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423045548.1324969-1-song@kernel.org>
Message-ID: <ZifAQY9yS4U3oEkT@google.com>
Subject: Re: [PATCH] arch/Kconfig: Move SPECULATION_MITIGATIONS to arch/Kconfig
From: Sean Christopherson <seanjc@google.com>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 22, 2024, Song Liu wrote:
> SPECULATION_MITIGATIONS is currently defined only for x86. As a result,
> IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) is always false for other
> archs. f337a6a21e2f effectively set "mitigations=off" by default on
> non-x86 archs, which is not desired behavior. Jakub observed this
> change when running bpf selftests on s390 and arm64.
> 
> Fix this by moving SPECULATION_MITIGATIONS to arch/Kconfig so that it is
> available in all archs and thus can be used safely in kernel/cpu.c

Yeah, it's a known issue that we've been slow to fix because we've haven't come
to an agreement on exactly what the Kconfig should look like[1], though there's
general consensus to add CPU_MITIGATIONS in common code[2][3].

I'll poke Josh's thread and make sure a fix gets into rc6.

[1] https://lore.kernel.org/all/20240417001507.2264512-2-seanjc@google.com
[2] https://lore.kernel.org/all/20240420000556.2645001-2-seanjc@google.com
[3] https://lore.kernel.org/all/9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org

