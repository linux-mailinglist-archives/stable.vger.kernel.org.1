Return-Path: <stable+bounces-234297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJrjEkOf1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:32:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B81913C0EB4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15E830A2213
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D323ACF11;
	Wed,  8 Apr 2026 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FIa4LQa5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA134252D;
	Wed,  8 Apr 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672494; cv=none; b=rlHDjlDbw1aXMZydIZnQc8oub49RVJc0yDnAyTQCFwyWc3rIirtZ+gB+HoonycxJVifbu5gSDvAoGGhNOyovjsCEvrUDKY0C5IzB0tEqqgZD5TsTiFlptXvK8hUamwXZCVo/Iieo/he0qz1w48U6K9u8QyCArlib6BvCpv/HBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672494; c=relaxed/simple;
	bh=rPtR0sy2m+HcWqk1NZDSknP9QAXQxn9Ft0wkBerbJ8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJirinIYHKGxpoMfGJyoGmsFqrlgUbeJ1EREfDVBaGJ0rrsHUdHZ+kLjvJSUu5vkHUfjrvQDTv6tr809n9fbK6XH/Cdbmp0PCqQVVkZo1U1aVBMsJDbynKh72OUCox+hr73zS8pJOpbuJzynQyMWMfPoBuIhYlFaeXB4HFiGgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FIa4LQa5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7905DC19421;
	Wed,  8 Apr 2026 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672493;
	bh=rPtR0sy2m+HcWqk1NZDSknP9QAXQxn9Ft0wkBerbJ8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FIa4LQa5KV2Q31iobX6+dvSJZybykZ/KV3jMuFWBOwQ7Hgreb7BmpGBdVszolJYRf
	 LbCmn2oHjIKx2Efj7I1JwbgRxu73hUFd3glfkcJnVQaR0zKME8PM66k8ipR4izGTX7
	 Zil8u0FVf+WHwXJKRoSjcGglfaky39S6L6AigxY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rishon Jonathan R <mithicalaviator85@gmail.com>,
	Vincent MORVAN <vinc@42.fr>,
	Paul SAGE <paul.sage@42.fr>,
	Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 005/160] tg3: replace placeholder MAC address with device property
Date: Wed,  8 Apr 2026 20:01:32 +0200
Message-ID: <20260408175913.386503038@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,42.fr,broadcom.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-234297-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,42.fr:email]
X-Rspamd-Queue-Id: B81913C0EB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul SAGE <paul.sage@42.fr>

[ Upstream commit e4c00ba7274b613e3ab19e27eb009f0ec2e28379 ]

On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads
a default placeholder mac address (00:10:18:00:00:00) from the
mailbox. The correct value on those systems are stored in the
'local-mac-address' property.

This patch, detect the default value and tries to retrieve
the correct address from the device_get_mac_address
function instead.

The patch has been tested on two different systems:
- iMac 20,1 (BCM57766) model which use the local-mac-address property
- iMac 13,2 (BCM57766) model which can use the mailbox,
    NVRAM or MAC control registers

Tested-by: Rishon Jonathan R <mithicalaviator85@gmail.com>

Co-developed-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Paul SAGE <paul.sage@42.fr>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260314215432.3589-1-atharvatiwarilinuxdev@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index ea4973096aa28..840231ebbef71 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -16945,6 +16945,13 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
+static int tg3_is_default_mac_address(u8 *addr)
+{
+	static const u8 default_mac_address[ETH_ALEN] = { 0x00, 0x10, 0x18, 0x00, 0x00, 0x00 };
+
+	return ether_addr_equal(default_mac_address, addr);
+}
+
 static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 {
 	u32 hi, lo, mac_offset;
@@ -17016,6 +17023,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
+
+	if (tg3_is_default_mac_address(addr))
+		return device_get_mac_address(&tp->pdev->dev, addr);
+
 	return 0;
 }
 
-- 
2.53.0




