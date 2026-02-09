Return-Path: <stable+bounces-215025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF3DHoLviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:30:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC541105B1
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3F693007538
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074C360741;
	Mon,  9 Feb 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wCduCSUI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494323B604;
	Mon,  9 Feb 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647422; cv=none; b=igwdmWGnq9nnDiCommNiB/7ClRWtpLlgsUSZUsTQcBnsGMh5Q6+dKwkJeuN+Oy+nqtzDl80QJ0Q/OkuVI5UDcTY4m5ebhzZGNZSJn604yhL4M9T0rysYq+ezIkk1/Iy27lgerlthDsuWO8kxhR2xMucnK+DLNJgw5i6s602Yt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647422; c=relaxed/simple;
	bh=3P0RuQSWcTdJzF5vSGYHOpy69VZPIyhOgPm3cfVFHMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGxwWGNP25s2u6nXTqAUU5T1lRk4Ppe0fo5DsFfHozFpsL4yjGuA8SX/qUNSxpVnljWvI7uvCUr7v1DKgAXjCZHuTj2ax1jQLibTCqFu2RcIz+NLwemWymMLW1FIaM6Ls9A46zMUPZDZBrRFCNGzTzb4Qjkfag9dqk1V5MND8Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wCduCSUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A690C116C6;
	Mon,  9 Feb 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647422;
	bh=3P0RuQSWcTdJzF5vSGYHOpy69VZPIyhOgPm3cfVFHMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wCduCSUItZBvU5OjM/UknGawRVeqj0q+k+mGCjJjTKpAkqk9/Id0JwqD3w5jZnG/A
	 60CR13kCpYJg2IEavxX2pL2bS+cbyF+rdruruJvNeBq2eHLkPGql2+EgGjN4vsfKNO
	 +NwevbOTEfrs6qcTFdZ2TNtag3l5phaDzT9frDXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 096/175] regmap: maple: free entry on mas_store_gfp() failure
Date: Mon,  9 Feb 2026 15:22:49 +0100
Message-ID: <20260209142323.878289471@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215025-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BC541105B1
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 2319c30283a6d..9cf0384ce7b95 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -95,12 +95,13 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 
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




