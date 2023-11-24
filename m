Return-Path: <stable+bounces-1968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0277F8231
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795D2B235FA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10BC364A7;
	Fri, 24 Nov 2023 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rGfPUtMH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F66A3173F;
	Fri, 24 Nov 2023 19:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F783C433C8;
	Fri, 24 Nov 2023 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852721;
	bh=IOOiPyRqNrW70f2wfNP9GxYqqWA28FWPPMJOO/xT2HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGfPUtMHcb8QIff6QrYnVoyqULscdEi3wVtFt1deQ7PJJNB+mQ2O/qJv8Arpyjmxu
	 n/8SXufvnC81v8mtHhg34owfpO0pb4a4Ycc7qWg7PlqQfuepTzuNVUgCd4sypOKCyf
	 Rigkm7QNH06ZVfNyKBcQM0EaRN3Ea4yulDmKtXas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10 097/193] KVM: x86: hyper-v: Dont auto-enable stimer on write from user-space
Date: Fri, 24 Nov 2023 17:53:44 +0000
Message-ID: <20231124171951.145865091@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Saenz Julienne <nsaenz@amazon.com>

commit d6800af51c76b6dae20e6023bbdc9b3da3ab5121 upstream.

Don't apply the stimer's counter side effects when modifying its
value from user-space, as this may trigger spurious interrupts.

For example:
 - The stimer is configured in auto-enable mode.
 - The stimer's count is set and the timer enabled.
 - The stimer expires, an interrupt is injected.
 - The VM is live migrated.
 - The stimer config and count are deserialized, auto-enable is ON, the
   stimer is re-enabled.
 - The stimer expires right away, and injects an unwarranted interrupt.

Cc: stable@vger.kernel.org
Fixes: 1f4b34f825e8 ("kvm/x86: Hyper-V SynIC timers")
Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20231017155101.40677-1-nsaenz@amazon.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/hyperv.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -674,10 +674,12 @@ static int stimer_set_count(struct kvm_v
 
 	stimer_cleanup(stimer);
 	stimer->count = count;
-	if (stimer->count == 0)
-		stimer->config.enable = 0;
-	else if (stimer->config.auto_enable)
-		stimer->config.enable = 1;
+	if (!host) {
+		if (stimer->count == 0)
+			stimer->config.enable = 0;
+		else if (stimer->config.auto_enable)
+			stimer->config.enable = 1;
+	}
 
 	if (stimer->config.enable)
 		stimer_mark_pending(stimer, false);



