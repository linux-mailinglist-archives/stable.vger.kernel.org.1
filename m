Return-Path: <stable+bounces-114743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C3A2FE68
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 00:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F41E1886EC0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD07E260A56;
	Mon, 10 Feb 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi+qNGxN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1425825A35F
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739230061; cv=none; b=SlrkpxtB4iFsPriXROBMF58iCVAFfqefoRkOhpaTBlLTLK5iRIXw8GbaT9MLcFIZNXx9l/5sPvnXw6JzxbMuWc6D2+33MYjJwZPvWBRDJPEaj6OfYSAf39nP82hklUTQVR7mYFlK34QPybpJiH0Nclz/aPs8jefUQOfNmgIjxCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739230061; c=relaxed/simple;
	bh=xMnwxhxjo4ByS2VFuen0Qr1Iek5j56cu/Qh0J9HJKZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FNRLVkIpH052i6IOQarR3+vYf5aqcJf4sT+sBYBHK02Vm57GoSMezTfkoXknJSidKY/lqMKuQMQ/DaeVLww9wD9HsVN0u2DUB3XNBAqimd/wLqC65ekC5AvHM7KxV7w5B4jH34qPusFza7f5IVXYasbXdLRP//g4fsTlRKQmqiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gi+qNGxN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so10615877a91.3
        for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739230059; x=1739834859; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SDwpYY4jYjxltbjhc/od4X7/kPT8qKA5UGsZNXQcdGU=;
        b=gi+qNGxNe8FUWN8PSW75VU9MbhJFls45irPZfqWeucmW/j8usqXZkiE3yqDu300vek
         9ity+FMH9WEkm8EflQSgb9rl1FLo+VTvmZYtKgkGIvMGsKsjRcaw69K0EpROThAg5Li4
         3w20+/Egs7RYOiE/XTJLhGvlZDcWyslhJYiMlJUOxV6xwdffeupAjckQlNZzzI/qIoHS
         5z8ernMZGU/L9dg/e/rV3JmcW25n4BWNEBMpsAEG2HbJmHow5rA6EKRYlZpt81jjh/Co
         3hRO88NlIsChmLuyYLiOZJqiVK8tbi2+Bv2Hw7durFTopLJg78rxsm8Y755fyKrLuEtX
         lyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739230059; x=1739834859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDwpYY4jYjxltbjhc/od4X7/kPT8qKA5UGsZNXQcdGU=;
        b=n+oAyJ3lj/2TMvzgfPwcT5C0hF2m0RoM8V+PoggxeGYXlNhEJsQ2cNVMBzhB/1c734
         Z3lqkrBFGTXHXp+EQNXIdjaHKDru1CIZdyjWH0DafvGvFJcRH3TY0bkOm8Xs9VgmdJB2
         RVr4rq91J8ADJg6/uLmvVu1jPYNBChS46q41FTRlqPrWECqqWPh/jqMmPn2RgdImH3Vp
         9SLkIdVgsH/tLwL5Hc4l2XOALAymeWxr96ymksxgA+RaBAXN8uXLT17J/adrFe2gSsur
         /tg7Bh6OD2baU/acGUBW1M7ZNlN6qW8cKuy6umx6oP7X8FSsO7ZhSbx/okm8uVz8lR4Q
         F56A==
X-Gm-Message-State: AOJu0YyhUiIO9F6UDiM8OLYVBUzkQcoBG+7t2R11tD0Dfli/8ieEtEHn
	U3DXEZ5iwXdFS38UKgcbq4lqj3swxXbSUatWn+qSxpJujALFnVTQu2cD9cjGTQ5U43i7kEjHrzZ
	dLw==
X-Google-Smtp-Source: AGHT+IHAcNhHXXFo0vm0L60pjUVp9JuvO2DrQhTHM97SIH1YvbieZTlOwzXPOIE4p2eHgrEOqYPs5ZlMvn0=
X-Received: from pjg15.prod.google.com ([2002:a17:90b:3f4f:b0:2d8:8340:8e46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2682:b0:2ef:e0bb:1ef2
 with SMTP id 98e67ed59e1d1-2fa2417808amr21384851a91.19.1739230059364; Mon, 10
 Feb 2025 15:27:39 -0800 (PST)
Date: Mon, 10 Feb 2025 15:27:37 -0800
In-Reply-To: <20250205222651.3784169-3-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100123-unreached-enrage-2cb1@gregkh> <20250205222651.3784169-1-jthoughton@google.com>
 <20250205222651.3784169-3-jthoughton@google.com>
Message-ID: <Z6qLaRYo-I6SSlYc@google.com>
Subject: Re: [PATCH 6.6.y 2/2] KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for
 AMD (x2AVIC)
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Gavin Guo <gavinguo@igalia.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 05, 2025, James Houghton wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Re-introduce the "split" x2APIC ICR storage that KVM used prior to Intel's
> IPI virtualization support, but only for AMD.  While not stated anywhere
> in the APM, despite stating the ICR is a single 64-bit register, AMD CPUs
> store the 64-bit ICR as two separate 32-bit values in ICR and ICR2.  When
> IPI virtualization (IPIv on Intel, all AVIC flavors on AMD) is enabled,
> KVM needs to match CPU behavior as some ICR ICR writes will be handled by
> the CPU, not by KVM.
> 
> Add a kvm_x86_ops knob to control the underlying format used by the CPU to
> store the x2APIC ICR, and tune it to AMD vs. Intel regardless of whether
> or not x2AVIC is enabled.  If KVM is handling all ICR writes, the storage
> format for x2APIC mode doesn't matter, and having the behavior follow AMD
> versus Intel will provide better test coverage and ease debugging.
> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Link: https://lore.kernel.org/r/20240719235107.3023592-4-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> (cherry picked from commit 73b42dc69be8564d4951a14d00f827929fe5ef79)

Same nit on the upstream info here.  Don't think it warrants a v2? (that's a
question for Sasha and/or Greg).

Acked-by: Sean Christopherson <seanjc@google.com>

