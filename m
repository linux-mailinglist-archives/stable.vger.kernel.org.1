Return-Path: <stable+bounces-114002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F65DA29CAA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA9167809
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE91214A90;
	Wed,  5 Feb 2025 22:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ihj7OjlO"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C6F510
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 22:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738794432; cv=none; b=VPXvlyCc4sbfVd+c7eDJiOj2iy+010zUbECnOOIwu+3gF70hjMZy+SW5NH3MO6Ai0mqeHvPlpX1t3RutKxJwDkD+qUWln6FMzt1y0ee8FBKg0hBVfEAX1RvcI7OUddi1kNBbPt8V6zrGksUM7V7mRvRyC+q6Z4MvLBzN2YwziN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738794432; c=relaxed/simple;
	bh=gDKm3UOi1ycZkLD85XAgCozDeIGYTajlvHnxJa6MUM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcvmFRCvFRUB7+iw2eCOq0Il/s6+6aJHDsn5swJ2C3+6l5xP8y4273grKt6y2EXqAAj29SgrZ5pYDqFjbHhnAOJhUEdDEeG0ljgoe3uBuzFw37L/WWCK1NtX98FLCAws0InxIL4u3RyCNQbSyqLnS6ZTG4iiiT9OoTe3U2vNsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ihj7OjlO; arc=none smtp.client-ip=209.85.221.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-51f20dd678fso29910e0c.0
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738794430; x=1739399230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EF9vcXhQEphhBLiJXIFUaZjjqTY6hbfdzTTVj3kzjxM=;
        b=ihj7OjlOFt+oNaxqM2HSkJosuprLyuya5kqs+84GiRXKzbsjNGxo8N9bmsfR5CWHzO
         tXOM+CU/9DSySoTyed+4IANpNpFkJuMXbyBnJhzeAKo9ojsGuG52aFGFjM6zP9hlJfvn
         qCYQsmTTaPvQvjDIbj2vfQHgsMa0q97hIi+t5hVv0E/4yhhkIYbytyTTyLog00Q+BMil
         Sjuu7XG8hW7Ymygqru5KRvUqVL5kKHfc7J1b9eilxLyY1HRr4fOdziFMKzKKvnhKcahO
         LodPPb2QHDRWTVIU7UmBlVZSPM1Q8PhsT2L7Oy/bu9b0ChszjujjGDYjk62nQ23pS+bo
         HcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738794430; x=1739399230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EF9vcXhQEphhBLiJXIFUaZjjqTY6hbfdzTTVj3kzjxM=;
        b=hJqzarF0mo/ZI5UqH2sH4X0s3/DNbxYWkZL3PjzPfyhJXD/qkc3OfOAVT9M5iRpysR
         7ETsrIG6ldVnnzgxh2x4oy3Bg4+shMFxtFr3Cx6psZmUMdsX9j3Am45AuRTObH6DIbZz
         tOOpgUpXRQYptHI/7yE8lOQx7sbWL9+J1l1EIKddg9G5t0UyPBn9TOMMRPG3X7twFyW6
         iodaVlN1q2w93igDM8YaJyJuIuwqfsdn/zATDnqaZCo+n3R/OIblLG5FxNW4ybUgD1O7
         cGNX7W9NO3ChEIcVnOnxZ6GL+URIM37bdQw6RG7U9/TTVGi6K9ghhzIGD0dNCxN3ezza
         xD+A==
X-Gm-Message-State: AOJu0YzirFil6LP1XeWjkJZGlyrabI5ox9el+WaqFyXwzQuSw/hhupo+
	rqbQ/O3Fq7EsJXwsJpFJvy5iuyn+BQL2lZUddiuhVLzLqYIRcmMiKfRIyBCF014CRnBrKZgEq8G
	Cj5ks6r60juELf9A41DdpQm4xEX0c0Cb5RPrnxZiQ59sS9W9fI1AqXn1swStPIWpC4Igw2ysNxl
	tSGwO/wpfE3uW1kunSE4XkcyNqMVr7ykWuhsrxEAQ/ip7qjo0hBGkfzw==
X-Google-Smtp-Source: AGHT+IH/soYGxZ8Wgbj/c0qisZbOBmIis3BGBCoRExNgY5mjDcA7YMQ7KMpgFRi76Ny/0A1Vcvt6H4Zy3mqMRFpa
X-Received: from vkbet6.prod.google.com ([2002:a05:6122:1c06:b0:516:f6b:e2fd])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:c92:b0:518:859e:87c3 with SMTP id 71dfb90a1353d-51f0c4f34b3mr3265460e0c.7.1738794429866;
 Wed, 05 Feb 2025 14:27:09 -0800 (PST)
Date: Wed,  5 Feb 2025 22:26:49 +0000
In-Reply-To: <2024100123-unreached-enrage-2cb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024100123-unreached-enrage-2cb1@gregkh>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250205222651.3784169-1-jthoughton@google.com>
Subject: [PATCH 6.6.y 0/2] KVM: x86: Backport split ICR for x2AVIC
From: James Houghton <jthoughton@google.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Gavin Guo <gavinguo@igalia.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Also pull in commit 4b7c3f6d04bd ("KVM: x86: Make x2APIC ID 100%
readonly") as a dependency, which itself fixes a WARN.

Tested with xapic_state_test avic=Y.

Sean Christopherson (2):
  KVM: x86: Make x2APIC ID 100% readonly
  KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)

 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/lapic.c            | 66 +++++++++++++++++++++++----------
 arch/x86/kvm/svm/svm.c          |  2 +
 arch/x86/kvm/vmx/vmx.c          |  2 +
 4 files changed, 52 insertions(+), 20 deletions(-)

-- 
2.48.1.362.g079036d154-goog


