Return-Path: <stable+bounces-69890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2B795B9FC
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4C2B22A10
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB93CF63;
	Thu, 22 Aug 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFwD3Dc4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1867182DF
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340128; cv=none; b=aZ82kRmrDSPNqvdF/7RrEQQWzps9MV/e7v9LjSsPJqcLq/LEh3+licxZgTg78J1BtvGAnbhZFRDU83dVCnD3CGqAVaCxZFUonwprZHeMq0yT2XtJuyh5pvvsStGfixQSplquP3cUh0p4kxENBigc9DthXc9+lsN66+zOFSP12JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340128; c=relaxed/simple;
	bh=8u69ufbrCHfQW2AosSzdS2m/deE0V7QxgZFVylnBlK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isXkCRb+aw3Moaa5WvhYPxVrLSK4QrPddD2I8KbbTG4T16V+Ib6E9m+SGHx5qvU1WR/Ib2KACRDwIu8MLUIjUnnZTxxLbfpTgnwRvibPrIHyDDb+FjoBoTavpOpUbBYcPxKMhccGAZkn8TzrAXbdL1hUaSO/BsTq4t0nFZdOfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFwD3Dc4; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5de0e47b9so590217eaf.0
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724340126; x=1724944926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftW5t8yNZCeZRBSWg58nVC1WR5Rd5XQN5IE7VyRL2DI=;
        b=kFwD3Dc4tFF4Yg/Niqxl6w36RjmpjM4em2lYlRuh4/kPwsMOv9kpQJZtVx6sMJaIBv
         2FOmIVHQGz+dA4wBf1WGhu9tFxqdH3Ld3w1zJ5ZnyKy4m00tLWCCunf55ZxiFGhjDABp
         Rosi0rMesaGkpeJOziJ8Kq858VXs+xfD2VL+d5UZ1Jz3Sr/k9namffOJEJT0BNUIZOTm
         aWmLsXo6vImmCi2lHOc5uaTd2Wjq6+ks5N/46z23HVzNfaAKZbP9/Wdl9CBKHiJIe3P+
         waT93dWaHSGkjeRN5Vy1xkTt5OR1DctnQGp5BPN7BBScT9X5ofWPBZpdMwAL1qqgVq11
         6Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724340126; x=1724944926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftW5t8yNZCeZRBSWg58nVC1WR5Rd5XQN5IE7VyRL2DI=;
        b=Ry8QjiGpk6RUjgCcy4U+2+NWta2Bo2J/1Kky+CiR1Mne0vWmxJQXcJEXmrbE+UnuQk
         3BZWKOgHaySha6ErztsaxfL4JC9dromBrGv/agnJeEMQ6hUhP7fufDCdXVMcFjTlVXqV
         /870/IhY1bTrhev+0eRO0YeEBTT0pgFqB8CIgTZkPQkpiT3tMBQbGPFCt95d2/CqrWdL
         T7R4ZvWH8Z6+svgI25bjfm8mk+dzoygHnWS0kT5w9ZVq2eCPjIumm9P+zywr5PpNRYYl
         gNVtJI3yX/EqZpWFH4qVxxuQClwpmvICfhbLqTCprZK46rgT8DsDjyPwgmaKW+iW5z/Q
         aH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKqr6oK4h/yIPgI7JZ/9PgUKj0f7c16Jgl/9Yub3IBiyThPeJY1bxBpQD7aFyWuYjosQJe6t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QPvKtJ9Yq1M+55+LzKjaILbzcjzv/YLA4iZv7QzWRJy7Zg8+
	2D8J1kXHDmpq13ZoU2qX+SULSDfoNftPCCvhiwQecJZcVaJZrLtS
X-Google-Smtp-Source: AGHT+IETQhZpasbAQT1A59XgCwpfu+/BYlphPzA4I1mrOOmIcot1KHDgSkggj7OkhnIhpezJP90GwQ==
X-Received: by 2002:a05:6358:7186:b0:1b5:968f:dbd with SMTP id e5c5f4694b2df-1b59f9b9f3dmr760977155d.15.1724340125747;
        Thu, 22 Aug 2024 08:22:05 -0700 (PDT)
Received: from localhost (57-135-107-183.static4.bluestreamfiber.net. [57.135.107.183])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-844ce515674sm224164241.23.2024.08.22.08.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 08:22:05 -0700 (PDT)
From: David Hunter <david.hunter.linux@gmail.com>
To: david.hunter.linux@gmail.com
Cc: Haitao Shan <hshan@google.com>,
	stable@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 6.1.y 2/2 V2] KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.
Date: Thu, 22 Aug 2024 11:21:46 -0400
Message-ID: <20240822152146.88654-3-david.hunter.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822152146.88654-1-david.hunter.linux@gmail.com>
References: <20240822152146.88654-1-david.hunter.linux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haitao Shan <hshan@google.com>

When running android emulator (which is based on QEMU 2.12) on
certain Intel hosts with kernel version 6.3-rc1 or above, guest
will freeze after loading a snapshot. This is almost 100%
reproducible. By default, the android emulator will use snapshot
to speed up the next launching of the same android guest. So
this breaks the android emulator badly.

I tested QEMU 8.0.4 from Debian 12 with an Ubuntu 22.04 guest by
running command "loadvm" after "savevm". The same issue is
observed. At the same time, none of our AMD platforms is impacted.
More experiments show that loading the KVM module with
"enable_apicv=false" can workaround it.

The issue started to show up after commit 8e6ed96cdd50 ("KVM: x86:
fire timer when it is migrated and expired, and in oneshot mode").
However, as is pointed out by Sean Christopherson, it is introduced
by commit 967235d32032 ("KVM: vmx: clear pending interrupts on
KVM_SET_LAPIC"). commit 8e6ed96cdd50 ("KVM: x86: fire timer when
it is migrated and expired, and in oneshot mode") just makes it
easier to hit the issue.

Having both commits, the oneshot lapic timer gets fired immediately
inside the KVM_SET_LAPIC call when loading the snapshot. On Intel
platforms with APIC virtualization and posted interrupt processing,
this eventually leads to setting the corresponding PIR bit. However,
the whole PIR bits get cleared later in the same KVM_SET_LAPIC call
by apicv_post_state_restore. This leads to timer interrupt lost.

The fix is to move vmx_apicv_post_state_restore to the beginning of
the KVM_SET_LAPIC call and rename to vmx_apicv_pre_state_restore.
What vmx_apicv_post_state_restore does is actually clearing any
former apicv state and this behavior is more suitable to carry out
in the beginning.

Fixes: 967235d32032 ("KVM: vmx: clear pending interrupts on KVM_SET_LAPIC")
Cc: stable@vger.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Haitao Shan <hshan@google.com>
Link: https://lore.kernel.org/r/20230913000215.478387-1-hshan@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Hunter <david.hunter.linux@gmail.com>
---
 arch/x86/kvm/vmx/vmx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 87abf4eebf8a..4040075bbd5a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8203,6 +8203,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.load_eoi_exitmap = vmx_load_eoi_exitmap,
 	.apicv_pre_state_restore = vmx_apicv_pre_state_restore,
 	.check_apicv_inhibit_reasons = vmx_check_apicv_inhibit_reasons,
+	.required_apicv_inhibits = VMX_REQUIRED_APICV_INHIBITS,
 	.hwapic_irr_update = vmx_hwapic_irr_update,
 	.hwapic_isr_update = vmx_hwapic_isr_update,
 	.guest_apic_has_interrupt = vmx_guest_apic_has_interrupt,
-- 
2.43.0


