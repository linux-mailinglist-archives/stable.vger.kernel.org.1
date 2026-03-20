Return-Path: <stable+bounces-227568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKHaMtluvWnL9gIAu9opvQ
	(envelope-from <stable+bounces-227568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:59:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA382DCFBB
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B21E3058088
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDA3CD8BD;
	Fri, 20 Mar 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SY+xRER4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB022A817
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022348; cv=none; b=f32uhLlzon2TwdH5qHq1rqu9Ls5wljGe6vRianOSdhOs9+qOMdx04/JVr9xiTYx0YaNsCACIAklUX3uxPrCNHcqEtJSAlM8+UWExz3L+qhuTZ92bU3hq+UmhPigkngVYoKxcxrDy/v8L5K4kgxBqRoZdWt4ij3v08gZ84vPl4M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022348; c=relaxed/simple;
	bh=16yO1qqMR4wLhgsIkXKZhV9SQP3DubEoX1WVxr3V5bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHD6/a5sJ666ewIadYDDE7Mw8D24wZ6N7ge4BzCqs0EdUDXNq4L42P5B7bm5V6/pfFfVQGwEFqjdAn5LPbzjKDBIoE8TiPvSNbEwXbWMuihUV+NzPVTd60MBFYXv6cxRHtg7FZJ7It6ZbtlWXLun9BlbAuzKw+MnNa1u/iYkqzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SY+xRER4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774022346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8yWdXXmCFKiAxvWiUii4eBbGeSCOI3DuI0otrKafgog=;
	b=SY+xRER403GlP1rrQ5R8URrW3x0tLm/xgW71JgjwkWvXxk8TGxN3XRTmL1VaZE7rh4yaB9
	kYf7VXzu6/5xNZyKv05u7k7VsAUP1la6BwfdglQ+27OQqyYoYR5Hj6hdNWMCNJQBKjqOhL
	DNmF/keJ6/PHIH7m6h1fdZWFlaCeavs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-pu8zbBcJOZ2ucDJsTPbYEA-1; Fri,
 20 Mar 2026 11:59:03 -0400
X-MC-Unique: pu8zbBcJOZ2ucDJsTPbYEA-1
X-Mimecast-MFC-AGG-ID: pu8zbBcJOZ2ucDJsTPbYEA_1774022342
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 556EA1800281;
	Fri, 20 Mar 2026 15:59:01 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.2.16.157])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 759B51953944;
	Fri, 20 Mar 2026 15:58:58 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	linux-riscv@lists.infradead.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] riscv: disable runtime constant support for XIP kernels
Date: Fri, 20 Mar 2026 11:58:41 -0400
Message-ID: <20260320155843.1848180-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227568-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmirabil@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.974];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FA382DCFBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Runtime constant support is predicated on patching the kernel binary at
runtime, which is fundamentally impossible for an XIP kernel whose text
section is backed not by RAM but by memory mapped read-only storage.

If CONFIG_XIP_KERNEL is enabled, do not define riscv implementations of
the relevant runtime constant macros so that the fallbacks which do not
perform runtime constant optimization are used.

Fixes: a44fb5722199 ("riscv: Add runtime constant support")
Cc: stable@vger.kernel.org
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 arch/riscv/include/asm/runtime-const.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index d766e2b9e6df1..05110bb7554e9 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -11,6 +11,9 @@
 
 #include <linux/uaccess.h>
 
+/* patching of the kernel text is fundamentally impossible on XIP kernels */
+#ifndef CONFIG_XIP_KERNEL
+
 #ifdef CONFIG_32BIT
 #define runtime_const_ptr(sym)					\
 ({								\
@@ -265,4 +268,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
+#endif /* !CONFIG_XIP_KERNEL */
 #endif /* _ASM_RISCV_RUNTIME_CONST_H */

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0


