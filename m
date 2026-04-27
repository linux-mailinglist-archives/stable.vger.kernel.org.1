Return-Path: <stable+bounces-241227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eElMEBoH72lJ4AAAu9opvQ
	(envelope-from <stable+bounces-241227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:50:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 979D246DD68
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 08:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F100B3006971
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 06:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F103264FA;
	Mon, 27 Apr 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNHSrOle"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B89933ADA9
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272597; cv=none; b=Yz2cjOZRNbYiSTtRFbbwMsgNrdmaPLgEQgdNjbeb5WegeUmLzrJCBFTc/gM9NWt98Fks6ITXrl7g2Ke1tcJvkqSI4h8Uoa3c5cvqKMstonPYOwTvU16N1bpeFcx0AyVycJVj4e9xwgnBuYxBpOFWtIruDH1YIL1dB93yVoR7Mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272597; c=relaxed/simple;
	bh=ifmFZuT2yL65hYWXSntFE3Xxo4d0ZlqISyl1YG9tRuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lW8dyOSRTzev464spPjCnNczaOKmSaX/80lJeTBL+tbSo6UZXdruahLEz7Gj1PCk3HP4YydsjknTbAiFSPifi/yRObPTO9JtaqQV+7F13ZNmDbt61zNOSuVaAXCZtDzcahPia+j5+8KU4LVzSNieD3WUb/TO3Rw9DV1AF2T0Jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNHSrOle; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso105801405e9.1
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 23:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777272595; x=1777877395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C0XFTVZm6nDhiD0bMo8SDFHEq9ueglfbqYEb/g+IqfE=;
        b=tNHSrOley5nunccN4wAq0N4ZsSHnQSGu8AtPrF9Q+itkNHFHHWk3u0NUa9zpWT4Ujt
         FBBIzoDkd/xA5TOU0pxyDNYM09X4yihi5q5v23aLQgSrRLZNmdhIdIyE5HFt4wN4CizW
         aGvVIbN2SseANos7x+8FDDSkzAaCyGY1tpyBF5wT528mJmDW6yTiS4hJLCj0f2kkX4hI
         r6t+jUjtQUrX5Foh4Mully8Y3YIqDY1WHJmgjxfed11PtmJF+DtgrITqIEiryqqTVMQ3
         awgcx5qm1iNRkOMNw61yWZlxCSlpksQ8JLttISblNRMhjqeu9sGgXp2XUNxWo2YD5ar6
         69Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777272595; x=1777877395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0XFTVZm6nDhiD0bMo8SDFHEq9ueglfbqYEb/g+IqfE=;
        b=RhRmfdD4u2Mq03hCDLJ6WL/0aERQzQy2ID86SqwML+Hfod087/KPyAX+2Or9MpvzHs
         DSCkEo6VXrUA13TZIAfbSQvMW9scdNJqErfjtFYqWYd01LdMwS76cRBZPXh6TONRqK4a
         ZUJCAbuXS2IM+rPgtCRhYoPNAeH9Fd/kUX2e1ML3jjlujT9cSsJ86ddcfrAznsvsDkAo
         NMQnk+HwL0MmBvX1U2ruWZgRvdInuHCryUOEGSy2ucgc2cnUM6lJ5BRc/8ECYcOqp8dG
         X9D6DKPfgOSQnndOzIxKqpd3mghG1JjGzLeHEweGGavsTKMHlDVmmmFqgwOPFGYgySWx
         CIQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Xcst3lEANlsrQhsGyFgCfK7c0cNO3sm1TnRJQtzWXznRfYWPnyxM7rxdgRRz6AQvGJi2x0/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBF0X8lID5AVGpouvG4ReZcTzpTrQbjbmJn188BORanPG3nvA
	XZmR81qgNUKRSUJS7S6bgcjP/aR9suEnQKArXkP2DUX2OSKmQbRrUdGj
X-Gm-Gg: AeBDieuxPW3vF29hsMUDYD/QRP2g6y+Pp1v+lJQMmh8IlZRQeO0NabPEB9jn17b4Dec
	oG3G1OB5Df5zat/N4ETe/od66n9Hl2FaPXTnI2h6YYpmq+0IsKCOOd935mZBFXlVFprJE5zqFNR
	uRQrZQfOPSASqC9u9tItoJcrOdU+CvvbKwA5bs99ExO+nsftmKPOcMIzDUs8qmBnM9QXkNKXcfj
	b0/Y8TVH/g2N/um4DvDTrIe0gH1/adVwKao2jmrCa8AUk9cmVYYy0cG2U0MxnUfsTKFagpJTjtX
	ZwBpVaWmzO/UgdeyW35/vN1d4o81H+Xwa/ATtf4DFQ/a05bf+w68MqjZK7/6IJltrLofOISICKl
	Kl9v7mWUVSCc0mYvn4glTUk6aRor8Y0CJB/m1hA0evnC3V6nV2oAOkWjUPQNhpWjDtZym00ODaU
	R2juZrShXjRUyOUXtrRtSXQGRyywkeWINBqDjZL7rXjP0qeYLk8Q==
X-Received: by 2002:a05:600c:3515:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488fb78e7c5mr569746115e9.28.1777272594279;
        Sun, 26 Apr 2026 23:49:54 -0700 (PDT)
Received: from vitor-nb (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm807502655e9.10.2026.04.26.23.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 23:49:53 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: 
Cc: Vitor Soares <vitor.soares@toradex.com>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: ti_sci: re-sync TIFS with genpd on resume
Date: Mon, 27 Apr 2026 07:49:39 +0100
Message-ID: <20260427064939.3240057-2-ivitro@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 979D246DD68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-241227-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivitro@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toradex.com:email]

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


