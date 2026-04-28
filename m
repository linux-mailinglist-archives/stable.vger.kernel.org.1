Return-Path: <stable+bounces-241654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DfDL9O48GlQXwEAu9opvQ
	(envelope-from <stable+bounces-241654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:40:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3865F486123
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E54C30EAD67
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64D451069;
	Tue, 28 Apr 2026 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQljEomZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64B451044
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381017; cv=none; b=eKGc3P6VhdhJyBoy4KGWVlADOoqjr3rqEQwr/rcvSy4+wLuZud2aiQkN6b56/Nryr4C/qygJavg0+OEsZF6SaOXGf4BxOZGfdBfyhGzG/W//RN7unacQB7Cm1lEoMZw2qEV+xa7mtbiXmm3JO92RvIcNSexXrGgbbcbRH3nMTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381017; c=relaxed/simple;
	bh=2RKSmrXDGmbJ+ILGomCmvqR5VHp9ZnHV9m4WyCI4c1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLsvI0J2HRM6PIxGSugNAXD/m87Rth6HlxS+tA+YorpaHrYTYIAQmMVStWNC89qs1WrK/8pZ/U3rJs4ixsdPTueGry7zbtXriJaP0hvQ+dkXI0iZxgZBhxglykYZBBZ2RB2+es3CsHOXbAr1E0uxoJBaYm/gHfCx2FkAyHyyOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQljEomZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC90C2BCAF;
	Tue, 28 Apr 2026 12:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381016;
	bh=2RKSmrXDGmbJ+ILGomCmvqR5VHp9ZnHV9m4WyCI4c1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQljEomZS5ZxUCq5PeFr2rJNcvjyI+alsvwnO+69CsFwF5XmCJLvLTtDodCTjYyKk
	 7GLC0lrbGR1c779dgqJd0LahUe17wHkEFEJhxFDwfR5qqSOYvxyTgYh3yp+kdcdbk1
	 Bc7dpgWTKpKNroZTO+O2vst3iTmtn60a26EijlMZluEu0GHEJ21yeWRAjjrSr7dQ4n
	 g9/pHUTe3/yPcEZEPQf3QUV2i+RSx29NNkSvCjMY4fboXnK2oZvmgyypX83gH/dPKq
	 bmvgojPF7A6HmsnvEKlS6TZpzNRGl3n85Xj7kEd9EZxnJIbNGJenJ2hu5c008MJ+VD
	 kvme8f4htCtiA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6BE9DF40079;
	Tue, 28 Apr 2026 08:56:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Apr 2026 08:56:55 -0400
X-ME-Sender: <xms:l67wadjtyyNijhm0BVs7qedWOc1AjPmbNZ0S76qYiNHqWVd8yHZxzw>
    <xme:l67waXm0V7ynTldqI_ONKYSLTwmMS6JLhXLagwQdWr1C9-j6W9ic0R6VFEojcB5P6
    Ouq-di276hM5qAEdmEJq7td_l61tCMhC9ipLrMpu8vxPP4N6yr0bOo>
X-ME-Received: <xmr:l67waWoVWl9yXDSgXT0dJN9DR2-d6zfj0qT68PGiiMn1EmlCRxoX2dWYgVvOIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcu
    ufhhuhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepjeeliefgueefleduieejuefhffdttdehfefguddtffekteeg
    ueeujedvffelleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvd
    ekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnh
    hsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhope
    hrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehs
    rghthhihrghnrghrrgihrghnrghnrdhkuhhpphhushifrghmhieslhhinhhugidrihhnth
    gvlhdrtghomhdprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:l67waTKY1hGMJDex_PyLIXZB4fpbyrE9RlMbEoyZrjfTD_YRrKTHvg>
    <xmx:l67waSDVL4W5m5Ewj48nETFIzio4-P56QlRWFRpd6kLMWNCN1iSiDQ>
    <xmx:l67waV7KvrkSq9bPSfsC0XueSTlv2tif69aModRDf5KwS87W3JLo8w>
    <xmx:l67waeHbs2L8iZhPnaTbPKwfZ5ssPqoe_Ca3EmkljaPv3k8T20PQag>
    <xmx:l67waQRDxavlZWTX7GuXZ7K97fnK3A6lmtghHOmd0ddga7R3ZZCpupLX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 08:56:53 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v2 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Date: Tue, 28 Apr 2026 13:56:32 +0100
Message-ID: <20260428125632.129770-3-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428125632.129770-1-kas@kernel.org>
References: <20260428125632.129770-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3865F486123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[zytor.com,intel.com,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241654-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

According to x86 architecture rules, 32-bit operations zero-extend the
result to 64 bits. The current implementation of handle_in() only masks
the lower 32 bits, which preserves the upper 32 bits of RAX when a
32-bit port IN instruction is emulated.

Update handle_in() to zero out the entire RAX register when the I/O size
is 4 bytes to ensure correct zero-extension. For smaller sizes (1 or 2
bytes), continue to preserve the unaffected upper bits.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 65119362f9a2..e09636564237 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,8 +703,17 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 */
 	success = !__tdx_hypercall(&args);
 
-	/* Update part of the register affected by the emulated instruction */
-	regs->ax &= ~mask;
+	/*
+	 * Update part of the register affected by the emulated instruction.
+	 *
+	 * 32-bit operands generate a 32-bit result, zero-extended to a 64-bit
+	 * result.
+	 */
+	if (size == 4)
+		regs->ax = 0;
+	else
+		regs->ax &= ~mask;
+
 	if (success)
 		regs->ax |= args.r11 & mask;
 
-- 
2.51.2


