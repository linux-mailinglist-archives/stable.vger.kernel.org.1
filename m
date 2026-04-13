Return-Path: <stable+bounces-237327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EqsKNsf3WnYaAkAu9opvQ
	(envelope-from <stable+bounces-237327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:54:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 414783F033C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 490DA30472AD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F931B100;
	Mon, 13 Apr 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vbm7rC+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1F317167;
	Mon, 13 Apr 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099168; cv=none; b=jjp+Q9LYly1QwCvQBg7gjvGL1eW1m6ePTxz3aj68xQlw55QksUsL85wFwYIBqmwTGa4CQljzxgLtopNdF70bw/852eO7CsSQ8Iio7rHswCRSFsoLYbcee6g6y/4pmH8xOnV0a5uqmNPM4+FINsl/WM9ZrUpPlVFOx9ngHvB7EfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099168; c=relaxed/simple;
	bh=FSF9WuvyyDORs5U36aL/u2/l48/9yvuJDjurgXLoohE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Twwa4irylYQNw51O/0ftZrJCIhijk6jKfTjcqyvczp+QkBylOout+0l/jV3nZWL/SsjMB7mcnD+DlRWem323kUNd4dTOq7cTzBFCuXb05JZIga6xD7s0EKai4fIu/5WeeTeWdFJV3qXo+b7d8Z2Jtf2SnmRN00o8iOyVzyjrbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vbm7rC+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25874C2BCB7;
	Mon, 13 Apr 2026 16:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099168;
	bh=FSF9WuvyyDORs5U36aL/u2/l48/9yvuJDjurgXLoohE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vbm7rC+GnBmfFl2H63Wafx0PR8mVPfurzgNcChDFTsdclcO62NuwnyLs0KK2J18jG
	 vXgfRQY1xEPtDM21VoqOc1GwK0x9fpBxgu/PC3fhs6WIumt0Au/dBwHj7HQRvF/Ra+
	 2bKeRnbcr3vRXeEhtSrTnSgP1tTsTbOUby6p74zU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 5.10 236/491] xen/privcmd: add boot control for restricted usage in domU
Date: Mon, 13 Apr 2026 17:58:01 +0200
Message-ID: <20260413155827.893445246@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237327-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 414783F033C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 1613462be621ad5103ec338a7b0ca0746ec4e5f1 upstream.

When running in an unprivileged domU under Xen, the privcmd driver
is restricted to allow only hypercalls against a target domain, for
which the current domU is acting as a device model.

Add a boot parameter "unrestricted" to allow all hypercalls (the
hypervisor will still refuse destructive hypercalls affecting other
guests).

Make this new parameter effective only in case the domU wasn't started
using secure boot, as otherwise hypercalls targeting the domU itself
might result in violating the secure boot functionality.

This is achieved by adding another lockdown reason, which can be
tested to not being set when applying the "unrestricted" option.

This is part of XSA-482

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/privcmd.c    |   13 +++++++++++++
 include/linux/security.h |    1 +
 security/security.c      |    1 +
 3 files changed, 15 insertions(+)

--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -26,6 +26,7 @@
 #include <linux/miscdevice.h>
 #include <linux/moduleparam.h>
 #include <linux/notifier.h>
+#include <linux/security.h>
 #include <linux/wait.h>
 
 #include <asm/xen/hypervisor.h>
@@ -59,6 +60,11 @@ module_param_named(dm_op_buf_max_size, p
 MODULE_PARM_DESC(dm_op_buf_max_size,
 		 "Maximum size of a dm_op hypercall buffer");
 
+static bool unrestricted;
+module_param(unrestricted, bool, 0);
+MODULE_PARM_DESC(unrestricted,
+	"Don't restrict hypercalls to target domain if running in a domU");
+
 struct privcmd_data {
 	domid_t domid;
 };
@@ -1023,6 +1029,13 @@ static struct notifier_block xenstore_no
 
 static void __init restrict_driver(void)
 {
+	if (unrestricted) {
+		if (security_locked_down(LOCKDOWN_XEN_USER_ACTIONS))
+			pr_warn("Kernel is locked down, parameter \"unrestricted\" ignored\n");
+		else
+			return;
+	}
+
 	restrict_wait = true;
 
 	register_xenstore_notifier(&xenstore_notifier);
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -123,6 +123,7 @@ enum lockdown_reason {
 	LOCKDOWN_XMON_WR,
 	LOCKDOWN_BPF_WRITE_USER,
 	LOCKDOWN_DBG_WRITE_KERNEL,
+	LOCKDOWN_XEN_USER_ACTIONS,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
 	LOCKDOWN_KPROBES,
--- a/security/security.c
+++ b/security/security.c
@@ -60,6 +60,7 @@ const char *const lockdown_reasons[LOCKD
 	[LOCKDOWN_XMON_WR] = "xmon write access",
 	[LOCKDOWN_BPF_WRITE_USER] = "use of bpf to write user RAM",
 	[LOCKDOWN_DBG_WRITE_KERNEL] = "use of kgdb/kdb to write kernel RAM",
+	[LOCKDOWN_XEN_USER_ACTIONS] = "Xen guest user action",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
 	[LOCKDOWN_KPROBES] = "use of kprobes",



