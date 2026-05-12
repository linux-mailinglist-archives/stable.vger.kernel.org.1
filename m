Return-Path: <stable+bounces-246106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DPaBOlrA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3B526B7F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30CBD316E093
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B93EDE45;
	Tue, 12 May 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjY0HZkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFDA3EDE59;
	Tue, 12 May 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608373; cv=none; b=iuKxHyvlQiMX1x+Rnzg3I3jSY9qWM0Y4/3sOMHr8UDEh/ze01MI6cZ3DtlJuluCLxKUt0jjQiTpIXoXT1lXdk6P1yDeRdNvIylgOKQaZAmCdTdyxUI+rgGn50Eh8gNY9SZCIkDts9RpJw6FLd6Rtt7JkvI9fwr4f2fjpg1k2vrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608373; c=relaxed/simple;
	bh=pwfvXt552AoZxGMjy4PyQSYEcOkPrfbtuE1HRLRcrfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTDBDGsg5f7aki4tmMaqKZPLNDpVQJKGAxUijrzaOVi6Xesjtoz27NpMft9OR15+c/OTyahI8BT+3wmX6TgHRYY1TBlC0cWzC0Sdc+uCqZ4WLEGcq4rzfSU8JDsvumxYoBi/Z39TaWJmVrDB9FERFikIEA2p5rsc7t+Qyczi9HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjY0HZkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7C3C2BCB0;
	Tue, 12 May 2026 17:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608373;
	bh=pwfvXt552AoZxGMjy4PyQSYEcOkPrfbtuE1HRLRcrfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DjY0HZkDUQ/3fh908jWZW4nzTSXNbzZzTROdeZ+iyW4OiQnWtpczW+F5EN9l+yvjA
	 ASeLfMCbYMp/EBlF/+CNTiy1DXGhpDp9KXEsry1l+gjYPxpEV256X1gNulJA8MsvvN
	 rYbj4ivpWfxgxpmc/YBxubEG/yibDhkW6qJMm++w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.18 054/270] powerpc/kdump: fix KASAN sanitization flag for core_$(BITS).o
Date: Tue, 12 May 2026 19:37:35 +0200
Message-ID: <20260512173939.587950089@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABA3B526B7F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJECT_HAS_CURRENCY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.ibm.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-246106-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sourabh Jain <sourabhjain@linux.ibm.com>

commit b3a97f9484080c6e71db9e803e3cc1bb372a9bc7 upstream.

KASAN instrumentation is intended to be disabled for the kexec core
code, but the existing Makefile entry misses the object suffix. As a
result, the flag is not applied correctly to core_$(BITS).o.

So when KASAN is enabled, kexec_copy_flush and copy_segments in
kexec/core_64.c are instrumented, which can result in accesses to
shadow memory via normal address translation paths. Since these run
with the MMU disabled, such accesses may trigger page faults
(bad_page_fault) that cannot be handled in the kdump path, ultimately
causing a hang and preventing the kdump kernel from booting. The same
is true for kexec as well, since the same functions are used there.

Update the entry to include the “.o” suffix so that KASAN
instrumentation is properly disabled for this object file.

Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in kexec paths")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ibm.com/
Cc: stable@vger.kernel.org
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260407124349.1698552-1-sourabhjain@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kexec/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o := n
 KCOV_INSTRUMENT_core_$(BITS).o := n
 UBSAN_SANITIZE_core_$(BITS).o := n
 KASAN_SANITIZE_core.o := n
-KASAN_SANITIZE_core_$(BITS) := n
+KASAN_SANITIZE_core_$(BITS).o := n



