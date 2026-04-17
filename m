Return-Path: <stable+bounces-238479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCZHHP0V4mln1gAAu9opvQ
	(envelope-from <stable+bounces-238479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:14:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB5B41ABED
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25873056165
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08473B7B75;
	Fri, 17 Apr 2026 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/l9SPQ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB838AC8A
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424435; cv=none; b=YlfZ8TjuDvGkuvrcICoG2zeXuOCO7dSGqRCEKrYU04FBdTfmSU45spdn3bWfq4TbFm/AQAM0nd2fvIJCkv6dI00w8f+lTgGRzlfJH6NoLYJzsSxVp4KAM3mxdt3WSzd4eyk+djeekIX3q6FX/bnR5k8zIAAvQq+wyLOb4Jcjs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424435; c=relaxed/simple;
	bh=ZFA0J21UavqemBdX61tkeeGyEAB0nt+X9PKTYKjXLbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SQd5BtzXh5DrGICBFYiAlJFs1Rq3ZOXkkAr8aou1TIhbhdzYDJB8JktLYH+JFyFqlE1JI/F9VAauJ++aZAtIX11MVkBnOdTcmt5HwE30akWbEY9rkEUDpy0SXBMjnyeUrsAcXldpVPUyxR3Fp726Y/lFpCu8UiRPr/e42O/5Oz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/l9SPQ8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-386b553c70eso4626911fa.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776424432; x=1777029232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bH6jMbcTJb5ej+R0a9MCxG7qrcx/3nMs2OEMFRxEA/Y=;
        b=Z/l9SPQ8kJdhqWcAzMFMcxoerc3yTGtrOIoqCNeEW9iQnZYnGHk7RpipjltxaNApst
         a+HACIh9BidMH0Smrn/TedVd36B2Agkh449OOeeeTIeXa3ka1f1jGB2gb1haJLJjXuWt
         fu7uxOxm3WU6iizqX9LNCBS2iEyDC1IzVgO98yW96o0pulSe7fxJCPV3iegVEJwBW2Mx
         TSo2hBR2qpi4OlpQGehkdYMwX7bzCopWuTp5NQ2OaOGyqklYMUYJHwVgtcNghyAsBMjr
         iinFGDD4Z6PjT4yn2xef3q95X4waMB7f8GsvG+y2yIsbh0BegkQe5hk3DbQDo/QbIt4Z
         x2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776424432; x=1777029232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH6jMbcTJb5ej+R0a9MCxG7qrcx/3nMs2OEMFRxEA/Y=;
        b=ROaXmDDBw25S93Gc5V9fRFXr0siEiBPaMULfvS7zq52tUOBp/fxYyRwqaOhs7f3rlK
         PeLUMElp9XhMAG2uiOLaxiUYqeVx7I/dXtP0rZ+HiDUUHfSCWyVw9K571jj0YtAKzyL1
         rzqwMKT1o9ba+s1yWCnapc2ZZR+Gs/knRwJRdH6KGHUfANLhbiVPENAIJDGO9RZh8THc
         v+TvNutFTpSGdIZHS7JI1nvC1xM9mXgYTsE7vBmQqLH4ME/xhFZmnFP7ScLC8hLJclL+
         C3b41+UfPAChwiDEZTzZ4DbMXroCdMu/v+gVjTtPWr2BjZq50ZYw3hM5llm7Nk6tbw2Y
         KRXg==
X-Forwarded-Encrypted: i=1; AFNElJ9XeNpb/gl50HHvgdGxnmN+mAgm+qCR3WIbqQoVxNaXMpRc0jk0EhU4I2E9OXc+BnW+v1dZVfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy8L3nPuLYpzEX58BXvsAMuiytwX0I2TPOg4rhKd/J2XrQKt4G
	IoIYhBUncd2hITpMu+G3YIJl3pdNR61VOVSjvCm0W3iq3Val7+kc/7A3D7gBHV74ESg=
X-Gm-Gg: AeBDiet/jZTWXknodAU06DVg+nsqubRIB76s7R1N9YShU1pRpEI52W9qRVqrUZT0nfX
	wG23LxshwXQdDCL/dYMlH8UuJOvr4eyNri3ksHTj2c7K0TovKeOJFTMIYCVcUxlP9dxXZkN15At
	LEC7g/3J8vK8L35/6ztNNgmeIdf4QaTZPWTm1unB2M6nAyFGFjaSDvrNl1nRTCaBSWHQO1r+mZu
	pBkxOnAWEzefSzi2Zlwi8RxhG9VhbG6xSJBmuu0/J13gCORmHnbEiwhZAVMRshe6XWj5uDUNNoB
	2hNPBip4ZTDbBhPcoe3oAvDmW+d+CaZwn7laly3KH7n8L7LAoEYYtVb2w1d/ntpfqi7gKZl4PfT
	zCX+HHdK9Fpivswy5jc/3zS4s4k+Pi8YNCX9waX09CfFoSDafEFlL3qa9qkc+dm4weh2fmaeCy4
	OiXqvm0oQI6iDsUdIlCK1vBpYi6dZ9XpZUGQvPII126j77XblIliiuzRUQ1zI09JM4c+xpdiRby
	WrLXZfGbY0=
X-Received: by 2002:a2e:bc26:0:b0:38e:58f1:99f7 with SMTP id 38308e7fff4ca-38ec7b61afcmr6554131fa.33.1776424432285;
        Fri, 17 Apr 2026 04:13:52 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb733847sm3086691fa.34.2026.04.17.04.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:13:51 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Marek Vasut <marek.vasut@mailbox.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] pmdomain: core: Fix detach procedure for virtual devices in genpd
Date: Fri, 17 Apr 2026 13:13:31 +0200
Message-ID: <20260417111331.158190-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238479-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,renesas];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: ECB5B41ABED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
genpd calls pm_runtime_enable() for the corresponding virtual device that
it registers. While this avoids boilerplate code in drivers, there is no
corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().

This means these virtual devices are typically detached from its genpd,
while runtime PM remains enabled for them, which is not how things are
designed to work. In worst cases it may lead to critical errors, like a
NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
reported. For another case, we may end up keeping an unnecessary vote for a
performance state for the device.

To fix these problems, let's add this missing call to pm_runtime_disable()
in genpd_dev_pm_detach().

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4d32fc676aaf..71e930e80178 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3089,6 +3089,7 @@ static const struct bus_type genpd_bus_type = {
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	bool is_virt_dev;
 	unsigned int i;
 	int ret = 0;
 
@@ -3098,6 +3099,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
+	/* Check if the device was created by genpd at attach. */
+	is_virt_dev = dev->bus == &genpd_bus_type;
+
+	/* Disable runtime PM if we enabled it at attach. */
+	if (is_virt_dev)
+		pm_runtime_disable(dev);
+
 	/* Drop the default performance state */
 	if (dev_gpd_data(dev)->default_pstate) {
 		dev_pm_genpd_set_performance_state(dev, 0);
@@ -3123,7 +3131,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 	genpd_queue_power_off_work(pd);
 
 	/* Unregister the device if it was created by genpd. */
-	if (dev->bus == &genpd_bus_type)
+	if (is_virt_dev)
 		device_unregister(dev);
 }
 
-- 
2.43.0


