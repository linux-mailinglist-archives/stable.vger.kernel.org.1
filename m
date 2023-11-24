Return-Path: <stable+bounces-364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457C07F7AC4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89E8B2102A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6C39FDD;
	Fri, 24 Nov 2023 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tehhTF7L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D039FD9;
	Fri, 24 Nov 2023 17:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B82C433C7;
	Fri, 24 Nov 2023 17:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700848708;
	bh=CI+1O1Q9c7QEIT8k7thUdBornaEY+KhR3u9PUeLUZ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tehhTF7Lu1E/E6TKVbEP54L3y9VkU8stniyHtojO9nht0CeWevefeErdon6RFhBuE
	 azgNQLwgh3+kfBrNGVTneUZ192eCfIYcnslZ23ApoCkiOrjKv+YZJ/4HxKnrPuw7HY
	 EQ02y0ZM9n/Y5NdXP49E1Pk2PaiuPItZk54VIOLc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 4.19 50/97] KVM: x86: Ignore MSR_AMD64_TW_CFG access
Date: Fri, 24 Nov 2023 17:50:23 +0000
Message-ID: <20231124171936.019167707@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171934.122298957@linuxfoundation.org>
References: <20231124171934.122298957@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

commit 2770d4722036d6bd24bcb78e9cd7f6e572077d03 upstream.

Hyper-V enabled Windows Server 2022 KVM VM cannot be started on Zen1 Ryzen
since it crashes at boot with SYSTEM_THREAD_EXCEPTION_NOT_HANDLED +
STATUS_PRIVILEGED_INSTRUCTION (in other words, because of an unexpected #GP
in the guest kernel).

This is because Windows tries to set bit 8 in MSR_AMD64_TW_CFG and can't
handle receiving a #GP when doing so.

Give this MSR the same treatment that commit 2e32b7190641
("x86, kvm: Add MSR_AMD64_BU_CFG2 to the list of ignored MSRs") gave
MSR_AMD64_BU_CFG2 under justification that this MSR is baremetal-relevant
only.
Although apparently it was then needed for Linux guests, not Windows as in
this case.

With this change, the aforementioned guest setup is able to finish booting
successfully.

This issue can be reproduced either on a Summit Ridge Ryzen (with
just "-cpu host") or on a Naples EPYC (with "-cpu host,stepping=1" since
EPYC is ordinarily stepping 2).

Alternatively, userspace could solve the problem by using MSR filters, but
forcing every userspace to define a filter isn't very friendly and doesn't
add much, if any, value.  The only potential hiccup is if one of these
"baremetal-only" MSRs ever requires actual emulation and/or has F/M/S
specific behavior.  But if that happens, then KVM can still punt *that*
handling to userspace since userspace MSR filters "win" over KVM's default
handling.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1ce85d9c7c9e9632393816cf19c902e0a3f411f1.1697731406.git.maciej.szmigiero@oracle.com
[sean: call out MSR filtering alternative]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    1 +
 arch/x86/kvm/x86.c               |    2 ++
 2 files changed, 3 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -414,6 +414,7 @@
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
+#define MSR_AMD64_TW_CFG		0xc0011023
 
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2460,6 +2460,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_PATCH_LOADER:
 	case MSR_AMD64_BU_CFG2:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		break;
 
@@ -2763,6 +2764,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
 	case MSR_AMD64_BU_CFG2:
 	case MSR_IA32_PERF_CTL:
 	case MSR_AMD64_DC_CFG:
+	case MSR_AMD64_TW_CFG:
 	case MSR_F15H_EX_CFG:
 		msr_info->data = 0;
 		break;



