Return-Path: <stable+bounces-271372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pg2QK9KaRmqxZwsAu9opvQ
	(envelope-from <stable+bounces-271372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:07:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2206FB02B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:07:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IVz9f8sB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271372-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271372-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AF6D3044B3E
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC630EF95;
	Thu,  2 Jul 2026 16:56:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7432D0602;
	Thu,  2 Jul 2026 16:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011371; cv=none; b=szKU0j3Y31/u9WzcLOOBhz8AcWQDCQaJIjNZTcm6WzO5q7+22lOK+LpjOH5LZYxY2Nj1WQ4UzQ8vD14LfkwrsjdpIybFEUyQ0fU6oEZwIv82/4WleJHUHxc5L5dshRsKW9UIJt0ep8PV5agJRXurOwGdnFFec4OaAhbnKF56q3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011371; c=relaxed/simple;
	bh=W1m94D8hd/eiKxtzyAN8xJY74imCfjDuEvqnJSj7lt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHC3OU8kTENaqxB58/At0uoBGT6QAi1AXhEyeTqiIeLzhu/fJwxodGwu/mUjVaEb3WP8BFSeLlHuYCr8GLzFke7Gk9KQbHVyIvdJztO4oB1zHsvY3xeNQTgFA6/X0MNSIxnVRd9h0twsDpe9zXbjuhEZBupopNAxM6c9zs/i75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IVz9f8sB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ABD1F000E9;
	Thu,  2 Jul 2026 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011370;
	bh=R5nNsxjG5e2diSQzgaK6KBvtUxVHlptepifNy4fkZFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IVz9f8sBOKhq4mOvAslFQhNMKzR49QuOK0pFY1o9SOGlCNBMhsxi4cUitM6LsV56f
	 tHx7kbIGW7vT2p4p1CNLEC4QFFNk6kNQYwS2dTEiPVxcCVRI5XPtGXULfGCxpIJYHU
	 uXIf4MhRiqpAYfZWgfrvtiL/QSdt2EUSLWOQ9ob0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 6.18 082/108] fpga: region: fix use-after-free in child_regions_with_firmware()
Date: Thu,  2 Jul 2026 18:21:19 +0200
Message-ID: <20260702155113.811737287@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.110058792@linuxfoundation.org>
References: <20260702155112.110058792@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271372-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:yilun.xu@intel.com,m:yilun.xu@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iscas.ac.cn:email,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B2206FB02B

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 54f3c5643ec523a04b6ec0e7c19eb10f5ebebdd3 upstream.

Move of_node_put(child_region) after the error print to avoid accessing
freed memory when pr_err() references child_region.

Fixes: 0fa20cdfcc1f ("fpga: fpga-region: device tree control for FPGA")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
[ Yilun: Fix the Fixes tag ]
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20260408154534.404327-1-vulab@iscas.ac.cn
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/fpga/of-fpga-region.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -168,11 +168,10 @@ static int child_regions_with_firmware(s
 						     fpga_region_of_match);
 	}
 
-	of_node_put(child_region);
-
 	if (ret)
 		pr_err("firmware-name not allowed in child FPGA region: %pOF",
 		       child_region);
+	of_node_put(child_region);
 
 	return ret;
 }



