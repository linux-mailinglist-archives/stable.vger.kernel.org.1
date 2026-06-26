Return-Path: <stable+bounces-269249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFN6EAO8PmqhKwkAu9opvQ
	(envelope-from <stable+bounces-269249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:50:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B96BD6CF7B6
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:50:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=L6GLdo6g;
	dkim=pass header.d=redhat.com header.s=google header.b=i729tSem;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269249-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269249-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13FD33032F5D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D269327BEC;
	Fri, 26 Jun 2026 17:46:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627439A06C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:46:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496007; cv=none; b=aKQR81pkD170GohLkP45fjfIQYH/2HOSURyjbeb5DHjEiCN6aAlQuYiGQRx1qhRGMW3o6v8eHPMmOi0yMfS6IEG4uOpNpiHKzq062FmBa62HyjSf6UXDh0vYWpOpZvHEcjXGzhxqDMDPKwEnFcFd43ZHthVDgDMvmbiMq23Vosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496007; c=relaxed/simple;
	bh=p+3Gwz6AyziYJJ9CXfquciLU3UkNoURa4qIotaW5/00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvxXhsMZEYpTXUYEJSHXFIbdvnZvDUutIX+8Lwg6W/J+15haU39xXWHMf63TSjfz8VDWRc/M9ksb37mYdyl2cjxTfxbaBZGc3UHbAGcAIzW0aXX5dqOH5dlfBqoHtVTaoDaDxCbTgTE0izn2mn5puJNx5fR6je+ELYR6EXCXs7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6GLdo6g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i729tSem; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782496005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
	b=L6GLdo6gSdfVhf/YIWBqjCNBto6YbQR6D6CyfoIvUVHi8WDW3wNQxekdgPmBImNRUrDVD/
	cU9eeunDKxo79CJpHoh73vTQr7B0aTuSg6MFMCVekYBf1wluNYIiRqhhJA2kc/KEXofXuP
	q4ZtjIhQT5thQwA/VN5d8fk9vl/Fn1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-KCZ4ToaWNHWaLsT_ofCjUQ-1; Fri, 26 Jun 2026 13:46:43 -0400
X-MC-Unique: KCZ4ToaWNHWaLsT_ofCjUQ-1
X-Mimecast-MFC-AGG-ID: KCZ4ToaWNHWaLsT_ofCjUQ_1782496003
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-469218e618dso581783f8f.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782496003; x=1783100803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
        b=i729tSemJXCtrs1uEezMWJeIpbEIPsZbOlDbIb7Qy4FoQ+Amdk+2FC5+UbpzKMamgs
         jl2BfkY2Dwwe+T5mQzR9fvjVt7ae9KcGt0qlMIOpp+khKyCexY8WBxnM7HzoAiLtc0bt
         EM4x2cdlpn8Tn8uZQO1z4O52CDmHONDoFprx53n+jCvdwo1Je09jS1tqT8SfXZ13RfiX
         qJTrDyX6GFxGNDzCATaL9vXWjckZBR9tksj+t+i7OHKrdd6VmWKRpfjdFkmzaBPS3x8G
         IohE6ZjoYOkYwhi1pD0bx4+Zc7+skdRRwVjObRI/NefjuiUYx9w8B+aGDblq0oR236ld
         7unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496003; x=1783100803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
        b=Qy5XmSKJThl9ZkJqOnQLjDvNlUjfnL3fClWcQlkUvJlf39HNUZBpzIOpdBZJREq0eC
         WZREPWCVzZMRc8/7mVssQdLw5hH5wwpu+etT7UvNHSjS9wuqjxKF1zhVP8Ev5X3jpxmk
         3pc+LdvDfyUZOFesFGiPF0QB7/cVQKy9qTGrqtS78zqePNhMLEhJ5cM3yLvCIAVYS1fX
         KINasC15ZYyBaE3nmrIL5XsU9FD/PmvVSW3KRO37kvFn3vIa6elw4Ei/HcQ7ULJvnvVt
         9xVevYWBa5RJr7fKFzKObvrKMbtPe2+XB93qi1aPzoUb7LKNnk3x5hFdM+TNSROsM8je
         6Ghw==
X-Forwarded-Encrypted: i=1; AFNElJ+RzMk6dMMn3JtgL2GaDrUtSSXV6A1nmZ1GvZHT4iKxdF0yr1z69MFpyYSOCyFTBVRpSaZGKgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmKTIepF+0zSTxXsh77uUqmT/kAGEOUwv8S5Rh8ap43t5ST5Bc
	SU2BFTH/A1XWY1lDBxx3G4LN9qwkDqmas9/86EqlRDPg7zPVV/v1+miysKsWNtpaBhwojim1AzN
	Ze/0oEl/bpFBk38pxni5i0hfrwGoGRXrlc1jfN0+8r7kvwTQLHOEC9+JNFg==
X-Gm-Gg: AfdE7cmx8d+N13w7SSAWZ7lSIH0TArn5TMSDNSks7JXL20AIgADfQ4FeXt+TgmoG7em
	XrpmII76WMvAtr6DQFZirog9i7FVIXGLfwwA/KgNAFlG+sC38Lvs9m3zDYJksAgxtxIEcGgtxfd
	DE9QIYZoOlL+EZwGIuT0/uKATKkFp/qZzKvqkk9dcj85qj99TgOdKDBjWz9+9EOIzXpX8Qs1sIv
	SjnNwRjUWjbayA1iQFvxNTYvRmqNcVZp2R1kqexEvSG4m2Td+6l/+Ws6p2azaCus34ulYRGJeV0
	jtBZVZETUVrQ3yj08wlVIHesF/PSu6RP4aoLApcxgHEdocx/aqOxiBICqtNxqQvUEVFhCrdEoTv
	gugB2nODf44e/VMN0xjWEMpA1ShU3ambSCgjhdA/alwE6P+u0cDhmUlRv01rV6zGur44p6CoXER
	2eK/4J+8Rh4i7AcMfx
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr30083645e9.24.1782496002729;
        Fri, 26 Jun 2026 10:46:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr30083255e9.24.1782496002330;
        Fri, 26 Jun 2026 10:46:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fef710sm165199095e9.7.2026.06.26.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 5.15.y v2 7/8] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 19:46:18 +0200
