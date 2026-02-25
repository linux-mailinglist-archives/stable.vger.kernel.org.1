Return-Path: <stable+bounces-218379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI5aHZNTnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E9618F911
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F419C31B60A2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA96251795;
	Wed, 25 Feb 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HGVuJn/A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D631D5ABA;
	Wed, 25 Feb 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983191; cv=none; b=JU9MtYM5Gu2QsonGqMbmQ74NPx8JX9l3R18lBmgvyWBJNxCAYy20p1XYVA8NqkndrY+p7udWI2WQM5TlFrIDtAFZB8Y8aSpFBdoWsFmt9J9Afn14P7ZlczCovXqbGAj+0pUpUvLuNuC6/wMXhsWG1IObP3gWjUwF8ICwhYzsxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983191; c=relaxed/simple;
	bh=w8l1rbQxRISOy9tGgCL6vaZIg+MzUf2/7CF8FzmO800=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBoJ6203gVG5xSdejQWTMZavBva4aQxePslH5oYjr+4VQ3SNutKufoLaAowMVM7rozjojhuwzejcDdo8h8dHqVCbiQkdFO71qYI01/zJKEZVxuUy668WNnVZqOhJU1Q7pb10ODR3mYhdjzEj2bgbuLuCsIVK+fY8yEJLLR+Kk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HGVuJn/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D08C116D0;
	Wed, 25 Feb 2026 01:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983191;
	bh=w8l1rbQxRISOy9tGgCL6vaZIg+MzUf2/7CF8FzmO800=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGVuJn/AJHJORDM77hSY0I0a59Zjl26wvsbWnGn2zFvk/FI3AJeq36KdRuE8OZVOx
	 SoHvGuZQTnkNfJ33PQ9RehVWDp2hRBB84Xtwu2JKtWhwE04ywka/Pz/nCjMON9R4tz
	 B7LEJ3EtalMxvosoY8enac1WaUzgC+YUggbHyuwQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 339/781] PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
Date: Tue, 24 Feb 2026 17:17:28 -0800
Message-ID: <20260225012408.007648587@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218379-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 27E9618F911
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit 99ee5837c63d1000f9ce7508591486a7bd8bdedb ]

The API comment for of_find_i2c_adapter_by_node() recommends using
put_device() to drop the reference count of I2C adapter instead of using
i2c_put_adapter(). So replace i2c_put_adapter() with put_device().

Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260115-pci-pwrctrl-rework-v5-3-9d26da3ce903@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index ec423432ac655..0a63add84d095 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -533,7 +533,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	ctx->client = i2c_new_dummy_device(ctx->adapter, addr);
 	if (IS_ERR(ctx->client)) {
 		dev_err(dev, "Failed to create I2C client\n");
-		i2c_put_adapter(ctx->adapter);
+		put_device(&ctx->adapter->dev);
 		return PTR_ERR(ctx->client);
 	}
 
@@ -613,7 +613,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	tc9563_pwrctrl_power_off(ctx);
 remove_i2c:
 	i2c_unregister_device(ctx->client);
-	i2c_put_adapter(ctx->adapter);
+	put_device(&ctx->adapter->dev);
 	return ret;
 }
 
@@ -623,7 +623,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 
 	tc9563_pwrctrl_power_off(ctx);
 	i2c_unregister_device(ctx->client);
-	i2c_put_adapter(ctx->adapter);
+	put_device(&ctx->adapter->dev);
 }
 
 static const struct of_device_id tc9563_pwrctrl_of_match[] = {
-- 
2.51.0




