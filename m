Return-Path: <stable+bounces-218757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENlvLiNVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 189EA18FF01
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4769831FB410
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537F26FD9B;
	Wed, 25 Feb 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="olksGbhe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298111E2834;
	Wed, 25 Feb 2026 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983627; cv=none; b=KoSV9FQUxoQogXtqmNXxGHziH6S2Igo4C7A9fmlCsrmbcOwqF4jRAwismplw8rowtUNkT7bk9TiFaXOCtlmQDCqkBoSDOe7n0QR3x8HrAQVvPuoQaM3j0uFzyGL2ZyD1x3ESfAwLjn1MIzH1SzDuRUg5NQzAS4VwyF4CtBNXHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983627; c=relaxed/simple;
	bh=stKaKHghAk4+C9RP/lCMY7JHw01tufxxCUPYzPJvRLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3Se3tJyPSEYtej+okKh7yyxcYVna2N9PJq/AKO6H0AZamXRGx3DMcgyiTj4NAbhz9l3NCLW78KMvx6r3LZy2DtANj7qsCq0P3TtC0A2/0xfbNIDxcxK/B9Ja3yTv+nIPCA+S3QBVt8oCodvASLm8OqZ6n5YAjqFy5+DeNYjV0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=olksGbhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBADC116D0;
	Wed, 25 Feb 2026 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983627;
	bh=stKaKHghAk4+C9RP/lCMY7JHw01tufxxCUPYzPJvRLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=olksGbhejVtTim8vD/Fbsg+WXe/5npq2ruDQ0a4NZYcS+Sn14CSCsCFTJaWvtPsd8
	 Ny1i2Vhfy5khnF7XhNmlG+JVzaheuhXWrVdKrFVBa2LSyYH0zm1sQ1Ogu8vTrfKq3C
	 TKuSN2ockWMjzEbhFAw3JH8w+0oVrWUSxFTfCtdI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 718/781] PCI: Validate window resource type in pbus_select_window_for_type()
Date: Tue, 24 Feb 2026 17:23:47 -0800
Message-ID: <20260225012417.349114080@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218757-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 189EA18FF01
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kaihengf@nvidia.com>

[ Upstream commit e5f72cb9cea599dc9f5a9b80a33560a1d06f01cc ]

After ebe091ad81e1 ("PCI: Use pbus_select_window_for_type() during IO
window sizing") and ae88d0b9c57f ("PCI: Use pbus_select_window_for_type()
during mem window sizing"), many bridge windows can't get resources
assigned:

  pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: can't assign; no space
  pci 0006:05:00.0: bridge window [??? 0x00001000-0x00001fff flags 0x20080000]: failed to assign

Those commits replace find_bus_resource_of_type() with
pbus_select_window_for_type(), and the latter lacks resource type
validation.

Add the resource type validation back to pbus_select_window_for_type() to
match the original behavior.

Fixes: 74afce3dfcba ("PCI: Add bridge window selection functions")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221072
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260210142058.82701-1-kaihengf@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 902fdae73c232..09a28cfcd5b88 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -225,14 +225,21 @@ static struct resource *pbus_select_window_for_type(struct pci_bus *bus,
 
 	switch (iores_type) {
 	case IORESOURCE_IO:
-		return pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
+		win = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_IO_WINDOW);
+		if (win && (win->flags & IORESOURCE_IO))
+			return win;
+		return NULL;
 
 	case IORESOURCE_MEM:
 		mmio = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_MEM_WINDOW);
 		mmio_pref = pci_bus_resource_n(bus, PCI_BUS_BRIDGE_PREF_MEM_WINDOW);
 
-		if (!(type & IORESOURCE_PREFETCH) ||
-		    !(mmio_pref->flags & IORESOURCE_MEM))
+		if (mmio && !(mmio->flags & IORESOURCE_MEM))
+			mmio = NULL;
+		if (mmio_pref && !(mmio_pref->flags & IORESOURCE_MEM))
+			mmio_pref = NULL;
+
+		if (!(type & IORESOURCE_PREFETCH) || !mmio_pref)
 			return mmio;
 
 		if ((type & IORESOURCE_MEM_64) ||
-- 
2.51.0




