Return-Path: <stable+bounces-229508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KJ/NGpjwWkDSwQAu9opvQ
	(envelope-from <stable+bounces-229508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E02F73AD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4150A35B2608
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB99253958;
	Mon, 23 Mar 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGlBEyC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8F2550D5;
	Mon, 23 Mar 2026 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279457; cv=none; b=gtVlCpo1xdNQ9oKNFL7AgmXNsJIr3jPyAK+MUnzt37YzJBoUEcHlQxEAQncr0mKiFLqd/2D7j/+kbCopbEAQmM4It4ZQzE/fK2gLJ5Zwf5QH+UmKXj2/q4fxk1s5KJVX7QxThIUc+qauauD6EQ3u61ygO61EPnsp6G+OQRQ9E58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279457; c=relaxed/simple;
	bh=ABZlyuhe8URUxfla/POnHLiQIyluiDvLEWSoBRa3DjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7Z3bEpS/gTVY+tQbLFulMUxFX+YJBV6KHzF5SEJS9o7PN5YuXQMqLlxfaFMs+FuKmimblFjm6bxumRZSn2WOElPNid7b5UWAcLL7rGouQuN4yCKacHBO4im9TENtoFpMdOjHvJBSUUyuhkmJDqNIvW34TIRS1fPa5mmaZYNTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGlBEyC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3EAC4CEF7;
	Mon, 23 Mar 2026 15:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279457;
	bh=ABZlyuhe8URUxfla/POnHLiQIyluiDvLEWSoBRa3DjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGlBEyC4Cd2jrFpTCfFn5it0KmBIyLqu11Ax0nfw819J76+APlZbXpwe+EMBp4M1e
	 03pKANGxXjKmvzOUBAsMi8WsqfZAwk/dWdlms8xN8xx03qq9NzVBKmIScshso+WA9x
	 m9KfmtyV/BeQdV4EWBgSYm0tSfHh/fbTwFS2/lv8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/481] PCI: Use resource_set_range() that correctly sets ->end
Date: Mon, 23 Mar 2026 14:40:07 +0100
Message-ID: <20260323134525.856436316@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,google.com,intel.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229508-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url]
X-Rspamd-Queue-Id: 5A4E02F73AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 8f99607e0a526..02f3fbe78c46f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -264,8 +264,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
 		    && sz64 > 0x100000000ULL) {
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
-			res->start = 0;
-			res->end = 0;
+			resource_set_range(res, 0, 0);
 			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
 				res_name, (unsigned long long)sz64);
 			goto out;
@@ -274,8 +273,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
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




