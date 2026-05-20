Return-Path: <stable+bounces-250158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aILuHJ/uDWpb4wUAu9opvQ
	(envelope-from <stable+bounces-250158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0DF593A06
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66B2F35D3E83
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A395E3CAE61;
	Wed, 20 May 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqAj887i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093F3C3458;
	Wed, 20 May 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294696; cv=none; b=FDwZ67Cf7Oc+jPcERM8gC600bZHXr+CfwJeap3KDOFRxtJE45qZODDXMSMGYba8lyLDg6Hu4odZKMR9N1NZ6tEi57Kadvm5CiQo7BcKmFOZI06yDWGROs59guPy6OUyKCgywHkQi0CB3ml9GE/KgQ6r1DXlfMJxXkSjOFwuwAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294696; c=relaxed/simple;
	bh=DK0IlJoTvGfgycoXf8NQ48p/zaT9nFJ0okpf+JApnz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbQhGr2wn3V6eKKT+GbTPN30by85aCN+1jxaKR66lkaQe/2ur2gUbCIawEyjYL+RFnRjb77FtKRWepeGabymXKXsEdCVoUtd8MhA31cOXkC2O5gtT0LjQyyH1Q97MerE1AbTwr8uLhs+9B931nAkTI5KhRXwteHYu1v3FdhhGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqAj887i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F41F000E9;
	Wed, 20 May 2026 16:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294695;
	bh=yolM2qp7mZZsM6feCcudGihGxpHjbhc16SPdO7RhJdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqAj887imqx5ItKHGTwGskJTrW6PvWTzKRd0uLjUUVssHsZMQkD7pCZqMDLHkstBf
	 TB93dcyYaErfhJJvUsR4hvliXV6Ii8GReo3tXwyyePvrrtmlgL7PhO5HfzAiRCWe5E
	 zcRK7bbqF4ugp8JQOh9DXSHs3tj/qXiBGYqN0/zY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0138/1146] wifi: rtw89: phy: fix uninitialized variable access in rtw89_phy_cfo_set_crystal_cap()
Date: Wed, 20 May 2026 18:06:28 +0200
Message-ID: <20260520162151.440322526@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250158-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ispras.ru:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,realtek.com:email]
X-Rspamd-Queue-Id: DB0DF593A06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>

[ Upstream commit 047cddf88c611e616d49a00311d4722e46286234 ]

In the rtw89_phy_cfo_set_crystal_cap() function, for chips other than
RTL8852A/RTL8851B, the values read by rtw89_mac_read_xtal_si() are
stored into the local variables sc_xi_val and sc_xo_val. If either
read fails, these variables remain uninitialized, they are later
used to update cfo->crystal_cap and in debug print statements. This
can lead to undefined behavior.

Fix the issue by initializing sc_xi_val and sc_xo_val to zero,
like is implemented in vendor driver.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 8379fa611536 ("rtw89: 8852c: add write/read crystal function in CFO tracking")
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260323140613.1615574-1-a.velichayshiy@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ee6ab2136b9a7..ee8a36003e5da 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4860,7 +4860,7 @@ static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 sc_xi_val, sc_xo_val;
+	u8 sc_xi_val = 0, sc_xo_val = 0;
 
 	if (!force && cfo->crystal_cap == crystal_cap)
 		return;
-- 
2.53.0




