Return-Path: <stable+bounces-117718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3402A3B833
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0EF17FDC5
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D61DE89A;
	Wed, 19 Feb 2025 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IYE38sjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2803188CCA;
	Wed, 19 Feb 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956147; cv=none; b=aR3TVvB4tyEpy6F6bD83MJ9dNk+h1W8wF1gNjhjSMbQuaBloLH2lFhGRLYjAO2WERIFPMR2d0/dBe0IODGTFHblUEArgrxTzmx024BUoH9tomEPl/NRSsOendOjE25vmZZvr3D/rt93pDissVLQmzoMkBpnDLOZbG7S0LzUtcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956147; c=relaxed/simple;
	bh=9EgrYnvilNV6RXsyxG5UZI96QBxpGcJk22/wKUvdQTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQHwwLxpUIni36j6S0ycTYxXP1+Otw4avBrIq6MDHZEtzlh6z6WoEfT5cms8js9TncsqmknVOgrHf2VpNE4iI2wVpnMndEenZXWcyqjD3qW6/uwhEc0zL9TsnaT0PfJlAXyyzGYKrNbUNIpjkloqJYGMXhPtye1ewCO66+grOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IYE38sjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B447C4CED1;
	Wed, 19 Feb 2025 09:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956146;
	bh=9EgrYnvilNV6RXsyxG5UZI96QBxpGcJk22/wKUvdQTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYE38sjF8TWQr42Ac3o46/UhP9z45Dua4uLCSBIRiE3aOds+cL27gVlSxCbED10Qk
	 8V4dpL+UuBLIPyhinxQC56Frb8L3B86yRzYbKi+PA0HOds0t5B1mJsIFR6IhZIDqDm
	 ME9KU5PJLSOn2H5b37sFhDqOYQuKxquaQ1dcx7RM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/578] wifi: rtlwifi: fix init_sw_vars leak when probe fails
Date: Wed, 19 Feb 2025 09:20:43 +0100
Message-ID: <20250219082654.432799899@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

[ Upstream commit 00260350aed80c002df270c805ca443ec9a719a6 ]

If ieee80211_register_hw fails, the memory allocated for the firmware will
not be released. Call deinit_sw_vars as the function that undoes the
allocationes done by init_sw_vars.

Fixes: cefe3dfdb9f5 ("rtl8192cu: Call ieee80211_register_hw from rtl_usb_probe")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20241107133322.855112-5-cascardo@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 038d9bb652b64..1753eccbefdd9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1082,6 +1082,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 
 error_init_vars:
 	wait_for_completion(&rtlpriv->firmware_loading_complete);
+	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 error_out:
 	rtl_deinit_core(hw);
 error_out2:
-- 
2.39.5




