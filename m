Return-Path: <stable+bounces-185650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B429BD96E3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B613A4115
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79966313E01;
	Tue, 14 Oct 2025 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FILiOJ2K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15D313E06
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445904; cv=none; b=f80uP8Mm8hyzklxVnGn2D/YICRdDkBLeC7g3//A1to2NWKwjXXbslpVr/OzYJwnGRHfeC4MtiRZZrIRv6KTv3XOeur0IawcKWlt+5GVqyGMJ8QsAuZpiW5Elo3ypJ+SCAN+bcprJI1TWsx2HesINHZWkziRoShjqJeK+0VTSHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445904; c=relaxed/simple;
	bh=IrdiHcJ9N5g16Q3ASpx314J/26lOuQJs6WEhZdyqT3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVaBWJxQWJnTnv7+zn2R+f6R5q6sOrNeP7T9jpvbkvuXb0mBSSubsbnF7+X8IEM6SgkHYp9uocPqp+nqs2u3/8AX4Ofovn46a8+ML7ViA53riG2cfM/j5iegMo+ekXZzIKcPSs1TCheVV26Z3Tcs2LDlCdcGqPPr+RDawzN1hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FILiOJ2K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760445900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oq5FU6UUWvw2KLYz4msTSjy80Lvwg4TbSIDB93lwHNo=;
	b=FILiOJ2KE0GykacXyD6iUmL+TpbK3IKaJtGMEfccgphe+9CYoRUes68QzyEyKIxlC0ZuUU
	x32BgbI3gnKRTpyMTsvP3paHypL9NAw/Cb+oYUI/VJ6mIdjcZhGJRu1fTHbqjyCiGbWGts
	jMv4/XnEerPUl2vx88ImjvTnLPcVSDI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-ijEUjAcuNaWOaDBlliTosQ-1; Tue, 14 Oct 2025 08:44:59 -0400
X-MC-Unique: ijEUjAcuNaWOaDBlliTosQ-1
X-Mimecast-MFC-AGG-ID: ijEUjAcuNaWOaDBlliTosQ_1760445898
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-401dbafbcfaso4191492f8f.1
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 05:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445898; x=1761050698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oq5FU6UUWvw2KLYz4msTSjy80Lvwg4TbSIDB93lwHNo=;
        b=KW+032tDEQS2cRgFPAwLEKs5LZ475pS51nEplOMXHQGS2G0YN2UA7I2vbCMBI60Fta
         VL7BbAf1YFzNKloHPLhGVHGQAF3SoBsmPo2D3mgYN2OE7VlmNUOIR6HowBATX7jzKOQy
         Lan4qB+avOaEjJW9r2hD6tZqtcsIDTaa21x0aASzVvV7nXGxaRYiOaJWqg9EvJJmCna2
         hAc5402YI/wSxh39S5hsor3LpmuDSzzDzSX+tTKc5gCZQJLEQnYsD1xDiLFE+0hO0L2F
         VAe89L87jpBdxXc9qhyaf+8sktJYFDPUt2xyMbSnumnYbsbq/EO3pHXJFjRjSRybGviK
         6vKw==
X-Forwarded-Encrypted: i=1; AJvYcCW28k+CLKI9V1anKA4w1xSvvlRNB0TGC2AJgF+EOyblPb2M9TP5vxjT3yAa7B5Fm6Q84C3OOdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztvaL+gAAgXIcUZQq3HAkE0X54KGYEgg6GTwP7Rl1kx/Z0bCWQ
	iq2aOP7vFgytD4YJcJFgAuF6mve6Ci49aMFsiSwhLhC/SNCZDMqVneyWV3tkDEI7bK7Dtc/Gibn
	4ZBtbtaBDxm9Lj82EuqwP6Pkrqn9jLMepycsc8Zk8xG8/Pt6K9fyUVgR52Q==
