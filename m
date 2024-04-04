Return-Path: <stable+bounces-35981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC98899239
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 01:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E731F230E3
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E479130E57;
	Thu,  4 Apr 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5Pp/35f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C913C691
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712274014; cv=none; b=K8Q2NuOsyWV2B0OVQDiVKT7UKpm69bRfGKoISglz8zd1/oesx4d1XgSsOajNMMcHZo6KTAx/97DeIze4311Y3hUDY4l2Ww2AZi2q5H36HQis7QL3sOxGMasuVKw0gMl6Gbcg78oj/pw5J54c1Grzipm695qWtSEfOKBOS+FVlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712274014; c=relaxed/simple;
	bh=AyWExNtliCMnaIPa31T8OjLJgx0gMQ33cU60bHVKOSw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sK/F4uauOwn4TKs+6SDNIAdLOaqxeFyE4h6SFHOxEc1zxvpUq6MB18UFIlYVK9qrsrT6qpF1hR3Jt1JfrOZ/+SATRQpEeGKWPL8NaVYwiQFf6pQ6ggksRt78fHMVTFkjjNbdJXQuDd3CVndfe1M7ktZBownY2l4Db0+NBBFjAvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5Pp/35f; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e0b5e79a57so14701595ad.2
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712274012; x=1712878812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRcmM7eAhmDISD6HIjOIg1nkLVAakLm4fAvyEdY+QHM=;
        b=K5Pp/35fX3s43YaZljYzeJR2qljX6VC2V0z1iKPqlOGjZkVGbGaoSlwbFOG5Z4s8sP
         jTOnbodPalR/EcWilFpugSxsBk8TZOgKuwFm7FRponMEJsKBou7PPGtOicwD/2bBTlJu
         nNjGI9tygSWFVGqJnkm7GtSv1JrV2C+SpNfGzaAi17lweU4pr+d0rbwt9pK1jSDH2kCO
         aVZBUS5UdPHYdhQ5T2CVZqnxLEWDbpVU4aSo4LB20rSOxXt1y1GLDbSHMoVwx6eRUHyp
         2q1wbEMacWZA7ulOq/VrFjSMw6p79DlgvtIol6+nCkrIUX1yuI90j51h+4CDIglf5jbL
         9fCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712274012; x=1712878812;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRcmM7eAhmDISD6HIjOIg1nkLVAakLm4fAvyEdY+QHM=;
        b=Y5SGfW1oSNBnQ4pDa1Cn6+KnnDCEfwbrusWielKHcZ5yJlJ09qGcxOtyeMYydGpP7U
         HB9FpDv2ohTWivV1IEmm9pfafh5AVk+d8B7sM9iKcV7+kzEHIQThP6gchA0jUiESAf+r
         qrWMg1rjOcwaYAIcpA7iBSjhqzMMa3S9Xk8nLUQsO9uCg+eiw7LPiqxcamsKN2UI13us
         ZC36Gnm9AxsKQDeFf1L1RPwcvohKz34Vyvoq5n/h74K6AFHrxi3ULO3nH4MvWoPQPcwT
         ayTx2TGJVZcreZb6JeovA/7L8NX4RPyVKdFcMO8irhsmaY4yNW6zoLvKCG2U/oi/4sUY
         sR1w==
X-Gm-Message-State: AOJu0YyeLcDH6eS9M+P2a15uyBPPe/8UIXSbvRT+3apDXiwy8a3ueROd
	51YyjCSdrKz7FYjYt8HOOAl55056CpKk0nFW0fAqpW/wxUk2K7zk/ENPnVYuN4L/T/dhx1tptu3
	J/b+tmTzEajB/Nz2BWy2L52O7Y9tXT7AhtJJS/ahl7r6GC2df3HjIgfDAAVy936/G9IqTQUbwCj
	8MaC233eQyMvthavChrN2xMNzIFxiQpk1k
X-Google-Smtp-Source: AGHT+IH9o8PgyZzQ8XSZQFyH+zK8kCLfWAtScsql9lRTz+nALM/WUpMPa6Y4oIh2MHxiiDJiPwpBejlrOEI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:6b06:b0:1e3:bfed:74b2 with SMTP id
 o6-20020a1709026b0600b001e3bfed74b2mr8787plk.1.1712274011683; Thu, 04 Apr
 2024 16:40:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  4 Apr 2024 16:40:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240404234004.911293-1-seanjc@google.com>
Subject: [PATCH 5.15 0/2] KVM: x86: Fix for dirty logging emulated atomics
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Michael Krebs <mkrebs@google.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Two KVM x86 backports for 5.15.  Patch 2 is the primary motivation (fix
for potential guest data corruption after live migration).

Patch 1 is a (very) soft dependency to resolve a conflict.  It's not strictly
necessary (manually resolving the conflict wouldn't be difficult), but it
is a fix that has been in upstream for a long time.  The only reason I didn't
tag it for stable from the get-go is that the bug it fixes is very
theoretical.  At this point, the odds of the patch causing problems are
lower than the odds of me botching a manual backport.

Sean Christopherson (2):
  KVM: x86: Bail to userspace if emulation of atomic user access faults
  KVM: x86: Mark target gfn of emulated atomic instruction as dirty

 arch/x86/kvm/x86.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)


base-commit: 9465fef4ae351749f7068da8c78af4ca27e61928
-- 
2.44.0.478.gd926399ef9-goog


