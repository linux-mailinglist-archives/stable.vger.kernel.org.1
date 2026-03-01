Return-Path: <stable+bounces-221523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FiPDEmXo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 392A11CAEDB
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A0B53022C3F
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F59259C80;
	Sun,  1 Mar 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAbeDDmX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2537B285C84;
	Sun,  1 Mar 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328478; cv=none; b=eJdUZMEmKjwdTos+YFvfDe7YgSVbfYdfv5qSLB2tBi62cvUp8U6UlHGyIlSc+sd6M0g9Edum/RPzeGIG8dFTkumKRtxQ2YadVe4vbvVMVluJrzkur8OOVe9rQ0BPzCRTfJFGGrbtvVCwRgeqT1eK5LNwnXEaqGQgU9rC38IcFsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328478; c=relaxed/simple;
	bh=MmtJWNnu3f1+1GqtsL/LcOyTGtnGPEeZyfimyyh8N9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=My/VurKR7i8WtgQLcq3r7AEVC0jh2okotQC+4SBNMOQQDxLGE/NAyth2r16SHowpYKNKE88Oa635s9hUzMabES2nlZhv3w7MX/ECxJqHDOPJW8ucf4fCR5DTeVr34nYbKm2qwR7CmOLm/HjmRV28g18rsNoJnb0TiD9SrBZ3E3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAbeDDmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B6AC19421;
	Sun,  1 Mar 2026 01:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328478;
	bh=MmtJWNnu3f1+1GqtsL/LcOyTGtnGPEeZyfimyyh8N9c=;
	h=From:To:Cc:Subject:Date:From;
	b=lAbeDDmXN9t/FtkYfnjq8jNEXob9i3kyq6XBifVsWGuWouny4uDS9VJmolEELP39p
	 /yRxyRv6hNxv93VjulqTY1J6UrTNVF2LPgbkH4DzfjThez8rjbBgDHhHJkU2mywO8a
	 8N9AAUr8RGSx2BWusVCQUK+eyffegkrb/jFfjHyE38ZZy4RYu2oIIAWfHGef4JnZ6n
	 mHcUXaPOTAQPL1/NdUEow6LU2cETfSKmTQK7e0AkMoFJtiaaBuloX5x/nlZ75WFHsj
	 bnAuW0DXIoZtK1ko5zIBNG3tlUlxankfeuFXLrsUKtp1PYeilz6Vk/xRsxdOx8yLEJ
	 Osx4/IuyG7wDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	haokexin@gmail.com
Cc: Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ti: icssg-prueth: Add optional dependency on HSR" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:27:55 -0500
Message-ID: <20260301012756.1685565-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-221523-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 392A11CAEDB
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e3998b6e90f875f19bf758053d79ccfd41880173 Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 7 Feb 2026 14:21:46 +0800
Subject: [PATCH] net: ti: icssg-prueth: Add optional dependency on HSR

Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
forward offload") introduced support for offloading HSR frame forwarding,
which relies on functions such as is_hsr_master() provided by the HSR
module. Although HSR provides stubs for configurations with HSR
disabled, this driver still requires an optional dependency on HSR.
Otherwise, build failures will occur when icssg-prueth is built-in
while HSR is configured as a module.
  ld.lld: error: undefined symbol: is_hsr_master
  >>> referenced by icssg_prueth.c:710 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:710)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:681 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:681)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:1812 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:1812)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(prueth_netdevice_event) in archive vmlinux.a

  ld.lld: error: undefined symbol: hsr_get_port_ndev
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:712 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:712)
  >>>               drivers/net/etherneteth_hsr_del_mcast) in archive vmlinux.a
  >>> referenced by icssg_prueth.c:683 (drivers/net/ethernet/ti/icssg/icssg_prueth.c:683)
  >>>               drivers/net/ethernet/ti/icssg/icssg_prueth.o:(icssg_prueth_hsr_add_mcast) in archive vmlinux.a
  >>> referenced 1 more times

Fixes: 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame forward offload")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260207-icssg-dep-v3-1-8c47c1937f81@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index fe5b2926d8ab0..c60b04921c62c 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on HSR || !HSR
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.
-- 
2.51.0





