Return-Path: <stable+bounces-210671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M+CE7pCcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:06:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15A503B7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 04:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58B1C525223
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B43559DA;
	Wed, 21 Jan 2026 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSiho5uH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C035504F
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964784; cv=none; b=To6RbCPSl6lJ65o7lseSgbjshgbxK8FthtQyzjgxtp7l8EMxoc6YUYs6X/qhnYq70c8xGP3sj7Iw4yW6QelgmiHlnd29zugaYEtwUWVWNajnywxNYcNBktw+pbQ0x6vTxbvXiudfPPeEtkgBBR7BeaYijySUpvL/inxVI2Jisxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964784; c=relaxed/simple;
	bh=7n7alaLpNF/XhbKRFNHns/vyW90qOJnEs1B1q/EiJ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYO7MPw4H0GQ6F1zotZzeXvkb7iLyGHQVpfE/nNlqH2yGxYmxf26ruP9ygQCl2LLylxAxCq8pdwikp5NREjhkiXJM46ndzRYx3+CXd7SG/+3z0yrdchf2TkQYFb04HTe/T5zWnq5G3Yv2/rM98E+70T96fv3oduS8iu3FMoLZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSiho5uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F93C19423;
	Wed, 21 Jan 2026 03:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964783;
	bh=7n7alaLpNF/XhbKRFNHns/vyW90qOJnEs1B1q/EiJ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSiho5uHN7hmeltEpdYXYOHEzV9u1IdDTPBz2eDmQ8oFB4IqHH+Qy9Bx1ReVO3f47
	 BAEkNjNOXCAd107qDt/z+QwOxrxdRvW76nL1W6cx3s9XkWH75fkYalYQSqrcAsfaBv
	 5JpbVMSJWHnE5ce1jJ4UsXKV8YzxHAqcGI5IEZJpqBbJVUtsuBbtRwJlzS7Fb24f2g
	 uNQK6uKvCF3RuZ0oksmdTHsWI1NRI04AO16dPpvPdQBqOWHzjhmRuxI8R0fJkKj7cX
	 rV0ZbIi9mnp/YeFxkPDxhD3iWScs0sbD1sFasMwt2VER1taQibPboRFd0WhkoVQKdT
	 YZ+L2LMMeGN1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] nvme: fix PCIe subsystem reset controller state transition
Date: Tue, 20 Jan 2026 22:06:19 -0500
Message-ID: <20260121030619.1172509-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121030619.1172509-1-sashal@kernel.org>
References: <2026012014-ferret-pungent-817b@gregkh>
 <20260121030619.1172509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210671-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EF15A503B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nilay Shroff <nilay@linux.ibm.com>

[ Upstream commit 0edb475ac0a7d153318a24d4dca175a270a5cc4f ]

The commit d2fe192348f9 (“nvme: only allow entering LIVE from CONNECTING
state”) disallows controller state transitions directly from RESETTING
to LIVE. However, the NVMe PCIe subsystem reset path relies on this
transition to recover the controller on PowerPC (PPC) systems.

On PPC systems, issuing a subsystem reset causes a temporary loss of
communication with the NVMe adapter. A subsequent PCIe MMIO read then
triggers EEH recovery, which restores the PCIe link and brings the
controller back online. For EEH recovery to proceed correctly, the
controller must transition back to the LIVE state.

Due to the changes introduced by commit d2fe192348f9 (“nvme: only allow
entering LIVE from CONNECTING state”), the controller can no longer
transition directly from RESETTING to LIVE. As a result, EEH recovery
exits prematurely, leaving the controller stuck in the RESETTING state.

Fix this by explicitly transitioning the controller state from RESETTING
to CONNECTING and then to LIVE. This satisfies the updated state
transition rules and allows the controller to be successfully recovered
on PPC systems following a PCIe subsystem reset.

Cc: stable@vger.kernel.org
Fixes: d2fe192348f9 ("nvme: only allow entering LIVE from CONNECTING state")
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b19ae93b5ff2..7a6827306e740 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1146,7 +1146,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
 	}
 
 	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
-	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+		goto unlock;
 
 	/*
 	 * Read controller status to flush the previous write and trigger a
-- 
2.51.0


