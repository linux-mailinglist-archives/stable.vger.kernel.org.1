Return-Path: <stable+bounces-229081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG5IOFNswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:37:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3562F876F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA0630C29F4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CAB3AF669;
	Mon, 23 Mar 2026 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TWAOtS3s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC75B26ED46;
	Mon, 23 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277999; cv=none; b=ExtJB6+ivOv6vdyuP5V30XKHevkxpvGuYTN5DYNR2CFdr83a4+Ae8UiTuDjDANhwcyHteo8B894UtNe2wOa5guNjMRkvmYMarsUv2AQasfnUvGg7M72nYyjXssjj+4ocElytydbQwLUCP8CJ+OQnalxSDBX3fW5+6cFNWi3E64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277999; c=relaxed/simple;
	bh=Pb3n0EmLggoQG+eFLHXFxMUV0FYJBtmt/sM8o9bQWMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTGhZ24H40Bgwi9IoQGYzSlMq2/N9YXjqqOZtXYxdOR3pjuD7INYLAdENhdLEJjL5KID8MV6/NyBrJ/UQ6ioZRmpUS06DpaGtR2rbbo//ahAOQM2PtPFheicSELJAxjaCDOT8Acd1c4RAGKhcY6Qxx24AyQUaAM3g7ihBaIFUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TWAOtS3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B0C4CEF7;
	Mon, 23 Mar 2026 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277999;
	bh=Pb3n0EmLggoQG+eFLHXFxMUV0FYJBtmt/sM8o9bQWMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWAOtS3sdiwtC42VNfMwoYn/prUK6KBSGDlo9wJlJUIhQoeb0JztpQjqkTt7dlDkb
	 jesQxeK/TtfrJ0Cu7i9d3ych1fh6y9os9RowGTR7uQw+ghfxJgR/4uEDxmTE3gVKE/
	 +QSbfaA4JYm3Ry5Hpf3o+DkiY/6eVRhGwrSCaxV8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/567] amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds
Date: Mon, 23 Mar 2026 14:41:02 +0100
Message-ID: <20260323134537.329670164@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229081-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3C3562F876F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raju Rangoju <Raju.Rangoju@amd.com>

[ Upstream commit 9439a661c2e80485406ce2c90b107ca17858382d ]

Extend the MAC_TCR_SS (Speed Select) register field width from 2 bits
to 3 bits to properly support all speed settings.

The MAC_TCR register's SS field encoding requires 3 bits to represent
all supported speeds:
  - 0x00: 10Gbps (XGMII)
  - 0x02: 2.5Gbps (GMII) / 100Mbps
  - 0x03: 1Gbps / 10Mbps
  - 0x06: 2.5Gbps (XGMII) - P100a only

With only 2 bits, values 0x04-0x07 cannot be represented, which breaks
2.5G XGMII mode on newer platforms and causes incorrect speed select
values to be programmed.

Fixes: 07445f3c7ca1 ("amd-xgbe: Add support for 10 Mbps speed")
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Link: https://patch.msgid.link/20260226170753.250312-1-Raju.Rangoju@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index aa25a8a0a106f..d99d2295eab0f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -514,7 +514,7 @@
 #define MAC_SSIR_SSINC_INDEX		16
 #define MAC_SSIR_SSINC_WIDTH		8
 #define MAC_TCR_SS_INDEX		29
-#define MAC_TCR_SS_WIDTH		2
+#define MAC_TCR_SS_WIDTH		3
 #define MAC_TCR_TE_INDEX		0
 #define MAC_TCR_TE_WIDTH		1
 #define MAC_TCR_VNE_INDEX		24
-- 
2.51.0




