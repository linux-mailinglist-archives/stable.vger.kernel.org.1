Return-Path: <stable+bounces-227994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNR+GFVFwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-227994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4B2F3577
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B28FD30255FC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2433ACA5C;
	Mon, 23 Mar 2026 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VBnVWRfx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F63A6B88;
	Mon, 23 Mar 2026 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273803; cv=none; b=qn2y2Epgmhl6knDuijKkZ39nyf9dvdQ/Oh2crI05IYnDN/6UYA5UXPb72A62loPLEH9x5S7zeC1n5xegPYvECLXFaEJA0IU0GXfQl516wrDiBe0gfgPWQsOqGPzwW1zNpIMEfFc2kq+nZni5/Q1L1EB+jba8uLuQ6zPrpp5ESoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273803; c=relaxed/simple;
	bh=fjnJO+5OCdwKKr/PZePzPX3+9+lmExRp7U02qVFXxCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNZiCZTUqErNdoX0TtNj4wOamiqj45OFc1R/K8BVO+ZG4zGV/Cpe2QC5OhUPzaMRBEAhooaonDQIAtZFV13dZnqthYHosulNGksGvjb0/ub5aIo97SyROiobESWfJxTLuGvaGyaODdwHyZPSCC+NMgd57ZNN8ETK7oHv4+EADt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VBnVWRfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2687DC4CEF7;
	Mon, 23 Mar 2026 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273802;
	bh=fjnJO+5OCdwKKr/PZePzPX3+9+lmExRp7U02qVFXxCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBnVWRfxcpjZfPXH1DDWUBUIP/LmYMU3cuBhJmqZp1zGJRAm9aBc/MI0LrtUTNbOt
	 LMYMHdrxOVsbo79h++cFS6MIc85E/6cmCG3phzcvVkDzLGS4FH9c0TkMwLSZpB3zCj
	 t2ItaTcyo4tbMfPXq8PcdW+IwphfOVRD8YaX2N90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Ray <ian.ray@gehealthcare.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 014/220] NFC: nxp-nci: allow GPIOs to sleep
Date: Mon, 23 Mar 2026 14:43:11 +0100
Message-ID: <20260323134505.026657127@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227994-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gehealthcare.com:email]
X-Rspamd-Queue-Id: 00E4B2F3577
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Ray <ian.ray@gehealthcare.com>

commit 55dc632ab2ac2889b15995a9eef56c753d48ebc7 upstream.

Allow the firmware and enable GPIOs to sleep.

This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
connected to I2C GPIO expanders.

-- >8 --
kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
-- >8 --

Fixes: 43201767b44c ("NFC: nxp-nci: Convert to use GPIO descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Link: https://patch.msgid.link/20260317085337.146545-1-ian.ray@gehealthcare.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/nxp-nci/i2c.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -47,8 +47,8 @@ static int nxp_nci_i2c_set_mode(void *ph
 {
 	struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
 
-	gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
-	gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
 	usleep_range(10000, 15000);
 
 	if (mode == NXP_NCI_MODE_COLD)



