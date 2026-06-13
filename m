Return-Path: <stable+bounces-263022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Q2OBxKvLWqwigQAu9opvQ
	(envelope-from <stable+bounces-263022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 21:27:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FF67F726
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 21:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263022-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263022-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5D8C3022074
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C33876AB;
	Sat, 13 Jun 2026 19:27:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274235E949
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 19:27:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781378830; cv=none; b=erqD0Z74rBRJEED7wD/KG7+ykaqnkRIpPC3YyuPmWlGd30wu41XAS1n6ZCL2zsmgkSGxDYo/cMBLIqtbKy82cQsYD6ecnyNyxTnY03igLQRhESJv+VepMhzLT7OEvB5O4rYKtew2DLVJIahOvSGKdVkGtamv+MLOKZq6abGhFjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781378830; c=relaxed/simple;
	bh=xVelLjBz1oChDfGaccyQlEKkrUo4O0HxtFhkEf12Xyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YDsDT3uit9tC3sN4cgskCdgDnOvUJFpGwMKCt9AQrILcqiQv/sWwHAS1ycjrMLO3jUw5AmFZN7yY45vxJrSesEuOYOmQuvRwOvz96T1iCuMfSypP0qzQZGDgTcVYNlK0adiIRsHfoeyk/UlW8pydGim0Fna+WedUAXcJWQc+O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A521F000E9;
	Sat, 13 Jun 2026 19:27:07 +0000 (UTC)
Date: Sat, 13 Jun 2026 14:27:06 -0500
From: Clark Williams <clark.williams@gmail.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org
Subject: Problems building RT stable for v6.1.175
Message-ID: <ai2vCqAXVEMQJDOJ@demetrius>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263022-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[clarkwilliams@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clarkwilliams@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,demetrius:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B1FF67F726

Sasha, 

I was having some compilation problems building the v6.1-rt branch after merging v6.1.175.
I'm building on an up-to-date Fedora 44, using gcc 16.1.1.

------------------------
First I saw this:

  CC [M]  arch/x86/kvm/vmx/vmx.o
In file included from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.h:15,
                 from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/nested.h:7,
                 from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.c:63:
/lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx_ops.h:15:58: error: ‘regparm’ attribute ignored [-Werror=attributes]
   15 |                                                          bool fault);
      |                                                          ^~~~
cc1: all warnings being treated as errors
make[4]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
make[3]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86/kvm] Error 2
make[2]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86] Error 2
make[1]: *** [/lilnas/src/stable-rt/v6.1-rt/Makefile:2025: .] Error 2
make: *** [Makefile:238: __sub-make] Error 2

The fix there is to add const to the definition of next_path:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7bd6aff6e260..33b214a91338 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10748,7 +10748,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
                if (!search_paths[i])
                        continue;
                for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-                       char *next_path;
+                       const char *next_path;
                        int seg_len;
 
                        if (s[0] == ':')

------------------------
next up is a warning-as-failure in libbpf.c:

   CC [M]  arch/x86/kvm/vmx/vmx.o
   In file included from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.h:15,
   from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/nested.h:7,
   from /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx.c:63:
   /lilnas/src/stable-rt/v6.1-rt/arch/x86/kvm/vmx/vmx_ops.h:15:58: error: ‘regparm’ attribute ignored [-Werror=attributes]
   15 |                                                          bool fault);
      |                                                          ^~~~
   cc1: all warnings being treated as errors
   make[4]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:250: arch/x86/kvm/vmx/vmx.o] Error 1
   make[3]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86/kvm] Error 2
   make[2]: *** [/lilnas/src/stable-rt/v6.1-rt/scripts/Makefile.build:503: arch/x86] Error 2
   make[1]: *** [/lilnas/src/stable-rt/v6.1-rt/Makefile:2025: .] Error 2
   make: *** [Makefile:238: __sub-make] Error 2


I'll admit I had to ask my buddy Claude about this one. Turns out that the regparm attribute is relevant only on x86-32
and is meaningless on x86-64, so treated as a warning and a failure. The fix is to wrap the definition in an #ifdef
for CONFIG_X86_32:


diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 5edab28dfb2e..50328be40b2b 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,8 +11,11 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-                                                        bool fault);
+/* regparm(0) overrides -mregparm=3 so args are stack-passed, matching asm callers */
+#ifdef CONFIG_X86_32
+__attribute__((regparm(0)))
+#endif
+void vmread_error_trampoline(unsigned long field, bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);

------------------------

Pretty sure you'll need these (or something equivalent) on 6.1 stable, when more people start using gcc 16.

Don't know if this email is enough but if you want I'll send you a patch series. 

Regards,
Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790

