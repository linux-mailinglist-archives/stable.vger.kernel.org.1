Return-Path: <stable+bounces-235533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNM5NHdJ2Gm0bAgAu9opvQ
	(envelope-from <stable+bounces-235533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:51:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB213D0E28
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 02:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13896300CC25
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 00:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DB13164C5;
	Fri, 10 Apr 2026 00:51:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1E314D37
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775782260; cv=none; b=Pe7dQVgmQmcOwFM+D2XHJDhRQotiumjzBdQQaLTVIqd1RM0mS3F6uEopXubxCO7MLRyG9ZGq7IU/zDqCQIoSWl1g4g7qvJcqexj2eXtJKs1YWBGzHUHdq31pjDB26+26DlhhdgxkYzaF3XXk/a2TdKRIGEw42GpYJtPeLWPvt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775782260; c=relaxed/simple;
	bh=ycsHQtK/vb04d3xZ9uSsqgZFisMK3iiK/T02wK3dXAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yw8TC/AFQQfnhrOpc0993rqB2mskUgNx5TH59PjeKblxwKenKlVvo4pgUBlgj4BERkWEeDDsPi5wzooVSeaq8kYjROJi8Z+4IeVjPy2q/iCfcJsnx8IvD0/RWnl26fMoj7r+2dkyUSM8uAaoLul+Rh3qZhZgEdO61G2js0/Besw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id CDA6F92009D; Fri, 10 Apr 2026 02:50:58 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: stable@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.12.y 2/3] MIPS: mm: Suppress TLB uniquification on EHINV hardware
Date: Fri, 10 Apr 2026 01:50:56 +0100
Message-Id: <20260410005057.49091-2-macro@orcam.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260410005057.49091-1-macro@orcam.me.uk>
References: <20260410005057.49091-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235533-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orcam.me.uk:email,orcam.me.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,franken.de:email]
X-Rspamd-Queue-Id: 5EB213D0E28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 74283cfe216392c7b776ebf6045b5b15ed9dffcd upstream.

Hardware that supports the EHINV feature, mandatory for R6 ISA and FTLB
implementation, lets software mark TLB entries invalid, which eliminates
the need to ensure no duplicate matching entries are ever created.  This
feature is already used by local_flush_tlb_all(), via the UNIQUE_ENTRYHI
macro, making the preceding call to r4k_tlb_uniquify() superfluous.

The next change will also modify uniquification code such that it'll
become incompatible with the FTLB and MMID features, as well as MIPSr6
CPUs that do not implement 4KiB pages.

Therefore prevent r4k_tlb_uniquify() from being used on EHINV hardware,
as denoted by `cpu_has_tlbinv'.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/mm/tlb-r4k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 645f77e09d5b..65f0357958fc 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -640,7 +640,8 @@ static void r4k_tlb_configure(void)
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
 	/* From this point on the ARC firmware is dead.	 */
-	r4k_tlb_uniquify();
+	if (!cpu_has_tlbinv)
+		r4k_tlb_uniquify();
 	local_flush_tlb_all();
 
 	/* Did I tell you that ARC SUCKS?  */
-- 
2.20.1


