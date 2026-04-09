Return-Path: <stable+bounces-235430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDt9O+PH12n6SwgAu9opvQ
	(envelope-from <stable+bounces-235430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:38:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B58043CCD4A
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 17:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C78C73082A32
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ADF3E3145;
	Thu,  9 Apr 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SHcTFoW2"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD43DFC90
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748514; cv=none; b=MRtKe3QMQI+nEnYNtVLbVOln3494D5cockpEDxXfRnrVOcdGqC+TYVIfebu00w0tSU/LRauUlTRv/LGxj40VnrMh2w3liG01D1vmtOSaFtR/0ZJhQIMv9ZRiYo3kscI3ijfLXMdaxltjmgesSNALcGyBtfgmzDpEcXSHihqZld4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748514; c=relaxed/simple;
	bh=/N+eEafkkkzcKAncyso2/4KjnGl5N91tx2c0DHFGeLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aI4VvTh9ZpFNcjycZtj5rG6Uz8g6w4Qk8Z830Ysq1agp/AkbjtBPJDiLWqYmrCWZFDPfPE1XMvnq9xZvZpIPnKJaOpkWBhPRnU9KMNkX77Sg/LJ4aRFlsIPpruKMwdiUXMr+PHRjtvJHtr51AdBporKAKLPngE+vp0e13PINeOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SHcTFoW2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso76339885a.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1775748510; x=1776353310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+DnPa6Sb2TShUFRzmwJOmZQYJ7+4xed43t8HDhFa3Hg=;
        b=SHcTFoW2BPOwnFPlBCZDt0RphHQbNTZtV0tIYoNutZKRhF6MRelWO4hoBNoZ34v2bz
         x6hxZeyNWEQ+k5tcW0pCVC06mB772IW6sokj3AQ01zLlYfy4tdHPQ/fgah4K4uLo1DtZ
         kI3/ssKfioatVcABhuaEDizZLaws+iBdv/pFqHuZmocsdOax3Mc1KKMk5RyIrXSnWbiM
         q8G204gQ7t08Pprr7rLUZ4AEYR1TB/ovcHTeaIK5fH6eImnmnwQ0sorAFCmWyVlywOgC
         gct/DwNjicysvmaQxSkZDAQes96ZRgXhnu4IRdW/rkjTrKBmdnDJLNeISZ8keQes4+L8
         Xr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748510; x=1776353310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DnPa6Sb2TShUFRzmwJOmZQYJ7+4xed43t8HDhFa3Hg=;
        b=c4ZUyrZg7QOEgUjM/sod0UcKsyi4Q//KR10lBbOxnPNHiOCe/jzuU/6k8aV6Koynly
         Nc5QV9b+/RDOp3u/1Qet9OtJ8maWtrv3OGfQJI1iY8nurQGQWxaRz8cCoOAQ8zwVeA9Q
         m9ZaozYOGLIPDhymBFlcvpQkE+qpzSLG3kCYx6HtErVUmjzoXgjJOVeNi1CBgO6Ymzes
         x3OPwqGsP5tXZQaye2kAF34wX4x21O7UTVLn28R09XSTPT8YKGags2KDoRVdVDo1geuQ
         sa+mTS/RCGYVNEL6zW8SdIFHsIxZpQu2nEJUDZkE2a+U7h+1kPqKMFoA6xoPK79T26cj
         7SbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVoVu11Jn6jAygkU2EouOgelekCjgYsixAkxcagsOVApq3oXvZc8CoyjbmTjQ+H1goplgo3YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYDuibaz1fixfLRxDRsZMxLRvhB5cQHC6yggn1oT/gUXKc6PM
	YBIblYlTrkmnXOBiGz7hNqvVzWGfErJX45PQR8j7oIQX4mSQv3LxBLz9BGjhDIhxGJU=
X-Gm-Gg: AeBDiesd30F9rH82PcMt8Ma5CCwKYNKWgMhoqAWHCrKQo+ypRYAKzS7qE3MC2hrbBvv
	W6rugvWL4vz1eEexr62Cpa2OzUd9RqmufEY4VOgHzLMyFyb3YcMKGH/pMjmxkbBrmR7JtfxGdv9
	i4JOZjwcpowzg/VemmodSC3gYgZh74arVQAS7Qq10covoI00AX0LK+suh59YrJ2oq5LU9HDb8Qf
	eXsbHoDzKxvtTWVzzs3tHndfn7c+Hj3gUaVzSb+pr3h/Eb3/1XTC1Sky/aLIwEdEL2kUPoWGnzm
	UA1bjYRBBe8g43Mp7MphxYOydKqsMCMbnRgLrmgLCRraJDiQsRoMkd+00c537RKZPXGBSma797j
	QOR3TV1EEa/1YHUH7yifb5ZIbvekAqLbHaDkz155cVg4zy6RhkcTeIzL/rdImPd92AkS5q/pmBu
	geZrsr8DKqShjI67KaBcEaM21dVXSmDV8jPvjF9kmGkHnFeo79kj0tdY2mAqmsUlpZg6ul6miSp
	5ta1azj4r04Aa8XLg==
X-Received: by 2002:a05:620a:4486:b0:8d8:ba4a:596c with SMTP id af79cd13be357-8d8ba4a5bb4mr1928631685a.51.1775748509683;
        Thu, 09 Apr 2026 08:28:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d3f588d2b1sm1529802085a.43.2026.04.09.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:28:29 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH] userfaultfd: preserve write protection across UFFDIO_MOVE
Date: Thu,  9 Apr 2026 11:28:22 -0400
Message-ID: <20260409152822.1073083-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,stable@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-235430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	DKIM_TRACE(0.00)[gourry.net:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:dkim,gourry.net:email,gourry.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B58043CCD4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

move_present_ptes() unconditionally makes the destination PTE writable,
dropping uffd-wp write-protection from the source PTE.

The original intent was to follow mremap() behavior, but mremap()'s
move_ptes() preserves the source write state unconditionally.

Modify uffd to preserve the source write state and check the uffd-wp
condition of the source before setting writable on the destination.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/userfaultfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e6dfd5f28acd..783ca68aed88 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1123,7 +1123,10 @@ static long move_present_ptes(struct mm_struct *mm,
 			orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
 		if (pte_dirty(orig_src_pte))
 			orig_dst_pte = pte_mkdirty(orig_dst_pte);
-		orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
+		if (pte_write(orig_src_pte))
+			orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
+		if (pte_uffd_wp(orig_src_pte))
+			orig_dst_pte = pte_mkuffd_wp(orig_dst_pte);
 		set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
 
 		src_addr += PAGE_SIZE;
-- 
2.52.0


