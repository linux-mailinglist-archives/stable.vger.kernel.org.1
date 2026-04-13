Return-Path: <stable+bounces-237514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OkHC+Qm3WlpaQkAu9opvQ
	(envelope-from <stable+bounces-237514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:24:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF13F1573
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D90031253ED
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06A342501;
	Mon, 13 Apr 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uVJnhIAS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFE33F5AA;
	Mon, 13 Apr 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099653; cv=none; b=QE1aDa3dWG2+lRcpVkj0ikQoBqeLVTjtqhtQaSA3N/8/pkbOhqXIbGRcQrLMGtEa6FAl3QrvSBqbyQZZ9uVzYOuSZ42iWditmTavC+6hIG1fcbgPw2Pb+q3LcEau2JCq3ZRt2yqBLnLfYMxqe2bZk6/DgJixQ/rkXaI5q0sZbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099653; c=relaxed/simple;
	bh=B7zMmvH/GmCCp7wHzVycJNbJLulvEPO/6MF4Elz3dWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNRd6QtKLzUiipnjTEwCa9mt52oimLBBqMj8z+eGLMrsUZGRSxY6/Vap/QiV2oG0euuOjxC9JpjNSSz7O48l0Pd18OMM6H7qenTnAkgjcSh4uy5HWJZNzHHPDr3FZFE54Ex+Kt+6POZotTj17ys6tS849Wso5aPYFtWDHyBxXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uVJnhIAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AC3C2BCB3;
	Mon, 13 Apr 2026 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099653;
	bh=B7zMmvH/GmCCp7wHzVycJNbJLulvEPO/6MF4Elz3dWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVJnhIASAK7VpmxQ0OguPi/P1u27AO+xwga7UL8qdwBhNizBnsx47t5uSs1SfbiWp
	 pNo3T2n+9k8Sp5WHuTt53QAlXnSUYIOtz/yof166UnDoaoZfd+1cHNOq+N5im6nj19
	 Qspyw1PRUuGj5m3gb4g8katg3veD5EgOOunzMPhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 5.10 390/491] usb: ehci-brcm: fix sleep during atomic
Date: Mon, 13 Apr 2026 18:00:35 +0200
Message-ID: <20260413155833.635641690@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237514-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 77BF13F1573
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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



