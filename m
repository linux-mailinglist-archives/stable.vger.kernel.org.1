Return-Path: <stable+bounces-241252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHukHs0U72l85wAAu9opvQ
	(envelope-from <stable+bounces-241252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:48:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC446E8F3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35BB330073D7
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB53976A7;
	Mon, 27 Apr 2026 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edcsfd8M"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB2388E6C
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276102; cv=none; b=KKltXQXROoloIyLM+Q/X1CNXbFkwuwwliRqj+JxSNeTATQcrF8T/OqLgZgSgBfu0wT4UGbzDOBBJ9zsmopxdoNzlbgIwzFTayyOyZkOBzcGvN8hXbQAssXU6H+tTgDNB41LbE+5+BWA29eGsMknu3s+G94j6otbomEqF3wsKFjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276102; c=relaxed/simple;
	bh=ifmFZuT2yL65hYWXSntFE3Xxo4d0ZlqISyl1YG9tRuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QBz6tOjn3n1eBt75WmfU3v8e/+Oi85pwsBageFY6H0X/IXTJu9iZYsha1FBbPWGwojxOgQC6w4X/T6cAM1VZf5bWxitNdNH0I4gFdRjoVUMhhYgHsciigGJzxWb2hJiLyOtStfaJDjSPbnAaIzIhL+FiwejYN2n+Hl186gGReAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edcsfd8M; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so118113885e9.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777276100; x=1777880900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0XFTVZm6nDhiD0bMo8SDFHEq9ueglfbqYEb/g+IqfE=;
        b=edcsfd8MjvD65H4SZ7bFHypdIw9UzJZ0AZ3foWn/wGZq5sJBnhDypNljOERj5RgpM2
         beF3os0pQt9sWM8rdEJHwldUSvJi50KQ+0IrOwjvgICkQi72KYKLLw7oTWXIqsxwA329
         ix2d0+PFiVS5+Ngftx4RRgonD3pGWdI3Rdl4G+Xvf+KIvjiY/mCDvUTQOoSX5UPEDtkV
         GiPBrfaKRMa+9O+TE3P4Jj7R7X3q4jly4iQLGjv5BXHrGGr/bBzqiBdeHMqq4l2LHqEO
         wvYD9uc/4gb5zNQbrj6iy2yBa746RXxp2EIDVA6VYVZ8wGiw6Q8rO4+8ByOdPKR3wYTh
         uhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777276100; x=1777880900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0XFTVZm6nDhiD0bMo8SDFHEq9ueglfbqYEb/g+IqfE=;
        b=dUASRzS8QToTIB5e5svK6aRSHgifVt3hlRqVftQy9BaxhTeJtLMD/eyqWikvRkSBfc
         mP3Fu4Bj3uVB+2eWFtC2kV60iNFUwp5WzwkgvlyyW21ZGSIsKZqzqS2+MJMXdbxCBKfa
         kSLHG1H59jdtZE07Tl060+/2MQ+1/gzqNbr8R4djYsnWrqsV9jYNfTX0fRwOg2aoE4fD
         oXLr2Osau7wC9e/v11t5GFUVUhxpvgdsdecRc6ZYcZxteTUv6w8u9MAofBL8KU9WSBeX
         X3wJQ6DJY7bgS/P3oWjefYInsp0/tKzU3aS1CrNTW5rIP+lsabEKehsXP/bxw3BXsHPu
         35Cw==
X-Forwarded-Encrypted: i=1; AFNElJ/QJGQLCqFM8m6WekuXZT+E8sP0p0TN3NvItJdE5Ir8pqxqRxuPBXAVgbKfITw52gCH0xh9ye8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz8W0u/Urtx7niEOboD1tf9XemJBep4+CAAhYr3jkEjsh5ZzzJ
	0sZ5XGcERH0YcLHXXnhiAMvvjxGipBmGefEwfHn1B42xskrlfiRlnDjj/8bYZA==
X-Gm-Gg: AeBDieu+VH/qQ1Qi2iJ0j50wvfjRUrZFFm4apVIpL3iTMFwfTPXqFrJZFjeFgK15Z2o
	QaEeR6I7saSk7d/KKza/BtOYVIL0M+FRvSSuONDsNUm5ad2WqHRtwUQ7hRDKQatwMHxM7wvoqAT
	aY7h90dynI4atXonCdiihkcodtwWClP+DtXfkFeYvHEMHxsTCBGfM2XU6chVTq75x9MFWxjDc1t
	YpGgJE1Y+A8cZ0d+4R5/RfaAYiEev2BRhnaFHSGhDd+Z1Jg0tBd+Evx6cjXsC0S+2tjfjtt4Ukr
	zA2Dsn4mcg2G7zTHhA2nOeo51KblZbpULqwXJdgR0BjpO1stCcAnhILAtaqLz1rTdAV9BFBVmuN
	CtPkjoUCVoNW1LDT62NqVSd81WwxRciAuHH272UfMIbbMGLPN3wDG7J9sKcOc7CTrxttp5aGHfh
	WmW7WQw/7/4WmxerkwICEfFZ8wdNYTRtzqlj2FZ74CxqyY1RZlqw==
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488fb77facemr578263265e9.21.1777276099604;
        Mon, 27 Apr 2026 00:48:19 -0700 (PDT)
Received: from vitor-nb (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm718761025e9.9.2026.04.27.00.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:48:19 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Kevin Hilman <khilman@baylibre.com>,
	vishalm@ti.com,
	sebin.francis@ti.com,
	d-gole@ti.com,
	Devarsh Thakkar <devarsht@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
Date: Mon, 27 Apr 2026 08:48:03 +0100
Message-ID: <20260427074808.3244226-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCAC446E8F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-241252-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Vitor Soares <vitor.soares@toradex.com>

When a device in a TI SCI power domain is on the wakeup path of a
wakeup-capable child, the suspend path skips genpd_sync_power_off().
No put_device is sent to TIFS and the domain's genpd status remains
ON.

TIFS powers off the hardware during deep sleep regardless, since it
was never informed to keep the domain active. On resume, because the
domain's genpd status is ON, no get_device is issued. The driver
then accesses registers of a powered-off domain, causing a
synchronous external abort (AXI bus error, ESR 0x96000010).

Commit 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according
to the HW state") exposed this. Before, domain status was initialized
to OFF, so get_device was always issued on resume.

Add a .resume hook that queries the domain's state from TIFS and
re-syncs TIFS with get_device when genpd has it ON but TIFS has it
OFF. The hook is only registered when the is_on op is available,
since detection depends on it.

Move ti_sci_pm_pd_is_on() earlier in the file so it is available to
the resume hook.

Fixes: 0b5fe1c4ab3c ("pmdomain: ti-sci: Set PD on/off state according to the HW state")
Cc: stable@vger.kernel.org # 6.18+
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 66 ++++++++++++++++++-------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index e5d1934f78d9..ec976d77b818 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -131,6 +131,23 @@ static int ti_sci_pd_power_on(struct generic_pm_domain *domain)
 		return ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
 }
 
+static bool ti_sci_pm_pd_is_on(struct ti_sci_genpd_provider *pd_provider,
+			       int pd_idx)
+{
+	bool is_on;
+	int ret;
+
+	if (!pd_provider->ti_sci->ops.dev_ops.is_on)
+		return false;
+
+	ret = pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
+						     pd_idx, NULL, &is_on);
+	if (ret)
+		return false;
+
+	return is_on;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int ti_sci_pd_suspend(struct device *dev)
 {
@@ -149,8 +166,37 @@ static int ti_sci_pd_suspend(struct device *dev)
 
 	return 0;
 }
+
+static int ti_sci_pd_resume(struct device *dev)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
+	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	int ret;
+
+	/*
+	 * If genpd's domain state is ON but TIFS powered it OFF during
+	 * suspend, re-sync by issuing get_device before the driver resumes.
+	 */
+	if (genpd->status == GENPD_STATE_ON &&
+	    !ti_sci_pm_pd_is_on(pd->parent, pd->idx)) {
+		dev_dbg(dev, "ti_sci_pd: ID:%d genpd/TIFS out of sync on resume, re-syncing\n",
+			pd->idx);
+		if (pd->exclusive)
+			ret = ti_sci->ops.dev_ops.get_device_exclusive(ti_sci,
+								       pd->idx);
+		else
+			ret = ti_sci->ops.dev_ops.get_device(ti_sci, pd->idx);
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_resume(dev);
+}
+
 #else
 #define ti_sci_pd_suspend		NULL
+#define ti_sci_pd_resume		NULL
 #endif
 
 /*
@@ -200,23 +246,6 @@ static bool ti_sci_pm_idx_exists(struct ti_sci_genpd_provider *pd_provider, u32
 	return false;
 }
 
-static bool ti_sci_pm_pd_is_on(struct ti_sci_genpd_provider *pd_provider,
-			       int pd_idx)
-{
-	bool is_on;
-	int ret;
-
-	if (!pd_provider->ti_sci->ops.dev_ops.is_on)
-		return false;
-
-	ret = pd_provider->ti_sci->ops.dev_ops.is_on(pd_provider->ti_sci,
-						     pd_idx, NULL, &is_on);
-	if (ret)
-		return false;
-
-	return is_on;
-}
-
 static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -283,6 +312,9 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				    pd_provider->ti_sci->ops.pm_ops.set_latency_constraint)
 					pd->pd.domain.ops.suspend = ti_sci_pd_suspend;
 
+				if (pd_provider->ti_sci->ops.dev_ops.is_on)
+					pd->pd.domain.ops.resume = ti_sci_pd_resume;
+
 				is_on = ti_sci_pm_pd_is_on(pd_provider,
 							   pd->idx);
 
-- 
2.53.0


