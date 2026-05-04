Return-Path: <stable+bounces-243906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PCBQKpf5+Gkr3wIAu9opvQ
	(envelope-from <stable+bounces-243906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:55:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F135A4C360D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 21:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D5E3301D32C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 19:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CE3EF674;
	Mon,  4 May 2026 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdg7x25y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC73E2756
	for <stable@vger.kernel.org>; Mon,  4 May 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777924500; cv=none; b=fLcYS133lfsLbL5gamQeOyZb2rUYMAoCH9RS8aglvVjL8rfk2s2XWumaAmoU+rn67sVYXmBKQfQLS+oimAcvJoqPS1tSCZRjuevq8bHuWnYCgqGHGqFVdLa3n5xh8EXvnIc3pN3NSMu5AKNVgMIvGnQePqfOkMCrRgagpva9R2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777924500; c=relaxed/simple;
	bh=qOxZwAzYuutAK04f6tS2GHcGvRNV0RK8BWtRC5bkWUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMXn4DuVgcNzflB5yQG0/ax7wNKc+6h7WD+inBeaIFF0Mbd5MvAOpr+sX6ksOrP+7zLcgsHALqmOmvCmRxZsHEolRVAQYhreIqS8LSRcP08cEqTseXwcmhVaCUBylyQAFYhp1bbutme0NnFayuiFRbIBYaL/IHaUhnMGwiod8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdg7x25y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so3558153f8f.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777924498; x=1778529298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erT6UBqquuMP02SpaxioEEnOQAd0rZiSq9AXy326h74=;
        b=Pdg7x25y2qdPcpATWxts5QD7Iqn0HTNg2ppnvxs2QCaQgYPjOkaTCyO1kxwbSYclag
         SPfnDH5k/w5bG5UEBwTP/9idlSJXmBFfj6bvv261ypSZUizfdHqNR/+vEDb2G4yGsuNh
         j4UPLxgi/DSS99s/blAbhaGq6fysGxnwX7Jyty20K08azCRFMN7JAa99f5yvVOQCHjXJ
         zo43r4mx2vTIt5U9Lvf7nBzaRZuveKCEx4kdOpaL6xTsBoLym5wtQs7iKfW4SVR5Rv3q
         b3MEVf0YHbm4geNPhoQv1Yame959pDYJGxlYOyVw/o9GzFj6w111CsaYotlU5ywUZp1z
         TqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777924498; x=1778529298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erT6UBqquuMP02SpaxioEEnOQAd0rZiSq9AXy326h74=;
        b=RXYZZsKFAEBt8eMunYK1tEKpfQ78FXnGAyZuor1NZBYJcP3EQlSHQhxmsMMFtTQFBg
         KGVsegHCfZhPEcOXHQ/I8LVpj/TAybWabKMAZz/2PjobfVu4mwAd18Oizd8jvVj0+UQM
         39iPJHOou7yOZjvdDS1KMUcXpYDM9iUwdVxAsevWCYFOmi0AN3WBzFqXE42R88p4NC4V
         ZjsIX5vCzSiTJdr9CEqFMnbOt4baQtIqFaxE3YoNfMO9yL1JHxGDW64z9hpRg2WQ9qT8
         7O+6oWf9C+NsJa7iRylB40gFvuaQNLm4xdGCgvHHNhYE7ObvbXpeXieImF2FSNWxWHFT
         EIFg==
X-Gm-Message-State: AOJu0YwLCTuKz1iVL3Z2OYkm6VvCaAADbQduRgkjw696hD8FO22KrYe+
	35PLPY3+ANG9GduyFYycqJ+XbyuZhGOmI8PUvEHo/o8h3KYKItG+jLqa
X-Gm-Gg: AeBDieustgcMKzOs/ycWUY8FioBhA+geLWUWbCRD/i1FC0Derylv+JSxSzrqmoVBBgK
	597kcM3gorM0T51TZwkNXnNYJG2OUkAvGPqav4v9/gagGNiz9xvrnAOjG0/UL2BslARosdNvA9Z
	3K1fkgqmwmsBCih4UNC2aX5y6x0z06q4SxgyLx1Wtj1Du5hcJs8Hx6q0JxamWPwJsImJzYENy9T
	/TkszyE0CiaRVQHSC3mgfqHNLtAlWd78Pa0FT0NTmHH1IWQpyMSzV/abNhXjBZ3iEaKmwYpqvxi
	lhlKgCKx+sMeCGdo7flxRe/chANuS6R4sk7aZ/pPGfv2P4bl7dwAy/nPbyNt2iKQcewDQuUalWS
	jXHkX1PakLqzRQN2LSUqyOJmFMHE/l+SM0BBYDG8L/QOC+DrbLl5CKBMt0sxbbSfynPoRja36hh
	BDcvMkofw+Vj5+RJRbb+qZ4wIlDZ++vJ0vecHZMmIh
X-Received: by 2002:a05:6000:228a:b0:43f:df1b:9e07 with SMTP id ffacd0b85a97d-44bb6ab19c2mr18028339f8f.42.1777924497759;
        Mon, 04 May 2026 12:54:57 -0700 (PDT)
Received: from fedora ([156.207.149.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4500f8ce84csm275794f8f.19.2026.05.04.12.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:54:57 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH 6.18.y v3] mm: fix VM_SOFTDIRTY propagation on VMA merge
Date: Mon,  4 May 2026 22:54:47 +0300
Message-ID: <20260504195447.31794-1-elaidya225@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CANaxB-xFcF7U=wJv8EqKy=j=-P3SN+sLQ9ytH8Ej69h03tqL8Q@mail.gmail.com>
References: <CANaxB-xFcF7U=wJv8EqKy=j=-P3SN+sLQ9ytH8Ej69h03tqL8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F135A4C360D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243906-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linux-foundation.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

During VMA merging, such as through mprotect(), VM_SOFTDIRTY flags could be
lost. This breaks tools relying on soft-dirty tracking, such as CRIU
incremental dump/restore.

Upstream resolved this using a broader VM_STICKY infrastructure (commit
bf14d4a05387 "mm: propagate VM_SOFTDIRTY on merge"). To minimize churn and
risk in the stable 6.18.y tree, this patch skips backporting the entire
VM_STICKY series (9 patches). Instead, it introduces a minimal standalone fix.

VM_SOFTDIRTY is intentionally excluded from normal flag comparison to allow
merging in mprotect and mmap. This patch ensures the resulting merged VMA retains
the VM_SOFTDIRTY flag if either of the original VMAs had it.

Fixes: 34228d473efe ("mm: ignore VM_SOFTDIRTY on VMA merging")
Suggested-by: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org # 6.18.x
Cc: lorenzo.stoakes@oracle.com
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 mm/vma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index 5815ae9e5770..2988f6b3feff 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -978,6 +978,14 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
+	/*
+	 * VM_SOFTDIRTY is excluded from normal flag comparison to allow
+	 * merging in mprotect, but we have to ensure the result is correctly
+	 * marked with it if either side had it.
+	 */
+	if ((vmg->target->vm_flags ^ vmg->vm_flags) & VM_SOFTDIRTY)
+		vm_flags_set(vmg->target, VM_SOFTDIRTY);
+
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1098,6 +1106,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	 * following VMA if we have VMAs on both sides.
 	 */
 	if (vmg->target && !vma_expand(vmg)) {
+		/*
+		 * VM_SOFTDIRTY is excluded from normal flag comparison to allow
+		 * merging, but we have to ensure the result is correctly
+		 * marked with it if either side had it.
+		 */
+		if ((vmg->target->vm_flags ^ vmg->vm_flags) & VM_SOFTDIRTY)
+			vm_flags_set(vmg->target, VM_SOFTDIRTY);
+
 		khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 		vmg->state = VMA_MERGE_SUCCESS;
 		return vmg->target;
-- 
2.54.0


