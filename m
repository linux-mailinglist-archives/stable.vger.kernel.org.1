Return-Path: <stable+bounces-169589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3B2B26BE7
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F8B3A9243
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7170F24634F;
	Thu, 14 Aug 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMt4earN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6021C9ED
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187356; cv=none; b=TYeBQ7Nf0huhb+WnEdDh9kfkf1EorLKB0ZkovKA2Fs3mN8iKTTLolenminf3I/7Wh12n0d+LUR3WO+t8P0JE+f3X+ZPEafJnTwjW86L5oGUOzHFVbTdXlAHKEw/3G3JCgjGHUQMm+NhEgdBcXaAvrR8Zv7BZxuzhp2axCGzucbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187356; c=relaxed/simple;
	bh=3EGUy3cBFQtjMO6ogn7JKTPOXGpFTkTo6KuqAQPDZAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O3wyEnSa4tMEYfuxFFeaFVQitIzgj8UqSJTPzXX4dCVDH3eqzKS/aPjo7QprQhDrB/T6T1svGArw9KPCMwcy7jO6bb1dwvChmDfstWad88bJqBcQ1Bqrvmn9p+8AgEbdJVeVPVLgkKAG1GVQuJc0MF9ZNHg4OvnNYFCgfUF3dbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AMt4earN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445812598bso24658835ad.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755187354; x=1755792154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LSXMc0KWh8xhPWqjxfJp37hjLBCTiWSMOR8adg/bjy4=;
        b=AMt4earNHy3pxwVFB0XtxKfxOHbKmJQ/0XgxsVh08ErZC0GrOIInOpUi/lLyv7+MTH
         mBPM3NVPkuPahPVAid7Eb6urfXn6BXoZzpyI8lIBoUFnDMly/WNvfSq39qm0DDQ61dBY
         PjqOr1iiPoE1IwI6ikOQ9aMo2t5d/BA5doND/GP7dSO2AE0V/0jyqj3BnJDJ7fyPFsp9
         boG+mzWH/uAuR2ujPGSCC7eKbiEWiyS7SfbXUlalVTDbuq1wbmIxjQ2qWw/2/hwLnWqZ
         m3MGmB3WCKccCBleKd8EYwSvhHVfK2dAe5KiWaFp2x6bYNM/BlsltRed5ZFqLYty13gr
         yUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187354; x=1755792154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSXMc0KWh8xhPWqjxfJp37hjLBCTiWSMOR8adg/bjy4=;
        b=CbDDJYs1tG9A09UMLarVbdicF4uO0Hz7Sk8AD7TP5b8+tJPojF9zAbVH0KbQmsxlZK
         IbRcHFY1rg3aPS3U2JD5oLAdWIR9fbecbLqmK3QITRKI3V2yxaJtpZItwwoACEwe57op
         fD1oP42ia+iZWmNAtCUAmh87Q4RDmiW5G4aZ4eT5dRX8yA6LGtdE93GdQ5L2ZmGuTMFb
         YGnMR9OONqxco1CY/IHUh8UUG2Zx6Tfrt1/AyQ13w/0oevmlgGG/G60PAiCx7IlD7Kqt
         sr2WduxtqEObAcBnHLSHZF/0AFptzcnMGbmn63kEBSA8NSJkrD8hP08ErErD9ucbPDkG
         IOVw==
X-Gm-Message-State: AOJu0YwtXP+eXjnllMjJSB2jz6146ErJmcsvKb18YTplk4TORDTFwI2L
	41rzp+m4P4UbWsLOieZqQk+rmj2nS9zLUaXIs1oiYykisCHqIfi9xAcBBgIOO6pa7OXIPSXa6an
	Q1t/lsQ==
X-Google-Smtp-Source: AGHT+IFUQSfE3psnf3hHJOlnKQ2yy/kjH7bva/8FGLvh44Z8nL/bhL1Ik+OSGKU8jkN9tg1y7oq3x2Day9E=
X-Received: from pjbli10.prod.google.com ([2002:a17:90b:48ca:b0:321:cc91:ad5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f05:b0:240:bf59:26ae
 with SMTP id d9443c01a7336-2445868ee6dmr62278115ad.36.1755187354176; Thu, 14
 Aug 2025 09:02:34 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:02:32 -0700
In-Reply-To: <20250813162151.2060137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081228-outthink-finisher-2a2a@gregkh> <20250813162151.2060137-1-sashal@kernel.org>
Message-ID: <aJ4ImLVUPzN6hgZ4@google.com>
Subject: Re: [PATCH 6.15.y] KVM: x86: Convert vcpu_run()'s immediate exit
 param into a generic bitmap
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 13, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 2478b1b220c49d25cb1c3f061ec4f9b351d9a131 ]
> 
> Convert kvm_x86_ops.vcpu_run()'s "force_immediate_exit" boolean parameter
> into an a generic bitmap so that similar "take action" information can be
> passed to vendor code without creating a pile of boolean parameters.
> 
> This will allow dropping kvm_x86_ops.set_dr6() in favor of a new flag, and
> will also allow for adding similar functionality for re-loading debugctl
> in the active VMCS.
> 
> Opportunistically massage the TDX WARN and comment to prepare for adding
> more run_flags, all of which are expected to be mutually exclusive with
> TDX, i.e. should be WARNed on.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250610232010.162191-3-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ Removed TDX-specific changes ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

