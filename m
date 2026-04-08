Return-Path: <stable+bounces-235237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOvqC2ym1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:03:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A26453C2453
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DB14301CFD7
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C78352C3C;
	Wed,  8 Apr 2026 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OykeJMQP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33525A321;
	Wed,  8 Apr 2026 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674923; cv=none; b=m/JeesLMKXuCNaPmI93a0nPdGhPEoQnpy5oLuQ+RsgF4D9rytE3aHhgbsl0DKOG2Y0CSqqLDFNnCjYrBWZAl2ubT+CItKodrYX/0cUmdrTCq6S+Z3OJc0ugKJFnmQxnT1S/Mzs3gNE7BXk8HXHfVB8s5nu012aRs+Ftq3BCzKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674923; c=relaxed/simple;
	bh=QO/AY42o/rDkS6LnCZIGQXVKHek46vJa5XwP96Zx1wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayTTKtmnPK5rQjaG74DkHVtmMzKaEjx7nQY7pKmBJhqqnNra7OexeWR9PhKZ3WakKD98/JHNhcZeFshckz31/4Jq564lF74OnGvTh/Vw4FHsMSUrkN8CGg0iOx421xwn3mu4jEi1GMFoIwx7CrDDUxiw3tpCDbm07k9XKVdlB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OykeJMQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8012BC19421;
	Wed,  8 Apr 2026 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674922;
	bh=QO/AY42o/rDkS6LnCZIGQXVKHek46vJa5XwP96Zx1wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OykeJMQPZ0EzwGXsNOlFUyLmzY2C7H62P3zKmojvc5TmTpRQHXpg8IJpIjw/INQMU
	 mS4bS01JuENboBmiUx/7vSjL43Z1g4Q5Tztd8qL/eUaWYmjZk0Hxo9+qOoa7Ck8+U8
	 3K7f66Ttq9N25GYhia3Dyko2jgwlO1V4Kple5+6Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.19 242/311] usb: ehci-brcm: fix sleep during atomic
Date: Wed,  8 Apr 2026 20:04:02 +0200
Message-ID: <20260408175948.428115681@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235237-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: A26453C2453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



