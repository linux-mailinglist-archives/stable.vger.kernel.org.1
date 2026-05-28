Return-Path: <stable+bounces-254893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK0OJnEsGGqwfAgAu9opvQ
	(envelope-from <stable+bounces-254893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:52:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F200E5F1974
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41AA030892F8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF293B2FF5;
	Thu, 28 May 2026 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0+2g1Yr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E492FE591
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968846; cv=none; b=biULgU18dOBIQzLauANMgf1AZkU14aMfNAN6LNsDa696crL9xpfMALPgMnh71t+5ZOY6XDHtJsOvRIestUZfnGcpYbNl91yJYryXRgZYh9yEiSg6z/jFYFw+lFw8DtPLh4rkJFdoy6eG/F2Y9NAJlfHpIOGbCD2r3Hs5n5+5Lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968846; c=relaxed/simple;
	bh=SFb1w6j3prrMBtLcz0p+FBqkq9WzITyj1PkUqo4t7RM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bpxI48XWhSoOXRKLHV4yYgVI2ZrLRsA2Hgciy99YB1ieDjOvFTDtOmNVh3LKJO1PTItOG6kKqbR1YO+SB6VsihnVV9nr4X+z9JVSuRrNzwxxJ+FBNuduT1MlyxFByCAtSfqvjIhosqctj7XJd0PKE6nrOIsEe2PbfoAJdAooxTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0+2g1Yr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7091F000E9;
	Thu, 28 May 2026 11:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968844;
	bh=taHepqvuRKZ1IDDx4ZOka0Gd1RH4kCnVe0TRx10NUgY=;
	h=Subject:To:Cc:From:Date;
	b=C0+2g1YrL8fvYNzheuhFlmV0PKsHdBZ4fp4hACNc2egA7QVzpjs6rvLQFWvXb+Cq8
	 Aie9RsmGvoODHz1Z7O8jqiFYj2hVVLubYft9ub+XQ6J5KX/C70Z5n0PsUSYA8D8VZD
	 PiGlJVC4kfDZO9DuoNo8PtexU4WHECqhYq7ybG8s=
Subject: FAILED: patch "[PATCH] s390/cio: Restore GFP_DMA for CHSC allocation" failed to apply to 6.12-stable tree
To: oberpar@linux.ibm.com,agordeev@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:46:23 +0200
Message-ID: <2026052823-removing-pretended-b7d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254893-lists,stable=lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: F200E5F1974
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ea34567db0a6b3a7ce78ba421592344315c8f90e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052823-removing-pretended-b7d6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea34567db0a6b3a7ce78ba421592344315c8f90e Mon Sep 17 00:00:00 2001
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Date: Thu, 7 May 2026 16:27:08 +0200
Subject: [PATCH] s390/cio: Restore GFP_DMA for CHSC allocation

Re-add GFP_DMA when allocating memory for CHSC control blocks.
On some supported machines, CHSC cannot access memory outside
the DMA zone, causing CHSC command failures.

Cc: stable@vger.kernel.org
Fixes: a3a64a4def8d ("s390/cio: remove unneeded DMA zone allocation")
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index fbb58edd6274..9689f722c863 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1142,8 +1142,8 @@ int __init chsc_init(void)
 {
 	int ret;
 
-	sei_page = (void *)get_zeroed_page(GFP_KERNEL);
-	chsc_page = (void *)get_zeroed_page(GFP_KERNEL);
+	sei_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	chsc_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sei_page || !chsc_page) {
 		ret = -ENOMEM;
 		goto out_err;
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 73413417a2ce..b6cb8bb8bcc4 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -292,7 +292,7 @@ static int chsc_ioctl_start(void __user *user_area)
 	if (!css_general_characteristics.dynio)
 		/* It makes no sense to try. */
 		return -EOPNOTSUPP;
-	chsc_area = (void *)get_zeroed_page(GFP_KERNEL);
+	chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
 	if (!chsc_area)
 		return -ENOMEM;
 	request = kzalloc_obj(*request);
@@ -340,7 +340,7 @@ static int chsc_ioctl_on_close_set(void __user *user_area)
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
-	on_close_chsc_area = (void *)get_zeroed_page(GFP_KERNEL);
+	on_close_chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
 	if (!on_close_chsc_area) {
 		ret = -ENOMEM;
 		goto out_free_request;
@@ -392,7 +392,7 @@ static int chsc_ioctl_start_sync(void __user *user_area)
 	struct chsc_sync_area *chsc_area;
 	int ret, ccode;
 
-	chsc_area = (void *)get_zeroed_page(GFP_KERNEL);
+	chsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!chsc_area)
 		return -ENOMEM;
 	if (copy_from_user(chsc_area, user_area, PAGE_SIZE)) {
@@ -438,7 +438,7 @@ static int chsc_ioctl_info_channel_path(void __user *user_cd)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scpcd_area;
 
-	scpcd_area = (void *)get_zeroed_page(GFP_KERNEL);
+	scpcd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scpcd_area)
 		return -ENOMEM;
 	cd = kzalloc_obj(*cd);
@@ -500,7 +500,7 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scucd_area;
 
-	scucd_area = (void *)get_zeroed_page(GFP_KERNEL);
+	scucd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scucd_area)
 		return -ENOMEM;
 	cd = kzalloc_obj(*cd);
@@ -563,7 +563,7 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *sscud_area;
 
-	sscud_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sscud_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sscud_area)
 		return -ENOMEM;
 	cud = kzalloc_obj(*cud);
@@ -625,7 +625,7 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *sci_area;
 
-	sci_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sci_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sci_area)
 		return -ENOMEM;
 	ci = kzalloc_obj(*ci);
@@ -696,7 +696,7 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 		u32 res;
 	} __attribute__ ((packed)) *cssids_parm;
 
-	sccl_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccl_area)
 		return -ENOMEM;
 	ccl = kzalloc_obj(*ccl);
@@ -756,7 +756,7 @@ static int chsc_ioctl_chpd(void __user *user_chpd)
 	int ret;
 
 	chpd = kzalloc_obj(*chpd);
-	scpd_area = (void *)get_zeroed_page(GFP_KERNEL);
+	scpd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scpd_area || !chpd) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -796,7 +796,7 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 		u8 data[PAGE_SIZE - 36];
 	} __attribute__ ((packed)) *sdcal_area;
 
-	sdcal_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sdcal_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sdcal_area)
 		return -ENOMEM;
 	dcal = kzalloc_obj(*dcal);
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index d13ed1011c03..171212a6d2d9 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -229,7 +229,7 @@ int scm_update_information(void)
 	size_t num;
 	int ret;
 
-	scm_info = (void *)__get_free_page(GFP_KERNEL);
+	scm_info = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
 	if (!scm_info)
 		return -ENOMEM;
 


