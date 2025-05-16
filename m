Return-Path: <stable+bounces-144601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEEFAB9C52
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 14:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB54188FFA9
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F5B2417E6;
	Fri, 16 May 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJp0rFIw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AED23F421
	for <stable@vger.kernel.org>; Fri, 16 May 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399197; cv=none; b=czq2ZUAIvXOQDQQCry9G5CrGriIUEsaKIbvM2hGMS7zFVAYFtVsJ5HGNcMHshn6kn86iW1YMzZfgy9dB2PFT4ZXteuPDIXKjOyV3DAn5cB+35ZrJRwxTHSzeTnNiUKdKhTD2OcG3UXs+3s/pqrTp71SNANHo0kdUOeFa9iBaETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399197; c=relaxed/simple;
	bh=NmMEnvYRjcgEyI5M5m7hBi79ExciAcqQbeWQvpSCOTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZxwZ3NCsBaU/SwRH7Ec9d6mwv25cMm3TYSWOeh5eASPGdrf0684YckxMTuAnYb/yQjO/C9DB3p2EwZE91xSA4zZeB9WWcwIiRXppWIEu0fiMgi0BNiZOENkr4DHArqM/MaIh00o/JC4hVjztDF4mDC/TIC/7mU4CCRnyr//72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HJp0rFIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747399193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dD4s5BjWgdY0XRygYfoiKVTZtRM5PGr6HfbLhrnOYkc=;
	b=HJp0rFIw/4KdU2ihKrOou43c+zZzN7YDSXQDamf+9ua5o9nNNUdgsvpNMCYApv9L5CTZX/
	+j4rCu135M0zHuLoaf3zVfzAhvneh33tmQNXeDPXs2dkjppDAiH9cqMiLaojI5xu+bakeR
	HpLYbheRVNvFZNK1rcrQV+hl0QcPSH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-vgZ1LjvYOIK-qu4RRI4rYg-1; Fri, 16 May 2025 08:39:52 -0400
X-MC-Unique: vgZ1LjvYOIK-qu4RRI4rYg-1
X-Mimecast-MFC-AGG-ID: vgZ1LjvYOIK-qu4RRI4rYg_1747399191
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a20257c758so1410333f8f.0
        for <stable@vger.kernel.org>; Fri, 16 May 2025 05:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399191; x=1748003991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD4s5BjWgdY0XRygYfoiKVTZtRM5PGr6HfbLhrnOYkc=;
        b=HAOSMkEs5aWWeCokRe6dQ+pJ6qnaf2OMLmgZTAJuh1JWqc7zmW0gdoJAtDFLZERTm9
         KlsLZDxs8WKMe1bGXvcBrbRpdALoSO3Hsvcx4i3SVrlMgPvcje276i9C4W1DJu8zDSwT
         H2th16iUP3UnNQVSLWi94/wvzDtvSBOjd+bSQWOsJ8e/NE91D8skFhajZ2qmI9kNt3WI
         0Ix79MFIKvW9xh2jKXyb+VfWEsEGot8mJ3UUes5sMBU1UGQ2cfYt7aS30139wfFpwo9/
         DWjjQircxrgQ7lzrNcyADHhBaeG464fR+oP67KaVLHW8Q7pGZRZHBR9lG0ZE5Mh2EVMm
         iN2g==
X-Forwarded-Encrypted: i=1; AJvYcCV1CbQVqqdXS6r6aHm0Ng9Dg+bkGjm2ewYjzSEXl7Pt6HmkYc58TZbvaaDF7sCwv+3pS2KGKC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswVVi95mFx2YGcG6M3WwRyVjMlu8aH3Ut+s8E0ajCm/YgB4SK
	1Semxicwpa8ZmbtZcIY3a7fBamr3JEhRLmviTGL1H8KHODIpIds1qe43dUkkIU7haLaWlT1NkMG
	+aJYy/eFZED5DijTwGGzfMMlCMnA8IMhlDusNk4Io8H5PSJcJA1HT4k1r8w==
X-Gm-Gg: ASbGnculQvsQrg1RMF/RVQpeRu6Gk0bDG+FBi9LpYyq6YXKv3JcdHykFSTAoIjTWQuq
	xIXgU1SCAQahoIGZj9mwHnDLIN6RbH31UlFJ64Mk4UR34pbbFBfxNswrTTMAB5Ke/lkwNFhzRtr
	zCKmsfaR9HfAeNcgRq7r3hKl516JErPDkMPf9NUw2f3Izw6Mkx9yQddy02svtb7Cx9s9HfEZQUM
	zdqdgSMTRcv09nHB326F8ULbw3oAv5BeksehsTdaUq1CBbZwlRSYJmYHT7vebimG+4aftMiu1Ux
	dG64EvMAhYXDFKI2L9pfLzF8AhJS21CkEPBdFafKAySRRkFQhI7STnwDXptjhcEHVoMrkeKi
X-Received: by 2002:a05:6000:2305:b0:3a0:7f9c:189a with SMTP id ffacd0b85a97d-3a35c7dd97fmr3453593f8f.0.1747399191333;
        Fri, 16 May 2025 05:39:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv93D7EpnmZ+BrL8Zcx6nM5iZBOF7WC9roZjSuYlsEHMwzBOdkSWq8EgsH051sEEAROR2png==
X-Received: by 2002:a05:6000:2305:b0:3a0:7f9c:189a with SMTP id ffacd0b85a97d-3a35c7dd97fmr3453568f8f.0.1747399190948;
        Fri, 16 May 2025 05:39:50 -0700 (PDT)
Received: from localhost (p200300d82f474700e6f9f4539ece7602.dip0.t-ipconnect.de. [2003:d8:2f47:4700:e6f9:f453:9ece:7602])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca62c70sm2792386f8f.54.2025.05.16.05.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 05:39:49 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Sebastian Mitterle <smitterl@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/3] s390/uv: don't return 0 from make_hva_secure() if the operation was not successful
Date: Fri, 16 May 2025 14:39:44 +0200
Message-ID: <20250516123946.1648026-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516123946.1648026-1-david@redhat.com>
References: <20250516123946.1648026-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/s390/kernel/uv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9a5d5be8acf41..2cc3b599c7fe3 100644
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
-- 
2.49.0


