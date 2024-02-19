Return-Path: <stable+bounces-20692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629D85AB4D
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFD3283A38
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA65D482FA;
	Mon, 19 Feb 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DEljFADL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933F5697
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368186; cv=none; b=MwRWVJFqVuqdxHio7GNm66vqEMTGjmcOQahgL/HDzlMNUBHwj1ix6Kaf+XKHvAb0QRWcVy+6rS0vpCcDW6kFX7kFtIlv03uS0F6oDGbcarGqVNFrhdz9WuJ8JfqccCJ0RLsGtmIz2qN6WdN6l9x33W36J7U6Kq7yP8Q5i7zUp/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368186; c=relaxed/simple;
	bh=TedoXiwkTipHYsnz4kBQXkMlrmFrWUwf0guxL2hnt1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MJeM5lXMTkQ9ZV8XpTycVgr6DQr75/4zAWQHyzi2/eNwMlsYdLeBK/RIiMM0KCgjtK59DvZ67rm37eF/JA8vIAlu6+GkHHRnWIOqUDJTyoCG0slQqTm1FEyOxyWdMwmTRYcIydeZwWJR0lHNBCTXuyuGepg/DCXrWzd2b6AP3WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DEljFADL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D97C433F1;
	Mon, 19 Feb 2024 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368186;
	bh=TedoXiwkTipHYsnz4kBQXkMlrmFrWUwf0guxL2hnt1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=DEljFADLgWGvEM3RMgOKCVZUT+X7IY2VjbLT457+sehpb8bMM8wRyCjRWgpZrkr64
	 LW2GGEzmerK/ysZqW2MRXbyvuqvVJv+PURgcBdjgBkjjENIcSLFCidqLnJ0am0Ls7k
	 7h8f1hs/wiwh9N8Z/kEUwwSLqhGZvslK3aJYC1PI=
Subject: FAILED: patch "[PATCH] KVM: s390: vsie: fix race during shadow creation" failed to apply to 6.6-stable tree
To: borntraeger@linux.ibm.com,david@redhat.com,frankja@linux.ibm.com,imbrenda@linux.ibm.com,mhartmay@linux.ibm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:43:03 +0100
Message-ID: <2024021903-knapsack-change-c3a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fe752331d4b361d43cfd0b89534b4b2176057c32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021903-knapsack-change-c3a4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

fe752331d4b3 ("KVM: s390: vsie: fix race during shadow creation")
c3235e2dd695 ("KVM: s390: add stat counter for shadow gmap events")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe752331d4b361d43cfd0b89534b4b2176057c32 Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@linux.ibm.com>
Date: Wed, 20 Dec 2023 13:53:17 +0100
Subject: [PATCH] KVM: s390: vsie: fix race during shadow creation

Right now it is possible to see gmap->private being zero in
kvm_s390_vsie_gmap_notifier resulting in a crash.  This is due to the
fact that we add gmap->private == kvm after creation:

static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
                               struct vsie_page *vsie_page)
{
[...]
        gmap = gmap_shadow(vcpu->arch.gmap, asce, edat);
        if (IS_ERR(gmap))
                return PTR_ERR(gmap);
        gmap->private = vcpu->kvm;

Let children inherit the private field of the parent.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Cc: <stable@vger.kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Link: https://lore.kernel.org/r/20231220125317.4258-1-borntraeger@linux.ibm.com

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 8207a892bbe2..db9a180de65f 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1220,7 +1220,6 @@ static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
 	gmap = gmap_shadow(vcpu->arch.gmap, asce, edat);
 	if (IS_ERR(gmap))
 		return PTR_ERR(gmap);
-	gmap->private = vcpu->kvm;
 	vcpu->kvm->stat.gmap_shadow_create++;
 	WRITE_ONCE(vsie_page->gmap, gmap);
 	return 0;
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 6f96b5a71c63..8da39deb56ca 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1691,6 +1691,7 @@ struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 		return ERR_PTR(-ENOMEM);
 	new->mm = parent->mm;
 	new->parent = gmap_get(parent);
+	new->private = parent->private;
 	new->orig_asce = asce;
 	new->edat_level = edat_level;
 	new->initialized = false;


