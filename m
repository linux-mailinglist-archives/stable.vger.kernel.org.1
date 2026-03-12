Return-Path: <stable+bounces-224979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBgDNFIfs2l/SQAAu9opvQ
	(envelope-from <stable+bounces-224979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B201278B85
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF9131A838F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAEC3FFABE;
	Thu, 12 Mar 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PUwOYB12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3116D35A3B6;
	Thu, 12 Mar 2026 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346450; cv=none; b=he8fR9LA4zZx9DxTsBqueZlXiC57nX52OktV7+aONo6zUCi72EhXJafCbefg4xFsBFgDdRmLYN0XUm8LZ2iU5XeT3nLk0nKHVFkTt1pjcqYSwoJ+WfH40/grC87pOHe2823ZQWi+g6DTi7awpZzimtzzOtliWIy9AT2KdrG94Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346450; c=relaxed/simple;
	bh=QH3H186oJjhPx2rnSFgOu3TMVYvsAA4W6vaXCcqkcmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8bVOF7bPgpA6ryUZoaeiC/oWuyY5ixnWAGXJFp3FaBFE9fSLBaJrjmko+imDjnMKd0izl8Qr2+jONYRwCv367wKUJM+hyglmovNLM00siFvHYIix4f3+oRf2L8wsj4y+8PhXKayWnFG3eG1C7a770T54pIb2ewJRLUAsz8iWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PUwOYB12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C878C4CEF7;
	Thu, 12 Mar 2026 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346449;
	bh=QH3H186oJjhPx2rnSFgOu3TMVYvsAA4W6vaXCcqkcmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PUwOYB12RdogL3lc2AdaNJYpkIQYBFQMwTU8I4CKSr5+t3POH6lgnlbu+P8CG6/jt
	 V4GbORjZ8nrzlK6EHJmaPMjViWBZatV6LaCb0xY+SkD/pbepIbS8BGrb4jZWiOiebL
	 mzl4wK7avaK/BIJwEhsS0PWDFG/NB4odwwOkS1HM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/265] PCI: dw-rockchip: Dont wait for link since we can detect Link Up
Date: Thu, 12 Mar 2026 21:07:11 +0100
Message-ID: <20260312201019.793655649@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224979-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B201278B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit ec9fd499b9c60a187ac8d6414c3c343c77d32e42 ]

The Root Complex specific device tree binding for pcie-dw-rockchip has the
'sys' interrupt marked as required.

The driver requests the 'sys' IRQ unconditionally, and errors out if not
provided.

Thus, we can unconditionally set 'use_linkup_irq', so dw_pcie_host_init()
doesn't wait for the link to come up.

This will skip the wait for link up (since the bus will be enumerated once
the link up IRQ is triggered), which reduces the bootup time.

Link: https://lore.kernel.org/r/20250113-rockchip-no-wait-v1-1-25417f37b92f@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Stable-dep-of: fc6298086bfa ("Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link Up"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 6b113a1212a92..8bcde64a7fe52 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -433,6 +433,7 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
+	pp->use_linkup_irq = true;
 
 	return dw_pcie_host_init(pp);
 }
-- 
2.51.0




