Return-Path: <stable+bounces-239385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L1AOP5j5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:35:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6594318EE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBA4634D6976
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127433F58E;
	Mon, 20 Apr 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jvh/QM9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CA33C532;
	Mon, 20 Apr 2026 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700111; cv=none; b=KLckkS6/1immUSKk2zv3Qwf7Vpkw2KWO92IEt/QUpqN9bw3R8s6Ma1TF/eicT89My+UqrmoIgwjNxDgz6MqJaS9dwk74eqFUsCMWivrSc/g+0rJMGxcOedaI1Fini0GUU1mgLwOrM2KjAiuJAwtVxk31y0mOqpvFYakZOGieL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700111; c=relaxed/simple;
	bh=CmRfc26KxaeAfb/lVrxbLpESBm9BiaivOwrAXXNNJhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVPB53VxR74xnKZSees5Jib+xlDq+pVj0/3Hm+nq3BdIoYzO1hZQuD75mQcIt3nCDZoNkwmoyWdHaQAJ6WyCVSKFmWlK/1cn/iAK6ymfTHBzQBOR1eN/p1AU4sY/gZlyeKqDQR5pIDNtPO3U18yF/QNdKZbizedv4VdxD+XWrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jvh/QM9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39182C19425;
	Mon, 20 Apr 2026 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700111;
	bh=CmRfc26KxaeAfb/lVrxbLpESBm9BiaivOwrAXXNNJhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvh/QM9jxGB+32WCO1D4vJavITqWR71BFwuPJDk/mDtrr5l6Gwnq9qsBFE1cf2rC6
	 xTBzkwrYg8Q1PjIBB6bfoMMweY+LcvyUtuxNw6dXnCvcAkvCzszDwJ0s/YvTD9JpXt
	 JXVI+Lwwr38LJ4cnCVm3mK3oGQ44pQZN0/bhOdXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Potin Lai <potin.lai.pt@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 047/220] soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching
Date: Mon, 20 Apr 2026 17:39:48 +0200
Message-ID: <20260420153935.733608167@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-239385-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,codeconstruct.com.au,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C6594318EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Potin Lai <potin.lai.pt@gmail.com>

[ Upstream commit 7ec1bd3d9be671d04325b9e06149b8813f6a4836 ]

The siliconid_to_name() function currently masks the input silicon ID
with 0xff00ffff, but compares it against unmasked table entries. This
causes matching to fail if the table entries contain non-zero values in
the bits covered by the mask (bits 16-23).

Update the logic to apply the 0xff00ffff mask to the table entries
during comparison. This ensures that only the relevant model and
revision bits are considered, providing a consistent match across
different manufacturing batches.

[arj: Add Fixes: tag, fix 'soninfo' typo, clarify function reference]

Fixes: e0218dca5787 ("soc: aspeed: Add soc info driver")
Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
Link: https://patch.msgid.link/20260122-soc_aspeed_name_fix-v1-1-33a847f2581c@gmail.com
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/aspeed/aspeed-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-socinfo.c b/drivers/soc/aspeed/aspeed-socinfo.c
index 67e9ac3d08ecc..a90b100f4d101 100644
--- a/drivers/soc/aspeed/aspeed-socinfo.c
+++ b/drivers/soc/aspeed/aspeed-socinfo.c
@@ -39,7 +39,7 @@ static const char *siliconid_to_name(u32 siliconid)
 	unsigned int i;
 
 	for (i = 0 ; i < ARRAY_SIZE(rev_table) ; ++i) {
-		if (rev_table[i].id == id)
+		if ((rev_table[i].id & 0xff00ffff) == id)
 			return rev_table[i].name;
 	}
 
-- 
2.53.0




