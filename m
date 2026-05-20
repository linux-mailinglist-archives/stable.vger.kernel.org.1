Return-Path: <stable+bounces-252251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNNqAIv6DWrh5AUAu9opvQ
	(envelope-from <stable+bounces-252251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:16:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5365595B4B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E6A0318BABE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A073F8707;
	Wed, 20 May 2026 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0FkDomZn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D23E832A;
	Wed, 20 May 2026 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300188; cv=none; b=OYWmLVUwp2UbOqd7QnGU+vRNPYRWp7JRLdd14LE3X9yNyPAZLLqdl7KCQoy936FDXHpbADR9hPp1O0VpXVKxOM2eNVSr3yKs3O0Lk5XWw8MdRFhawC/iffVCsLXViGZ/U5qGgNTpQDfEXulfRahXKBItXKuwCpnIWlHCpOP6uR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300188; c=relaxed/simple;
	bh=ZabyJAIM17S7zvcf/BImerIe2RqQPGL0e0bk1/3FmMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfRQA1ac7IrxlqEykypGL7dBvW/1sF6RXu2Hf4WInd96/rMWos7v/X4NfFKLcSFz8FyHbhKSFpAW4vjIXHqGm14tI9uAQNuNkdVcE38TZJZoI3IyNtZSCmC91lYLU88xRqXUhEYE1pCG9oGjPGOG6E6YZOhDQHKTk6bw7s68jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0FkDomZn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2E41F00894;
	Wed, 20 May 2026 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300187;
	bh=aaiWixhW9CUqMrwdDCSLHsA4KMwcCCoPyPYVpxtpxpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0FkDomZneMLOpB1lhsgVp3KFcZlK4PSXdNIlzyxWCZ6UwxOzbzh2RiqzF70+Blh4+
	 P+9S9SlXscXLKVRiyhdBtNwNEtDRdYojE6p7Ic8Ck0xshYIsvfd3kNXmtt79kGa6Zv
	 gDu6hQYol2Y8m6PYbi3ZlRom2UoSaUbtQwyS42sQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Cai Xinchen <caixinchen1@huawei.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 038/666] dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n
Date: Wed, 20 May 2026 18:14:09 +0200
Message-ID: <20260520162112.064253131@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252251-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email,msgid.link:url]
X-Rspamd-Queue-Id: C5365595B4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cai Xinchen <caixinchen1@huawei.com>

[ Upstream commit 97daf00745f7f9f261b0e91418de6e79d7826c36 ]

CONFIG_FSL_DPAA2_ETH and CONFIG_FSL_DPAA2_SWITCH are not
associated, but the compilation of FSL_DPAA2_SWITCH depends on
the compilation of the dpaa2 folder. The files controlled by
CONFIG_FSL_DPAA2_SWITCH in the dpaa2 folder are not controlled
by CONFIG_FSL_DPAA2_ETH, except for the files controlled by
CONFIG_FSL_DPAA2_SWITCH. Therefore, removing the restriction will
not affect the compilation of the files in the directory.

Fixes: f48298d3fbfaa ("staging: dpaa2-switch: move the driver out of staging")
Suggested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
Link: https://patch.msgid.link/20260312065907.476663-3-caixinchen1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index de7b318422330..d0a259e47960f 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -22,6 +22,5 @@ ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
 obj-$(CONFIG_FSL_FMAN) += fman/
 obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
 
-obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
-
+obj-y += dpaa2/
 obj-y += enetc/
-- 
2.53.0




