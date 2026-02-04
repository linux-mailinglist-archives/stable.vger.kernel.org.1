Return-Path: <stable+bounces-213438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM2SJhdcg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30691E75D2
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CD1E30440AA
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34D3274B5F;
	Wed,  4 Feb 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VldjAhrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BC1C5D77;
	Wed,  4 Feb 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216338; cv=none; b=eh4KLkNkRxl5WBTnUghAqTIybg8M7kFBpnEgp8Zqoc3Ndq/YrkPXC+gH1eqtkxxrViUC0tG1yBxTAYqyLLGzb2+4q9NN28fSX094x0FPJVxPF+quyjv3MujJwnyqmIb2BPUu+wRRaFQQuJ9LEZvoMBRZm58a1P8okIe7wRZKCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216338; c=relaxed/simple;
	bh=yIR65TYqZSRxKiKI5ThMrLKm1cCUpNdomoig4mL77bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5jOLVL0ZTH3nrULM7eRQmss4Mb53dQS95xuPXsdEqEk7KzSuWmiUqdFRUmx+nIt4xMgx56ZkVVLavHc96pqzv4H3xZg9nqrbP9sI/dVffHxSa5wOdIiNEWHOvOlQWwlK2PlVmvHwwrBAGPNaxTouccgRThZPwIo9CqnmKatZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VldjAhrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47ACC4CEF7;
	Wed,  4 Feb 2026 14:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216338;
	bh=yIR65TYqZSRxKiKI5ThMrLKm1cCUpNdomoig4mL77bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VldjAhrWefOMmP6KI1LPTE9rwUmuXSNRJjRTzeCvtU5xEIfgvUvSzRaPPXIM/L2lf
	 Xg2PM9no5HVfiV3blAMmpwgEoFzYBW36tywVdnQEtfuNqm4U2ABPha6MIRxabNVTnY
	 Yf1gY8GJDL4znh5MFWKwdzimAm2lEvC7ZrHadIkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Fomichev <sdf@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 057/161] net: fou: rename the source for linking
Date: Wed,  4 Feb 2026 15:38:40 +0100
Message-ID: <20260204143853.812910442@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213438-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 30691E75D2
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

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




