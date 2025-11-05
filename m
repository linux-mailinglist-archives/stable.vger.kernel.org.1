Return-Path: <stable+bounces-192509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40249C36028
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 15:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61DB425919
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5776210F59;
	Wed,  5 Nov 2025 14:18:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119C1DC997
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352307; cv=none; b=UXeud+mwFxwS1AbPzaFpgR/XxPHJkPtMiJbAL3YkgbEFQI6xrWZ1uEbIX7R08Ktf356xz6ITer7VhBNr1CzRTPIaTlpXKCdXKL+gc4Uyl0spCs0AgfV4i3hcMSX5QAS97dnJBpI5xWx+fIAVJe+qHHbA0P4jQh40sRkSaKZdpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352307; c=relaxed/simple;
	bh=FPI0VgLB5Qk9//bA5850N1i023mixWR7VDo9UEncEE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hKwjAtRxGAILZ5doi0mMnJgfkqr1jZjgbhBWlnUbCKKI5SUEsN8cCmJGXpRaoyAOSyfPEzSwrP/YIM5ZrEFJgrHZJ+EFGwQgGzWxYtJ+yUdRAIyrlGU9fmzNqfR48TG2+EfwVuDnY8i0pI0ahHdvuwWj31n8YGFLj6TmLLAV5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 9D2C53F072;
	Wed,  5 Nov 2025 15:12:31 +0100 (CET)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: allow request_irq on GSC interrupt
Date: Wed,  5 Nov 2025 23:12:04 +0900
Message-ID: <20251105141220.2674-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default flags for freshly allocated interrupts are platform dependent,
and apparently powerpc and arm set IRQ_NOREQUEST by default, and resets it
once setup is complete.

Most do this in the IRQ domain's "map" function. The xe driver does not
define a domain, so clear the NOREQUEST and NOAUTOEN flags as part of the
initialization. Also set NOPROBE -- it is doubtful this will ever be
relevant, but it seems correct for what is effectively a softirq.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6468
Fixes: 87a4c85d3a3ed579c86fd2612715ccb94c4001ff
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
---
 drivers/gpu/drm/xe/xe_heci_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index 2b3d49dd394c..b0e38bd2e6f8 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -40,6 +40,7 @@ static int heci_gsc_irq_init(int irq)
 	irq_set_chip_and_handler_name(irq, &heci_gsc_irq_chip,
 				      handle_simple_irq, "heci_gsc_irq_handler");
 
+	irq_modify_status(irq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	return irq_set_chip_data(irq, NULL);
 }
 
-- 
2.47.3