Message-ID: <20260626174620.1819772-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626174620.1819772-1-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269249-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:imv4bel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B96BD6CF7B6

Commit 0cb2af2ea66ad ("KVM: x86: Fix shadow paging use-after-free due
to unexpected GFN") fixed a shadow paging mismatch between stored and
computed GFNs; the bug could be triggered by changing a PDE mapping from
outside the guest, and then deleting a memslot.  The rmap_remove()
call would miss entries created after the PDE change because the GFN
of the leaf SPTE does not match the GFN of the struct kvm_mmu_page.

A similar hole however remains if the modified PDE points to a non-leaf
page.  In this case the gfn can be made to match, but the role does not
match: the original large 2MB page creates a kvm_mmu_page with direct=1,
while the new 4KB needs a kvm_mmu_page with direct=0.  However,
kvm_mmu_get_child_sp() does not compare the role, and therefore reuses
the page.

The next step is installing a leaf (4KB) SPTE on the new path which
records an rmap entry under the gfn resolved by the walk.  But when
that child is zapped its parent kvm_mmu_page has direct=1 and
kvm_mmu_page_get_gfn() computes the gfn for the 4KB page as
sp->gfn + index instead of using sp->shadowed_translation[] (or sp->gfns[]
in older kernels).  It therefore fails to remove the recorded entry.

When the memslot is dropped the shadow page is freed but the rmap
entry survives, as in the scenario that was already fixed.  Code that
later walks that gfn (dirty logging, MMU notifier invalidation, and
so on) dereferences an sptep that lies in the freed page, causing the
use-after-free.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c9656b8062e..e9dbe3e7ec62 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2175,13 +2175,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
 						 bool direct, unsigned int access)
 {
-	union kvm_mmu_page_role role;
+	union kvm_mmu_page_role role = kvm_mmu_child_role(sptep, direct, access);
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
-	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
+	if (is_shadow_present_pte(*sptep) &&
+	    !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) &&
+	    spte_to_child_sp(*sptep)->gfn == gfn &&
+	    spte_to_child_sp(*sptep)->role.word == role.word)
 		return ERR_PTR(-EEXIST);
 
-	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_page(vcpu, gfn, role);
 }
 
-- 
2.54.0


