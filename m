Return-Path: <stable+bounces-255719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH8vLzykGGrClggAu9opvQ
	(envelope-from <stable+bounces-255719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78625F8852
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E1533049D10
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C9B3101B0;
	Thu, 28 May 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VisxbPoC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F02F8E83;
	Thu, 28 May 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999695; cv=none; b=lUFTfR37975znd2u5mQcHwT2/dgTTOMJIb1t7jhDcKpQA94N2qjKg5eaxG/mztNE7KYKC7tVk+k24U/9W8y1RP1OQCqXfWqWW7AMwNzCWyWuMUoH2jg5RUhqd//CBywMUqxx0zhW0kw4tpKtNQtQEJFr4WSBy17182TJelI1lBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999695; c=relaxed/simple;
	bh=zjrGyxyXKr9fkjtekitAglDRAM1Ystas3Pd0XMi0Akc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAE6IAKevfLoJd/fZhPH+1D1hVQHxZX/kJFCEaMTzWaTHihXvtampEECPw7yLlU3Hd3nNZmvvdFK9L7nY5EKN/h8lVDNpUN872tt8ScCtUQ8XbhkMv8t3RUjiZeCWZrJ0OXzf3DmPY7yEO9Q+mX0xJDpCPm677iEoqD9rm9lru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VisxbPoC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018101F000E9;
	Thu, 28 May 2026 20:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999694;
	bh=gNX2BG/yJXaDIR7lDhgpIozIQ5sAd9S/wLX0aG1NsI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VisxbPoClaZVukuCqwCo4wgWDBpYw4R9af8/T2dXsgj7DqjyFzykXcbnGjuDNvyUK
	 sfF7X/FAD43Jk9yPrVKLoLuuhN1xqudCzNXB1YS45PRbez0ZJjT1zm1D30d41kaET4
	 EfNuXYcfp4uJaMVKqlbfqLsHEol+xPVOVFoVIZ+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org
Subject: [PATCH 6.18 112/377] virt: sev-guest: Explicitly leak pages in unknown state
Date: Thu, 28 May 2026 21:45:50 +0200
Message-ID: <20260528194641.577495746@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255719-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email,alien8.de:email]
X-Rspamd-Queue-Id: C78625F8852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Carlos López <clopez@suse.de>

commit fd948c3f96b18ff9ba7d3e8eae13d196593e1aaf upstream.

When set_memory_{encrypted,decrypted}() fail, the user cannot know at which
point the function failed, meaning that the pages are left in an unknown state
from the point of view of the caller.

Since the pages may be left in an unencrypted state, they are not suitable for
general use, and cannot be returned safely to the buddy allocator. Avoid the
issue by never freeing the pages, and then do the proper accounting by calling
snp_leak_pages().

Fixes: 3e385c0d6ce8 ("virt: sev-guest: Move SNP Guest Request data pages handling under snp_cmd_mutex")
Signed-off-by: Carlos López <clopez@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/coco/sev-guest/sev-guest.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -176,6 +176,7 @@ static int get_ext_report(struct snp_gue
 	struct snp_guest_req req = {};
 	int ret, npages = 0, resp_len;
 	sockptr_t certs_address;
+	u64 pfn;
 
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
@@ -215,10 +216,11 @@ static int get_ext_report(struct snp_gue
 	if (!req.certs_data)
 		return -ENOMEM;
 
+	pfn = PHYS_PFN(virt_to_phys(req.certs_data));
 	ret = set_memory_decrypted((unsigned long)req.certs_data, npages);
 	if (ret) {
 		pr_err("failed to mark page shared, ret=%d\n", ret);
-		free_pages_exact(req.certs_data, npages << PAGE_SHIFT);
+		snp_leak_pages(pfn, npages);
 		return -EFAULT;
 	}
 
@@ -272,10 +274,12 @@ e_free:
 	kfree(report_resp);
 e_free_data:
 	if (npages) {
-		if (set_memory_encrypted((unsigned long)req.certs_data, npages))
+		if (set_memory_encrypted((unsigned long)req.certs_data, npages)) {
 			WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
-		else
+			snp_leak_pages(pfn, npages);
+		} else {
 			free_pages_exact(req.certs_data, npages << PAGE_SHIFT);
+		}
 	}
 	return ret;
 }



