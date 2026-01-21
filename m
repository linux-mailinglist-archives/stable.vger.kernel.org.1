Return-Path: <stable+bounces-211026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PiBL8QicWl8eQAAu9opvQ
	(envelope-from <stable+bounces-211026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:02:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DBE5BBDD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ADC6A80E018
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395D3AE715;
	Wed, 21 Jan 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7+ApCvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E333C52D;
	Wed, 21 Jan 2026 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020185; cv=none; b=HlBCN8ZkLSG9D2kXDlU8sNrVQL7CCeLyhnKuG8bixYzDrZfdSBSpGBVWgp8s/6BDONdG6l1wdweNhAdvW6lISJNhLs2iXHkMX+BprcFaxvoxIgQ/Lld39GlAGlqpcM4UaNe+qh7ObORsGFknVL5FEtNMnLi4y0+WG2qs1jZG8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020185; c=relaxed/simple;
	bh=mDMWJXvKuWkX9AzpGVCKb5rSN01T8WyyN38qbRh1D8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfOFWVErutmZnsLwR3CzQ/g/wu6IT7z1TMBZaISHSvvidh5s/VInaxhFZ/XGRZgoz9PhJTBRWxEtpEJ0WLdY/8cpulJIEFP2SfPuOGRkU6/IMCX8bOqQkL0+Lv8IDa9xOtA0elI31LAZ9apfdFLaUJdLRpvieVLfdliBVzVxXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7+ApCvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC38C4CEF1;
	Wed, 21 Jan 2026 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020185;
	bh=mDMWJXvKuWkX9AzpGVCKb5rSN01T8WyyN38qbRh1D8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7+ApCvrrfyEbSmmeIWBSAdakIlmLuDnRyI1WtxxfRcMEXG1eJEXDmMy6t8cnn64/
	 dwrh0zEksWtAR8A8Z9sqtmb9ioODVYVebP3cAXbWZUC2vna/vlrGegyLduWgb35dju
	 ljbie+5hyCFkNs0O2aRvRmT1bFlm9VW9aC6spkcc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 084/198] soundwire: bus: fix off-by-one when allocating slave IDs
Date: Wed, 21 Jan 2026 19:15:12 +0100
Message-ID: <20260121181421.583443571@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211026-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 14DBE5BBDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit 12d4fd9a657174496677cff2841315090f1c11fc ]

ida_alloc_max() interprets its max argument as inclusive.

Using SDW_FW_MAX_DEVICES(16) therefore allows an ID of 16 to be
allocated, but the IRQ domain created for the bus is sized for IDs
0-15.  If 16 is returned, irq_create_mapping() fails and the driver
ends up with an invalid IRQ mapping.

Limit the allocation to 0-15 by passing SDW_FW_MAX_DEVICES - 1.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512240450.hlDH3nCs-lkp@intel.com/
Fixes: aab12022b076 ("soundwire: bus: Add internal slave ID and use for IRQs")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260110201959.2523024-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus_type.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 91e70cb46fb57..5c67c13e57357 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -105,7 +105,7 @@ static int sdw_drv_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = ida_alloc_max(&slave->bus->slave_ida, SDW_FW_MAX_DEVICES, GFP_KERNEL);
+	ret = ida_alloc_max(&slave->bus->slave_ida, SDW_FW_MAX_DEVICES - 1, GFP_KERNEL);
 	if (ret < 0) {
 		dev_err(dev, "Failed to allocated ID: %d\n", ret);
 		return ret;
-- 
2.51.0




