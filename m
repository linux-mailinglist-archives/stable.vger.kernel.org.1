Return-Path: <stable+bounces-242075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F39MFYm82mZxgEAu9opvQ
	(envelope-from <stable+bounces-242075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:52:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E434A037F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32F93308CDB3
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3FA3FB07A;
	Thu, 30 Apr 2026 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H4W59MvG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3BF3FFAC2;
	Thu, 30 Apr 2026 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542355; cv=none; b=NdORIR7879uTWJNL0K79CUV561+nQdPjOJ4oWU/cIC72ONSRapcE+svT2FkCeKFrXFbCQXoYV25ZxSIxaY9P7dZhQDq24WUu2p9FXNmpPoOnfXDcEi9DsVrF2UR+3uFzOfZOIMZ1Ghl2w2nRB7dOstHUwaXyyx9eTinU9+OP2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542355; c=relaxed/simple;
	bh=UpDLWD4oxHyFP99ch3aJwxBm+h7KtymOvkDKAk24mLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKOjyJG29yHoEclcbyEX99vEYVuTeHIpwNhSYiSFab3+X3zbJWgzUBMp+gHYhDWYDhxFrPH3LHFGBtP3TGIf5IwmDgYSJ8C6EmlkVKXqiY5yF8zW3wm6aa7yIadcTDQWXs2J1J3g+mVy3jkLft5Eeily3Ui6TCibj4NxbloMEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H4W59MvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DEEC2BCB3;
	Thu, 30 Apr 2026 09:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777542355;
	bh=UpDLWD4oxHyFP99ch3aJwxBm+h7KtymOvkDKAk24mLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4W59MvGF9qUiuM4XtsCdNzmpDThGKLlck1tzpV0ZANlO6j9FGjOOG1VT1Pg3eyA5
	 JqmqIzAx8zC4mlahXpS1K1Kc8a3iWjjPpkEBfisC+i+BEA04Mk2IVBdrAvHEOorbRg
	 Ncj/M1+sfLGTfulL4tkVOVK5I7IvGbbnV1x4GwIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.3
Date: Thu, 30 Apr 2026 11:45:06 +0200
Message-ID: <2026043052-repent-reckless-1967@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026043052-coasting-tinwork-27b5@gregkh>
References: <2026043052-coasting-tinwork-27b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71E434A037F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242075-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]

diff --git a/Makefile b/Makefile
index b17ca865bcee..61f8019efd5a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 2
+SUBLEVEL = 3
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 15ba592236e8..725a49a0eee7 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1620,6 +1620,12 @@ static void privcmd_close(struct vm_area_struct *vma)
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
@@ -1631,6 +1637,7 @@ static vm_fault_t privcmd_fault(struct vm_fault *vmf)
 
 static const struct vm_operations_struct privcmd_vm_ops = {
 	.close = privcmd_close,
+	.may_split = privcmd_may_split,
 	.fault = privcmd_fault
 };
 
diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index b1bb01ba82f8..91923242a5ae 100644
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

