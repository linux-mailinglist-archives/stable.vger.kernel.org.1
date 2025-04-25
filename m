Return-Path: <stable+bounces-136736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A4A9D52D
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 00:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5F41C016B3
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10038233736;
	Fri, 25 Apr 2025 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNkQVFtp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA83233140
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 22:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745619012; cv=none; b=XIrSznsS8UHEFAH4Tej7dyI6BCCYDES3cbXn+bw496VDQS00Q4ecyJJXpBj7BXed7ZHQSy65jovqkWSo+KCIyc2g7Jus0eZnktZv2zUYEif8FkBQqA1+4R0rxFQIsaz3kolgQkzDOGZqKaIUzB8HCm0JzkFK8KJ0Ooaet3sBEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745619012; c=relaxed/simple;
	bh=QDpNpdZSVvNzvd5MLR7pzG4I1iT2a6SWMqrV4UoqPjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lix5etY4MvrrgYjSTNbkLnGCgu0+Efpd1YKk+pY4VcaSvTTz/d3hrs8Ra1VlZNABKZzO2mf5RKJq9agcUjB1ePwkpDVke0oyiKHziiPFuWC6wH2H1dfzh1saAtTctyiwb049RBFqBKiI7OoD550HV66R0MZvfDRhoIGA0GQXW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNkQVFtp; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736bf7eb149so1799739b3a.0
        for <stable@vger.kernel.org>; Fri, 25 Apr 2025 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745619011; x=1746223811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KP7SMXC0UpOU8ebuPaD2r2QZRSGge8gBq4uVn0V+Tno=;
        b=BNkQVFtpvyp7q0DXrtG/tzkoggY7rb9JzVNmzL8BKY92NjvTOA5URmkJLsFET1MJNa
         n88iMENOP1nWyojYhtxzWzG/bKcS+i8LBl9hNQ/4TE3Q8i5iX0tAA6V7AAANUuFagonZ
         CFgFpCWbYFjsgGwm4TWvbu9/gVGNYmLBGGtrGhrx66ZHpcCncp6HClw2R42MIzh1YG0H
         4dETiKWlPY6QmtR5r4SmYm0iqUzMqCy1iQpko16YupF725TyV93TVKv7PJIgsc6zPS7t
         zgJsMKXd8ytsUiHtcDYLIdaSypWmtz8deT89LILGCC/mM1Rbe8h4TgvuvWszHtd97r59
         nF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745619011; x=1746223811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KP7SMXC0UpOU8ebuPaD2r2QZRSGge8gBq4uVn0V+Tno=;
        b=U7JxhjHlUIRGKk1CvrOS8cr4UYzAYzpfE86/37N2pLZxSSQYXMw5dGa1YJmuCva+qK
         yDYKj3Vs3nt+mnPKumncLXHFmLsWqENnmggW/+jtMQb3Rr/0NdmWiebummM53dyrInkl
         pTY7lTfFPoP+cFCGOhj+LpASt6TsBBIvbk9mBJt7z6tP4J6yinswdswgBN5FKXNcK2v0
         E4PPF0lGrGHuR1w0hFZG5ChifwEcd7ADGrnDnhDNuzHknk/zxoDzRiDfmK28ydmTI8zy
         F6ZtXPtvyXIQG6djexQuUDSnpX1QTU0847Y+VmERNvChYcCnWcHHpXmiaegWVc4W7hLZ
         9H8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtACcXJraalk8+AZXld28p83RQw1IJO2kMdkJn+b6gCANcH++LBBcpSm+PIsO0fMzpCqiqDvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySEP14H4gCAiB14WaiyEboLmH4DsNniM5ticW3ld3NvgUjp6Gr
	Z+n6l0bG86ilskP6LXe1IbQR0zFiNFK83ylWZ9elCXcFydGT88N3U4nl1m6wH3vZUK0tUhkH0lh
	arA==
X-Google-Smtp-Source: AGHT+IHlxsqOZTM+LSrc0NBMmc8B9QyOShS3ixyiaGAbKud07pM591093aslJMz7+/hiacjkdUWS8cPxxuk=
X-Received: from pfbhx20.prod.google.com ([2002:a05:6a00:8994:b0:73b:c271:ad40])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:179e:b0:736:476b:fcd3
 with SMTP id d2e1a72fcca58-73fd9145c92mr6310645b3a.24.1745619010562; Fri, 25
 Apr 2025 15:10:10 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:08:58 -0700
In-Reply-To: <20250414171207.155121-1-m.lobanov@rosa.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414171207.155121-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <174559665447.890486.10602051835802598167.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: SVM: forcibly leave SMM mode on vCPU reset
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 14 Apr 2025 20:12:06 +0300, Mikhail Lobanov wrote:
> Previously, commit ed129ec9057f ("KVM: x86: forcibly leave nested mode
> on vCPU reset") addressed an issue where a triple fault occurring in
> nested mode could lead to use-after-free scenarios. However, the commit
> did not handle the analogous situation for System Management Mode (SMM).
> 
> This omission results in triggering a WARN when a vCPU reset occurs
> while still in SMM mode, due to the check in kvm_vcpu_reset(). This
> situation was reprodused using Syzkaller by:
> 1) Creating a KVM VM and vCPU
> 2) Sending a KVM_SMI ioctl to explicitly enter SMM
> 3) Executing invalid instructions causing consecutive exceptions and
> eventually a triple fault
> 
> [...]

Applied to kvm-x86 fixes.  I massaged the shortlog+changelog, as firing INIT
isn't architectural behavior, it's simply the least awful option, and more
importantly, it's KVM's existing behavior.

Thanks!

[1/1] KVM: SVM: forcibly leave SMM mode on vCPU reset
      commit: a2620f8932fa9fdabc3d78ed6efb004ca409019f

--
https://github.com/kvm-x86/linux/tree/next

