Return-Path: <stable+bounces-246457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO3HHrVsA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:08:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C6B526E0A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13FDE305B779
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131B34405B;
	Tue, 12 May 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTlNivPd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9E2DE6E3;
	Tue, 12 May 2026 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609277; cv=none; b=shjUfC6bkWQlEvZ9aN9Dq5c/8TGI3z1CCiOWNymZKYFcZZelqugQMUHaxAwcmB2im/ARHtp1ochZ+vi5clCwxrOX4zBBEMat3TAADGoh1fMgKQgdCdegKbA0c1vjmSOH1oyEOT4zy7V6W3heRhPfTgM39pYnXeYBiFbme7XqadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609277; c=relaxed/simple;
	bh=YU40AbNgBn2rUBWLQ2o5kfFEKLBSBIXaJdqRP5y6xiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bt2+hGvvkD4oPTNmCF66PBbuE2nXgmpUl78NTqltovpqc3XVz36K9xy0UR3XDi4kWIlQqp8byPXTsxeIHw9uydthWlXZpZyDOOTP3hTgaz7xBdYF8mXj7HOHAE8KOWwW6lJlgxzwn2/21J7X4MBoJydE8sOvkUbj4YSNrsTw+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTlNivPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03F4C2BCB0;
	Tue, 12 May 2026 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609277;
	bh=YU40AbNgBn2rUBWLQ2o5kfFEKLBSBIXaJdqRP5y6xiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rTlNivPd0NRSGEbkrkA2qt1NQccAFDaL8FYAdhPdds46tdcWf/TR5B4d2CNMFGIu+
	 Gs/JheDnllWo3+Umsrn+0nimNjis47RGI81WOHDNJFkayegiscHTZ3b7dHvxakthVx
	 fQjZpR9ggtHe6owEbrcHnF3ZARwtVnaeO9BTDnMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7.0 133/307] pmdomain: mediatek: fix use-after-free in scpsys_get_bus_protection_legacy()
Date: Tue, 12 May 2026 19:38:48 +0200
Message-ID: <20260512173942.934850153@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F1C6B526E0A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246457-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,iscas.ac.cn:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit ec1fcddb3117d9452210e838fd37389ee61e10e8 upstream.

In scpsys_get_bus_protection_legacy(), of_find_node_with_property()
returns a device node with its reference count incremented. The function
then calls of_node_put(node) before checking whether
syscon_regmap_lookup_by_phandle() returns an error. If an error occurs,
dev_err_probe() dereferences the node pointer to print diagnostic
information, but the node memory may have already been freed due to the
earlier of_node_put(), leading to a use-after-free vulnerability.

Fix this by moving the of_node_put() call after the error check, ensuring
the node is still valid when accessed in the error path.

Fixes: c29345fa5f66 ("pmdomain: mediatek: Refactor bus protection regmaps retrieval")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -993,6 +993,7 @@ static int scpsys_get_bus_protection_leg
 	struct device_node *node, *smi_np;
 	int num_regmaps = 0, i, j;
 	struct regmap *regmap[3];
+	int ret = 0;
 
 	/*
 	 * Legacy code retrieves a maximum of three bus protection handles:
@@ -1043,11 +1044,14 @@ static int scpsys_get_bus_protection_leg
 	if (node) {
 		regmap[2] = syscon_regmap_lookup_by_phandle(node, "mediatek,infracfg-nao");
 		num_regmaps++;
-		of_node_put(node);
-		if (IS_ERR(regmap[2]))
-			return dev_err_probe(dev, PTR_ERR(regmap[2]),
+		if (IS_ERR(regmap[2])) {
+			ret = dev_err_probe(dev, PTR_ERR(regmap[2]),
 					     "%pOF: failed to get infracfg regmap\n",
 					     node);
+			of_node_put(node);
+			return ret;
+		}
+		of_node_put(node);
 	} else {
 		regmap[2] = NULL;
 	}



