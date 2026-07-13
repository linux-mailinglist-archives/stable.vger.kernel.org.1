Return-Path: <stable+bounces-273774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GoPzOjnrVGq5hAAAu9opvQ
	(envelope-from <stable+bounces-273774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:42:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6665A74BC2B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:42:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shutemov.name header.s=fm3 header.b="1 CBCtny";
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=jAPpN7JB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273774-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273774-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0806D3066E31
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7042EEBB;
	Mon, 13 Jul 2026 13:38:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829F42DFFA;
	Mon, 13 Jul 2026 13:38:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949882; cv=none; b=F25Zv9HaoBCZThxTvUUEEL0reBxzKKx0+UmtClil6yoOCtIawfQ/PAgg3JbB1/nb6Cl97rULOVvkFu3QreHlVbaWZggoH64Y+K0+xslovQloofvRE1eL2/vgdmKOBe54an97lAsaIFTDuwGbg8lPry5Gttidn72LSdkHXl+HQ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949882; c=relaxed/simple;
	bh=2DBiqKRYqbSrjzVq5ZSkTZf5cQARlCrAG2tlIQmkq/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIj6HQZWTSt58wULaj0rD4dUog5DzHvJznE/BCzILNkJcGGVeP+4fl0dvUoW36jBsZpo/1d7xOBGoamO9uxbBM0QWkY5Ny6toOowi+8nI2ExWjf1wxMg50zmQc51dkDZdnQRsAXYhXM+uyFHSzKZOMYOoBYQtY9L4f5cICN+FaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=1CBCtny2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAPpN7JB; arc=none smtp.client-ip=202.12.124.139
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6F3CE13000B4;
	Mon, 13 Jul 2026 09:37:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 09:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783949879; x=
	1783957079; bh=/jud+WB3AytPcrI/2OwbTXS5VtUrFeK0EaGOk27FRSs=; b=1
	CBCtny2sUeZcUKZzUvYEt2sflm/YrEJ9hVbpaKStmQ4kie1dy83JWOUfkKqzbCzs
	5DTm3ykPAJjOM3Cs68kpziZ7Oga9hwdb52ApPWv0mPlluTWUBL+HPSDhmiN2jIQn
	whU8SFKyCaA2RGn9/PrYOEua/MLcdmvm9woH5bj+clDIdMWaMN4Te/fv8a0Gz6ps
	Wy0jKFPYa6atsxLwKcTQsmYY0Pk4qSh2f9VWtxC8sPP4v0bcVjwXNeBHihulsyVy
	jeYB98QB+cflaNUnmRCLN0OGwZYRt7UKHHHxYB0U6xbyKre3yxpX9AnbfLnv0qiz
	VapVQmZd5plzi/2pKI5UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783949879; x=1783957079; bh=/
	jud+WB3AytPcrI/2OwbTXS5VtUrFeK0EaGOk27FRSs=; b=jAPpN7JBwNF3JRq91
	/dbGeuHMQigIlzcMSyf4oIjLBVOqefg7NepA4ek2lzIZh6ZLdYczS8YwS+iBAWR/
	wj2jfm4YM4pkwC5cYf59DdtipCt59BNCPAkqVdeYEQvnKvjCqSLu40tBCBTB86x5
	kQbxjzmAgD+1NEQN5iDpY8affGUmmKSFKNu50gvFCc8iEKMPgPogEIBtgZIiatXQ
	BRKX4gSW6ghXD0a3a7/zVgSXxKkAVJsoemUpHVs6g6t+8wmG0vWQLraWUBWRx3mX
	KPz/vjdCC4FBi1cZjJ96egZJVNLon71jLSWOWgl/V0yLTQLRzgvt7Zo0UGjxYR9X
	CyweQ==
X-ME-Sender: <xms:N-pUaiVPT8dNph93HMJ1tj38UzKBV8At6gZg4MyS8RmCaeTDFQzf3Q>
    <xme:N-pUarxHNEDoREtShl9hEQDWH-Rle40sjZLjs1wmhkcn9cU7KofOD-LdBUW88K__m
    -47MUY36pO4vhBa6s0ijJcsmFKlIw840jaTNd62I5BeCUIXjreA8vM>
X-ME-Received: <xmr:N-pUaq7rvG897rW2EOp-15sa-05WeyPNwO_YtXqKq3dREqvG4um7obZfI_yhWw>
X-ME-Proxy-Cause: dmFkZTEW6S1SvXSlZs4OOnc4VahxjW69aaGDPVJd2EBjsmGIohL3aDaqbSu+8YkVanPFjR
    tgfQDCCpmX969bn/U9UO+n3QFXz0q323naPF4jWiHMmRntzGcQhp3Vx2KAhMBucKBrMoVj
    X5CwYvbDFJlTUkQTRAgKvI65LvTaLY14waW97LrBigSnkpE1VVt9mBrvLTUpmoEfS6d4eG
    NKQd5S3QFjNq4Gy3l1vDGekWs+36+zmLytr+byevjqc4klRvGFU3gjURfoh9Tfq4eVG+a+
    Cgqgl3n6aDHjUo+YCrNUfd8of0qgvvgGYEP4z2EH+IhHTWSStBT7XqcjOnyMOC1DkjQYFL
    oAfg3QAucdYxGUn3jeVN0nxN4p7Xq/MJkY77NT8/xFh3P4Vi+v0hufh3nI82OzyTTo40PW
    mZg5tjU+tSZxmmoGCoIRSwrctX05kHi86z/I6Xb9bTvTe6edRxxVRfANp+uWOow94KtKTF
    /wXlv6CTShc0eHn/oRi3jHPlNMsdTO8n/e9zzGnhGcHqgKR7O4Yc1Ioccp8iL9BhkYWLQj
    LZDFEMsidCliTk8kA7CZ1rF+6mZ979Mc5Q6TI0H3Zygtze4Eoov2WWTeueStqcIgEcAFNl
    6soFzwY/WC2VvlnBbvlR1JHJ4POS4leBrjRIhWgR+fsmjVTcXaekUhRwN/HQ
X-ME-Proxy: <xmx:N-pUali0X42g355dyDA8Ra7RdSxvEXQyK_SJSQ-gEDtMIysBSD2Cjg>
    <xmx:N-pUati-qCXdA3jnh_RekQiZbXj_upWpADKU6yA_bxtmYSk--cy1Rg>
    <xmx:N-pUatn4gKnY01SEvJTHo4WvP9XHg0y69j9pGbkCU4ebQz378d9lSg>
    <xmx:N-pUatGGg2_5hzEEqzhmYRqSeMHtGj__9keVbq1AwFUhksnFEQW1Vw>
    <xmx:N-pUaquuWjfjsmIM4HpYYB8WnxHw6kJ31STQM5wH2tObCDsVcBmDMkHC>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 09:37:58 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Dan Williams <djbw@kernel.org>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v6 1/3] x86/tdx: Fix off-by-one in port I/O handling
