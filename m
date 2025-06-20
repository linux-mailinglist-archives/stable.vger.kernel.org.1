Return-Path: <stable+bounces-155024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88EAE16F5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CC54A5EFA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB12027F751;
	Fri, 20 Jun 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFdQKuCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC572356C7
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410336; cv=none; b=BVoRN9+20fr+iA4MGltoQ3V5K8Wq26oNQPaDeE2FBK5Vxo8QkbjqIMJSKIEx8NFv3CCsFLNSZfMBR8XJisRxNd7aFTSWxI2wya5fAuqcYTZUGhotqofRjF3FLzCA06G6zvI8n6bHNETl4/5GxPthj36AeMdTm7VgnRKO9qLQO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410336; c=relaxed/simple;
	bh=KQTCA+mazHe0VR8eBdQf4QZZTpiwxpr0b8gpBFiZxfg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UdVlBus4Pup9mITd/rOOcqho/2+RkRqkxhLBTpfa3nkLf0cL/WI0RkPrvgxpdHEP5PCP+pzBGsqkMoiECJ8DvMYBBP1DayykNEBfucXJns8UoUhWRNS0TEvk2XdvLu8fgP39oQbQ7JVVYEFMblqms/48YHyKYXxy5/WicDVV76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFdQKuCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9150C4CEE3;
	Fri, 20 Jun 2025 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410336;
	bh=KQTCA+mazHe0VR8eBdQf4QZZTpiwxpr0b8gpBFiZxfg=;
	h=Subject:To:Cc:From:Date:From;
	b=gFdQKuCx5mvYQcgoAd7SFi3MEeKpk79Fkd71A0pn5mZgdOP9TpI5f5sj1DUzMxyYs
	 Vkh9TqCf6Wxt46t2z6GreOjE9doiIivlHoLIONas4JZ17v/GHflujEK7WdavwTQckE
	 sxRppPKiYTDMtdP2zWa5TAE61uToXWxSF59ULsuU=
Subject: FAILED: patch "[PATCH] s390/uv: Don't return 0 from make_hva_secure() if the" failed to apply to 6.15-stable tree
To: david@redhat.com,imbrenda@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:05:33 +0200
Message-ID: <2025062033-retold-crinkly-e6e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3ec8a8330a1aa846dffbf1d64479213366c55b54
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062033-retold-crinkly-e6e3@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ec8a8330a1aa846dffbf1d64479213366c55b54 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 16 May 2025 14:39:44 +0200
Subject: [PATCH] s390/uv: Don't return 0 from make_hva_secure() if the
 operation was not successful

If s390_wiggle_split_folio() returns 0 because splitting a large folio
succeeded, we will return 0 from make_hva_secure() even though a retry
is required. Return -EAGAIN in that case.

Otherwise, we'll return 0 from gmap_make_secure(), and consequently from
unpack_one(). In kvm_s390_pv_unpack(), we assume that unpacking
succeeded and skip unpacking this page. Later on, we run into issues
and fail booting the VM.

So far, this issue was only observed with follow-up patches where we
split large pagecache XFS folios. Maybe it can also be triggered with
shmem?

We'll cleanup s390_wiggle_split_folio() a bit next, to also return 0
if no split was required.

Fixes: d8dfda5af0be ("KVM: s390: pv: fix race when making a page secure")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250516123946.1648026-2-david@redhat.com
Message-ID: <20250516123946.1648026-2-david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9a5d5be8acf4..2cc3b599c7fe 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -393,8 +393,11 @@ int make_hva_secure(struct mm_struct *mm, unsigned long hva, struct uv_cb_header
 	folio_walk_end(&fw, vma);
 	mmap_read_unlock(mm);
 
-	if (rc == -E2BIG || rc == -EBUSY)
+	if (rc == -E2BIG || rc == -EBUSY) {
 		rc = s390_wiggle_split_folio(mm, folio, rc == -E2BIG);
+		if (!rc)
+			rc = -EAGAIN;
+	}
 	folio_put(folio);
 
 	return rc;


