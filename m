Return-Path: <stable+bounces-215342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MGaG1j1iWkaFAAAu9opvQ
	(envelope-from <stable+bounces-215342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:55:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA30811132C
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01C80305BD82
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25062690EC;
	Mon,  9 Feb 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TEhY/EVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6491285073;
	Mon,  9 Feb 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648481; cv=none; b=WGFMhEv/8x06FAH5NQu5Lc9dREZl6KMtc22hlWZHtC90bL7k4AQQ47d1vVjwB6Mx42NIIZHQpmQ26r131beCwaO8QbyPwxhrsER3x+Yg9IQh9oMxS2ejyh1uBe05XMbzzyWjJBlh8Xq9gxuAKcuki87Q07Xq8zDkCuxvWAhrOMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648481; c=relaxed/simple;
	bh=P6N9AuBPWZnTfQBCmtGOgOiPo+vrD/AZ7cH6YyCXUO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgKnpoSDJxzp+cqP5fr4q2tefo/MbzsBQ2FLzoYpf3ACd7QpFCdKlfz5Nc2OGZwvcJLhdpvkCKnKUUO93IukqaiyuD04Ab7GAXwkVq5o6Cs79VT2I61gjFpdWjEzNfsUGdMxtwSLTF5PE4koFg2s4gjj7M1pz9mwTNMd6Zp/3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TEhY/EVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABABC19422;
	Mon,  9 Feb 2026 14:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648481;
	bh=P6N9AuBPWZnTfQBCmtGOgOiPo+vrD/AZ7cH6YyCXUO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEhY/EVA+QMFjq0+ovFofwsSGsM1bINisQdntmwsv7qH4RW71T3WZVH/9q/AZhR1f
	 e9B5i5gt7rgF4cWRSnietH+K+mdtMhVMKBuevxmuurvciwTkXzQI7eksZsxGR4/Orj
	 GUAx5LAQLh2TVEAStAJH5CHFqWnPvJleh2L4ps08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 49/86] regmap: maple: free entry on mas_store_gfp() failure
Date: Mon,  9 Feb 2026 15:24:12 +0100
Message-ID: <20260209142306.546010997@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215342-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AA30811132C
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit f3f380ce6b3d5c9805c7e0b3d5bc28d9ec41e2e8 ]

regcache_maple_write() allocates a new block ('entry') to merge
adjacent ranges and then stores it with mas_store_gfp().
When mas_store_gfp() fails, the new 'entry' remains allocated and
is never freed, leaking memory.

Free 'entry' on the failure path; on success continue freeing the
replaced neighbor blocks ('lower', 'upper').

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Link: https://patch.msgid.link/20260105031820.260119-1-kaushlendra.kumar@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index fb5761a5ef6ee..86de71ce2c191 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -96,12 +96,13 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 
 	mas_unlock(&mas);
 
-	if (ret == 0) {
-		kfree(lower);
-		kfree(upper);
+	if (ret) {
+		kfree(entry);
+		return ret;
 	}
-	
-	return ret;
+	kfree(lower);
+	kfree(upper);
+	return 0;
 }
 
 static int regcache_maple_drop(struct regmap *map, unsigned int min,
-- 
2.51.0




