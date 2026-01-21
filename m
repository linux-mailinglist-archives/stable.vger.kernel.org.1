Return-Path: <stable+bounces-210829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC2wF0AbcWmodQAAu9opvQ
	(envelope-from <stable+bounces-210829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:30:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1165B479
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B802B746EA3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E24D387587;
	Wed, 21 Jan 2026 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4I9M01k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC1136672;
	Wed, 21 Jan 2026 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019523; cv=none; b=hArwBuo68kI+y8VleMxWAOK3TWP7u34zUMtwP40e5Kyhpxe7lNWic5n0zLfoewiv506Meu8FF2s5/mp9xuovB6FBDrjnyj1BAEOI9rooStBYfK4DNkmf1iOhop9Toz3FvLX/nVohWwDBm3wnnaFiYMMDX+kpQaCd98VfpQ6dYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019523; c=relaxed/simple;
	bh=4X+vrZxj40NMiNIJoXPrlhim2GTgKvGmE0TPlBWth64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtDFdBqU+v1gd5Ajfz7adIchKLYEFG6oAChzO2leQ6+jwsr4bxcMeU9/1vqpeLN/kB2UIgDwmR1JN5PrCbbGwvvQVHESTWBXflQglmT5UCQI2MZG2/Rn2hPTcT7ULm1dojD4bX82GgswxNUA37AySebM9ITLSqsSCsCszq0k2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4I9M01k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A3C4CEF1;
	Wed, 21 Jan 2026 18:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019522;
	bh=4X+vrZxj40NMiNIJoXPrlhim2GTgKvGmE0TPlBWth64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v4I9M01kNli02uvXxNeVqE4y4YtoA5ePpv6Pz2W91ta3cNJFTUD3dPM4MMK8aj6gM
	 QAZtGFqScXzbWyWBFtBsXDWRXoPE6aZ9i7MBmoJFCdKu7e7a9LxKu5auUlnUHnb4R5
	 Amztqq5F+g7IzUW/N69xwtegGUzGacZseGc9sr78=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kery Qi <qikeyu2017@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 031/139] net: octeon_ep_vf: fix free_irq dev_id mismatch in IRQ rollback
Date: Wed, 21 Jan 2026 19:14:39 +0100
Message-ID: <20260121181412.575977988@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-210829-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EA1165B479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kery Qi <qikeyu2017@gmail.com>

[ Upstream commit f93fc5d12d69012788f82151bee55fce937e1432 ]

octep_vf_request_irqs() requests MSI-X queue IRQs with dev_id set to
ioq_vector. If request_irq() fails part-way, the rollback loop calls
free_irq() with dev_id set to 'oct', which does not match the original
dev_id and may leave the irqaction registered.

This can keep IRQ handlers alive while ioq_vector is later freed during
unwind/teardown, leading to a use-after-free or crash when an interrupt
fires.

Fix the error path to free IRQs with the same ioq_vector dev_id used
during request_irq().

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
Link: https://patch.msgid.link/20260108164256.1749-2-qikeyu2017@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index ccb69bc5c9529..b9430c4a33a32 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -220,7 +220,7 @@ static int octep_vf_request_irqs(struct octep_vf_device *oct)
 ioq_irq_err:
 	while (i) {
 		--i;
-		free_irq(oct->msix_entries[i].vector, oct);
+		free_irq(oct->msix_entries[i].vector, oct->ioq_vector[i]);
 	}
 	return -1;
 }
-- 
2.51.0




