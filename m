Return-Path: <stable+bounces-236680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAwpJAkh3WneaAkAu9opvQ
	(envelope-from <stable+bounces-236680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9003F073A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52745328EFAD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA542E11B9;
	Mon, 13 Apr 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ovK6BpoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21E7306B0A;
	Mon, 13 Apr 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097528; cv=none; b=CnRenASm45Oq/uTMsaXQyN13BEsWtxCGZ4WnHPlBQQS3U6XYHBoH8AKNVIHDa4cmgC9+WrByYUGAeltcE4TTTrrcUaTxhlWoG9NWyzTdUW+L4ED2neLyYbLA+dtZ0UwVfVNgtRadbOwf5lxMgLePaDEPfgP5jPgTyzBy51ehr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097528; c=relaxed/simple;
	bh=n+nigzL3F98FBrizZdEw4RlfeSAZPoL2G4lb5u8oSIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTyXSjdY81pxKhqtHFlIiJwezQ/qG5Y6eL4mbYs0D728LnpnfmqPSwcmSp8uC501SeXrG7nBpxpA70HTTuW4jnWDAO4Nzb/4eqO4D7DobY7xqk/3pbMxafaJ6s+53STxY1VwF0T7MKBWRpFOADqecZkb8juFA9sEf9+s0olrInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ovK6BpoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789A5C2BCB0;
	Mon, 13 Apr 2026 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097527;
	bh=n+nigzL3F98FBrizZdEw4RlfeSAZPoL2G4lb5u8oSIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovK6BpoFl/WoEEbKHI3ljQbmo7o2Jc6yaw86Pq8F8Payw5CfMyaZlANBoSgRjQ5PA
	 SGtzQde3yFHvnxEaz3Z5fXpaJf4ho+ovbCd3wK3UWZdWNftgv4P0bFOMvO3OMEWUtV
	 x7oj3dCGY4o7Hcnnl1ZLE/Er5LMFg0j+fQgIdKsU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fan Wu <fanwu01@zju.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 172/570] net: ethernet: arc: emac: quiesce interrupts before requesting IRQ
Date: Mon, 13 Apr 2026 17:55:03 +0200
Message-ID: <20260413155836.897979675@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236680-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zju.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF9003F073A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fan Wu <fanwu01@zju.edu.cn>

commit 2503d08f8a2de618e5c3a8183b250ff4a2e2d52c upstream.

Normal RX/TX interrupts are enabled later, in arc_emac_open(), so probe
should not see interrupt delivery in the usual case. However, hardware may
still present stale or latched interrupt status left by firmware or the
bootloader.

If probe later unwinds after devm_request_irq() has installed the handler,
such a stale interrupt can still reach arc_emac_intr() during teardown and
race with release of the associated net_device.

Avoid that window by putting the device into a known quiescent state before
requesting the IRQ: disable all EMAC interrupt sources and clear any
pending EMAC interrupt status bits. This keeps the change hardware-focused
and minimal, while preventing spurious IRQ delivery from leftover state.

Fixes: e4f2379db6c6 ("ethernet/arc/arc_emac - Add new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Link: https://patch.msgid.link/20260309132409.584966-1-fanwu01@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/arc/emac_main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -934,6 +934,17 @@ int arc_emac_probe(struct net_device *nd
 	/* Set poll rate so that it polls every 1 ms */
 	arc_reg_set(priv, R_POLLRATE, clock_frequency / 1000000);
 
+	/*
+	 * Put the device into a known quiescent state before requesting
+	 * the IRQ. Clear only EMAC interrupt status bits here; leave the
+	 * MDIO completion bit alone and avoid writing TXPL_MASK, which is
+	 * used to force TX polling rather than acknowledge interrupts.
+	 */
+	arc_reg_set(priv, R_ENABLE, 0);
+	arc_reg_set(priv, R_STATUS, RXINT_MASK | TXINT_MASK | ERR_MASK |
+		    TXCH_MASK | MSER_MASK | RXCR_MASK |
+		    RXFR_MASK | RXFL_MASK);
+
 	ndev->irq = irq;
 	dev_info(dev, "IRQ is %d\n", ndev->irq);
 



