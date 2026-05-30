Return-Path: <stable+bounces-258718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAbTJtgqG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:22:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C986119DC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8865230080B6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04C21ADC7;
	Sat, 30 May 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMJVV5KK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE02E7390;
	Sat, 30 May 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165304; cv=none; b=s00xTcEDQqX/WajkaUg/sSUkCLgjsBR2IocqWH3yIfj3CtG9jB5evxg3LcZEdnzaW/PBZ7RSDunt1nU7d7Dnw4TVI45ECaqd5iBm7C9l4peV26g022xI4fSu9UdWTMhnYQOBi378WwXeW7aLZnqGSlwhHHxaxSJ1cJzt6YOvn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165304; c=relaxed/simple;
	bh=yTPn4b/vTwy1g0rjnteXJE+vk9BDR7IMO43njJqRaZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys1o+dVF4z8eEpYyFLC0alvsNn74lucKiEZ4OlutXJa3qzZhddOHAc2RiXBYsjYcAJseZFRW8KLnuzE/66nu7t8QdQGLr/c0rkzklYxBuTu5i7DizfjbxIsxmd+uVHFyjSSP6ooXQQbz388f2VHXz6GTjM0ozkmYUYc6BMf038I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMJVV5KK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC751F00893;
	Sat, 30 May 2026 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165303;
	bh=7CFcBBoQIQLjLtdwi1x4pNvOeZL3Ut7nnXennv9cw6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hMJVV5KKh8utV5tjD64a4VoBCdqAwkQCc0lHE5oB8PHppuWNlz5rzHiRSgsrNln1J
	 c9vK0ghzplyh6rSV44Ub6jZvZJCKKd4H1F/bKg9KZep8N+GaZxNKHmC6PnK3OrPqns
	 YTxkwOWkwLPX5d+R5wxBFCi1XqZOlqCpOKWQ0Z60=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 039/589] MIPS: mm: Suppress TLB uniquification on EHINV hardware
Date: Sat, 30 May 2026 17:58:40 +0200
Message-ID: <20260530160225.615351022@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258718-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,franken.de:email]
X-Rspamd-Queue-Id: A9C986119DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/tlb-r4k.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
index 3aef6acd57bdd..af0f1d4693099 100644
--- a/arch/mips/mm/tlb-r4k.c
+++ b/arch/mips/mm/tlb-r4k.c
@@ -630,7 +630,8 @@ static void r4k_tlb_configure(void)
 	temp_tlb_entry = current_cpu_data.tlbsize - 1;
 
 	/* From this point on the ARC firmware is dead.	 */
-	r4k_tlb_uniquify();
+	if (!cpu_has_tlbinv)
+		r4k_tlb_uniquify();
 	local_flush_tlb_all();
 
 	/* Did I tell you that ARC SUCKS?  */
-- 
2.53.0




