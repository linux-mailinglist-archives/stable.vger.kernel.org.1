Return-Path: <stable+bounces-246815-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEyDCjpgBGqiHQIAu9opvQ
	(envelope-from <stable+bounces-246815-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C575323BF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4259A3013AB0
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D013D525B;
	Wed, 13 May 2026 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuUsxv4B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C512C027A
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671669; cv=none; b=mcLzzNg4HZfAmPPtOkDZINcHcLqsMrjK83tmLoEKNQMRDoYtxl19M4g/YHqQj1zJ4GkZTqjKpMZHemYmnw5GVgQN9zPWYqKJLMAjJAvdsy5l0N2ZZpN6wwRXRm+ijlQK3Z0R6LOULpiTgnFQiopCegSpoRs1RNJFYWdDGMyv2ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671669; c=relaxed/simple;
	bh=hIMwtu1BGZ6nIdRrCxIzKid56GjxB6cT1kpq1ZI2Z+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdMxm2uB7UtxWgwHEWgohEWs3VmzMC0Q9BLmCBfV179hyYwJ7+zcGHC+H7gjt5hJw7P66KrP3mY2vAGeVaTXap6Nzu6x5ONleweCQLXKDWC1vuIC2CJHiEoJZSua6IMgZ/PRcgRGe3n17q+vnqeqa7j7hd0Cfs2a2WCbz1Jnb7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuUsxv4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92861C2BCB8;
	Wed, 13 May 2026 11:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778671669;
	bh=hIMwtu1BGZ6nIdRrCxIzKid56GjxB6cT1kpq1ZI2Z+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CuUsxv4BGNfOTzYZpy1A/DajQbRkmgr4N1v0SO8YufLvxwOPL/7V77v6/Ux2KgU8e
	 1z9mMaa8a3+E5TP7atp6eRTNBOxztaHVeHO4T+wPADidsqV2KtFqet453Ic7sZr93W
	 qgr1V76l//CJUPcTHXnoVXg9zfhvkj5aiEeCHcH86n85deG/X3RKK5GNdtnBOss8T3
	 BswCPJh0ZKw24ewu4+vu4gWaBz+pydBQKYKynYqU/PqmMBNGt5tiTlqYiBdRQsbRNS
	 c97J5h90u2JSoAQaT4TZ6ItAHfPQjVK5eZv8dcMNCh/vMwPb/ty49i9fvexkxvHGg2
	 A4zN02La6t6mA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	stable <stable@kernel.org>,
	Pritam Manohar Sutar <pritam.sutar@samsung.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] usb: dwc3: Move GUID programming after PHY initialization
Date: Wed, 13 May 2026 07:27:44 -0400
Message-ID: <20260513112744.3646168-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513112744.3646168-1-sashal@kernel.org>
References: <2026051240-configure-sizably-846f@gregkh>
 <20260513112744.3646168-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21C575323BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246815-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,samsung.com:email]
X-Rspamd-Action: no action

From: Selvarasu Ganesan <selvarasu.g@samsung.com>

[ Upstream commit aad35f9c926ec220b0742af1ada45666ae667956 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c5bec0bd9cb10..a1f99c3b5f378 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1339,12 +1339,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
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
@@ -1376,6 +1370,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
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
 
-- 
2.53.0


