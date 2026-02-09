Return-Path: <stable+bounces-215007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLBNOsPwiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:35:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8731107C7
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62696307B7EB
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B2837B41E;
	Mon,  9 Feb 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mrM84TfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399D37B40A;
	Mon,  9 Feb 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647361; cv=none; b=CoYYUYAsptZ7VgqewdqJFip03+QvDuBGiEBNtCm+zR3E/xEefBJmBuJPOqjMVfNYYZDvZw/5FlTl9LuKKngLcSlhBIYEbypQsbbvevwWhocKfvWBuTzMn2lknix4fleoHysahky20ZCed8pF9GuyrYvNxxz7YBOtf+AHgqmzXsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647361; c=relaxed/simple;
	bh=nRIHrOgYVnusXRl4m4vu9dtuOxbXoAjWzRH2ol0JrsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6Elz3dUkSHGJ1kVwX3xC0efqqtDdSOVadS9VqUANW8RyVmOJ39MHbphCmCp53AYOVR12FXL2ziYS5NCiN2WiOGxVO2Vc/thLMOh/WwA1Lxnceb94EPiCNwLR4pCMhQuoXMnv2xGz0DD1lzbpYhMKhYmejCBkVlzgicckkYby9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mrM84TfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5A2C116C6;
	Mon,  9 Feb 2026 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647361;
	bh=nRIHrOgYVnusXRl4m4vu9dtuOxbXoAjWzRH2ol0JrsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mrM84TfYjXv1/X55Oz305eMplAXtPKV+tG5b7L+mzJcZpFMNc9ViG8VKPuIZubkAw
	 yYU/7RwKW9Qfu5MZajY0Vdb69895IhQygBtcy9TzT5Ukj9kwtzY91RYKFzi29tiK2S
	 PUd3Y4hwQzTD+ztGz2WXvfi6GBeKNmUzrStMNhyk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Even Xu <even.xu@intel.com>,
	Rui Zhang <rui1.zhang@intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 077/175] HID: Intel-thc-hid: Intel-thc: Add safety check for reading DMA buffer
Date: Mon,  9 Feb 2026 15:22:30 +0100
Message-ID: <20260209142323.216006334@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215007-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4C8731107C7
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Even Xu <even.xu@intel.com>

[ Upstream commit a9a917998d172ec117f9e9de1919174153c0ace4 ]

Add DMA buffer readiness check before reading DMA buffer to avoid
unexpected NULL pointer accessing.

Signed-off-by: Even Xu <even.xu@intel.com>
Tested-by: Rui Zhang <rui1.zhang@intel.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
index a0c368aa7979c..6ee675e0a7384 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c
@@ -575,6 +575,11 @@ static int read_dma_buffer(struct thc_device *dev,
 		return -EINVAL;
 	}
 
+	if (!read_config->prd_tbls || !read_config->sgls[prd_table_index]) {
+		dev_err_once(dev->dev, "PRD tables are not ready yet\n");
+		return -EINVAL;
+	}
+
 	prd_tbl = &read_config->prd_tbls[prd_table_index];
 	mes_len = calc_message_len(prd_tbl, &nent);
 	if (mes_len > read_config->max_packet_size) {
-- 
2.51.0




