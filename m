Return-Path: <stable+bounces-220452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH7QODU4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1691C640C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B97B431B003E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3443B8933;
	Sat, 28 Feb 2026 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pH1CneM6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7B3B892B;
	Sat, 28 Feb 2026 17:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300340; cv=none; b=EzAtoWQKqoJWQ8pOlSfHQR+AndJ1hxstv/FybFgddwud4ujVjUlSOpalO1Cg4Owu6DrdUqSKPMATgO3+oW9fU+nlLd2aEPfxnLzeGrDAOZAF4tDL+94xZIY4yT0Ufs6XXanXqlW+5/IJYktTmFx3sgXeWiS2985QiabznV5vE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300340; c=relaxed/simple;
	bh=4B9zfesSIGCETB9yT7zZ8o1RykvPoYvqKhAu5noR5P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl3/b0omLlzy/HPrfqYpj5Z9B1QoUzhoigJEWDYcUsSA64RJ7rfBy26mU7Tw7kYB1gEnHdbbupBhQHB/HBQqKsSNgJupOSZxLBIoyZPtNHuIShZZgvQEjqFcOmnoEw8Z2kcofG17FeNaJiUMXSV6/wChOTySgGYLOjaGEWHuXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pH1CneM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79F5C2BC87;
	Sat, 28 Feb 2026 17:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300340;
	bh=4B9zfesSIGCETB9yT7zZ8o1RykvPoYvqKhAu5noR5P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pH1CneM6NB0CYGHvwEo4Y5biUcELhwqzkJ7NBRvqDwonXA5Z3E11PggbBgpzaZD8h
	 IBr5dHj6mjt1KYOkAA2J7wqDaZhqaT40n6dmaT1skdKRh4Zf+9C7+Q5UJOs7ohnwo+
	 9f8giRK9hsMiqeSvqnEWSrkZeWxcncjLmjBk004OpM0mtMyFePqMt9B2YLa2QxRNYY
	 LXDCnTVu4YElYcz6UE6L8VHXnOuZ4B1Uqjs+w2W82nPhJZpnCa4xrLwLLPPIDT3Opi
	 7imr4b5eGAdwHFCLlO4KfHbzPsBt0ig0EXPOxgUiEktBNSUSzWSwiMsvgnP1PDWgum
	 QKPJ4As7nnOJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 373/844] fpga: of-fpga-region: Fail if any bridge is missing
Date: Sat, 28 Feb 2026 12:24:46 -0500
Message-ID: <20260228173244.1509663-374-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220452-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AA1691C640C
X-Rspamd-Action: no action

From: Romain Gantois <romain.gantois@bootlin.com>

[ Upstream commit c141c8221bc5089de915d9f26044df892c343c7e ]

When parsing the region bridge list from the "fpga-bridges" device tree
property, the of-fpga-region driver will silently ignore bridges which fail
to be obtained, for example due to a missing bridge driver or invalid
phandle.

This can lead to hardware issues if a region bridge stays coupled when
partial programming is performed.

Fail if any of the bridges specified in "fpga-bridges" cannot be obtained.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
Link: https://lore.kernel.org/r/20251127-of-fpga-region-fail-if-bridges-not-found-v1-1-ca674f8d07eb@bootlin.com
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/of-fpga-region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 43db4bb77138a..caa091224dc54 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -83,7 +83,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
  * done with the bridges.
  *
  * Return: 0 for success (even if there are no bridges specified)
- * or -EBUSY if any of the bridges are in use.
+ * or an error code if any of the bridges are not available.
  */
 static int of_fpga_region_get_bridges(struct fpga_region *region)
 {
@@ -130,10 +130,10 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 						 &region->bridge_list);
 		of_node_put(br);
 
-		/* If any of the bridges are in use, give up */
-		if (ret == -EBUSY) {
+		/* If any of the bridges are not available, give up */
+		if (ret) {
 			fpga_bridges_put(&region->bridge_list);
-			return -EBUSY;
+			return ret;
 		}
 	}
 
-- 
2.51.0


