Return-Path: <stable+bounces-252369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIRyOAYGDmqv5gUAu9opvQ
	(envelope-from <stable+bounces-252369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:05:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D3597BA4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56994320E1EF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6823F7AA9;
	Wed, 20 May 2026 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyDCbfQI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E432A36A02E;
	Wed, 20 May 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300495; cv=none; b=ZFf00cvwzjrLk3RxswSwXR9CSbTFjW2YALhfkD+wpmlMwP8Xtc7jkrT4t7nbFvOLoQy/P5jtRX2oYLVJ9RxGO+DftadjAIYGi71vlVz9NA0k0qTKUewqkiGdZNtwRCETmVYmA6/peJmflxEa8h/BJZWUzNd/O9fmz3vEQIOnv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300495; c=relaxed/simple;
	bh=pelow93vsq8E872PIih/Xa67i/4bN+Ul/FyC8FzUc6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcUwYSUcbRWHHnJcMKyGdVx/sq34MAmBTo4rsrBW+KSp4JXLtCQVVoZlTPmoVwvGyKUWQhZfZoFIBMtQqgqlbducPCa1fmZqB6llPpVHVlqhYlLDelsw9TVk5xLjAcoFldfVngLGBXeOTDTkz7VVUFqvLx/Sv1vK+H8SnI1TCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyDCbfQI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9661F000E9;
	Wed, 20 May 2026 18:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300493;
	bh=+uPNBo80AEP9zpfJdRuGaoRT1jPzATVrbFVq7bv33Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IyDCbfQI171+AdV9k2cCzE5YBeIC+m+N0gNfKsBkfiZad4ONfppYZWpPql+/CTYQ+
	 nXWVPgNXxfasGSdXYIYA4htqyRzyk26BwzpRhOaJOKjgUCJ4V+z0RaiP/b/BoZKXbi
	 OCH7YKgZuTE6iCUx8x/gaYNy3upAlYmGmyiBhN+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <gu_0233@qq.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 195/666] pmdomain: ti: omap_prm: Fix a reference leak on device node
Date: Wed, 20 May 2026 18:16:46 +0200
Message-ID: <20260520162115.427401430@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252369-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,qq.com,linaro.org,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:email,pd_args.np:url]
X-Rspamd-Queue-Id: E37D3597BA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <gu_0233@qq.com>

[ Upstream commit 44c28e1c52764fef6dd1c1ada3a248728812e67f ]

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In omap_prm_domain_attach_dev, it does not release the reference.

Fixes: 58cbff023bfa ("soc: ti: omap-prm: Add basic power domain support")
Signed-off-by: Felix Gu <gu_0233@qq.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/ti/omap_prm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
index b8ceb3c2b81c2..f4e52e92dcbf6 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -651,6 +651,7 @@ static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
 	if (pd_args.args_count != 0)
 		dev_warn(dev, "%s: unusupported #power-domain-cells: %i\n",
 			 prmd->pd.name, pd_args.args_count);
+	of_node_put(pd_args.np);
 
 	genpd_data = dev_gpd_data(dev);
 	genpd_data->data = NULL;
-- 
2.53.0




