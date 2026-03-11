Return-Path: <stable+bounces-224669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNVqDLhKsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:58:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C91E262A6F
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B79832240D0
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02903C555B;
	Wed, 11 Mar 2026 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="V3a21pVu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66F2EC0AE
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226187; cv=none; b=S7xw/Q9SBqVR0mQ5eZJJ38TTQ7sdpTmbfaasBSuyFkVKu8xoCRA1Wh1BjugOuGlPNBbqTJoEnHJ5CTlPk9Lnf+ea9227PmhdW+hrXtFpToy0OAit3IpKtp+sDHICQRr+AZ3pgrcjuDJagGDJP1WstXdLA4Hw3HxVIAkMQoraHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226187; c=relaxed/simple;
	bh=khvPnFCLVUsPLSLX4B6oL+qklfdjM0m6etTNoHaJxZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AZNBLNzUM/BL+jDNS7kme3bWoxGct2XEXfavCIIXnVzY6LV/JO4bu2Gfqe3Y0FjjG8BrxnJJ1yV9lSemwOxZPzaIO164x8hhUjPNQtjgIr3JJGPqEyXMTQMPnGOnYxMw7NnLN4Q1QCrOhYjCAEQSHBG6srx7FsDqdKe6EEhGC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=V3a21pVu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3591cc98871so6323720a91.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1773226185; x=1773830985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+01bG4ShJI7+j2R9rM6ycD3z2Zv6pTOBtZ3Q4caNO/o=;
        b=V3a21pVuFi31rQa7oojZeueZVBNOBlMFTsM5W97Kj3MG1fWiYdk53YvskdEas1elMH
         5169xTbU7ZfGWjEUw/aJoEJSZDil+IWJZagUHNaHWHhuDTJKjA2VB97yyKQZRJbhrAQD
         VzKHSXSTbDYevtc7l+zxQY+sPKZoAYkWV5Z0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226185; x=1773830985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+01bG4ShJI7+j2R9rM6ycD3z2Zv6pTOBtZ3Q4caNO/o=;
        b=e2u98GWQlv1Y6IfokAAmFuRGeNxrBiqRsW/6WW4kn/Wjjk/0YmHaBrUvj47xIuvyRi
         jvbqsOk80KGspovJ7VZp0utE7wS+NPgEv3WXDxJiPf2uK3V621T1Z1dBFpqa1Q7qrvhz
         8a1dGiQSAmb0nJt+HCDQMU7MZN7lRJeIZYbDVZcEq/CMNtXe8uvv7T8e4vQCcOTAB1mj
         EbxPeExdwjJz64thW3wAMi2nlur1oribGz/q0qzvtdj5Ti0hy5AVpW9bOGZrRrLVUfRE
         zLDwQ5COKYJZCDpZF+UWpNh7ttqQPeEYRuczfvERX/kEZ9u5PZgPVYN9VS7NvEdrg8yH
         LSdw==
X-Gm-Message-State: AOJu0Yz27yQgeXouleb4h/1ddQskY0mWfs6pIEzAA/OETxqPvwQft0/X
	dCXAShGzN/v52oNT50pJIWSkfZOUBCwxDqfShFe/lDZ7WE2Yl4aD/HjxrvUwBuxJcQ3P+6d+3DN
	mneZ0
X-Gm-Gg: ATEYQzzFo7Z1m+XMkZeyNxXs5MQGQKBdirpZSk/jiWPB2Soc0mSk9iwSRLiGAgbNFiu
	wyzO/JfMd9EKvdlmT/UNtAVr1/V+yb64aNEUXnTwKGwPHLHw2UIcNzhoxJPStu0g7srC9nOOlDb
	YXqp5mPfuA5iIdaPVDdsuQiWcTd3Q11dgSwgkadu2HrRzaS/0pHOOkJKkdFC5UEsOB4zlVoXewB
	i5BdDsY8BbFJoWAPvK2W9SdlJFC3PXuLCnb4todAi6vVysXXSs2WouiUZnUMHRNuhryrf/LW91s
	BuhJ+Tzg08pTRWmIifXWvQt2mpxZ4bw90R20WTub4wULgaJAh1w3/RZAeCOKILfU3ZPpf375/Af
	5s62LPBgtm/x9LGJZl9/7EPYzAaZ6IW1yiklGRUjuBHAIfrvmR2oyJDddlQUbPn1szlr57XZGet
	5mQDgNrm+Nj1z6EWS9pVulXK2ULtVjwWL8irV++mbV6g==
X-Received: by 2002:a17:902:cf08:b0:2ae:7ee0:ab3 with SMTP id d9443c01a7336-2aeae8c1b72mr21926545ad.38.1773226185357;
        Wed, 11 Mar 2026 03:49:45 -0700 (PDT)
Received: from localhost.localdomain ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae361a00sm20107155ad.76.2026.03.11.03.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 03:49:44 -0700 (PDT)
From: Taeyang Lee <0wn@theori.io>
To: stable@vger.kernel.org
Cc: Taeyang Lee <0wn@theori.io>
Subject: [PATCH] KVM: VMX: fix null pointer dereference in vmx_guest_apic_has_interrupt()
Date: Wed, 11 Mar 2026 19:49:06 +0900
Message-Id: <20260311104905.18397-1-0wn@theori.io>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C91E262A6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[theori.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[theori.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224669-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0wn@theori.io,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[theori.io:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

vmx_guest_apic_has_interrupt() checks virtual_apic_map.gfn to determine
if the map is valid, but kvm_vcpu_unmap() only clears hva and page
without clearing gfn. This leaves the map in an inconsistent state where
gfn appears valid but hva is NULL.

An L1 guest can exploit this by:

  1. Executing VMLAUNCH with a valid virtual APIC page, then triggering
     a VM-exit. nested_vmx_vmexit() calls kvm_vcpu_unmap(), which sets
     hva=NULL but leaves gfn stale.

  2. Executing VMLAUNCH with an unbacked virtual APIC page GPA while
     setting CR8 load/store exiting. kvm_vcpu_map() fails without
     modifying the map struct, and the special branch in
     nested_get_vmcs12_pages() clears TPR_SHADOW without invalidating
     the stale map. With guest_activity_state=HLT, the vCPU enters
     the blocking path without a hardware VMLAUNCH.

  3. kvm_vcpu_has_events() calls vmx_guest_apic_has_interrupt(), which
     passes the gfn != 0 check, reads hva (NULL), and dereferences
     NULL + 0xA0 (APIC_PROCPRI).

This bug does not exist in mainline, where virtual_apic_map was replaced
by gfn_to_pfn_cache in the "KVM: nVMX: Implement cache for L1 APIC
pages" series by Fred Griffoul.

Add a NULL check on hva before dereferencing, consistent with
vmx_complete_nested_posted_interrupt() which already performs this check.

Reported-by: Taeyang Lee <0wn@theori.io>
Fixes: e6c67d8cf117 ("KVM: nVMX: Wake blocked vCPU in guest-mode if pending interrupt in virtual APICv")
Cc: stable@vger.kernel.org
Signed-off-by: Taeyang Lee <0wn@theori.io>
---
 arch/x86/kvm/vmx/vmx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ebdc86030a7a..7bc9a029c1d8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4078,6 +4078,9 @@ static bool vmx_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
 	rvi = vmx_get_rvi();
 
 	vapic_page = vmx->nested.virtual_apic_map.hva;
+	if (!vapic_page)
+		return false;
+
 	vppr = *((u32 *)(vapic_page + APIC_PROCPRI));
 
 	return ((rvi & 0xf0) > (vppr & 0xf0));
-- 
2.39.5 (Apple Git-154)


