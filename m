Return-Path: <stable+bounces-246874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLBcHkGVBGqrLgIAu9opvQ
	(envelope-from <stable+bounces-246874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:14:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D620A535DC1
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6113A3175A49
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EEB3126B2;
	Wed, 13 May 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur0FZEoX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E23311592
	for <stable@vger.kernel.org>; Wed, 13 May 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681356; cv=none; b=TT1pdquRNi4yWKC2ipZ1kcD9uAV7HIHBbkoHG6OnYxoVX+PEHRlKXlloYdnkFxGcwKjRjc4y4N5/hA6YdTxIc8BS0FIu8OZJg7YDKuiM5tTP8kBlWJuwWOlZaQDzsJts/xlLqkwiG1TZgXVo1wBmP8naHG71f8k1rUlDces8eSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681356; c=relaxed/simple;
	bh=VnXjZ6AJVxVYzsJ68WzbQlHx/iUQzt7aJedAHNU8Nm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zsg4Z7fqftVBd5OfkTis8Ztx9EbCnevYg4IktW9E08WXettdfAemA7wqMR5URvKw1X+A/KSisg7Rx2WOEOdtNU/TdtYETHgKbm9kur3h3bhJRoZ1DdEVd3kWayzCceZ8fm7OmFqJLPKoNXuN+Ca0jFhC4+7yCU/EdGR4WDkm180=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ur0FZEoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE54C19425;
	Wed, 13 May 2026 14:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681356;
	bh=VnXjZ6AJVxVYzsJ68WzbQlHx/iUQzt7aJedAHNU8Nm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ur0FZEoXRCEe1/ZprjmAT5yYeyxSNPsCbbXd5M2wl2mMNi9Ix3obJzw+miu+d01Zx
	 fOg7gRLX4tGADTNO4svQDUhDShT9T4xBZ1gp4imnarmPyPzCLk23N4bxMxzxVUseCn
	 2ejabuh5Fv5vDxoLq2wIKX47g5xCG1Bb8KNiJzVQm/zd7yZBBDP8RftVzzokEZxaaO
	 r5DzyOKcw27ZMhm8F/Jpib4zYG/Puh/H5fVFkOrVnUW5OxWyBdx+wE4Iufi790LdiO
	 6b0AxXuznYM2mH+p0slMXC627zkv4DNpagS+cUdb7/YgTMaMiYOkSdr7UoRaZpyMR+
	 MHw5BEh7NDxRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	stable <stable@kernel.org>,
	Pritam Manohar Sutar <pritam.sutar@samsung.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: dwc3: Move GUID programming after PHY initialization
Date: Wed, 13 May 2026 10:09:13 -0400
Message-ID: <20260513140913.3746791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051247-tyke-varmint-56e0@gregkh>
References: <2026051247-tyke-varmint-56e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D620A535DC1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246874-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,synopsys.com:email,samsung.com:email]
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
[ adapted dwc3_writel(dwc, ...) to dwc3_writel(dwc->regs, ...) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 77be06b680914..a115fd874cee6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -978,12 +978,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		goto err0;
@@ -1023,6 +1017,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err1;
 
+	/*
+	 * Write Linux Version Code to our GUID register so it's easy to figure
+	 * out which kernel version a bug was found.
+	 */
+	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
+
 	dwc3_core_setup_global_control(dwc);
 	dwc3_core_num_eps(dwc);
 
-- 
2.53.0


