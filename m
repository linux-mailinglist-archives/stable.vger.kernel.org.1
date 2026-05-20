Return-Path: <stable+bounces-249956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLYDNojHDWr93AUAu9opvQ
	(envelope-from <stable+bounces-249956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBF658FC66
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6382F303B6B2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06683233958;
	Wed, 20 May 2026 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+hfom+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8D3E1D16
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287889; cv=none; b=gZ4g1Glk2SkwYw5SvjfmDkTqusb+/MqQ8VXqj4bzIOG+6yb0jZIuRvxATVKX0nqXh52o6YNw7j1ObH003qdqJlJedOmV/AwEsLblJTBU561UH832zufO+jcpVbdK00b9vy7aBwify/LHUDAKkghcDNOdV/Gcmf3i89Q/IquP73M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287889; c=relaxed/simple;
	bh=gooRKoCZbJ4YQWubavNCNNkvu2cZaoaSK3kVtUouhC4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hb5X2ZbPI2jbqkOW9yI7rDzMaC3QdiJkqJ487T1U3fHqMQXU7LNbwwAqmc4fo6dBLW9VyiNtKkoCJZ0pdQNOMtFDgkyj5rruJh7Ddr+Cg8/ECYCei3H37REoe1ptVvY5D6wAlT9H7L4r0ENV1N3jG3Ekxb0iDns0Rb7gN9QeaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+hfom+W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654FF1F000E9;
	Wed, 20 May 2026 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779287887;
	bh=2l5EigCaKs7okWJEczIAaq1TS2/7CB5vK7wzUh2TKj4=;
	h=Subject:To:Cc:From:Date;
	b=S+hfom+W+QGHgVHZeCDmp/aUcU1GkjsmomqqDdI1rmXDswMMnqKyTRtBxzGb/v01G
	 KgZnCq7VNMVGAcX6EBnriFI21k2EkKIaJ685gLxfqhT5PZABZuj0P4EhufKTdDehhC
	 Jt7qv8HMVNqtuXDck7oodVbcKKuxOnv96qMAmx50=
Subject: FAILED: patch "[PATCH] platform/x86: intel: Move debugfs register before creating" failed to apply to 6.12-stable tree
To: srinivas.pandruvada@linux.intel.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:38:11 +0200
Message-ID: <2026052011-viewpoint-showoff-4451@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249956-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 8BBF658FC66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ad3bff944c0f4f2e913298a9664391af32f87491
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052011-viewpoint-showoff-4451@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ad3bff944c0f4f2e913298a9664391af32f87491 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Thu, 30 Apr 2026 08:11:01 -0700
Subject: [PATCH] platform/x86: intel: Move debugfs register before creating
 devices
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It is possible that the driver handling device is enumerated before
registering debugfs. If the driver wants to access debugfs by calling
tpmi_get_debugfs_dir(), this will return error in this case.

Hence register debugfs before creating devices.

Fixes: 811f67c51636 ("platform/x86/intel/tpmi: Add new auxiliary driver for performance limits")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stable@vger.kernel.org
Link: https://patch.msgid.link/20260430151103.1549733-2-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/intel/vsec_tpmi.c b/drivers/platform/x86/intel/vsec_tpmi.c
index 7fc6ff8d1040..a38014e81e85 100644
--- a/drivers/platform/x86/intel/vsec_tpmi.c
+++ b/drivers/platform/x86/intel/vsec_tpmi.c
@@ -817,10 +817,6 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 
 	auxiliary_set_drvdata(auxdev, tpmi_info);
 
-	ret = tpmi_create_devices(tpmi_info);
-	if (ret)
-		return ret;
-
 	/*
 	 * Allow debugfs when security policy allows. Everything this debugfs
 	 * interface provides, can also be done via /dev/mem access. If
@@ -830,6 +826,12 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 	if (!security_locked_down(LOCKDOWN_DEV_MEM) && capable(CAP_SYS_RAWIO))
 		tpmi_dbgfs_register(tpmi_info);
 
+	ret = tpmi_create_devices(tpmi_info);
+	if (ret) {
+		debugfs_remove_recursive(tpmi_info->dbgfs_dir);
+		return ret;
+	}
+
 	return 0;
 }
 


