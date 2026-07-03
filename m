Return-Path: <stable+bounces-271827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ry2SFHPiR2pChAAAu9opvQ
	(envelope-from <stable+bounces-271827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 18:25:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC0C70438D
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 18:25:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=Og2wnZ21;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271827-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271827-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C35463046D7C
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731A30566B;
	Fri,  3 Jul 2026 16:20:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3733043BE;
	Fri,  3 Jul 2026 16:20:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095620; cv=none; b=q6t/vUbflIseXAgxjI8M00clCuIjIkL0AtJvIEY5lyX5dAmu+H0rahBgWPvKrpa/vZZIlKyKYHnvFqXhxtuhHGylQNETKK2t7/W6K2IFDIL1F0SEv5xmHnr/iqbeXSL4insNg0HWUntwckRLTSYoeBe2rWd+G2cKUSYHi8eHTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095620; c=relaxed/simple;
	bh=w3VSZDCuOXAjVdXDlxvTjX0QnAa4kgg0zmai2tKL4a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TZ8wq88P+8+Ml150iHJqB+aPFI9Ediwv9T4qKKObGlIhyXIOb7H4Y5mU2hKbRPxBiW/mZlj7xrBzdZX3vh1bRyjA5XdXTeFnnZO1UcnY3Mbb3942qE1mceYCE2TJPAXI4IGNzKapWH6XEmdiMta3B49GCGnedzpcTy6xwY1WJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Og2wnZ21; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=oOBLhxm3kAjTeflZACa4rcGCxUXzgYmnLvdg8EZf+9Q=; b=Og2wnZ21fqFUhrLnbeoPe/FgQU
	ZVjkCKeKYg7MLqZBzv1tvDZ+xQtu+cXc+vkBzMRCqKJ0ILw4eBC7YHP0jSdiOwLu7dxPgGm1zLZTQ
	YVhuRV6637lm05DOjDkozMp+8jCNrNXKzJioQ4Wt6Up5EsabJDE1Vp1CvUwfi+MNtHxyK40DINXqp
	pije8I/YKtOz3qD3N/7glNVsXnOZyXNc+KagR8cZYpqq88Zu3wT0wHQ/2eKiiYhWCqGM3cpVGaebX
	/XBC/RfZllNqDkI42l97pGltMF7kpTOq1FDygjGI4M9YNedCv9Mcg+fIk62kFWt4ZbwV2rJ+5+0hT
	ROiil/Pg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfgcd-009WZ2-0P;
	Fri, 03 Jul 2026 16:20:11 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jul 2026 09:17:24 -0700
Subject: [PATCH] mm/kmemleak: fix checksum computation for per-cpu objects
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-kmemleak_checksum-v1-1-5e0ab7d6966f@debian.org>
X-B4-Tracking: v=1; b=H4sIAJPgR2oC/x3M4QrCIBQG0Fe5fL8nmIKRrxIR5r61i7lC2QjG3
 j3oPMDZ0dmUHVF2NG7a9b0gymkQ5DktTxodEQXOumDP1ptSWV9M5Z5n5tLXahguwbqHD8mPGAS
 fxkm///N6O44fDt2D12MAAAA=
X-Change-ID: 20260703-kmemleak_checksum-e69602b36a3d
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=leitao@debian.org;
 h=from:subject:message-id; bh=w3VSZDCuOXAjVdXDlxvTjX0QnAa4kgg0zmai2tKL4a8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqR+E40XrNANZmWGTTEflSoKmO+SPJv3DPgL0Q9
 TJ4ssqH1ZmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakfhOAAKCRA1o5Of/Hh3
 bfghEACFWQgEmpXIdb2pkGgrBs/mke1GfJxg2ovDvsveqL+NbLezvyMnc9TrJURGMoEbP/+HJTU
 4l7WScNmGFgEce6L9Td6rSvOEj/rp8hRKYVJfX3f5Uo3xJl03jPIrvvrxXvE735qz+6VMjRW1Rw
 bgjouTgNr29bLKRAvD5805cATAQAfMwccGvwEMBDc36/Fcl5pMxfU9U2+1YXuT7oRLCntEaTwIg
 pii1/Dhtnv9xjtSpE6EgDoGNQyPzNGRMwaiS5doMygHj7+Gk4HytGKBPnhlRub9Z1lCOwk0lCdg
 Lss4oXFNYNpaR+0q24hap6T/8mMK0Ru64DvcRTSTTJ8LaCJJPCYdPZmpnBH1YWMK75fLUH61H1r
 W7R7bbdNbDc0tsiTF6ePpY9+xSlwZ1Ts6qtsavyq1+WuhgnoStbK9LLI+4KO2KjHJXSlDxWikv+
 p6RAvgVza/9U1Tzjx0eqhOxxwbod6g33AsaA8RYZa/2V9W2zN6UiWq4Ql4MhvJe3Tt9PaaE+Lsy
 vIBHReJySbx4vNv7RYZO7oBZ7fsx+ArndecgJejNI7aPy62StZfQIkfawnS97a8uKjvooCHa5f3
 wro4pcL84vVlpi2ZotvpcZ4Vz0Zr40DSjn0hUghTiXD2Mh6mPuBSj1LJjcooZQS+d8sTZc1liGW
 6Bu0ZGufij5v/HQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271827-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:catalin.marinas@arm.com,m:akpm@linux-foundation.org,m:ptikhomirov@virtuozzo.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:stable@vger.kernel.org,m:leitao@debian.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACC0C70438D

The per-cpu object checksum folds each CPU's CRC together with XOR and
seeds every CRC with 0. Both choices make update_checksum() miss content
changes:

  - XOR is self-cancelling, so equal contents on two CPUs cancel out and
    simultaneous identical changes leave the checksum unchanged.
  - crc32(0, ...) over all-zero content is 0, so a freshly allocated,
    zeroed per-cpu area checksums to 0, matching the initial value, and
    the object is never seen to change.

See discussions at [0].

When update_checksum() wrongly reports an actively modified object as
unchanged, kmemleak stops greying it for an extra scan and can report a
live per-cpu object as a leak.

Fold the per-cpu CRC as a single rolling checksum across all CPUs and
initialise the object checksum to ~0 so the first computed value always
registers as a change, even for content that hashes to 0.
reset_checksum() is seeded the same way.

Link: https://lore.kernel.org/all/akfYImSNDh3OjIfR@gmail.com [0]
Co-developed-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 6c99d4eb7c5e ("kmemleak: enable tracking for percpu pointers")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/kmemleak.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 68a0e30eea1e3..e96e9efd19b0d 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -687,7 +687,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
 	atomic_set(&object->use_count, 1);
 	object->excess_ref = 0;
 	object->count = 0;			/* white color initially */
-	object->checksum = 0;
+	object->checksum = ~0;
 	object->del_state = 0;
 
 	/* task information */
@@ -981,7 +981,7 @@ static void reset_checksum(unsigned long ptr)
 	}
 
 	raw_spin_lock_irqsave(&object->lock, flags);
-	object->checksum = 0;
+	object->checksum = ~0;
 	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
@@ -1410,7 +1410,8 @@ static bool update_checksum(struct kmemleak_object *object)
 		for_each_possible_cpu(cpu) {
 			void *ptr = per_cpu_ptr((void __percpu *)object->pointer, cpu);
 
-			object->checksum ^= crc32(0, kasan_reset_tag((void *)ptr), object->size);
+			object->checksum = crc32(object->checksum,
+						 kasan_reset_tag((void *)ptr), object->size);
 		}
 	} else {
 		object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);

---
base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
change-id: 20260703-kmemleak_checksum-e69602b36a3d

Best regards,
--  
Breno Leitao <leitao@debian.org>


