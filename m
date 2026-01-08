Return-Path: <stable+bounces-206300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 234BDD04736
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B52A32B80A6
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63444D028;
	Thu,  8 Jan 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TEufoNT2"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2344D684
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867364; cv=none; b=homTGBvLo2oc90H0J8QHNeVg1m2XRi6PEMkADWcxxr8S11nlz4tFrIEnMXFfj40l+PIXFnTezIP5sL3RIvo+Dq7JmJDXdyzyONQod1JqRmnuU2amkzaLYz1Er7TxcRg4gLGopCofHpPJvGXrQruHFiM+VQ1as8kJ+ZAEtrKZkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867364; c=relaxed/simple;
	bh=KnfQAnM+l2z2S/g5DcHrhNzL1mjNWv9NWOhHwCcsx2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyZRJFSbOGfrosfq1xosLsSpz6TS8wAVMswfW8s2pGbO3ZrJQlpI7gQk3u0g1baRBUyFiYkapE0h1FTWHNZ06Oxwga5tToof98AGiQexKgJ32ofxjxLraZGd3l50ad4FXzetN0JMMqihv6i2SOcgcPwd+uW8QbSZQeVNC0gHE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TEufoNT2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KtwvkUaI/cm62FVFp+cSFiqZBKmpAHGKeghZNnNK2xc=; b=TEufoNT2Tvf6o3CFqisyH0mgrg
	r8xAw8zXWAlFgchdyjeCtJ8CZA/tLUqcCDHCuvkdoX1s4KsD5BpIY1Lo3mhoP7yT17q+HNL7BmuI2
	z0bPX/Qw68d1/b9U5d+zTzn46tU+Mulu0UmjgGqL4tiJKKw4FNAISIAZ4TVFNsolmtq30AZNFxluV
	PByJAQfTjMC6DlzxX1mk59a5PGegIxwssmJOA9uASl5gijckbjkuK+Hj/8ZHu4ef6N72YmSLZi5DJ
	frhhPZj7CH3LQRz3YXt/pu2TZ5ljzdOURd9EIleJyUcQDiiXKLfDsJjtUONyvtJtQGShqq388fxWJ
	h+eS5TOA==;
Received: from 179-125-75-246-dinamico.pombonet.net.br ([179.125.75.246] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vdn3d-002vo2-1u; Thu, 08 Jan 2026 11:15:57 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Hsin-Wei Hung <hsinweih@uci.edu>,
	Florian Lehner <dev@der-flo.net>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 2/2] mm: Fix copy_from_user_nofault().
Date: Thu,  8 Jan 2026 07:15:45 -0300
Message-ID: <20260108101545.2982626-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108101545.2982626-1-cascardo@igalia.com>
References: <20260108101545.2982626-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

commit d319f344561de23e810515d109c7278919bff7b0 upstream.

There are several issues with copy_from_user_nofault():

- access_ok() is designed for user context only and for that reason
it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
and perf on ppc are calling it from irq.

- it's missing nmi_uaccess_okay() which is a nop on all architectures
except x86 where it's required.
The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.

- __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.

Fix all three issues. At the end the copy_from_user_nofault() becomes
equivalent to copy_from_user_nmi() from safety point of view with
a difference in the return value.

Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Florian Lehner <dev@der-flo.net>
Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
Tested-by: Florian Lehner <dev@der-flo.net>
Link: https://lore.kernel.org/r/20230410174345.4376-2-dev@der-flo.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[cascardo: the test in check_heap_objects did not exist]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 mm/maccess.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/maccess.c b/mm/maccess.c
index ded4bfaba7f3..02f87fad4336 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <asm/tlb.h>
 
 bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 		size_t size)
@@ -223,11 +224,16 @@ long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 	long ret = -EFAULT;
 	mm_segment_t old_fs = force_uaccess_begin();
 
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
+	if (!__access_ok(src, size))
+		return ret;
+
+	if (!nmi_uaccess_okay())
+		return ret;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
+
 	force_uaccess_end(old_fs);
 
 	if (ret)
-- 
2.47.3


