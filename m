Return-Path: <stable+bounces-225000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCFYOekes2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D9278A91
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59CDA301AA80
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9241F4181;
	Thu, 12 Mar 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhUSxqrP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C37145FE0;
	Thu, 12 Mar 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346533; cv=none; b=Jx2UCR78Sfp5IklsaqmJu4U8FHmpygaIpPnrhNgkvxCjUbplFwUsDQJI7r658OuD8S3+OYgNiFNUJfKb7Fajukw3QzrcERGrneodohe+5Ji1fFaB5h6B9LMpgGCqB4au+kvQsIN7IqfXYXW1g55WZPZxtkTvPATGuWe5mpgCvAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346533; c=relaxed/simple;
	bh=jEaYyGOlyhWy7yD2sTTrU45zBvLrEYbpzEu6nEHRwWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUlren+Qt4fl3ySLgt3jqIt8cHMOWtCjfP5FL34GRgD8j+gZ8/Q/XNoniQApRNFHWZ8i1yta5o2VF51SVkshsHy8CizymuKLc31GlOld5kCHBlmJH0yBpFegAxu4u1uMqf2EE3uw2eK5eibx5XItygz0eQfW7JZktCP/+2UEdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhUSxqrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7397DC2BC86;
	Thu, 12 Mar 2026 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346533;
	bh=jEaYyGOlyhWy7yD2sTTrU45zBvLrEYbpzEu6nEHRwWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhUSxqrPvFJRXxy4H2aJUtOY6Ji0/OybDNJXhSzvF3Q16S8UuqzqVm1Ni453xW9aQ
	 Bhd2kYhUS0mW85/Zb8bBN7d/jxqQ9+1hhY91PFjlBZQoMu5YJLpkkgnIW2TE55a1Bm
	 ksC4N3eFB9IdtGfBpMMy8YwlZUeZhMYnEzcFWgAs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 049/265] PCI: Use resource_set_range() that correctly sets ->end
Date: Thu, 12 Mar 2026 21:07:16 +0100
Message-ID: <20260312201019.974464893@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,google.com,intel.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225000-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 655D9278A91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 11721c45a8266a9d0c9684153d20e37159465f96 ]

__pci_read_base() sets resource start and end addresses when resource
is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
of representing 64-bit PCI addresses. This creates a problematic
resource that has non-zero flags but the start and end addresses do not
yield to resource size of 0 but 1.

Replace custom resource addresses setup with resource_set_range()
that correctly sets end address as -1 which results in resource_size()
returning 0.

For consistency, also use resource_set_range() in the other branch that
does size based resource setup.

Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Link: https://patch.msgid.link/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9e419f14738a2..9e71eb4d1010e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -263,8 +263,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
 		    && sz64 > 0x100000000ULL) {
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
-			res->start = 0;
-			res->end = 0;
+			resource_set_range(res, 0, 0);
 			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
 				res_name, (unsigned long long)sz64);
 			goto out;
@@ -273,8 +272,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8) && l) {
 			/* Above 32-bit boundary; try to reallocate */
 			res->flags |= IORESOURCE_UNSET;
-			res->start = 0;
-			res->end = sz64 - 1;
+			resource_set_range(res, 0, sz64);
 			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
 				 res_name, (unsigned long long)l64);
 			goto out;
-- 
2.51.0




