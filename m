Return-Path: <stable+bounces-213616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFPiHitgg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0E7E7DD1
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DEF63010744
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E0C421889;
	Wed,  4 Feb 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="an3TpSoJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38088421883;
	Wed,  4 Feb 2026 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216927; cv=none; b=QG651RaZjzTCpqESNQppy7Px4RWP79qZcmhaOjPImBZnNMcxpXbqB/e8e54qQ+cheuvKRB5ZkvrgwFOSiD8vKHBQjwyquRunMskqWHgJORI6D3Ah5smRXt8aN94z39IcXSqCfA7LME7d0ITYfy5SnOouPtquGERTcUADXSzdD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216927; c=relaxed/simple;
	bh=UE2nJvmPj6OtIrETQqRI5V9Bx0NxNBA/vbsuSgTtnWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTzOBOIgq+Es0CYoc2MZ0gchiCldnFQX0Zv+Qzp7gVC9OA5RKBPbv6fIxzUkw4Jp+YtecYKaTo6CYcpqHqn5TLi/6dmsuB0+c5+bfspS9qwIueLhLL0h6UqrnUg2ETfnB6JYKK8CKCOXBaNVkv0/NQ1Dpbu1v5Ce67n3e+jCYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=an3TpSoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E2CC4CEF7;
	Wed,  4 Feb 2026 14:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216927;
	bh=UE2nJvmPj6OtIrETQqRI5V9Bx0NxNBA/vbsuSgTtnWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=an3TpSoJxBqi/I8csW16ODuDKaogz0vnJFCeJInXy8BsK82f/ZdT5SodhZgCxEJpB
	 4pEu1QFucg8V2ydOrLe4GY41qQuFEVZgPO4Y+/kiV44bS4FVh64grnqyqnd8XFk3xk
	 26KOv+FyKgSJWO4u+wljGJzXoEFqlqduPVZJAHDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Fomichev <sdf@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/206] net: fou: rename the source for linking
Date: Wed,  4 Feb 2026 15:38:25 +0100
Message-ID: <20260204143900.879439514@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213616-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE0E7E7DD1
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 08d323234d10eab077cbf0093eeb5991478a261a ]

We'll need to link two objects together to form the fou module.
This means the source can't be called fou, the build system expects
fou.o to be the combined object.

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/Makefile              | 1 +
 net/ipv4/{fou.c => fou_core.c} | 0
 2 files changed, 1 insertion(+)
 rename net/ipv4/{fou.c => fou_core.c} (100%)

diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index bbdd9c44f14e3..e694a5e5b0302 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_IP_MROUTE) += ipmr.o
 obj-$(CONFIG_IP_MROUTE_COMMON) += ipmr_base.o
 obj-$(CONFIG_NET_IPIP) += ipip.o
 gre-y := gre_demux.o
+fou-y := fou_core.o
 obj-$(CONFIG_NET_FOU) += fou.o
 obj-$(CONFIG_NET_IPGRE_DEMUX) += gre.o
 obj-$(CONFIG_NET_IPGRE) += ip_gre.o
diff --git a/net/ipv4/fou.c b/net/ipv4/fou_core.c
similarity index 100%
rename from net/ipv4/fou.c
rename to net/ipv4/fou_core.c
-- 
2.51.0