X-Gm-Gg: ASbGncsX+e1arxtnw3qP3Ayp8lglVU/wga5py8F1NXwn/QAl6f3tqp2OI3yZsQ7+zfw
	0hDYCWb9oVmxzqIc1AQd3iqloSQScepy98khS0Ge605p4Lt3IIZHlP2yW4yJlo/8s4OlAs2vPVY
	29tf6IMrSAPmB/UqzFwrHjxji7fPa6jhFyDr2JPT8g9qufGu8gnFFMFmZwok4QwSMIxrFi9e+NK
	XHybk9NWaVnQ+6SeFBvkrnbDqFwwl2Flp9+HUyHXIBNzUlOIxpqJ9tX6J2lvevL5fZDkFmuIZTa
	apNGnwasglVfdJHvsPEtO3+S067Ku0foKO0=
X-Received: by 2002:a05:6000:2003:b0:3eb:5e99:cbb9 with SMTP id ffacd0b85a97d-42666ac410emr16251744f8f.10.1760445897966;
        Tue, 14 Oct 2025 05:44:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxSeyruCmc9SGR2jeGa4d8IULuUIdP5u2aBzan4Fq5iEL1yjTsOV2vBHOnBmYhi1j6hNaRzA==
X-Received: by 2002:a05:6000:2003:b0:3eb:5e99:cbb9 with SMTP id ffacd0b85a97d-42666ac410emr16251717f8f.10.1760445897499;
        Tue, 14 Oct 2025 05:44:57 -0700 (PDT)
Received: from localhost ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426e50ef821sm8878961f8f.38.2025.10.14.05.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 05:44:56 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1] vmw_balloon: indicate success when effectively deflating during migration
Date: Tue, 14 Oct 2025 14:44:55 +0200
Message-ID: <20251014124455.478345-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When migrating a balloon page, we first deflate the old page to then
inflate the new page.

However, if inflating the new page succeeded, we effectively deflated
the old page, reducing the balloon size.

In that case, the migration actually worked: similar to migrating+
immediately deflating the new page. The old page will be freed back to
the buddy.

Right now, the core will leave the page be marked as isolated (as
we returned an error). When later trying to putback that page, we will
run into the WARN_ON_ONCE() in balloon_page_putback().

That handling was changed in commit 3544c4faccb8 ("mm/balloon_compaction:
stop using __ClearPageMovable()"); before that change, we would have
tolerated that way of handling it.

To fix it, let's just return 0 in that case, making the core effectively
just clear the "isolated" flag + freeing it back to the buddy as if the
migration succeeded. Note that the new page will also get freed when the
core puts the last reference.

Note that this also makes it all be more consistent: we will no longer
unisolate the page in the balloon driver while keeping it marked as
being isolated in migration core.

This was found by code inspection.

Fixes: 3544c4faccb8 ("mm/balloon_compaction: stop using __ClearPageMovable()")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

I have no easy way to test this, and I assume it happens very very rarely
(inflation during migration failing).

I would prefer this to go through the MM-tree, as I have some follow-up
balloon_compaction reworks also mess with this code.

---
 drivers/misc/vmw_balloon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 6df51ee8db621..cc1d18b3df5ca 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1737,7 +1737,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 {
 	unsigned long status, flags;
 	struct vmballoon *b;
-	int ret;
+	int ret = 0;
 
 	b = container_of(b_dev_info, struct vmballoon, b_dev_info);
 
@@ -1796,17 +1796,15 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 		 * A failure happened. While we can deflate the page we just
 		 * inflated, this deflation can also encounter an error. Instead
 		 * we will decrease the size of the balloon to reflect the
-		 * change and report failure.
+		 * change.
 		 */
 		atomic64_dec(&b->size);
-		ret = -EBUSY;
 	} else {
 		/*
 		 * Success. Take a reference for the page, and we will add it to
 		 * the list after acquiring the lock.
 		 */
 		get_page(newpage);
-		ret = 0;
 	}
 
 	/* Update the balloon list under the @pages_lock */
@@ -1817,7 +1815,7 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
 	 * If we succeed just insert it to the list and update the statistics
 	 * under the lock.
 	 */
-	if (!ret) {
+	if (status == VMW_BALLOON_SUCCESS) {
 		balloon_page_insert(&b->b_dev_info, newpage);
 		__count_vm_event(BALLOON_MIGRATE);
 	}

base-commit: 1c58c31dc83e39f4790ae778626b6b8b59bc0db8
-- 
2.51.0


