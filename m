Return-Path: <stable+bounces-47955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDCB8FBBBD
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 20:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B5284D8D
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B413F447;
	Tue,  4 Jun 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vtMzvgrM"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C51A5F
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526498; cv=none; b=u4moJqkeSKgr2fS2ahNRZnOSbWuQyF3XX/3VZB2GtErdg8UPuvn/FRVTjkSHNL2m9Convcc+qUjlqxvnIxzKJbQLp0iDsrtsI7ZlPg3ObDueJGYwMvK0Ga05v1pgLa5Qj1ResZNzlqGKUjHbWCDrfLa4eYqVeL9EZErl+9eehPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526498; c=relaxed/simple;
	bh=ttnc6urSopkvU7MEya6X5MUzY5HTjhW1mZzBVhjezio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8FkQTcSVmLUTr4sK4u0N/fy40M0bbsFVoV88zAH4ns9ZwXhCcqfLYxRQFYvXcZvxCazKFDSOOSnMvAaUygTRI0j4ZE58tcWVjUDpm297pVtCiHZOLZ68gGvZQSsbuz23ZV8AxEqD0eNt0nnNL1udO8RqqNBI93ySc9AQHpYKJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vtMzvgrM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: broonie@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717526494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5WnlOVDjBHd9bElbrjgxT+VxkYHxEL7ejS5txWCrkc=;
	b=vtMzvgrMBwWgARu6nY4QE42Ka1Lwl8foDmpfnSMQDSfWZE9bXxYec+LmUPwei0gvQ1v9B8
	EmNSyaRouaZYaIKtxIAoxRzSjzjfJPJhutXHdMTV1AiyV8S19UDW0xE8AUN+brss6pyvrZ
	yjI2lHS7w3wmaE7ZaGRZWla/kkAukPE=
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: sashal@kernel.org
X-Envelope-To: stable@vger.kernel.org
Date: Tue, 4 Jun 2024 11:41:29 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: v6.6.33-rc1 build failure
Message-ID: <Zl9f2XgKaFgS-G3i@linux.dev>
References: <b4cc4d63-3c68-46ba-8803-d072aad11793@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4cc4d63-3c68-46ba-8803-d072aad11793@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

Hey,

Thanks for flagging this broonie.

On Tue, Jun 04, 2024 at 02:35:20PM +0100, Mark Brown wrote:
> I'm not seeing a test mail for v6.6.33-rc1 but it's in the stable-rc git
> and I'm seeing build failures in the KVM selftests for arm64 with it:
> 
> /usr/bin/ld: /build/stage/build-work/kselftest/kvm/aarch64/vgic_init.o: in funct
> ion `test_v2_uaccess_cpuif_no_vcpus':
> /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:388:(.text+0x
> 1234): undefined reference to `FIELD_PREP'
> /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> 388:(.text+0x1244): undefined reference to `FIELD_PREP'
> /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> 393:(.text+0x12a4): undefined reference to `FIELD_PREP'
> /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> 393:(.text+0x12b4): undefined reference to `FIELD_PREP'
> /usr/bin/ld: /build/stage/linux/tools/testing/selftests/kvm/aarch64/vgic_init.c:
> 398:(.text+0x1308): undefined reference to `FIELD_PREP'
> 
> due to 12237178b318fb3 ("KVM: selftests: Add test for uaccesses to
> non-existent vgic-v2 CPUIF") which was backported from
> 160933e330f4c5a13931d725a4d952a4b9aefa71.

Yeah, so this is likely because commit 0359c946b131 ("tools headers arm64:
Update sysreg.h with kernel sources") upstream got this test to indirectly
include bitfield.h. We should *not* backport the patch that fixes it,
though.

Let's either squash in the following, or just drop the offending patch
altogether.

-- 
Thanks,
Oliver

From 5a957ab6d80f4fcb4b1f2bcbd5b999fde003bffd Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Tue, 4 Jun 2024 18:36:29 +0000
Subject: [PATCH] fixup! KVM: selftests: Add test for uaccesses to non-existent
 vgic-v2 CPUIF

commit 0359c946b131 ("tools headers arm64: Update sysreg.h with kernel
sources") upstream indirectly included bitfield.h, which is a dependency
of this patch. Work around the situation locally by directly including
bitfield.h in the test.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 tools/testing/selftests/kvm/aarch64/vgic_init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index ca917c71ff60..4ac4d3ea976e 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -6,6 +6,7 @@
  */
 #define _GNU_SOURCE
 #include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <sys/syscall.h>
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
-- 
2.45.1.467.gbab1589fc0-goog


