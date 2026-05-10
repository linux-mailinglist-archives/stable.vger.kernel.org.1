Return-Path: <stable+bounces-244997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN/FLw8JAGq9CAEAu9opvQ
	(envelope-from <stable+bounces-244997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:26:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40774502845
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0D03031312
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3329BD87;
	Sun, 10 May 2026 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dms11K2j"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF3286881
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387154; cv=none; b=CCAO/7UBmi/Fwaj7ZM0GtU3uL2IsY06e8qiviDLX0KNaq2DMT06dESGO1mD5wz2H79Q4n+QyyfP+KlnqD7DN/aUFlWucLXbz7cCZMkkiUIjMZ6+DFMxR4GIizOVL+7fnaZakQIn7GaIMXwWPOsQ01aLdGWpvoAIdtgzYT7myMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387154; c=relaxed/simple;
	bh=6uvm7kxcoZxl4SJop0VuYLP778pizJEeCY5iHUnRujE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N9SgD4X/INYVHLVKC4jhq97nROWcSqiyX8zLe7v8/m7vshOFBuXGnxXOqZW1MOR9g0hyHva+OYDaUB6jOdZFdxCoPSTBoz0xY89bCWbLURE2Fr+L+vBDc+4M4RnnqOgPY8OZRpaEz5HFJONNArF+c54v76GSVPQEkMoK8UUR13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dms11K2j; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f3c623322bso5361407eec.0
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387152; x=1778991952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=dms11K2jMcDfQbw8xdMgaYe88MJgln/XfhDTd4/L2OnwUbq0H623qiTK1lbl4pRsdN
         F72mDZcMBXNrIKGy6jTnlIJ8I4PhqZnH4vx0yckkCSbl3Byfd0sl5ia27rADR+0Kgriy
         ivoLDZDVTMC7DPwJVTkHw2EWgPC0er/Hc50zq1HGYNbCXE59GZwnVgYHF3RK/VJzpEzx
         JlJoCQWJMUoy6JZHpDHpkGy3FnrWcKAQzOxnxx1Jz0kM+qsoIZA16UwKqamof6DUb1yO
         CgCitzl/r3ax5m9jlEsX9ao6PTvKkr/tnmJtmvzyc6XiJV6NvGEn+rWgu4EOcm372eJ2
         BVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387152; x=1778991952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ki2zpxXcCZiQ654Cm5JOUD1c7/Sq7YjZSIjBtyxJhk=;
        b=qJiDX2AO+zZsGr6ga8xmF5bmekHLltRnkkX5qqp95FEEXt6jjiuQ9wQNhy3KXy3fo4
         2Q5eL671qOc+rOMOIRof4GcHVSqFh1BuoP4sjHGyE3lf10FAssfTZwsUYChvYpVTzkCq
         a53wZsG59UIQHnDs79S6WKzu0cYaXCWP2lzQVs/bL1Y1f18mhYy8gIbCE8LusqTxipUq
         6/kb6GKjUzEbtfEN24eUe5Q1rOk5AQm3Eh3VewasCPJy1WXL5xdwEcaTERASnMF+C0+Q
         p3ADLHkuaVU9+dKuIdu4V66V+89J1CKjLbCL56q0W9JUX4mUwFldRlsIDiEdHjZD1+O+
         l0dg==
X-Forwarded-Encrypted: i=1; AFNElJ8wIpkh/ixLW04VCY4pdVpUsUfI/v3y2p9TBSHa9zcunR7YuhDJy8qcohrm2vb6W5yM+TZbRxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2UMqCt6V+vm0igfled/zrfSTcFzxEO/0vLaoe/Yhr9eSZBqs
	hcdrv8+0Xt+wwzf5HqU/9OfXzBCtGMdtehryw8yKpXGd6wX/5E7JR7NX
X-Gm-Gg: Acq92OGXDssY+lOAXCAUX0cpnS+o8CaisSDZKqHtl/WSYiJk9gft+raH4W9whylknUm
	8cKZwJCz59+mZyYRXEGPltxucJYMoYOmhw2uE2A9V1Bi0NhsqR8kB1PsIu7vBGqlnppU4jR8kju
	qcasR44DVTHsh6qrd6qWx8/C43tQTOAp2Hou6Evj1myfubTur5l75+1EPvfmK4vBTL6YuJDCidH
	Jax6DjyURHWcss2zU0Hfo+V85dn2A83x3D4SgnL3qyyl8DFdPkdAXAJtATnf/Myegx/XbUebCtU
	9lEMhhU4iEPKgpc0A+Bee1MfWJpdHAZgXmyaO4NuEClrPQ8ek2jbT0jkpcb49YPrm4BU3y9jMXD
	blsbhp2qQQevAIuxEMvitVeOWUabE0sM0x+aOsTSF1o+2EBLmKIKyXZNWiEUCxKfp7RTuPxe/hN
	3MxFe7GlvWuqwE69hCvuETwpd3Z8bWxySLmosc/RKnvyStRXzHA+oOPuvXn+Np6uiwMaQuQAyM5
	4A+
X-Received: by 2002:a05:7300:434b:b0:2ce:3aa1:d39b with SMTP id 5a478bee46e88-2f54c97128bmr9262664eec.20.1778387151815;
        Sat, 09 May 2026 21:25:51 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:51 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	marshall@shzj.cc,
	hyacinth@shzj.cc,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v12 03/16] platform/x86: lenovo-wmi-other: Balance component bind and unbind
Date: Sun, 10 May 2026 04:25:33 +0000
Message-ID: <20260510042546.436874-4-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510042546.436874-1-derekjohn.clark@gmail.com>
References: <20260510042546.436874-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40774502845
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244997-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rong.moe:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,squebb.ca:email,intel.com:email]
X-Rspamd-Action: no action

From: Rong Zhang <i@rong.moe>

When lwmi_om_master_bind() fails, the master device's components are
left bound, with the aggregate device destroyed due to the failure
(found by sashiko.dev [1]).

Balance calls to component_bind_all() and component_unbind_all() when an
error is propagated to the component framework.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260331181208.421552-1-derekjohn.clark%40gmail.com [1]
Signed-off-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/platform/x86/lenovo/wmi-other.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index be3309d74e03..a6be3463341c 100644
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