Date: Mon, 13 Jul 2026 14:37:51 +0100
Message-ID: <20260713133753.223947-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713133753.223947-1-kirill@shutemov.name>
References: <20260713133753.223947-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[shutemov.name:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273774-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:dave.hansen@linux.intel.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:x86@kernel.org,m:seanjc@google.com,m:pbonzini@redhat.com,m:sathyanarayanan.kuppuswamy@linux.intel.com,m:kai.huang@intel.com,m:xiaoyao.li@intel.com,m:rick.p.edgecombe@intel.com,m:binbin.wu@linux.intel.com,m:david.laight.linux@gmail.com,m:ak@linux.intel.com,m:djbw@kernel.org,m:tsyrulnikov.borys@gmail.com,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kas@kernel.org,m:davidlaightlinux@gmail.com,m:tsyrulnikovborys@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[shutemov.name];
	FREEMAIL_CC(0.00)[google.com,redhat.com,linux.intel.com,intel.com,gmail.com,kernel.org,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kirill@shutemov.name,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[shutemov.name:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,shutemov.name:from_mime,shutemov.name:dkim,shutemov.name:mid,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6665A74BC2B

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=1 (INB), this produces
GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
bits). The mask is one bit too wide for all I/O sizes.

Fix the mask calculation.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1ed59ec..b8bbd715fb62 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -694,7 +694,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
 
 	/*
@@ -714,7 +714,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found
-- 
2.54.0


