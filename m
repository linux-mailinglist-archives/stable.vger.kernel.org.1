Return-Path: <stable+bounces-97933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EAC9E28E3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E73B3C118
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D281F8907;
	Tue,  3 Dec 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lbji6eAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC51F76BF;
	Tue,  3 Dec 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242228; cv=none; b=jILdUhLfa6qu+osg6rphaNem4u3onSDZOkhDQTOhopDDrt5qaLDDAGy6m42eNn77k1VYYFZacQ8ANLwjG0laIkOSJzYats5P2nGE4qgResn9lFFl7gwqtFCvnqzu4bkAdJHhOguD765Nln3O537oNvQCcpK8dO8JhXqEOu0Ijxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242228; c=relaxed/simple;
	bh=0931WkGnLx6KHC+bUISNaayNl4S+ECOEFseXvwEYnog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gv3pTFVr5qBjgXPy0uReDNztw+G7e4xOHmL4o2ymsnIhlPEremurigyWGLCDDNZBliqoT8YRh32UIgjCHaro9GGmRnqZtl+naI/6vqOT/VHp7gsWJLR9Rkuy0RLaw91Byqj01xMGdJEmMkgid+1WHtOQ7Li9N4QnKO4gcya3Xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lbji6eAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FE6C4CECF;
	Tue,  3 Dec 2024 16:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242228;
	bh=0931WkGnLx6KHC+bUISNaayNl4S+ECOEFseXvwEYnog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbji6eAF2eL6qKl0lGykjdR0AU7X6vbECxSGwujc8fF87NwzAvJI0vt2T+g7KtgLl
	 Wspf5z83CObOYCX29SsP6GEbX4EEPbeM+xpPb3KLKWMMvTVIijFTCCAweufEihLZ5x
	 QoYWqpEP00EZIjkGMnmL+U6dT9rNImgu3+wNbIBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.12 643/826] KVM: x86: Break CONFIG_KVM_X86s direct dependency on KVM_INTEL || KVM_AMD
Date: Tue,  3 Dec 2024 15:46:10 +0100
Message-ID: <20241203144808.831768059@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 9ee62c33c0fe017ee02501a877f6f562363122fa upstream.

Rework CONFIG_KVM_X86's dependency to only check if KVM_INTEL or KVM_AMD
is selected, i.e. not 'n'.  Having KVM_X86 depend directly on the vendor
modules results in KVM_X86 being set to 'm' if at least one of KVM_INTEL
or KVM_AMD is enabled, but neither is 'y', regardless of the value of KVM
itself.

The documentation for def_tristate doesn't explicitly state that this is
the intended behavior, but it does clearly state that the "if" section is
parsed as a dependency, i.e. the behavior is consistent with how tristate
dependencies are handled in general.

  Optionally dependencies for this default value can be added with "if".

Fixes: ea4290d77bda ("KVM: x86: leave kvm.ko out of the build if no vendor module is requested")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20241118172002.1633824-3-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -18,7 +18,7 @@ menuconfig VIRTUALIZATION
 if VIRTUALIZATION
 
 config KVM_X86
-	def_tristate KVM if KVM_INTEL || KVM_AMD
+	def_tristate KVM if (KVM_INTEL != n || KVM_AMD != n)
 	select KVM_COMMON
 	select KVM_GENERIC_MMU_NOTIFIER
 	select HAVE_KVM_IRQCHIP



