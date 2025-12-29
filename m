Return-Path: <stable+bounces-204124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F417CE7F76
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF9C03004616
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469C23AE87;
	Mon, 29 Dec 2025 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo4N9IRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0F21ABAC;
	Mon, 29 Dec 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034683; cv=none; b=eUnY/sN8KR8XaRykFgddGxV1s1+a0HxZ6LOU7EwApAlhVOR2zB5fVpAWhyF8yl6nirM7OpJS1NXaBoncj/FvoSz1j4nlGgM/32vawPrEJkQI8wL3XctXOKm3Y20BWJPJKy+c1fXgiqR4iPVwsSqpbJuFI9jnBQk9AlImdJQTd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034683; c=relaxed/simple;
	bh=7+LeXcurmTBOVO36bBzbTi7onIGqQLPY4eKkZIpXIlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3N4moyud8b+a2QGt1ljZXhQcjjLdo+I+NpJWO0Pwqxz0D7AbnlVVKOnQbjpS3vcWjBrHWIzaHau1Xpbm1LpSSz8WAjJQl7zEeOdsR217skeRcL1eDNcp8tiiTt3f/tTKzPp7967VcvtDyOa0GijkqpI+VZey0Idsi5Q1obc5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo4N9IRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7EC4CEF7;
	Mon, 29 Dec 2025 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767034680;
	bh=7+LeXcurmTBOVO36bBzbTi7onIGqQLPY4eKkZIpXIlE=;
	h=From:To:Cc:Subject:Date:From;
	b=uo4N9IRq/AvzzW9dqo1QG8mFHMjhv/iz9k2zrkLa50lwknnHw2IUgs37G9wkbHGm/
	 UEVAY1qN80bTqP2FlMBfIrmhPELGQ2IzIEOylQ1/vgCrjO+8Gacbe4y9Di9SCXfPw3
	 LUk8qAkv+2CTgxcQMhbxV6BDKXXTIGOPiifilZKBzLf/7AwFtDFfZx7peWvdvqKcdy
	 ISNfqlKowKgRlCMy7ywzhEsAx9vRlM68EpwCC2E3FW4QpK0JlqA1ShlACjHK0QRtD6
	 0mWsseX6uxzlUt5UD+sypMLpE/wkielPjwt3USR1LZ/muq4oTKA2NX7MH64/HlxdXB
	 xB+hB/Uprs59A==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 6.18-stable] x86/microcode/AMD: Select which microcode patch to load
Date: Mon, 29 Dec 2025 19:57:52 +0100
Message-ID: <20251229185752.4358-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit 8d171045069c804e5ffaa18be590c42c6af0cf3f upstream.

All microcode patches up to the proper BIOS Entrysign fix are loaded
only after the sha256 signature carried in the driver has been verified.

Microcode patches after the Entrysign fix has been applied, do not need
that signature verification anymore.

In order to not abandon machines which haven't received the BIOS update
yet, add the capability to select which microcode patch to load.

The corresponding microcode container supplied through firmware-linux
has been modified to carry two patches per CPU type
(family/model/stepping) so that the proper one gets selected.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251027133818.4363-1-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 113 ++++++++++++++++++----------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a881bf4c2011..3821a985f4ff 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -186,50 +186,61 @@ static u32 cpuid_to_ucode_rev(unsigned int val)
 	return p.ucode_rev;
 }
 
