Return-Path: <stable+bounces-235112-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MLEHLGl1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235112-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:00:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE413C227A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFD45303D8B3
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81BB67E;
	Wed,  8 Apr 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AxZR0PPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719FB3D9DBE;
	Wed,  8 Apr 2026 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674600; cv=none; b=Aog9epnRGKR4/wP/r7pLrGXjNkAu99UJfY5pty5T78W+UxzsKDty56K8gzbqT018hdiUkccxWZPrOAC7nXA0iWRONW9YaL0GYYBxT4tyar8sPYESa1kfc9oUTbJ+hP3L2eOaxgpbIRWisbKLuSnujo6jbkmIfExifo/IoOL/Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674600; c=relaxed/simple;
	bh=/VesRiGqCTwU5m4ycSUvXoKtbDGID+IBEwIqHXzUBOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrC3hagLA7AQoI/gRfcFG5+AqlajOtkHsb4XsJ3xcMG80wygidz27aJZHWQNpWxvnVhLkBkimbTXWF5lYwB1EJUnRE7RFtBNmzxOH9Jvb4n9b2SYF5MT8umP8vRET0B3CgOF+DYYlfn76L7Spt9sFjVdWOyNBAShpzCXjZ+mOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AxZR0PPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9949C19421;
	Wed,  8 Apr 2026 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674600;
	bh=/VesRiGqCTwU5m4ycSUvXoKtbDGID+IBEwIqHXzUBOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxZR0PPeK6JOHSBoaN4CMk9hYRepA2aDTRLB5W5MBSkd8Mt7ezmKVYj8rTBzV31jx
	 pB+MsBNzvW4mh/0v1LDanWjp5Z9Q+2X0mT5xDY7G9YEY6+v5O+aGmHwSmjfpsvXxgB
	 6k+x+qCf4NVcCCJwLjbMzYk1l5rYb1GffewJ9ImA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sunil V L <sunilvl@oss.qualcomm.com>,
	Paul Walmsley <pjw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 160/311] ACPI: RIMT: Add dependency between iommu and devices
Date: Wed,  8 Apr 2026 20:02:40 +0200
Message-ID: <20260408175945.378512623@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235112-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 0AE413C227A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunil V L <sunilvl@oss.qualcomm.com>

[ Upstream commit 9156585280f161fc1c3552cf1860559edb2bb7e3 ]

EPROBE_DEFER ensures IOMMU devices are probed before the devices that
depend on them. During shutdown, however, the IOMMU may be removed
first, leading to issues. To avoid this, a device link is added
which enforces the correct removal order.

Fixes: 8f7729552582 ("ACPI: RISC-V: Add support for RIMT")
Signed-off-by: Sunil V L <sunilvl@oss.qualcomm.com>
Link: https://patch.msgid.link/20260303061605.722949-1-sunilvl@oss.qualcomm.com
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/riscv/rimt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index 7f423405e5ef0..8eaa8731bddd6 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -263,6 +263,13 @@ static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *node, u32
 	if (!rimt_fwnode)
 		return -EPROBE_DEFER;
 
+	/*
+	 * EPROBE_DEFER ensures IOMMU is probed before the devices that
+	 * depend on them. During shutdown, however, the IOMMU may be removed
+	 * first, leading to issues. To avoid this, a device link is added
+	 * which enforces the correct removal order.
+	 */
+	device_link_add(dev, rimt_fwnode->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
 	return acpi_iommu_fwspec_init(dev, deviceid, rimt_fwnode);
 }
 
-- 
2.53.0




