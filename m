Return-Path: <stable+bounces-136618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4BDA9B662
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BDE924FDE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1128F521;
	Thu, 24 Apr 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oOubYkw7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Kq7mWCb"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968B317A2EA;
	Thu, 24 Apr 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519584; cv=none; b=ffi1ZADV1rltteQX8YhhKdaSenMg3fVAAHowOhZes4XhHzzXOybYuCTItlFCwpnIsO/jI3wkh5uIs23iMUyyto/BO2x8sVLQAUi/QdWa5hOAcMfdricAWGJIqCRdX0xhuEgnCjjIvCwtG95ariu/RrpEYamiXpc+FQuroNgIUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519584; c=relaxed/simple;
	bh=ZNjTTkIVczQOE20AWVMxZ4dJusk/b99WAuEhTbOuIkE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bLzjVfQ1e7XuVleg2+JtTfpB0vCeXXqEx+WDToY+N7osDhsag3G91pfvTVNYGukwhKkoiAORYAHQ5pgaQYlrNPwiBgwMX9o9kMzZOIW9SbXlbsTCW+hsGnv/NSzulNTL7NakBjovOImNe2Bwq4prmS9OjmR3sccwVddcrS4PUYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oOubYkw7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Kq7mWCb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 18:32:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745519580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MZFnzPN9B1NEXxGPpUYgQtTdpcH3q01EOLR0qp5Dfc=;
	b=oOubYkw74rGpW+4IXKsDfnDYcUaVutGDkICsI0GdlWA80RC5i59LuFPc1KUMYzyOxJQpmO
	Rb/BBkC4knaC9xFmmib39+oA9e5m395RXwdjes8Kid6QeEEXTg0NoLm/Mu2P/MM0Bxpixt
	kKsRgqK5Hyj4zvdyc6DHJ29t432muSmttNtR2bjWZ2PtLPyVteovdh3A4B017fs6x9XxRr
	PdDesVUeaSJU9TEz0gFYa+K9qv7Hy/TJxYcuk8IO8wuZ8V8MW1E+vsn2s3jdzANI06To/b
	Ts7lQbSkYB1buQo9UV5rEU1kZuC57HKKs7zCdzGh7vQy+6cghh2lRoPXpZ00/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745519580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MZFnzPN9B1NEXxGPpUYgQtTdpcH3q01EOLR0qp5Dfc=;
	b=9Kq7mWCbXiBugiSoiHJVV4W+fMzrraSnoC6lvRr2FvVavtFMYHx4Fi+B+1oONPu6w9xdLj
	HlOdZQvhEpcS59CA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/insn: Fix CTEST instruction decoding
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, v6.10+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250423065815.2003231-1-kirill.shutemov@linux.intel.com>
References: <20250423065815.2003231-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174551957937.31282.18105092355555203592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     85fd85bc025a525354acb2241beb3c5387c551ec
Gitweb:        https://git.kernel.org/tip/85fd85bc025a525354acb2241beb3c5387c551ec
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 23 Apr 2025 09:58:15 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Apr 2025 20:19:17 +02:00

x86/insn: Fix CTEST instruction decoding

insn_decoder_test found a problem with decoding APX CTEST instructions:

	Found an x86 instruction decoder bug, please report this.
	ffffffff810021df	62 54 94 05 85 ff    	ctestneq
	objdump says 6 bytes, but insn_get_length() says 5

It happens because x86-opcode-map.txt doesn't specify arguments for the
instruction and the decoder doesn't expect to see ModRM byte.

Fixes: 690ca3a3067f ("x86/insn: Add support for APX EVEX instructions to the opcode map")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v6.10+
Link: https://lore.kernel.org/r/20250423065815.2003231-1-kirill.shutemov@linux.intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 4 ++--
 tools/arch/x86/lib/x86-opcode-map.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index caedb3e..f5dd84e 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -996,8 +996,8 @@ AVXcode: 4
 83: Grp1 Ev,Ib (1A),(es)
 # CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
 #			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
-84: CTESTSCC (ev)
-85: CTESTSCC (es) | CTESTSCC (66),(es)
+84: CTESTSCC Eb,Gb (ev)
+85: CTESTSCC Ev,Gv (es) | CTESTSCC Ev,Gv (66),(es)
 88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
 8f: POP2 Bq,Rq (000),(11B),(ev)
 a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index caedb3e..f5dd84e 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -996,8 +996,8 @@ AVXcode: 4
 83: Grp1 Ev,Ib (1A),(es)
 # CTESTSCC instructions are: CTESTB, CTESTBE, CTESTF, CTESTL, CTESTLE, CTESTNB, CTESTNBE, CTESTNL,
 #			     CTESTNLE, CTESTNO, CTESTNS, CTESTNZ, CTESTO, CTESTS, CTESTT, CTESTZ
-84: CTESTSCC (ev)
-85: CTESTSCC (es) | CTESTSCC (66),(es)
+84: CTESTSCC Eb,Gb (ev)
+85: CTESTSCC Ev,Gv (es) | CTESTSCC Ev,Gv (66),(es)
 88: POPCNT Gv,Ev (es) | POPCNT Gv,Ev (66),(es)
 8f: POP2 Bq,Rq (000),(11B),(ev)
 a5: SHLD Ev,Gv,CL (es) | SHLD Ev,Gv,CL (66),(es)

