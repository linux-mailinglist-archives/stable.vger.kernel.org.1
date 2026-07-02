Return-Path: <stable+bounces-271262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NM5qEACbRmrCZwsAu9opvQ
	(envelope-from <stable+bounces-271262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 925496FB05B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:08:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=LnKCO70B;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271262-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-271262-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B54B431277B2
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983D33E348;
	Thu,  2 Jul 2026 16:51:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202E33B975;
	Thu,  2 Jul 2026 16:51:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011087; cv=none; b=lqODIR/QDEvCZSWKCTtFajP5rJwXRcg1ZWiDhFlujPmp9hootljKtsBiOQQcl7ngozBRSOvvCQskf5uPq5YefZeMmYMNnffGl+ZzbUyrZ+QK4+XP+JtmIcHEDCQM+OHNSB/s/jSQYfw401yq4pPaCAPLLTLOtgv0PLFz+xxUPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011087; c=relaxed/simple;
	bh=XCnQxaDkeEdTpJOjRSR6JTMTPIFeJbTc5Vkk9HwAUCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5V/HEPXn72u22ouVWuEJ+2BN3gA9h5Mm0O/cg8DymHrzSLVWEcGvOD2NWlWIQIwW/IGdxbnTLFtr44RNCuZ0BltElN6vetz8cKoHXOiJ3GwVfsnX2veKX9yTnGKlggJoxkZFgDmrN3klW9NoqHfJYu4fxyS5A0RiucRkJxuulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LnKCO70B; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03AA31F00A3A;
	Thu,  2 Jul 2026 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011086;
	bh=g8pcysCsLfneAgPdzazwC+BbXlNboIWtdpc5wvvdj64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnKCO70Bvjj2AIPQdt9G6QcTY93KNp3cUPxChR0+LHaW+qKU2m/9MQkrmIla7hNhg
	 OdLrZwZWrEmkWmPIfkej+R1PfOp9VkywsZDNVCssiwdekSuYY0rJUIamXeX8dBjQnn
	 k8Nlg3eblzaTQS9Y/A+HG4XruopcCHvJpaIL6BUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 6.6 152/175] fpga: region: fix use-after-free in child_regions_with_firmware()
Date: Thu,  2 Jul 2026 18:20:53 +0200
Message-ID: <20260702155119.002139680@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271262-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:vulab@iscas.ac.cn,m:yilun.xu@intel.com,m:yilun.xu@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 925496FB05B

6.6-stable review patch.  If anyone has any objections, please let me know.

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



