Return-Path: <stable+bounces-215049-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FW7MurviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215049-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:32:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C8C110651
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D7C9300D0E9
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F937BE78;
	Mon,  9 Feb 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pj0eoFYD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA2285060;
	Mon,  9 Feb 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647504; cv=none; b=KjpCmjjh7jJTihB6+3gOWJdOvhejHukVu/MvSzNXFFImXDyQn49im5Cq1j13QiVmzNtcNxSUBSqI7qF1u/7CNpEOFGups84v/w23t9tS/fyr7G2x6etorxUejsXQXbqib9nwZ7hOMU9fnzgrkLnC3mZa16nm4qtfaWOsjfBCFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647504; c=relaxed/simple;
	bh=A2n79W7GpKVHsvK+O5dJj0qFggABBHeC0eWmXJNases=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEAU1zx0Br431ipj/UTEaWSA8iMNBT6ibjoyICihIIifOi6Upel+Lg4mhDqUzMSJe1EdwlObef0/QHZlF6KjDajpbFghY7HZZQQOQt4G2kXYiAIHYatooW3O1+Wgn3dNITG5ODiDm+N1OTYJe2QTU/bKFKPgDbgu2R0wLKMNluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pj0eoFYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E027C16AAE;
	Mon,  9 Feb 2026 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647504;
	bh=A2n79W7GpKVHsvK+O5dJj0qFggABBHeC0eWmXJNases=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pj0eoFYDK/c6qlwNNWYj5179qMR4XXWzsDYozZ4hCEadyrEameO3Rpe0O2w2RGPcf
	 jwtQJml4n0Eyon8Z5uHMF+aYAS3iB+rGXoTkEmjaio8f42ArGn4L9Sik6lYO/btJTD
	 3cfIbxS0zOjRyX9UpWMkIn7IjR/T02eN7o84BauI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leo Banno-Cloutier <leobannocloutier@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 118/175] hwmon: (dell-smm) Add Dell G15 5510 to fan control whitelist
Date: Mon,  9 Feb 2026 15:23:11 +0100
Message-ID: <20260209142324.655978229@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215049-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,roeck-us.net,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 89C8C110651
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: leobannocloutier@gmail.com <leobannocloutier@gmail.com>

[ Upstream commit 830e0bef79aaaea8b1ef426b8032e70c63a58653 ]

On the Dell G15 5510, fans spin at maximum speed when AC power is
connected. This behavior has been observed as a regression in recent
kernels (v6.18+).

Add the Dell G15 5510 to the fan control whitelist to enable manual fan
control and resolve the issue. This model requires the same fan control
configuration as the Dell G15 5511.

Fixes: 1c1658058c99 ("hwmon: (dell-smm) Add support for automatic fan mode")
Signed-off-by: Leo Banno-Cloutier <leobannocloutier@gmail.com>
Link: https://lore.kernel.org/r/20260117015315.214569-2-leobannocloutier@gmail.com
[groeck: Updated patch description to follow guidance]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 8cf12b9bae2a7..f3d484a9f708b 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1630,6 +1630,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
 		},
 		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
 	},
+	{
+		.ident = "Dell G15 5510",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Dell G15 5510"),
+		},
+		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
+	},
 	{
 		.ident = "Dell G15 5511",
 		.matches = {
-- 
2.51.0




