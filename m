Return-Path: <stable+bounces-218433-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMvnE9hTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218433-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40418FA67
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27CEC30D4235
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C621EB5E1;
	Wed, 25 Feb 2026 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GbAPz9Kp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA718B0A;
	Wed, 25 Feb 2026 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983254; cv=none; b=S4LDOEbfs0mUg51XeEtpLH8+FSAKYdqAJu/eOH6JyMGQWWHpVzPbMWkAnlQ7X5YI6WxFxyP+k8/Cbm1xB2Bdt/8NBtUsV5dMXBCZPIIXG20ET4Sf1cA0Rx2DBh74hgSJkUPKQAdAp4kfK4z8XD2k/KOnVDjkL0A4UBQ47EUT0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983254; c=relaxed/simple;
	bh=TUwIWqLQow2Qn1+toAUtxIqWCGDv6CgdNN8AhGjEfSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YL7vCFcJaQybVYE5Ua9wCNei1MejFuPQyTX1XEOBbHuEiVK/AL7sT8nb26UNRTWOtNoP7eJyun45rm+ovJSAdw6d0+jdvwf26sRWnRDX0FnK3Z3jDSh7svVs2axDx1zzPGFAydL6lw5d4OUgeei5cUqAlN5wzRQA6CjRe80CyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GbAPz9Kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED136C116D0;
	Wed, 25 Feb 2026 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983254;
	bh=TUwIWqLQow2Qn1+toAUtxIqWCGDv6CgdNN8AhGjEfSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbAPz9Kp1oHJ9bO0NllNHqeIDDTbCZN/CDvUSN4iVJ4O0ipOe3BhsMZPHtr1vPFx6
	 uYN/WeFEWGh0YOt3BZeLC18ReE7QnD1LkbNy+zPPcbx7X86acb0ci/Pu5IIZSTmYMl
	 KUKaTKFclnl0MFNLVtutOv2Jz7Kpqd/IUNv6TPz4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Zilin Guan <zilin@seu.edu.cn>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 353/781] wifi: rtw89: debug: Fix memory leak in __print_txpwr_map()
Date: Tue, 24 Feb 2026 17:17:42 -0800
Message-ID: <20260225012408.346914374@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218433-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,seu.edu.cn:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7A40418FA67
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 6070a44051b1c35714fa130de7726cfe91ca5559 ]

In __print_txpwr_map(), memory is allocated to bufp via vzalloc().
If max_valid_addr is 0, the function returns -EOPNOTSUPP immediately
without freeing bufp, leading to a memory leak.

Since the validation of max_valid_addr does not depend on the allocated
memory, fix this by moving the vzalloc() call after the check.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: 036042e15770 ("wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips")
Suggested-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Reviewed-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20260116130834.1413924-1-zilin@seu.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1264c2f82600b..987eef8170f2b 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -825,10 +825,6 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 	s8 *bufp, tmp;
 	int ret;
 
-	bufp = vzalloc(map->addr_to - map->addr_from + 4);
-	if (!bufp)
-		return -ENOMEM;
-
 	if (path_num == 1)
 		max_valid_addr = map->addr_to_1ss;
 	else
@@ -837,6 +833,10 @@ static ssize_t __print_txpwr_map(struct rtw89_dev *rtwdev, char *buf, size_t buf
 	if (max_valid_addr == 0)
 		return -EOPNOTSUPP;
 
+	bufp = vzalloc(map->addr_to - map->addr_from + 4);
+	if (!bufp)
+		return -ENOMEM;
+
 	for (addr = map->addr_from; addr <= max_valid_addr; addr += 4) {
 		ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, addr, &val);
 		if (ret)
-- 
2.51.0




