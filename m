Return-Path: <stable+bounces-232849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN7IG49szWnvdQYAu9opvQ
	(envelope-from <stable+bounces-232849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:05:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9F937F9F6
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C0BA308153C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56928477E4D;
	Wed,  1 Apr 2026 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="TWtdQxnj"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E035CBD7;
	Wed,  1 Apr 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070164; cv=pass; b=NChsVR0UCfck1K+IjajwUh5d4XqJzyegwVmu7M9aRqfcx0Y1PcGhUUZehqHuGTNcJDbzvgFlCKTzUxY4gDj1ySU+VAqM4fq0l2icjFuF6pOmLV7iYfAJRwqh8JNaCpJcWpRbtpsyhGK7LgVRXklkaswzGz4s+DHwysdgctaA5PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070164; c=relaxed/simple;
	bh=vN4i0w1j45GOoB5Hu5uffu0CsFappwHWccRsuRRL4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgibTVNGnQZXOsXK7XhO3gVx/MBdgdWm7s26sQnLLabGNGBa7jowYrPVrFUXL+oodXElCB5YO0midMh/AgGJfCBjZrcYUDx8Z2zhbfYhHz4INYSWBG4ZoO/35EfqOd7f4G7GVi8VaNuWNtOu7M6LFCKtz6Fuufe35GGKixVs8yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=TWtdQxnj; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1775070155; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=axDbOFBHJZLeqv3u+9OXwF759VuxQqpUgVXVoVS4GlwT9OFHcU9KnR56tVSXNZc3RFRmZ9d6icuQ7r2tRNTv5N2rC+DOjo7Luh3dMQQkwMs9b1LLbjkBtABszNWxrS5EBL2yPFQi2D7CP6YUzXRvOaeQ4Avx0UQwk0esZzi+eTg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775070155; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=526/sqH61ydxU9ksm4AkcWTMmCfqZfsUQZd9dOh0Jd8=; 
	b=V0BkhvxNEbvbROo9AL/pEEJqGuiqHlwzSB53QeUo7Q8RwqMoMTtXHJpj20PlaabFgpgKK0R4Qv/7tz077mzq0zK4KobbFCT48kVyWXlxOoD+OdIFEJAHufK7UU6kUGqqJxV1FORFawgRZ1NhmWQQdlHafZMhLN6PlOW79zZ2bFQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775070155;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=526/sqH61ydxU9ksm4AkcWTMmCfqZfsUQZd9dOh0Jd8=;
	b=TWtdQxnjKfrJNfCGA6ogjIkMpR2rcs9UGewYhcDE8abhrJgByJfieieAA5kNODxz
	nmUS6wUyFp7SFVEqI2AN97DJN9ST69GmhbW6nFzU3dnoG1s/yCvQlBsZ9USbdidtXBi
	KZ4cLY7D44Kb+k+z0s/d58iVaFPnJsqtySq5uMN5E0m1jqCQhw98sTY+hLfBSE3uY2b
	/JH8xRBW+FWB74ZJIxvBULctBmIcV+q79y1fh+2BJUZGnMVAVH+H2rJzlzvBJGUI2sl
	jxV59Katky6UaJi3B16bTvXiCQnta+T2U0pbwWvuF+bxvSgFdNyflu7W7TgrPkxMTRu
	1hhyr4Yh7g==
Received: by mx.zohomail.com with SMTPS id 1775070153052257.07179805357987;
	Wed, 1 Apr 2026 12:02:33 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Rong Zhang <i@rong.moe>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Kurt Borja <kuurtb@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/3] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Thu,  2 Apr 2026 03:00:57 +0800
Message-ID: <20260401190221.1595264-3-i@rong.moe>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
References: <499fa3efd5be054ffdda77dd00ad4d8d3391e073.camel@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rong.moe,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rong.moe:s=zmail2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rong.moe,squebb.ca,gmx.de,lwn.net,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-232849-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i@rong.moe,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rong.moe:+];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:dkim,rong.moe:email,rong.moe:mid,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA9F937F9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When lwmi_om_master_bind() fails, the master device's components are
left bound, with the aggregate device destroyed due to the failure
(found by sashiko.dev [1]).

Balance calls to component_bind_all() and component_unbind_all() when an
error is propagated to the component framework.

No functional change intended.

Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/wmi-other.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index b47418df099f..4b47b5886e33 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -1068,8 +1068,11 @@ static int lwmi_om_master_bind(struct device *dev)
 
 	priv->cd00_list = binder.cd00_list;
 	priv->cd01_list = binder.cd01_list;
-	if (!priv->cd00_list || !priv->cd01_list)
+	if (!priv->cd00_list || !priv->cd01_list) {
+		component_unbind_all(dev, NULL);
+
 		return -ENODEV;
+	}
 
 	lwmi_om_fan_info_collect_cd00(priv);
 
-- 
2.53.0


