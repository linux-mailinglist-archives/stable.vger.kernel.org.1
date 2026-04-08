Return-Path: <stable+bounces-234871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNQoHZ6i1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:46:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 199013C1802
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 787613036311
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8BC2641FC;
	Wed,  8 Apr 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qk6tr1dd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F93AEF5F;
	Wed,  8 Apr 2026 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673979; cv=none; b=UglLQja7SzRHrBaCE68DDUskiL1L8zRJsRrMs/gInaL2jJjjK5RCFRfc7WhBSZi9OY/Aj3lkPt2ENNb7oq/f2xtOB4tdgwBRLLHuZ3+b2atoCx40dM4Spo0FQjyrWAKifea7Bns+P8cWJbhPZs63hwAQDV3dgcVaO0TsqzByt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673979; c=relaxed/simple;
	bh=AGEtcqz83Aw5sc+0t3nvyMzubx1HV+LkJTWLiLUsT/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZF+AM9G/QfqCzE5BtfY6VVd4n8JhPE4e9uGYrJaWkyvv6URtyLk0AMlI7u3dvg2cHpbkColu+TmYWYRPmOQQ/AVZafDF/jjZri2FwnbLJ9Vu6Xw2Dc3IhwWHSagVrANRC2ky9htAd860s60Z0XD0kx6NCzv6Tw4CxVfwvTaBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qk6tr1dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4D1C2BC9E;
	Wed,  8 Apr 2026 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673978;
	bh=AGEtcqz83Aw5sc+0t3nvyMzubx1HV+LkJTWLiLUsT/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qk6tr1dd2CPjubtWXW6vJtHFOtLHO28T7dQ90Nbx3oPadgCvvGTurEqAfkNLzPwrI
	 QU/cgxBiQYcxvyQHTFwFEZNbEDQ4I8px9nYGWqFKwQY69OYZL1Ug+neUkQHBRQFvxb
	 MlswjXZC/u98br9Q0Gqi47tIEusEKP8Cx+9OrALc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.12 162/242] usb: ehci-brcm: fix sleep during atomic
Date: Wed,  8 Apr 2026 20:03:22 +0200
Message-ID: <20260408175933.152581409@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234871-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 199013C1802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justin.chen@broadcom.com>

commit 679b771ea05ad0f8eeae83e14a91b8f4f39510c4 upstream.

echi_brcm_wait_for_sof() gets called after disabling interrupts
in ehci_brcm_hub_control(). Use the atomic version of poll_timeout
to fix the warning.

Fixes: 9df231511bd6 ("usb: ehci: Add new EHCI driver for Broadcom STB SoC's")
Cc: stable <stable@kernel.org>
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20260318185707.2588431-1-justin.chen@broadcom.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ehci-brcm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/ehci-brcm.c
+++ b/drivers/usb/host/ehci-brcm.c
@@ -31,8 +31,8 @@ static inline void ehci_brcm_wait_for_so
 	int res;
 
 	/* Wait for next microframe (every 125 usecs) */
-	res = readl_relaxed_poll_timeout(&ehci->regs->frame_index, val,
-					 val != frame_idx, 1, 130);
+	res = readl_relaxed_poll_timeout_atomic(&ehci->regs->frame_index,
+						val, val != frame_idx, 1, 130);
 	if (res)
 		ehci_err(ehci, "Error waiting for SOF\n");
 	udelay(delay);



