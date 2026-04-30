Return-Path: <stable+bounces-242073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB3nGk0o82mwxgEAu9opvQ
	(envelope-from <stable+bounces-242073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:00:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A14A0664
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37317304B2A0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36C3ACA5D;
	Thu, 30 Apr 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A3Njnx4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9063A6B68;
	Thu, 30 Apr 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542332; cv=none; b=CvZBqkL4CRwTH32MFAHOsZmImfb2/hz3DJsNPw4jXBOxTfb0/lhShuv9CLfEHLiIx9BwEiMm49rnZgAWD2g5VwA+b2YR7DDc7MOCfNxYfoJPLtdNfYWuxwppk/bLzb9zCn49x5lRR00LwMiBBZmwlQr0rHm+ff+metqrI5r9/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542332; c=relaxed/simple;
	bh=MjxwqqaU3hhTRFqdasRyycj9/LGTTmT3foM20G0pE+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGgR4aS0tpeHsJd0898oEMHNQ6CmSwpi7esIPaCsxUlC4gwrS7kM2cqNa4XHtR3ZrmnmxhK39epnnfo6X6puxp5+vKGsNBfLZBnR9/ajuR+3iQ1hi1bvYA04bpPJzQp2F8a6o4WiEadZowjj4jfrylVjSdJYoVIM2YD/lsfi+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A3Njnx4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F87C2BCB4;
	Thu, 30 Apr 2026 09:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777542332;
	bh=MjxwqqaU3hhTRFqdasRyycj9/LGTTmT3foM20G0pE+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A3Njnx4hpQ0HgwjElp+c0h8J+1KA2H+gzOkSYElmdo08rzhttzw9i9PtyU1c5Tlub
	 Iyh9vxQqjLMMuqbFXnRiGiDN2YPOiJ2xzvPxPAnGwRCEuZMoTiZ8MdZl4Be6qVjmFS
	 aIQHfa/GbbrjmT4Hbdcm1WGdH6zEOYvoAnmxisxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.18.26
Date: Thu, 30 Apr 2026 11:44:43 +0200
Message-ID: <2026043013-carmaker-dispatch-fa91@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026043013-dingbat-underline-1169@gregkh>
References: <2026043013-dingbat-underline-1169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D8A14A0664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242073-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

diff --git a/Makefile b/Makefile
index c8343ec96a09..f1b9b5849b79 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 25
+SUBLEVEL = 26
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index cbc62f0df11b..f37d8d212c06 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1619,6 +1619,12 @@ static void privcmd_close(struct vm_area_struct *vma)
 	kvfree(pages);
 }
 
+static int privcmd_may_split(struct vm_area_struct *area, unsigned long addr)
+{
+	/* Forbid splitting, avoids double free via privcmd_close(). */
+	return -EINVAL;
+}
+
 static vm_fault_t privcmd_fault(struct vm_fault *vmf)
 {
 	printk(KERN_DEBUG "privcmd_fault: vma=%p %lx-%lx, pgoff=%lx, uv=%p\n",
@@ -1630,6 +1636,7 @@ static vm_fault_t privcmd_fault(struct vm_fault *vmf)
 
 static const struct vm_operations_struct privcmd_vm_ops = {
 	.close = privcmd_close,
+	.may_split = privcmd_may_split,
 	.fault = privcmd_fault
 };
 
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 2f880374b463..c1a0ca1b1b5f 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -366,6 +366,8 @@ static ssize_t buildid_show(struct hyp_sysfs_attr *attr, char *buffer)
 			ret = sprintf(buffer, "<denied>");
 		return ret;
 	}
+	if (ret > PAGE_SIZE)
+		return -ENOSPC;
 
 	buildid = kmalloc(sizeof(*buildid) + ret, GFP_KERNEL);
 	if (!buildid)
@@ -373,8 +375,10 @@ static ssize_t buildid_show(struct hyp_sysfs_attr *attr, char *buffer)
 
 	buildid->len = ret;
 	ret = HYPERVISOR_xen_version(XENVER_build_id, buildid);
-	if (ret > 0)
-		ret = sprintf(buffer, "%s", buildid->buf);
+	if (ret > 0) {
+		/* Build id is binary, not a string. */
+		memcpy(buffer, buildid->buf, ret);
+	}
 	kfree(buildid);
 
 	return ret;

