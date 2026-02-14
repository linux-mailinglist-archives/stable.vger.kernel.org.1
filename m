Return-Path: <stable+bounces-216461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKUNEajUj2nXTwEAu9opvQ
	(envelope-from <stable+bounces-216461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:49:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DC13AB7C
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 198AF300753D
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13970191F92;
	Sat, 14 Feb 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAjz47Na"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE705474F
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771033765; cv=none; b=ItS9y4EHYhpLJ6qoBBKnpL2HJnCk6yvfpkuGKc6HCRFW8HwnKA97d33e6paGPBEZsoe5+78KX96JleSKAC8vDssMJdvXv/tA80uglH0ki2//PjO3/PLLHtM7ZyMM8zDn4eldUQiI315dPi/D9aK1h0/eg8Fzc1JOGMvK2DeQF+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771033765; c=relaxed/simple;
	bh=oA6XVbp8UxEuLBdaHDl5bBXAQ/Jax8QX0CfDmu6UcY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YX3FMCqcXbFjkXocOo5wV9nz35kAlAhP3u2VA9hYpG9zhTStulhc3AM43Gst/cla4EmwPbPkGORQHwil34YM8QIsjEJaI96aF4o1rXHpdI17ZfUPqI72iQdvXWE7a/Iys/Jdr6QZC/ipVehM125UBletaYhVeO7rREGvqBt/D/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAjz47Na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5248C116C6;
	Sat, 14 Feb 2026 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771033765;
	bh=oA6XVbp8UxEuLBdaHDl5bBXAQ/Jax8QX0CfDmu6UcY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAjz47NaZhfEjE8XKbWOjDLggwJEi0bYb2Qzhq7+amh9A9hplwVJSgKV4mgZvjGBj
	 yXja3dtNC3wF2sJkDqDW0t4htOnc5C3esUfzZrTTba97xDSD5qmkGngRXflGVRDvPC
	 yC8l9tNQxWFePIKWzLNF9h3Fd/AVkgD7Dsbp5BKg4tcFJ0bT0LLvWorCxTh1aw7Nas
	 H0XXwTA/o5Qzf4CkciqlmxvkGlZczj7a0kgfbUyB8oJCcISVI1a777kEQ9TVy4tMgg
	 Aqgts7MRmXwRiUaaBpFvpIbqm7EhQJOT6V37NxcSCNIuhLTvPq6pDQz7YHAlzdaVhr
	 4zqO5eYtS5HAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] PCI: endpoint: Remove unused field in struct pci_epf_group
Date: Fri, 13 Feb 2026 20:49:22 -0500
Message-ID: <20260214014923.3899226-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021303-salt-retread-63e7@gregkh>
References: <2026021303-salt-retread-63e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216461-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wanadoo.fr,kernel.org,google.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC3DC13AB7C
X-Rspamd-Action: no action

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 328e4dffbeecc0f2cc5a149dee6c11a0577c9671 ]

In "struct pci_epf_group", the 'type_group' field is unused.

This was added, but already unused, by commit 70b3740f2c19 ("PCI: endpoint:
Automatically create a function specific attributes group").

Thus, remove it.

Found with cppcheck, unusedStructMember.

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/6507d44b6c60a19af35a605e2d58050be8872ab6.1712341008.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 7c5c7d06bd1f ("PCI: endpoint: Avoid creating sub-groups asynchronously")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index c17dff4bd19b4..a2b81a64fcd11 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,7 +23,6 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
-	struct config_group *type_group;
 	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
-- 
2.51.0


