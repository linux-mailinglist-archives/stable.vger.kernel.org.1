Return-Path: <stable+bounces-20697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2193A85AB54
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82405B22CDD
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD3482F4;
	Mon, 19 Feb 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mj1W/YZ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8142481DB
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368208; cv=none; b=TejYFni/hoZTwphaPoE4/h78MRsbidga7BKm7yEZO0OndTjvQ9ImNmoxRyDqsHmhXN3LRGFa2ETVxy4HLo/lin+tyQY8MPdANB7GIuUPJwtyCge3NRjEVXu1JKnXGOJY6ywaWcNEcMQeLp7a3AAeMc8ehMeHNGXiVzmw9Tl+oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368208; c=relaxed/simple;
	bh=10fHnt4mZNGW4YRJV5OdDQQ4HK9aZMTNAkJIHMFO1pw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CXz6ZoSy9YOzn3niyKc7hIE4uKRH2Sol2+J22StSI35iW++tER1yr/2C3b0ZAY4gVbO6J6Y+Bn62IuNsyZ6KfVl44qpXTSpI06B+nq0ANwadaL1cDDE4HCKh8dsxC1uowPF+Y+iyQWB9WBk4EUDCII/gc1IRiq56A6j1eyiC/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mj1W/YZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F89FC433F1;
	Mon, 19 Feb 2024 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368207;
	bh=10fHnt4mZNGW4YRJV5OdDQQ4HK9aZMTNAkJIHMFO1pw=;
	h=Subject:To:Cc:From:Date:From;
	b=mj1W/YZ3paM05g/+YMrbdMYocJuyCZlAru3ooCM5gJacAPTN374zk0idvsda6t1l1
	 RNJn0/y1q+d0/EviukdibMpWGpQw/Cm61ku68kZCP8IoBtMFzJiQ+USCfjxrHXQFaJ
	 KLXvZx6ZFubCPNNRwBfM2vjGmYeXTHZe85IQt2ZE=
Subject: FAILED: patch "[PATCH] KVM: s390: vsie: fix race during shadow creation" failed to apply to 4.19-stable tree
To: borntraeger@linux.ibm.com,david@redhat.com,frankja@linux.ibm.com,imbrenda@linux.ibm.com,mhartmay@linux.ibm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:43:09 +0100
Message-ID: <2024021908-spooky-conductor-a78c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x fe752331d4b361d43cfd0b89534b4b2176057c32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021908-spooky-conductor-a78c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

fe752331d4b3 ("KVM: s390: vsie: fix race during shadow creation")
c3235e2dd695 ("KVM: s390: add stat counter for shadow gmap events")
0130337ec45b ("KVM: s390: Cleanup ipte lock access and SIIF facility checks")
73f91b004321 ("KVM: s390: pci: enable host forwarding of Adapter Event Notifications")
98b1d33dac5f ("KVM: s390: pci: do initial setup for AEN interpretation")
6438e30714ab ("KVM: s390: pci: add basic kvm_zdev structure")
062f002485d4 ("s390/pci: externalize the SIC operation controls and routine")
d2197485a188 ("s390/airq: pass more TPI info to airq handlers")
61380a7adfce ("KVM: s390: handle_tprot: Honor storage keys")
e613d83454d7 ("KVM: s390: Honor storage keys when accessing guest memory")
79e06c4c4950 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

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