+static u32 get_cutoff_revision(u32 rev)
+{
+	switch (rev >> 8) {
+	case 0x80012: return 0x8001277; break;
+	case 0x80082: return 0x800820f; break;
+	case 0x83010: return 0x830107c; break;
+	case 0x86001: return 0x860010e; break;
+	case 0x86081: return 0x8608108; break;
+	case 0x87010: return 0x8701034; break;
+	case 0x8a000: return 0x8a0000a; break;
+	case 0xa0010: return 0xa00107a; break;
+	case 0xa0011: return 0xa0011da; break;
+	case 0xa0012: return 0xa001243; break;
+	case 0xa0082: return 0xa00820e; break;
+	case 0xa1011: return 0xa101153; break;
+	case 0xa1012: return 0xa10124e; break;
+	case 0xa1081: return 0xa108109; break;
+	case 0xa2010: return 0xa20102f; break;
+	case 0xa2012: return 0xa201212; break;
+	case 0xa4041: return 0xa404109; break;
+	case 0xa5000: return 0xa500013; break;
+	case 0xa6012: return 0xa60120a; break;
+	case 0xa7041: return 0xa704109; break;
+	case 0xa7052: return 0xa705208; break;
+	case 0xa7080: return 0xa708009; break;
+	case 0xa70c0: return 0xa70C009; break;
+	case 0xaa001: return 0xaa00116; break;
+	case 0xaa002: return 0xaa00218; break;
+	case 0xb0021: return 0xb002146; break;
+	case 0xb0081: return 0xb008111; break;
+	case 0xb1010: return 0xb101046; break;
+	case 0xb2040: return 0xb204031; break;
+	case 0xb4040: return 0xb404031; break;
+	case 0xb4041: return 0xb404101; break;
+	case 0xb6000: return 0xb600031; break;
+	case 0xb6080: return 0xb608031; break;
+	case 0xb7000: return 0xb700031; break;
+	default: break;
+
+	}
+	return 0;
+}
+
 static bool need_sha_check(u32 cur_rev)
 {
+	u32 cutoff;
+
 	if (!cur_rev) {
 		cur_rev = cpuid_to_ucode_rev(bsp_cpuid_1_eax);
 		pr_info_once("No current revision, generating the lowest one: 0x%x\n", cur_rev);
 	}
 
-	switch (cur_rev >> 8) {
-	case 0x80012: return cur_rev <= 0x8001277; break;
-	case 0x80082: return cur_rev <= 0x800820f; break;
-	case 0x83010: return cur_rev <= 0x830107c; break;
-	case 0x86001: return cur_rev <= 0x860010e; break;
-	case 0x86081: return cur_rev <= 0x8608108; break;
-	case 0x87010: return cur_rev <= 0x8701034; break;
-	case 0x8a000: return cur_rev <= 0x8a0000a; break;
-	case 0xa0010: return cur_rev <= 0xa00107a; break;
-	case 0xa0011: return cur_rev <= 0xa0011da; break;
-	case 0xa0012: return cur_rev <= 0xa001243; break;
-	case 0xa0082: return cur_rev <= 0xa00820e; break;
-	case 0xa1011: return cur_rev <= 0xa101153; break;
-	case 0xa1012: return cur_rev <= 0xa10124e; break;
-	case 0xa1081: return cur_rev <= 0xa108109; break;
-	case 0xa2010: return cur_rev <= 0xa20102f; break;
-	case 0xa2012: return cur_rev <= 0xa201212; break;
-	case 0xa4041: return cur_rev <= 0xa404109; break;
-	case 0xa5000: return cur_rev <= 0xa500013; break;
-	case 0xa6012: return cur_rev <= 0xa60120a; break;
-	case 0xa7041: return cur_rev <= 0xa704109; break;
-	case 0xa7052: return cur_rev <= 0xa705208; break;
-	case 0xa7080: return cur_rev <= 0xa708009; break;
-	case 0xa70c0: return cur_rev <= 0xa70C009; break;
-	case 0xaa001: return cur_rev <= 0xaa00116; break;
-	case 0xaa002: return cur_rev <= 0xaa00218; break;
-	case 0xb0021: return cur_rev <= 0xb002146; break;
-	case 0xb0081: return cur_rev <= 0xb008111; break;
-	case 0xb1010: return cur_rev <= 0xb101046; break;
-	case 0xb2040: return cur_rev <= 0xb204031; break;
-	case 0xb4040: return cur_rev <= 0xb404031; break;
-	case 0xb4041: return cur_rev <= 0xb404101; break;
-	case 0xb6000: return cur_rev <= 0xb600031; break;
-	case 0xb6080: return cur_rev <= 0xb608031; break;
-	case 0xb7000: return cur_rev <= 0xb700031; break;
-	default: break;
-	}
+	cutoff = get_cutoff_revision(cur_rev);
+	if (cutoff)
+		return cur_rev <= cutoff;
 
 	pr_info("You should not be seeing this. Please send the following couple of lines to x86-<at>-kernel.org\n");
 	pr_info("CPUID(1).EAX: 0x%x, current revision: 0x%x\n", bsp_cpuid_1_eax, cur_rev);
@@ -494,6 +505,7 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 {
 	u8 family = x86_family(bsp_cpuid_1_eax);
 	struct microcode_header_amd *mc_hdr;
+	u32 cur_rev, cutoff, patch_rev;
 	u32 sh_psize;
 	u16 proc_id;
 	u8 patch_fam;
@@ -533,11 +545,32 @@ static int verify_patch(const u8 *buf, size_t buf_size, u32 *patch_size)
 	proc_id	= mc_hdr->processor_rev_id;
 	patch_fam = 0xf + (proc_id >> 12);
 
-	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
-
 	if (patch_fam != family)
 		return 1;
 
+	cur_rev = get_patch_level();
+
+	/* No cutoff revision means old/unaffected by signing algorithm weakness => matches */
+	cutoff = get_cutoff_revision(cur_rev);
+	if (!cutoff)
+		goto ok;
+
+	patch_rev = mc_hdr->patch_id;
+
+	ucode_dbg("cur_rev: 0x%x, cutoff: 0x%x, patch_rev: 0x%x\n",
+		  cur_rev, cutoff, patch_rev);
+
+	if (cur_rev <= cutoff && patch_rev <= cutoff)
+		goto ok;
+
+	if (cur_rev > cutoff && patch_rev > cutoff)
+		goto ok;
+
+	return 1;
+
+ok:
+	ucode_dbg("Patch-ID 0x%08x: family: 0x%x\n", mc_hdr->patch_id, patch_fam);
+
 	return 0;
 }
 
@@ -606,8 +639,6 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 
 		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
 
-		ucode_dbg("patch_id: 0x%x\n", mc->hdr.patch_id);
-
 		if (mc_patch_matches(mc, eq_id)) {
 			desc->psize = patch_size;
 			desc->mc = mc;
-- 
2.51.0


