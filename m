Return-Path: <stable+bounces-270689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UQo7Ji+gRmrbaQsAu9opvQ
	(envelope-from <stable+bounces-270689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:30:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1A6FB641
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:30:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rB61b9lv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270689-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270689-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C89DD30093A3
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BA137A84C;
	Thu,  2 Jul 2026 16:26:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5983403FC;
	Thu,  2 Jul 2026 16:26:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009593; cv=none; b=WgOI0hoA78wL8DHmEcjdrZEeakUELI1X8AnqkPbfb1MvzDYofXM3ETJHDbPFSOTURFp0ml5EBcT0kprQbFb6YORDYDgtaP1Wi57IJTrB8NkUdoMydmR8IEIfRWbIUNOkwAaxRwyJf34CtIFDP7fcg/h/ItD87DH4WJRYwZDikG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009593; c=relaxed/simple;
	bh=Bac/BAqy/ENIIHmSGttCixWk/3zhoWQflFA7nH4ITrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoENXdI2pWoC3oB6EST09K88vTn06SrcROZinb6SFt7OSV31+s6E1rjtjKacrVOwJ/tZuMINDt/QrT74nTPj+xtrrVxgOTlgdA+r4ktibN5/yykjm5QnV+9qjS17iK+7tRQOnd6CFLRDyaLDMMGoeFW5+INdzZ+ACtzj/UZkeVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rB61b9lv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC131F000E9;
	Thu,  2 Jul 2026 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009592;
	bh=yv6tyF2PJFEdRuvWno2wOF6IAqJ485YArgOw2NTkERE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rB61b9lvg1UkpeR4My796VsH40GCbBQ6idibuDXEu4ISJIjfUXdedy6BFSGC9u1f5
	 gya1qFbTJVjL4Uae7empTwH+k4ijqXpz0Bsz2ek2sHTns4BdqD8MmUJwqbJ9HJ7iND
	 M/ixHh1nM/aXYi2WhdqFyrj6uiuPKF+fm8wlY+Sw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 14/95] RDMA/bnxt_re: zero shared page before exposing to userspace
Date: Thu,  2 Jul 2026 18:19:17 +0200
Message-ID: <20260702155109.506137802@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155109.196223802@linuxfoundation.org>
References: <20260702155109.196223802@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:henrik.holmberg@defensify.se,m:leon@kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270689-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83A1A6FB641

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>

commit f6b079629becfa977f9c51fe53ad2e6dcc55ef44 upstream.

bnxt_re_alloc_ucontext() allocates uctx->shpg via
__get_free_page(GFP_KERNEL). The buddy allocator does not zero pages
without __GFP_ZERO, so the page contains stale kernel data from
whatever object most recently freed it.

The page is then mapped into userspace via vm_insert_page() under
BNXT_RE_MMAP_SH_PAGE in bnxt_re_mmap(). The driver only ever writes
4 bytes (a u32 AVID) at offset BNXT_RE_AVID_OFFT (0x10) inside
bnxt_re_create_ah(); the remaining 4092 bytes of the page are exposed
to userspace unsanitised, leaking kernel memory contents.

Any user with access to /dev/infiniband/uverbsX on a host with a
bnxt_re device (typically rdma group membership) can read this data
via a single mmap() at pgoff 0 after IB_USER_VERBS_CMD_GET_CONTEXT.

Other shared pages in the same file already use get_zeroed_page()
correctly:

  drivers/infiniband/hw/bnxt_re/ib_verbs.c
      srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
      cq->uctx_cq_page  = (void *)get_zeroed_page(GFP_KERNEL);

uctx->shpg is the only outlier. Bring it in line with the existing
convention by switching to get_zeroed_page().

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Lord Ulf Henrik Holmberg <henrik.holmberg@defensify.se>
Link: https://patch.msgid.link/20260509084011.11971-1-pomzm67@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3864,7 +3864,7 @@ int bnxt_re_alloc_ucontext(struct ib_uco
 
 	uctx->rdev = rdev;
 
-	uctx->shpg = (void *)__get_free_page(GFP_KERNEL);
+	uctx->shpg = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!uctx->shpg) {
 		rc = -ENOMEM;
 		goto fail;



