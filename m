Return-Path: <stable+bounces-226463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFFjKruLuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:13:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CD2AF23F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18211325E2B8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6583F7E84;
	Tue, 17 Mar 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qQfWyDgj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29183F7E66;
	Tue, 17 Mar 2026 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766827; cv=none; b=jhooMr6aN57+vvd4OH8U9/+fX0HHSs+Sf39rDhYrhHljnpTA4GDesfysXHvUh6iFgeORbR2hI5vcAXCOGNUo7BQnbyaQ7z8qZjBB7b6BGN7ny0irCl+xzrOQq93hBwlzPJuCO0YdL5/HOniFbB2Zy+X+8bE8At+bmX7tGynTulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766827; c=relaxed/simple;
	bh=tddEdZ35J/EFIyQUMMQ6a+CqYdBXIfhNy2RxJi4w404=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLBTYvnyMEFhdRDbKa2R5lgFQJjELn/nNgceUat3MclC696ECzhJ6IIV52AVY2KKZHQxrzfxvQEK1ZWTKknL7Dx1Y3rJ4bwe8u02keUZTZQcnuahjv62QwGDMmKKcgPGLySA4oJWfQcxpPZFW8Qp99/+AWWo6sLcCk/WtS836N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qQfWyDgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17241C4CEF7;
	Tue, 17 Mar 2026 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766827;
	bh=tddEdZ35J/EFIyQUMMQ6a+CqYdBXIfhNy2RxJi4w404=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQfWyDgjTCjBR+HU4pW6HN4U+0yhJ2hAsbhsOj06zSWJYW4fVvVPYtP+FD3DZwq5O
	 Dk8Rnhd/ygzIA3k1G+YDAYLznD5H5gOEgNu/TOFWAFGRlN2MDHXO7Y65wSsddQjb7k
	 gbr4w53y+LDKRZiOdg9lRP19bcjQLNIRi4TSDweY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 6.19 329/378] powerpc/pseries: Correct MSI allocation tracking
Date: Tue, 17 Mar 2026 17:34:46 +0100
Message-ID: <20260317163019.092913040@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226463-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email]
X-Rspamd-Queue-Id: 2D2CD2AF23F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nam Cao <namcao@linutronix.de>

commit 35e4f2a17eb40288f9bcdb09549fa04a63a96279 upstream.

The per-device MSI allocation calculation in pseries_irq_domain_alloc()
is clearly wrong. It can still happen to work when nr_irqs is 1.

Correct it.

Fixes: c0215e2d72de ("powerpc/pseries: Fix MSI-X allocation failure when quota is exceeded")
Cc: stable@vger.kernel.org
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
[maddy: Fixed Nilay's reviewed-by tag]
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260302003948.1452016-1-namcao@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/pseries/msi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -605,7 +605,7 @@ static int pseries_irq_domain_alloc(stru
 					      &pseries_msi_irq_chip, pseries_dev);
 	}
 
-	pseries_dev->msi_used++;
+	pseries_dev->msi_used += nr_irqs;
 	return 0;
 
 out:



