Return-Path: <stable+bounces-264706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZnZHFIV9MWrkkgUAu9opvQ
	(envelope-from <stable+bounces-264706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1026926B8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=rLEwC6Bv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264706-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264706-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E66AA302E9F4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC5472786;
	Tue, 16 Jun 2026 16:30:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0075466B4E;
	Tue, 16 Jun 2026 16:30:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627436; cv=none; b=AlNj0lgu485W89EoOhx+K8BNjxGjp+5FjUxbi3CClXAw7xR+UPuc2gB9kxPdt7Q53CyEwnUhIzCsljZIYJ7od5b41KLmFS9/qE5YTMVAfqzMrMMZ492dCatG4oqz8Ef8gFeintfw8L9oMg5Q6AGhThmtfYceSPWaqpBy4EP7AKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627436; c=relaxed/simple;
	bh=9GB6SEprNiFBYEiHriUs2J8kw4/LnSifnicL+HQchgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idAaNA1AiysQNrdq2N5zVSO3tLSGsT1vjzogqQ7h34dVBzTzAfqujpGp1aACoCSEw+PWynZ2c71lD5IB3znHWm2DE66Y4Xw2eagZI+X177/VXwbRM6bYq0qyC3LovWEJw02TTwnesAUrJzSN7YIacFM7Lq9NAYVHWom4gTZ8zQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rLEwC6Bv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A42C1F000E9;
	Tue, 16 Jun 2026 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627435;
	bh=MwrKsmsUo1fGODvWJfxjr5pJvui1OqYtqIJcnvMzqno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rLEwC6Bv6kJPYxe6ufrGIpKyCEPQAqrlF8uUmIZPY0lvGolvmVkZsizvMZBfSoQL4
	 o1GGwlq4T2kJuBw1u7HhpZpSuOu1hYKM/I9n2GrBJIwvIcRt6eq8JIshl+L3+1yX4r
	 dkrO8kQ0IpY0vy178TDS7wpIPnr+g2DnzK4vphFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arpith Kalaginanavoor <arpithk@nvidia.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: [PATCH 6.12 170/261] fs/qnx6: fix pointer arithmetic in directory iteration
Date: Tue, 16 Jun 2026 20:30:08 +0530
Message-ID: <20260616145052.947445753@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264706-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:arpithk@nvidia.com,m:brauner@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B1026926B8

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arpith Kalaginanavoor <arpithk@nvidia.com>

commit 89c4a1167f3a0a0efd2ec3e1801036d2eb65ae1a upstream.

The conversion to qnx6_get_folio() in commit b2aa61556fcf
("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
introduced a regression in directory iteration. The pointer 'de'
and the 'limit' address were calculated using byte offsets from
a char pointer without scaling by the size of a QNX6 directory
entry.

This causes the driver to read from incorrect memory offsets,
leading to "invalid direntry size" errors and premature
termination of directory scans.

Fix this by casting 'kaddr' to 'struct qnx6_dir_entry *' before
applying the offset and last_entry(...) increments. This allows the
compiler to correctly scale the pointer arithmetic by the 32-byte
stride of the directory entry structure.

Fixes: b2aa61556fcf ("qnx6: Convert qnx6_get_page() to qnx6_get_folio()")
Cc: stable@vger.kernel.org
Signed-off-by: Arpith Kalaginanavoor <arpithk@nvidia.com>
Link: https://patch.msgid.link/20260526123858.1683035-1-arpithk@nvidia.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/qnx6/dir.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -131,16 +131,16 @@ static int qnx6_readdir(struct file *fil
 		struct qnx6_dir_entry *de;
 		struct folio *folio;
 		char *kaddr = qnx6_get_folio(inode, n, &folio);
-		char *limit;
+		struct qnx6_dir_entry *limit;
 
 		if (IS_ERR(kaddr)) {
 			pr_err("%s(): read failed\n", __func__);
 			ctx->pos = (n + 1) << PAGE_SHIFT;
 			return PTR_ERR(kaddr);
 		}
-		de = (struct qnx6_dir_entry *)(kaddr + offset);
-		limit = kaddr + last_entry(inode, n);
-		for (; (char *)de < limit; de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
+		de = (struct qnx6_dir_entry *)kaddr + offset;
+		limit = (struct qnx6_dir_entry *)kaddr + last_entry(inode, n);
+		for (; de < limit; de++, ctx->pos += QNX6_DIR_ENTRY_SIZE) {
 			int size = de->de_size;
 			u32 no_inode = fs32_to_cpu(sbi, de->de_inode);
 



