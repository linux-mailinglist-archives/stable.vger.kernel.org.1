Return-Path: <stable+bounces-270986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OxnBJVSVRmqDZAsAu9opvQ
	(envelope-from <stable+bounces-270986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:44:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 336786FA75C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=0kmKrRS8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270986-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-270986-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03BE1309E4CE
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD5635F180;
	Thu,  2 Jul 2026 16:39:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24E431AAAF;
	Thu,  2 Jul 2026 16:39:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010370; cv=none; b=I0HwMAstgmI9/7xhVy/C6sikZFgtc5kjvL6A6pGafxZtOsxicoFBXst/viVHR6q7D3TfGqiH0L9e2WtLfkcEMEn2QTXI1CGyaHlJHahhXKItD3uUilu+08RUGeXLl2MrSuZrppgICa6cTJ++OzKB1dQLRMGCj3MWkal9FJUSnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010370; c=relaxed/simple;
	bh=Q/xJ1PGYkGQC0R4pMiaWO3nlSwOd/t+bI8ddXyvCddM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSNAN6mPCE684qwinLdqXBUxlb7H6IE/ICNyvKHgcVIHYKtJpZ9em+G01IAozphD1Qh7by6YCM2nnB+ze+pwSoOW7CoJ8AjtENwOMAgLLerbOHc/3o03Bm8r2XYW+NuqLbECQqySdCWx2SouJibYu2pLuh5mvmo4uOyiePRkrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0kmKrRS8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0B21F000E9;
	Thu,  2 Jul 2026 16:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010368;
	bh=JvwRHV8jbvDRfNEqm387K6nTHhOD8B/ypYnyGLkHrYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0kmKrRS8CU2iOLCGEAZ3jtZ6I8nsTntuUwOCRF4Rfre9Ot5NU0FecjMmzYRDWvR+/
	 tAxU1gCXDwpM8evojw/z5oSZFPzSYEWY6jbvUR7CvC0tqvVWUT9DU55Dd6C82fNVNn
	 tVW+BR9lclX+W/b6PIOm4GXK8qBUUgeF8/fLQkXU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: [PATCH 6.12 083/204] scripts/sorttable: Fix endianness handling in build-time mcount sort
Date: Thu,  2 Jul 2026 18:19:00 +0200
Message-ID: <20260702155120.404616730@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270986-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mhiramat@kernel.org,m:catalin.marinas@arm.com,m:nathan@kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:iii@linux.ibm.com,m:ihor.solodrai@linux.dev,m:gor@linux.ibm.com,m:rostedt@goodmis.org,m:andrey.grodzovsky@crowdstrike.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,goodmis.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arm.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 336786FA75C

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 023f124a64174c47e18340ded7e2a39b96eb9523 ]

Kernel cross-compilation with BUILDTIME_MCOUNT_SORT produces zeroed
mcount values if the build-host endianness does not match the ELF
file endianness.

The mcount values array is converted from ELF file
endianness to build-host endianness during initialization in
fill_relocs()/fill_addrs(). Avoid extra conversion of these values during
weak-function zeroing; otherwise, they do not match nm-parsed addresses
and all mcount values are zeroed out.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Link: https://lore.kernel.org/patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours
Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Closes: https://lore.kernel.org/all/your-ad-here.call-01743522822-ext-4975@work.hours/
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/sorttable.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -857,7 +857,7 @@ static void *sort_mcount_loc(void *arg)
 		for (void *ptr = vals; ptr < vals + size; ptr += long_size) {
 			uint64_t key;
 
-			key = long_size == 4 ? r((uint32_t *)ptr) : r8((uint64_t *)ptr);
+			key = long_size == 4 ? *(uint32_t *)ptr : *(uint64_t *)ptr;
 			if (!find_func(key)) {
 				if (long_size == 4)
 					*(uint32_t *)ptr = 0;



