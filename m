Return-Path: <stable+bounces-245662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDH6FFg0A2oA1gEAu9opvQ
	(envelope-from <stable+bounces-245662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1753521F9E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A72B73085DA6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD93A7182;
	Tue, 12 May 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gX2Wg7E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8F23D290
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594573; cv=none; b=tYONaP/K1IpFuCVpwTUn4O/EIfj5uPWFX4YGcZnpJYlGR57AdwmhA/0uAKOOis80jxqfXQAOVA3l4JOYJr/N5etvX2SB9jvHpZ9grHULZGVaxs5sZbdZBlLYkhzN+ZBEmIMnX+/oWfawa8H86D/96DdcXpMNfSD2acqHh1oyuxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594573; c=relaxed/simple;
	bh=FnT3it2uS2j3rvjP51NUiWGuFuczCgM3YY7cQ4ofiXo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hHC/I8UTCZKrABUJqwMaKogi8axIKrGTMyxhCeXnno1EnEvmTwbXelxOJhwGgxFdP87CtGRGT0lFqPDDl1pr9u8Tjo8+JjlxEfBLSI0S9KR3ly6l2+BOzde64v9S4NiobKUavtLYoOLsLi4NQgztYOMSWT87ymN9q6QIG3XS1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gX2Wg7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D6FC2BCB0;
	Tue, 12 May 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594573;
	bh=FnT3it2uS2j3rvjP51NUiWGuFuczCgM3YY7cQ4ofiXo=;
	h=Subject:To:Cc:From:Date:From;
	b=2gX2Wg7E5HPD9ARFse75sEyMiYag1HurTg0EvhNmpa/754D/wP2AQgj4+AhtMBc46
	 qCygekS5sKYQxrSYaTB7yUJYbz9zyGrGb0hdmx4yOOgjD/Bpfq2hOHRUfNKit3isOe
	 B2USmDl0nBUfoAibBAHRYCmlc17wk5HE5B7Llli8=
Subject: FAILED: patch "[PATCH] iommufd: Fix return value of iommufd_fault_fops_write()" failed to apply to 6.12-stable tree
To: zhenzhong.duan@intel.com,baolu.lu@linux.intel.com,jgg@nvidia.com,kevin.tian@intel.com,praan@google.com,xueshuai@linux.alibaba.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:00:40 +0200
Message-ID: <2026051240-paralyses-sprawl-a7f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1753521F9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245662-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,nvidia.com:email,msgid.link:url,alibaba.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aaca2aa92785a6ab8e3183e7184bca447a99cd76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051240-paralyses-sprawl-a7f1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aaca2aa92785a6ab8e3183e7184bca447a99cd76 Mon Sep 17 00:00:00 2001
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
Date: Sun, 29 Mar 2026 23:07:55 -0400
Subject: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()

copy_from_user() may return number of bytes failed to copy, we should
not pass over this number to user space to cheat that write() succeed.
Instead, -EFAULT should be returned.

Link: https://patch.msgid.link/r/20260330030755.12856-1-zhenzhong.duan@intel.com
Cc: stable@vger.kernel.org
Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index f1e686b3a265..710eef0b6004 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -187,9 +187,10 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 
 	mutex_lock(&fault->mutex);
 	while (count > done) {
-		rc = copy_from_user(&response, buf + done, response_size);
-		if (rc)
+		if (copy_from_user(&response, buf + done, response_size)) {
+			rc = -EFAULT;
 			break;
+		}
 
 		static_assert((int)IOMMUFD_PAGE_RESP_SUCCESS ==
 			      (int)IOMMU_PAGE_RESP_SUCCESS);


