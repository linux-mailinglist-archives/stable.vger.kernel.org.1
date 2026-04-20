Return-Path: <stable+bounces-239802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N7xFm5o5mnBvwEAu9opvQ
	(envelope-from <stable+bounces-239802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:54:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9655432405
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92C7233B3754
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58A33EAF9;
	Mon, 20 Apr 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c45uzj4x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DA244661;
	Mon, 20 Apr 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701253; cv=none; b=lgmlcKVdpujE9lIFFa1AEEr8WEupF3DwOSACYvpmPCXw4mI9OkzYi/4aU2+tdRAJh2kWJFSQOA1N+v02V0PDHUgQPdG8VdNzvV8T9s3vh3+5vLaWs/zR9xhaQwmADnsHE1zkIH7xN+R/chAhCuqGmq+fMl2mRwGe/MaAj3JcnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701253; c=relaxed/simple;
	bh=hwYL9DyzhG1Q18u+5N9XnPwfQXt575Q0L2yeMqfXvjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FowztASwDVpkj2A/ZqJnyem8MA6uaELyeMXXhB2dTPmnhmXQ/n9rcnyzgVfXTtZcpQGocEO2etSoYX8gANQCjF3+i7gcPFBh1zXQBfsyQiFG5LYFF9l0U31VI5NGKa/sj9QgZ2+SP6jjAVBOkR0UsMomR0btkEr+62BgIBp8vmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c45uzj4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05747C19425;
	Mon, 20 Apr 2026 16:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701253;
	bh=hwYL9DyzhG1Q18u+5N9XnPwfQXt575Q0L2yeMqfXvjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c45uzj4xT34h9Ibto1yeZIOJM61xO80WU1Fe5wrTY1GRk5H0VeNKdgL74P/71p6ZR
	 uHCSsfMo0mb3OCcxw4IfiNi9jlXyUSqRm/HY+lm/VhKm07EAZ5xL1kSIxnnoYWRE7v
	 f8vQycVvUjCjUb0BqhSFUeQxr8Q0K2HR+vRAAzuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serhii Pievniev <spevnev16@gmail.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 040/162] tools/power/turbostat: Fix microcode patch level output for AMD/Hygon
Date: Mon, 20 Apr 2026 17:41:12 +0200
Message-ID: <20260420153928.479879415@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239802-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9655432405
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serhii Pievniev <spevnev16@gmail.com>

[ Upstream commit a444083286434ec1fd127c5da11a3091e6013008 ]

turbostat always used the same logic to read the microcode patch level,
which is correct for Intel but not for AMD/Hygon.
While Intel stores the patch level in the upper 32 bits of MSR, AMD
stores it in the lower 32 bits, which causes turbostat to report the
microcode version as 0x0 on AMD/Hygon.

Fix by shifting right by 32 for non-AMD/Hygon, preserving the existing
behavior for Intel and unknown vendors.

Fixes: 3e4048466c39 ("tools/power turbostat: Add --no-msr option")
Signed-off-by: Serhii Pievniev <spevnev16@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 86ffe7e06a146..fb1c65f6ff9de 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -8058,10 +8058,13 @@ void process_cpuid()
 	edx_flags = edx;
 
 	if (!no_msr) {
-		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch))
+		if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch)) {
 			warnx("get_msr(UCODE)");
-		else
+		} else {
 			ucode_patch_valid = true;
+			if (!authentic_amd && !hygon_genuine)
+				ucode_patch >>= 32;
+		}
 	}
 
 	/*
@@ -8076,7 +8079,7 @@ void process_cpuid()
 		fprintf(outf, "CPUID(1): family:model:stepping 0x%x:%x:%x (%d:%d:%d)",
 			family, model, stepping, family, model, stepping);
 		if (ucode_patch_valid)
-			fprintf(outf, " microcode 0x%x", (unsigned int)((ucode_patch >> 32) & 0xFFFFFFFF));
+			fprintf(outf, " microcode 0x%x", (unsigned int)ucode_patch);
 		fputc('\n', outf);
 
 		fprintf(outf, "CPUID(0x80000000): max_extended_levels: 0x%x\n", max_extended_level);
-- 
2.53.0




