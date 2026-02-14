Return-Path: <stable+bounces-216478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE28EIhykGncZgEAu9opvQ
	(envelope-from <stable+bounces-216478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:03:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5EA13C04C
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CF003013A67
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 13:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA80283FC3;
	Sat, 14 Feb 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1PA/HSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A318DB35
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771074178; cv=none; b=d5NLdIMgaBI1PEq5Mo1GuUyt5XGfgGXM22jQ3JSwRR6cxAbzjN+bOSfiwn00rE9SKABu0AxlYYMtp/01uxU8zXsmwZi/U9/C0ha/LTmYTsiGVWJ6pdMkKdxE2MTZAujUwAzs3pZ1cAGYs9EfdYQ7MHldWtgqR8xFYyJN/KiBffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771074178; c=relaxed/simple;
	bh=zFgZkSjSFmU/HZ22kjAOL1QSmrzCS4OF0sUNXoyvSKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGsQVU/pqf+6M2gOEmC3kWXEUztGJd4Zh1R0lBfKrDs96juO6IlDyGwW+GUumKJfdEoSuMQNlDJCu/XXCX5rS6B4PHfOgGo9fWyumTTL8zumFLCz0CIyLGzYhdWGZx7bvozHf3RMuKiONGoEQqew4Sp21lCs83M4q94xdxJuBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1PA/HSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92331C19423;
	Sat, 14 Feb 2026 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771074178;
	bh=zFgZkSjSFmU/HZ22kjAOL1QSmrzCS4OF0sUNXoyvSKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q1PA/HSoTizKg8oFqJdbMPuT9ShP9C7i1vgY9ojAtaplHtlyHs2PIgL8nnXUrUwzz
	 RMoB22PlISCaMOcGlB5zdjCKTnpFygiUNE2AIUxQ2JIM2O8NKmk5tKxOR+GUq4HoWV
	 b4H0+AB7OS0vDb673uenNDPYRjlnnDkpvhVtacKjDgKz0VP35oGLZyibxTwCB8IdSH
	 MD8cs0pbT2/qlSclD4ekDe2CFK7tM3i9hVWMAQlOr+ftLiyLMy8aNjD3tgy3vXCHhn
	 YW8sRlDfoEx/EarPxwMTuPPRMJm1KN0y4vltunqd8XEUE+66t7UpQh5iiq0YL/h6th
	 ifRLycIugeWUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] PCI: endpoint: Remove unused field in struct pci_epf_group
Date: Sat, 14 Feb 2026 08:02:53 -0500
Message-ID: <20260214130254.345213-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214130254.345213-1-sashal@kernel.org>
References: <2026021309-browse-cloud-99d5@gregkh>
 <20260214130254.345213-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216478-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC5EA13C04C
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
index 9afc907f3660a..eb3ae3abab242 100644
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


