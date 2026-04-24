Return-Path: <stable+bounces-240725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMYJObBx62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:35:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978A45F2C3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 302B53009015
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C6F38837E;
	Fri, 24 Apr 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3lKFnsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34923E356;
	Fri, 24 Apr 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037675; cv=none; b=OBLZV90zdQkOMctdNcTP41WUNYXw+ggBGeDCbM+JnTR0hcl6nmg8rHjPyHXbibW0WHHI4Aow5EeF8bMFIuOfI4zSHbkhceBHVuu2OOqFqVUG/A6XlWUbh7pf5NwD+z8ZR+SsrX4wylQpBuLtDNHz1ctz2wtcG3FDx5PbzH5vCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037675; c=relaxed/simple;
	bh=EhnXJy5lR+0hqODY43b1ATl3Rds+E1Dj9HiiM/4+Ku0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bolhl3K+QcAyG1Z9Wa0pEiJ++IZvXZo1WQm5FD7LvvEFpOOtGK95lVIo3QGNUMt9sUm29sJIn9SZNHDzCWktvIb4e5xBreSun3CH8Gpdzp7s0Om1yuYS9xIA4d9HwLkMSmKRkfZKKYx8JPtbASm2HQGf4DkbkdA/08ykqzoMTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3lKFnsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBC9C19425;
	Fri, 24 Apr 2026 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037675;
	bh=EhnXJy5lR+0hqODY43b1ATl3Rds+E1Dj9HiiM/4+Ku0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3lKFnsKZLrMP0j2xLnDaGOXQkksBBv/bc/U4War1l0LpUu6wU24QkWsB8q3XKm2x
	 b0mdkfrm6Tx1zS6FiuvgVXOG7/O4qXGk5BuFBl1zYxqczNRfgmJE36iOB6c1XcdSuh
	 Ara/X8FTSDO+uGqgePXG1CjSJ76bL0RKLhkZzf/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Potin Lai <potin.lai.pt@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 027/166] soc: aspeed: socinfo: Mask table entries for accurate SoC ID matching
Date: Fri, 24 Apr 2026 15:29:01 +0200
Message-ID: <20260424132538.529768550@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 7978A45F2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240725-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,codeconstruct.com.au,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,codeconstruct.com.au:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

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




