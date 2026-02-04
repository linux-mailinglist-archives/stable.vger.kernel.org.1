Return-Path: <stable+bounces-213746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FbZNXdig2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:15:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F36E8302
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA6C5304CAE9
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C02BE7C6;
	Wed,  4 Feb 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrj0/H0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798328853E;
	Wed,  4 Feb 2026 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217366; cv=none; b=a59lK6FF3y+fxHn4WOTyDG5oq0MNhTlh25rnMnCFpBL0eXnfU6jrXx/nP+/kmZHRctqKzFhZxxUNEllxPzRowSrmQA2tBCSnFXYOwXc9wdqDePEkkBy4DH4Ltn/d6hi7GVbFT4yByQ9htXT6TTFuO6EeA1fT7lnRyQMXCR/9deg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217366; c=relaxed/simple;
	bh=TQDzW3Y54enWWjXkXoNY2Su6avL4RffjMRvHkolHzsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qA6a+33rw0Yg3tq7EthMirN+FGjP+xOGgH2hS8FTVYhgQ9K6+ECXhd43tBuPIVEH3C35+0MfzaSNsfXrzJHO3+/ewzS8r6pqFwMYA8WQ/DyszO3WpnB3uEQ8Mo6vhyUbDAqUjfGAoUPj/CWB7Av9xQXpGJ2TPrPr3ZOO7xuwc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrj0/H0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4166BC4CEF7;
	Wed,  4 Feb 2026 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217366;
	bh=TQDzW3Y54enWWjXkXoNY2Su6avL4RffjMRvHkolHzsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrj0/H0Z+jlZsDwvZBRX35Q7aokY4fYig5De3dbMuhdUxf5+Vlql3q+TXqzya2JBn
	 +cZznxtv92TBvQHRsVYeRgwjRX3fzK6rzllN0OlUC/8Qt1X98IgdAG//0KzhzSXpXI
	 SrGI6iH8eGxK4Nw53DuFtx8HtGUaL5X3JCNMMDeU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Wagner <dwagner@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 169/206] nvme: fix PCIe subsystem reset controller state transition
Date: Wed,  4 Feb 2026 15:40:00 +0100
Message-ID: <20260204143904.295355891@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213746-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email]
X-Rspamd-Queue-Id: 01F36E8302
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1144,7 +1144,10 @@ static int nvme_pci_subsystem_reset(stru
 	}
 
 	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
-	nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+		goto unlock;
 
 	/*
 	 * Read controller status to flush the previous write and trigger a



