Return-Path: <stable+bounces-251483-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNOGOKzxDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251483-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:38:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC45942E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D07F30B50EE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C43A3833;
	Wed, 20 May 2026 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y9rQHbDu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042B36F421;
	Wed, 20 May 2026 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298100; cv=none; b=c50GcpUREK2sx8MVgDo+Sju9BKldzaH7PfXQKjRQ7YStMDiuAVxoek4j3yEsBy8SeD2gGOWjmFbDn7MiEw+ofrKSO9cRFO/o/PCTz5e3sOeZIHqh4J2VNjZ+liMktruhGDEI/rEjSM72/LmPJNf4o5JPRpB5mreEhQzsi7V/6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298100; c=relaxed/simple;
	bh=6bORIgttPQM6s/R4zy93f3dqKDO5LMH+MjS0WCKEyrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irpUXCgWOafzKpvrIy4jamjtpQlxMxLntQbC9g6nwLJj9ABx9UgP1cuajnMQLd7hyN7lv0NSVujnFYRgFsdHU3a5IFCB87humeUDVz9qpCkmjSnMdmqmaekKvgka844Xj2+tjEnT6T70yd9G9mpCuAV/oHKrQ3zvSGkBoR76MGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y9rQHbDu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC361F00893;
	Wed, 20 May 2026 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298099;
	bh=Vki3s5WV08TAEhGO3tXPCTfRgHM/7I9CzufmupTKxzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y9rQHbDupyr8MyQY/xGxiPy5C06DtziDW//CxZevPdMQFz/6jXPeM2zzkn0Kcm2qV
	 JwFZ1W5uY4DtY/lZdIuXB31lqogdqPOLTGPIza6vw+eXqRbZFILmKDnNeB0oPjUSWT
	 MlPOwYgtbE0qZvuvu8GNWlQ/gMm/qN2pkedWxfEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 282/957] PM: domains: De-constify fields in struct dev_pm_domain_attach_data
Date: Wed, 20 May 2026 18:12:45 +0200
Message-ID: <20260520162140.656382280@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251483-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6DCC45942E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 1877d3f258cbb57d64e275754fb9b18b089ce72d ]

It doesn't really make sense to keep u32 fields to be marked as const.
Having the const fields prevents their modification in the driver. Instead
the whole struct can be defined as const, if it is constant.

Fixes: 161e16a5e50a ("PM: domains: Add helper functions to attach/detach multiple PM domains")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pm_domain.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f67a2cb7d7814..5ed1753a7cb47 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -49,8 +49,8 @@
 
 struct dev_pm_domain_attach_data {
 	const char * const *pd_names;
-	const u32 num_pd_names;
-	const u32 pd_flags;
+	u32 num_pd_names;
+	u32 pd_flags;
 };
 
 struct dev_pm_domain_list {
-- 
2.53.0




