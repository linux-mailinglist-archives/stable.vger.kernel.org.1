Return-Path: <stable+bounces-245455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OZKJpgcA2pD0gEAu9opvQ
	(envelope-from <stable+bounces-245455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:27:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C595520159
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDDD430229D1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7E38D415;
	Tue, 12 May 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oh3jRgqI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0A372061
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588816; cv=none; b=b/vytR7KWuYLI3dSp3/v1oegi38s3ypGc75QIvy/v4c6CvijUSklR6PUZVFMtXrAwA0dzHk6kDM2uakDUm7fPz/f1rl43FmmDFeSp3mWkQZs86flfhO6n7L/HAZ9JMGziCs1Ff7MwkCyswDvuMP5mQDZFzGRKFTdunCANIlKSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588816; c=relaxed/simple;
	bh=3X9zzFpy6FXwb6IHFaDJwvDAZLPqSSYGMlRSrypdW/w=;
	h=Subject:To:Cc:From:Date:Message-ID; b=XF6NleDbcGVuS1C3GidiOHzPUHeF/FaDf+aDcqBGqMaptZecsK89dp9pEo7DlpWf/boKjpJa0FqR3K15IMsbHRmJTd1jA4KsNmVHN8WNgvE2xuC+PdWV2ZQYecPJgyOPQTGpfsN4zOiNCIJGQl74raCLH24ns/re/a0Zqh4LzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oh3jRgqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DFDC2BCB0;
	Tue, 12 May 2026 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778588814;
	bh=3X9zzFpy6FXwb6IHFaDJwvDAZLPqSSYGMlRSrypdW/w=;
	h=Subject:To:Cc:From:Date:From;
	b=oh3jRgqI8Jj4HFT80ethoOidxXWMzLKFE4TcO3XugIKo4NmHGEn4BgB8qpIBgBK2V
	 4myf8vh8QYyulALYc4NKnu89eYmxGdkabIgCUnY71Pw0ZrnT1OeH6cPsCgYmEypfQd
	 NvwnlwJBzY8Ae2/ksuasX+kk4KgL0E1230dtejBY=
Subject: FAILED: patch "[PATCH] usb: dwc3: Move GUID programming after PHY initialization" failed to apply to 6.12-stable tree
To: selvarasu.g@samsung.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,pritam.sutar@samsung.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 14:26:46 +0200
Message-ID: <2026051246-fool-grumble-b747@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 2C595520159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245455-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x aad35f9c926ec220b0742af1ada45666ae667956
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051246-fool-grumble-b747@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aad35f9c926ec220b0742af1ada45666ae667956 Mon Sep 17 00:00:00 2001
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
Date: Fri, 17 Apr 2026 12:03:11 +0530
Subject: [PATCH] usb: dwc3: Move GUID programming after PHY initialization

The Linux Version Code is currently written to the GUID register before
PHY initialization. Certain PHY implementations (such as Synopsys eUSB
PHY performing link_sw_reset) clear the GUID register to its default
value during initialization, causing the kernel version information to
be lost.

Move the GUID register programming to occur after PHY initialization
completes to ensure the Linux version information persists.

Fixes: fa0ea13e9f1c ("usb: dwc3: core: write LINUX_VERSION_CODE to our GUID register")
Cc: stable <stable@kernel.org>
Reported-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260417063314.2359-1-selvarasu.g@samsung.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 58899b1fa96d..65213896de99 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1359,12 +1359,6 @@ int dwc3_core_init(struct dwc3 *dwc)
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		return ret;
@@ -1398,6 +1392,12 @@ int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
 
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc, DWC3_GUID, LINUX_VERSION_CODE);
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 


