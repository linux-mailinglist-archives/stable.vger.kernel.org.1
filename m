Return-Path: <stable+bounces-233868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB8WNBtE1mk0DAgAu9opvQ
	(envelope-from <stable+bounces-233868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:03:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BC3BBB28
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12363031CDC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F763B95F9;
	Wed,  8 Apr 2026 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcozcVtG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09433BAD9C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775649720; cv=none; b=R3kXQx0dLuox/EQhOS+3VB+LOe2XpuUChriwUof7dbJokTAs7c+5PA1OiWZM2PwTVlUjMvH0i+Q+nBaEkNA9EoqujP0e11RFskh6fK7S4ql8eiDf/3PsvtsZEhhuD91+aYmWwo5iVWhpniD1/McBmpOL8cJR6ftj41VDW2k+87E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775649720; c=relaxed/simple;
	bh=9NbnFzTEGh6+lE1PwksEW7af7i8jzYb/dCKoYyURmxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phOqv5gHXgV3tv1oMexLJ+qrpf0ZoE0O/WtTocj+ZaKEfOuqbthzc9Jzn+wSfFO+51bPcw70gGkPVmXJ4JuyJufqM9EjxWC0aw5N6M7iz3Q/ICs3ey5OMFumd51mCbGi5oiLkMjDlbgSJObF9aQmWhjeOszasiifVqUoPF9uPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcozcVtG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2851588b3a.3
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775649718; x=1776254518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=FcozcVtG9cxE+N635I6r7uMJ3TvmOLaFn35Phn8ibNkhGn3TjmDONgqxtA9W+dwdvB
         /AAawq1I4g/JIrlXTMFmFRmpGBb0unoUhbUV6F3jYboi83haRf+vUeWbk8D+Q3gH7sbv
         6lFzn3z0h+drRLHGKyllmRKbqEm9/95tcMilqGJoG+xHqlCH0PSVMnv6I20KQlUQRUZI
         EhqbTglBZIubP6SBiOi0aUmbjZPYbiJ6COHfIVGt7Y9x9o9j226uO5biv6wuepQm6SLN
         4nBM7TvNRC//zIWStfk5brec6BIhh5a/XAkOGKq7/WLmsN901gz6J1Pwa3/l4/mU6+DG
         +uOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775649718; x=1776254518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYNm6J9AhUQ6HT8V6B6W7Iuh7E+aasxrExqJ2exyz7U=;
        b=MSBq7ZbXCVaX7pxT1yJNfdH7tADEjlr2k94m4kCtpl9CN+AponiuK95IjmT2GAQbAW
         Yam/b/w5FTdE8LbBrXWqomgyiquFxjXUHRHN+TRQOIKhbtYJY03W9zS48ZsvMFWKVHMb
         n9Rmyxf1XNYNxM7VDBlGeyQqtJI5TOQnK4Ca+BINiDk7RKXZBAgVDpLE62lFmZi4apEs
         q4gCT3nDTrTYCUYFRL7SLijC4T4TTxisJ3tOcDEzOLM3s6kHHWUYqV2BqYuAI98gkZVV
         afC4SX8SL3NK3/G7wXlpJwldgct83/PweTNdKEySrdT/r2JB5nz+SaTaE+JlPl3exehf
         d3yA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/QkNBnL3MVxzonseuu4O+oa7oYpxeRHKKQogSAsKWZJS4J5rvh3qrqJ+wmu0mBuC3c/gyDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+j5ww8J/Y8AeAgaBRCy7eZXNzfZqlu5A3QvxR2AI0xGX6AQO
	rOZ3SRTrZvzWTkKfxKdo4mXvQhWYlUJ6S+JBFiHLOLLZr4tHzaHDrCxz
X-Gm-Gg: AeBDietsipWgKnNtEPv2bX1jHArtWGnCrtvBDr5Z6BkE5NqBCQeXpzjJl6qta6slBcM
	9luQtabDbfiLp5xbD2lhrkUuQbGo5IvvwPKAiwvgMj53GjEsIEqRzuJtTntJplp+NYMpa44Pvbz
	eaOz5l3mngCgQG55lsC1bCrexJ1ZyWkeKlb+VtvlvCdAEr056HLumHEXXsebxBF/CDw0SvYIhDc
	i1U8h6SO264I+W155Yq7H2OJ++3wvi3tTpokh41UqsqTPJK4c+f0B5VW329VlhZiT+JvfZd22gY
	h/zh4hf+rqC78A/FRXAWU6T6XynxjJwngSbVqDEZerVASGMdnqeIBmZ5xBy7kFpkCdlTOmjTiBJ
	R8CetNnB8fGNMMrO8dtQVoA/Drr/EWW4CNZvcMlaX3JOOtROEmSuQZ0VRzW+BSgMHqXZmMJaFuo
	5QW2DiauQlotjP27maZT97FBjY7MeE2NG7hdyFx8DxFQsg
X-Received: by 2002:a05:6a00:92a9:b0:82c:ed02:a242 with SMTP id d2e1a72fcca58-82d0dc05906mr20919689b3a.52.1775649718138;
        Wed, 08 Apr 2026 05:01:58 -0700 (PDT)
Received: from Mac.localdomain ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3e169sm21209322b3a.18.2026.04.08.05.01.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Apr 2026 05:01:57 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Haren Myneni <haren@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [RFC v2 01/10] pseries/papr-hvpipe: Fix race with interrupt handler
Date: Wed,  8 Apr 2026 17:31:31 +0530
Message-ID: <54c52b89a626627aa57191b67a3ee22710b46f7f.1775648406.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1775648406.git.ritesh.list@gmail.com>
References: <cover.1775648406.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233868-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF1BC3BBB28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While executing ->ioctl handler or ->release handler, if an interrupt
fires on the same cpu, then we can enter into a deadlock.

This patch fixes both these handlers to take spin_lock_irq{save|restore}
versions of the lock to prevent this deadlock.

Cc: stable@vger.kernel.org
Fixes: 814ef095f12c9 ("powerpc/pseries: Add papr-hvpipe char driver for HVPIPE interfaces")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/platforms/pseries/papr-hvpipe.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-hvpipe.c b/arch/powerpc/platforms/pseries/papr-hvpipe.c
index 14ae480d060a..c41d45e1986d 100644
--- a/arch/powerpc/platforms/pseries/papr-hvpipe.c
+++ b/arch/powerpc/platforms/pseries/papr-hvpipe.c
@@ -444,13 +444,14 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 				struct file *file)
 {
 	struct hvpipe_source_info *src_info;
+	unsigned long flags;
 
 	/*
 	 * Hold the lock, remove source from src_list, reset the
 	 * hvpipe status and release the lock to prevent any race
 	 * with message event IRQ.
 	 */
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	src_info = file->private_data;
 	list_del(&src_info->list);
 	file->private_data = NULL;
@@ -461,10 +462,10 @@ static int papr_hvpipe_handle_release(struct inode *inode,
 	 */
 	if (src_info->hvpipe_status & HVPIPE_MSG_AVAILABLE) {
 		src_info->hvpipe_status = 0;
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		hvpipe_rtas_recv_msg(NULL, 0);
 	} else
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	kfree(src_info);
 	return 0;
@@ -480,20 +481,21 @@ static const struct file_operations papr_hvpipe_handle_ops = {
 static int papr_hvpipe_dev_create_handle(u32 srcID)
 {
 	struct hvpipe_source_info *src_info __free(kfree) = NULL;
+	unsigned long flags;
 
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
 	 * Do not allow more than one process communicates with
 	 * each source.
 	 */
 	src_info = hvpipe_find_source(srcID);
 	if (src_info) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		pr_err("pid(%d) is already using the source(%d)\n",
 				src_info->tsk->pid, srcID);
 		return -EALREADY;
 	}
-	spin_unlock(&hvpipe_src_list_lock);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 
 	src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
 	if (!src_info)
@@ -510,18 +512,18 @@ static int papr_hvpipe_dev_create_handle(u32 srcID)
 		return fdf.err;
 
 	retain_and_null_ptr(src_info);
-	spin_lock(&hvpipe_src_list_lock);
+	spin_lock_irqsave(&hvpipe_src_list_lock, flags);
 	/*
 	 * If two processes are executing ioctl() for the same
 	 * source ID concurrently, prevent the second process to
 	 * acquire FD.
 	 */
 	if (hvpipe_find_source(srcID)) {
-		spin_unlock(&hvpipe_src_list_lock);
+		spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 		return -EALREADY;
 	}
 	list_add(&src_info->list, &hvpipe_src_list);
-	spin_unlock(&hvpipe_src_list_lock);
+	spin_unlock_irqrestore(&hvpipe_src_list_lock, flags);
 	return fd_publish(fdf);
 }
 
-- 
2.39.5


