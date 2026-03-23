Return-Path: <stable+bounces-228310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN70NPxLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC12F432B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9F453028416
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191183B0AC7;
	Mon, 23 Mar 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aBZmoneL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFD53AEF22;
	Mon, 23 Mar 2026 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274767; cv=none; b=KKlL2B6tTTtt5PFWKMa/5gLRHuBkWrgmKbRobtfOCR/IaguA+SOhOZIn1Te+633bZjPhFkjVIRz1j09C5OFvZQZ+hvWoojcm2ChdqaxVr5G19VEDu1H/Cp9Rwo/nhnrewiGfAoRHpv3K8DjJF082gDR8wvbJKMw6joaxNBsUkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274767; c=relaxed/simple;
	bh=jac9PeboftAlQLCcaetn7VRVt8oBNDw6mQ7xoA8p5l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WunivIb2/LxsSn++z6xq+Uz4/3PQEKLt/jr4BWo57JW8FVNujPmW6aeRA0+Do1z4kNbu/g0f6MtLLLj7PMrWiL2lVQifblXMaKob7lakXdHwvZB22FPSPucpBp5JK+BNXdRe/e3++kw1G2udUvZdz6Lhavh0aYPcskV/QUOoooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aBZmoneL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18080C4CEF7;
	Mon, 23 Mar 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274767;
	bh=jac9PeboftAlQLCcaetn7VRVt8oBNDw6mQ7xoA8p5l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBZmoneLtv/JPQaUXUSNFi6nclu0lVlGu0V5aLs8Iqno+9VOBR4DzUKOqvX8ta5j6
	 oDsXBnzpCVi83m2JCJPIKuOtyOocJ4Gz7KR4u+5QUxIcwJg88TwHS9LmzEGVTIf3p+
	 0PgiWdRbKPTRlu+lSvnX6kooOOyb8o6EF8KpaotU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 102/212] cache: starfive: fix device node leak in starlink_cache_init()
Date: Mon, 23 Mar 2026 14:45:23 +0100
Message-ID: <20260323134507.003073042@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,huawei.com,microchip.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228310-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A4CC12F432B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 3c85234b979af71cb9db5eb976ea08a468415767 ]

of_find_matching_node() returns a device_node with refcount incremented.

Use __free(device_node) attribute to automatically call of_node_put()
when the variable goes out of scope, preventing the refcount leak.

Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cache/starfive_starlink_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
index 24c7d078ca227..3a25d2d7c70ca 100644
--- a/drivers/cache/starfive_starlink_cache.c
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -102,11 +102,11 @@ static const struct of_device_id starlink_cache_ids[] = {
 
 static int __init starlink_cache_init(void)
 {
-	struct device_node *np;
 	u32 block_size;
 	int ret;
 
-	np = of_find_matching_node(NULL, starlink_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, starlink_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-- 
2.51.0




