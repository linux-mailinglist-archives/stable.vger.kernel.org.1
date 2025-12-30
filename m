Return-Path: <stable+bounces-204172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08171CE88B8
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D29E630024B1
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851D2DF6E9;
	Tue, 30 Dec 2025 02:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7g9MZru"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCCA2D8382
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767061486; cv=none; b=FFBkbOeZB3UAWifd56K5RpF0oNdk9gWP6L9wRIm1nZiCXkMxqXYJTMCmqN++oJhLtlNdJdF7LUm0da/GYLKwPAjuRYWvxJ1Q88DnPIRp64PpijFJxRRtP9v9S5/e5kFrMci+xI50cuLNP0q7qjEP3VKzbflVs/dizn58X/KD0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767061486; c=relaxed/simple;
	bh=Y2d/CkXgDCUfq+HeES3Gz0BuPuu6qm4OAyv3mnAt3M4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fPZSbbVeuEzv8GiiO0szxyxXIY/xVdpZdRFb6qTKLguqkOG7awOtK6T4qoRPHJp9ezF7zZOkY50n9UQ3+IrpU9W9csg3LFBdteODhxXo+pgUfpuNXRh6k34+6NkeSUVadQchw4fCPB9U+f4MAKZpWwGrjEHBPGiWCszdbSvh0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7g9MZru; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b0588c6719so9129826eec.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 18:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767061484; x=1767666284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBG9qGfwdN2gzPyM4vrD083y3HoBOEnU7+ZJVK/meSs=;
        b=R7g9MZruu9+yIRrVlCa3zGQ8jfyRtdKNHjUcIPiAWaU3eFQeBE5z8Hy9zsfwUkqbgO
         XhvlrJ4FP7IQdBy+go4G1bT4yghZ5HMbHVYJfsESDjKyN3Hw9W5Jcy0Lgf2jj6yWViUn
         wJatIRUxsBoDccHu+qiBrw0nNQ36hEfKytlyfWt0wR+IWWvtTNTQwD2YSL4iHkeSFArm
         ce4tGjpUrEOZcOsLx1sI/zkdLuH5+6if8Ar1DNif6Ey0qBxoCANjXZl3aiQ2MGm4qdUC
         9A6bioeSy8Sucn69sUaBWm71511hLaJEq9rXefBxtNlofK46/qghjwZ7ezEx2ZE1CcVq
         RtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767061484; x=1767666284;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBG9qGfwdN2gzPyM4vrD083y3HoBOEnU7+ZJVK/meSs=;
        b=CJlQfXbocZVZ14Nx99XuJLdAMQJSBSz1JYbwm5QWfmbdm30wUAO23DBLWzEAY7Yqjx
         VGeKFfgDSpfP9RaSXVQi55+dILTtMxSLUxExwN0b9e0TTPX2eZb3W004m2JODIXbgWT5
         wsBEUsVp2DGDd6lr4uOo8nFCNEIQc20x8gfhh+gTM1jbmoD1yF855OoQ/vrn0dpGhbTw
         qfhR269JRC/XWimHJ8n7rmMzqwRunC3eZXp8c2J7wqWkIQ3uP5W04ppl4CjWrAllKkQz
         Dn+H75pO9fEPkh6ZZgCN6krmXa/cWwqhE93fGezPmeHBDKpZigCxKB10O6xM0NDpJdgK
         IEew==
X-Forwarded-Encrypted: i=1; AJvYcCVzO2W/JJmb380SuNc3N5/FRgN6yg+fDlif6PpsCtj+h77cyN/yxJhheAuhDSxpCkQ0fTOIOlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ1PUphVkLtjMnErHm/4iCjAb2kTV1NfvZNYvzjYrSx/8S96cN
	eAKbqdthg2SCjveMIh8TrmoWugqChNIG3//qZMpZHiSy35KIkWoPLANkqFWkJ+rXXPydQoaWjGm
	JOC/faSz5fQ==
X-Google-Smtp-Source: AGHT+IGuKbBb2lRfg0zkm1s3qWA/FlYtdLZvNL3qHYsniInakt/sV+rfHnyjB/VJVAG4XIo5VyzVxdsJDy6k
X-Received: from dybgp28.prod.google.com ([2002:a05:7301:211c:b0:2b0:5541:d643])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80cc:b0:2ab:ca55:b75b
 with SMTP id 5a478bee46e88-2b05e6beb4emr39241858eec.20.1767061483570; Mon, 29
 Dec 2025 18:24:43 -0800 (PST)
Date: Mon, 29 Dec 2025 18:24:41 -0800
In-Reply-To: <20251204-b4-stable-disable-uninit-ptr-warn-5-15-v1-1-41212e2c6409@google.com>
 (Justin Stitt's message of "Thu, 04 Dec 2025 12:44:48 -0800")
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204-b4-stable-disable-uninit-ptr-warn-5-15-v1-1-41212e2c6409@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx8cy3wso46.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH 5.15.y RESEND] KVM: arm64: sys_regs: disable
 -Wuninitialized-const-pointer warning
From: Tiffany Yang <ynaffit@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Christopher Covington <cov@codeaurora.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Justin Stitt <justinstitt@google.com> writes:

> A new warning in Clang 22 [1] complains that @clidr passed to
> get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> doesn't really care since it casts away the const-ness anyways -- it is
> a false positive.

> |  ../arch/arm64/kvm/sys_regs.c:2838:23: warning: variable 'clidr' is  
> uninitialized when passed as a const pointer argument here  
> [-Wuninitialized-const-pointer]
> |   2838 |         get_clidr_el1(NULL, &clidr); /* Ugly... */
> |        |                              ^~~~~

> This patch isn't needed for anything past 6.1 as this code section was
> reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache
> configuration"). Since there is no upstream equivalent, this patch just
> needs to be applied to 5.15.


This error has also been showing up in 5.10 since KernelCI started using
clang-21.

> Disable this warning for sys_regs.o with an iron fist as it doesn't make
> sense to waste maintainer's time or potentially break builds by
> backporting large changelists from 6.2+.

> Cc: stable@vger.kernel.org
> Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
> Link:  
> https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e  
> [1]
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
<snip>

Reviewed-by: Tiffany Yang <ynaffit@google.com>

-- 
Tiffany Y. Yang

