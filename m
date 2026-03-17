Return-Path: <stable+bounces-226721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGJXHdGSuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:43:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFED2B00D6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB13F3236160
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8F02FFDEA;
	Tue, 17 Mar 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZjEdgdEW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92F225A38;
	Tue, 17 Mar 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767949; cv=none; b=NJ0v7abg3XjiaMhkZJsOfw56ioOb6WmtLxLi2DgXkJ93uDTyU3K3g6dxJTecw7G4AM9wXESAvzGeYzNa0j3ZXEVAo+TrrPHnP5dAWI2P7xn1TdR9R+qHY/1sUWqAjhLTF6KLOyvOdPRZWPxy1HFPCyT78/K5lCOlc4II7huVszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767949; c=relaxed/simple;
	bh=kHnhNwzWE3jDRdZ5LbviWfA8Jbr/rqQ3+ROEhQsgnTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDyXiun1CA349+LMiPcqNtRkSQcoAa4e6VFEqmd64bDQno8Zna+P8Cc+7zeNBBOxdj5FIW7wAUusmZYqS9RGnH1a3shynSw8TW59FhOtPMzFrWF4TkNzkjxij4tBlvuCyyDm0dKTSZWvXPiAvvjKwiDR4e7Sji5+zvVSgGuVu+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZjEdgdEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59904C4CEF7;
	Tue, 17 Mar 2026 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767948;
	bh=kHnhNwzWE3jDRdZ5LbviWfA8Jbr/rqQ3+ROEhQsgnTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZjEdgdEWFR45E5/pJag9xCra203B+EGxqsqDs22JPS0+sqsh1hy/PAJqMfIUlxuz6
	 2fsPFyWpi2kSgB/1xiRcNz6oOgitCjnE+g6sz6YiHzcpvnxveGAPFuiTN3C5sZxj6c
	 facOOCJrycCKO/t//pjz0cKcG/k6AYLuVP4zEwYA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.18 197/333] s390/pfault: Fix virtual vs physical address confusion
Date: Tue, 17 Mar 2026 17:33:46 +0100
Message-ID: <20260317163006.662326571@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226721-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFFED2B00D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Gordeev <agordeev@linux.ibm.com>

commit d879ac6756b662a085a743e76023c768c3241579 upstream.

When Linux is running as guest, runs a user space process and the
user space process accesses a page that the host has paged out,
the guest gets a pfault interrupt and schedules a different process.
Without this mechanism the host would have to suspend the whole
virtual CPU until the page has been paged in.

To setup the pfault interrupt the real address of parameter list
should be passed to DIAGNOSE 0x258, but a virtual address is passed
instead.

That has a performance impact, since the pfault setup never succeeds,
the interrupt is never delivered to a guest and the whole virtual CPU
is suspended as result.

Cc: stable@vger.kernel.org
Fixes: c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address spaces")
Reported-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/mm/pfault.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/mm/pfault.c
+++ b/arch/s390/mm/pfault.c
@@ -62,7 +62,7 @@ int __pfault_init(void)
 		"0:	nopr	%%r7\n"
 		EX_TABLE(0b, 0b)
 		: [rc] "+d" (rc)
-		: [refbk] "a" (&pfault_init_refbk), "m" (pfault_init_refbk)
+		: [refbk] "a" (virt_to_phys(&pfault_init_refbk)), "m" (pfault_init_refbk)
 		: "cc");
 	return rc;
 }
@@ -84,7 +84,7 @@ void __pfault_fini(void)
 		"0:	nopr	%%r7\n"
 		EX_TABLE(0b, 0b)
 		:
-		: [refbk] "a" (&pfault_fini_refbk), "m" (pfault_fini_refbk)
+		: [refbk] "a" (virt_to_phys(&pfault_fini_refbk)), "m" (pfault_fini_refbk)
 		: "cc");
 }
 



