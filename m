Return-Path: <stable+bounces-246844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBOVBRx1BGprIQIAu9opvQ
	(envelope-from <stable+bounces-246844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:57:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3675336FE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD6131B3FB6
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CD429825;
	Wed, 13 May 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bht02YRU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028B42B754
	for <stable@vger.kernel.org>; Wed, 13 May 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676543; cv=none; b=nviT55seR6pwWsX9CGFegayynjEdu+sA71PQcTVcdszYsJYHflkqzMEeu7jCdU4u5xKPlvOgUJTz78eSMMoma3yyVQHF8teoh29Hy66Wn79ti3wbbOavfObJ51DcHpw6Q4pjG6lDMPNW2+K85T4Y8HhZ7rso9QRNKzjZgMy2LkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676543; c=relaxed/simple;
	bh=/kCQ9F0+A6iE50KxDwql1d7sbuaJfgpqxLDwbwdGJFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfsUDoyuR956lFSJ4QsoPexkKRq0J07Y2Ej2ac0mEaNZUt4QQS8bljq++Mv9R4VXxyEydcI/9cYrZ+XinbIOqv+U2OrcG5uFTC0ACxy7MlHuuqILoeFsq6yUoQljYK9IvIz3yzZCwuONsYAhIG2iQlgCp+yz7g9coq+MoUcZRTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bht02YRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40CAC2BCC7;
	Wed, 13 May 2026 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778676542;
	bh=/kCQ9F0+A6iE50KxDwql1d7sbuaJfgpqxLDwbwdGJFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bht02YRUOBAVca8vww7CtZuvoS0lvKnwrlBeCdsSYlp7wXlY17dY+YjXa+qUTol5d
	 xxodNnJbZupQaiWFFwwV3pbHivBp+8YOxILES43vS/mfE5XLlXl+kAyh0aZumj9foi
	 EJ4phfPxrYEDMOPlEYPrLIHRaBgrIpcr0VS9hxBP4PgTLiF9cwHLk8bf/FiuCkmWTo
	 47Zt9kj8gio7ZmYRFeqG9UtsHmuPAnliDCD9LbOVX+ogKHp3TR0pd6WCzA8CR5B2bR
	 C3W/zGC9jQgO2X7VpvRoeVlQi/RP9oZbwJXjj0sWcVRoxqIYJYe/LM3Gc0nwMB0C83
	 BdhMIn3kLuBkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>,
	stable <stable@kernel.org>,
	Pritam Manohar Sutar <pritam.sutar@samsung.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: dwc3: Move GUID programming after PHY initialization
Date: Wed, 13 May 2026 08:49:00 -0400
Message-ID: <20260513124900.3713317-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051246-fool-grumble-b747@gregkh>
References: <2026051246-fool-grumble-b747@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5E3675336FE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246844-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synopsys.com:email]
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
index 526b6a1fa3540..2cdb073aff724 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1336,12 +1336,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
-	/*
-	 * Write Linux Version Code to our GUID register so it's easy to figure
-	 * out which kernel version a bug was found.
-	 */
-	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
-
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		return ret;
@@ -1373,6 +1367,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (ret)
 		goto err_exit_phy;
 
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


