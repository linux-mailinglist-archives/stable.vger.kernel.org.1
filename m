Return-Path: <stable+bounces-244975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHlJKcNf/2l65wAAu9opvQ
	(envelope-from <stable+bounces-244975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:24:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 231DB500732
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E97533011851
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5AA2F260C;
	Sat,  9 May 2026 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNAutQl6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EA11F7575
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778343867; cv=none; b=noqbCz4aHBhHaCNrYHuimco9JLDFZH3SFNIunelbwtlK1EJXO54+XgfLesYtXc8tDfXSd/x1LC0z9pEvziAeaYjYhe1x+cdQByLNJwiDewz37Qgkt3/2l4591PC/nJHulkjfh8Whklv9FKCsCjhqDQTq2/k9IswQ7h9lfh0s76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778343867; c=relaxed/simple;
	bh=TkAJyJ7WOgqR/TiwL7gxZKviciw4ykyPwtVKTcjsik0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaBhtWBH0vXMvQI/ZMmOuokcb76ebszzKOQd3lKgha/XHrmmWNQYvaszCh1L+of5ylhLscjkbzVgW9paadLaZrdaXOyFykkCQorcb27F1BPOKnvg8WqCx/u0mguNW4CVAu+NThtph5S2PJfh2362MEhOFDbsNO7dSLp0IAjRr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNAutQl6; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dce4d6b923so159598a34.2
        for <stable@vger.kernel.org>; Sat, 09 May 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778343865; x=1778948665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO2P0xIyQDisD90PKW6kTEf7ozKUuDCN/MlNOVEwtA8=;
        b=tNAutQl6/loP8j1LaAnt6ZyGD/Xarf9NSXp7Ks5iklBhPXPf7IUxmgk9yANngl97r3
         tQfakK33XJ8x4marEeMeqgUHV2kzCqvC965OBV6nTAXNKWshE+Xr5zLwKlpgotBH6J5w
         qFh9fiO7HNifbCFgg6e0X7VbgbqyVimTIskCsEd89w5L+La92PfE8jvSbde+CACD9UD7
         UuoqF//fnedR+K5x+xFqGtnb5SSyRpiSzeFXhJJnA4xS/Rv6+7weZaT9DW9VE3NCvHEZ
         DW/7RcDI2taU31Y64/hFjheI9NthJTosZmthbw0DRO30KAu2WeBY6XZFxs3rWNE40agH
         lOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778343865; x=1778948665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LO2P0xIyQDisD90PKW6kTEf7ozKUuDCN/MlNOVEwtA8=;
        b=Jz7qPr9UBzG6JQy8jbMhlE2zAhzJhmF73HwUaw2riaSPkVeKO59oFcueL3uk6aeCYA
         sq4xvHxMX9s/KZp17NqcqW/L7n8Djx/FsFeli7M221l3MAEvi8w2wPO90SnQLear/E5c
         TZ9/cfTlZhjSB8ucB5Evp72m9/PeM0hR/fQdHqboWSA4SR5ozBvMmpkydKscKnuhTK01
         +pIUoQcezJGGTG9WmS3QZhBQHIP6LKPu4+drBOk77xOeaqYbFVPhgfvvnYgnQWXSjkhU
         d5EmTohu8+d10OqzMkLs0DCVomLoaxz7NULe0lUHx1+FtWnSHORrYhloAqNGaSXFxJKU
         yw1A==
X-Forwarded-Encrypted: i=1; AFNElJ+YKY7xolcnTMxtJ7bYtOITFqcgLD/xhp4UOaegb7wNO7p7ARy8q9cGbYlpKJj+s8/HbnxLFnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcK2ZOBVLfQ/mcaGYLbFSaEzfrfMMoO/V9+xZlGUOWs+5wbol
	QeoS1fcnFajmWxPAX07kstXd35EYtk0JsGSc5Zwu16LH52BuXRLMbK0d
X-Gm-Gg: Acq92OHtkoe6+45M3s/k8DFyMGrAzICA46p+2OimEspebZHM2SM2XAxlUDXSgITLRiL
	u2pEqquiTQEVzbzxJWcTJwaat7dUgIPNRTpqa9KGmpBKiqm2Vg8U0QVCTe3aAueGKbM26u8ozJw
	vHlqB9YZDQNl1SVapPuwbnUgGHokSGjWQR8RnEcI5w+oTvl43ROMOFMPVnye33rayVxMSW4tVgZ
	9cd8mU8Uej8A9dHgB8Ha1jq6Bs4jGmIatE8NGcEJT/cmuNOomkKH1kgYSWo8fS8f865Bcb/4CjC
	zsc6lNN0E2hGWMkDaHLOrjkhxZ1kts0K8Sahb89KweTy/w+gnBH2iTKvZWpYLpTylhnT637o/4V
	7I49HanL59usykDJfYVdDvIVsEoGxTD6gOWIQ8O/DruuiFPD5PuJffKxEX9QIsgQdzhS25L64PY
	vSc5c9sOABdU3X1kDi1UYam4Ol3Ai6qXQiDpVsgtznR8XDR/wx6AetzXeY8DQ5CLVQw66OyLyEl
	Xd9/Fi6xZEPcQnj+KffHCdb
X-Received: by 2002:a05:6870:fbac:b0:434:357:6dcd with SMTP id 586e51a60fabf-434fc418c5amr6222410fac.8.1778343865106;
        Sat, 09 May 2026 09:24:25 -0700 (PDT)
Received: from localhost ([136.49.184.116])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435571099a4sm4623244fac.7.2026.05.09.09.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 09:24:24 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	mika.kahola@intel.com,
	stable@vger.kernel.org,
	Aaron Esau <aaron1esau@gmail.com>
Subject: [PATCH 1/3] drm/i915/cx0: check PLL ACK bit in intel_cx0_pll_is_enabled()
Date: Sat,  9 May 2026 11:24:05 -0500
Message-ID: <20260509162407.510539-2-aaron1esau@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509162407.510539-1-aaron1esau@gmail.com>
References: <20260509162407.510539-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 231DB500732
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,linux.intel.com,intel.com,ursulin.net,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244975-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron1esau@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Action: no action

intel_cx0_pll_is_enabled() only checks the PCLK_PLL_REQUEST bit in
PORT_CLOCK_CTL, which is set by the driver during the PLL enable
sequence. It does not check the PCLK_PLL_ACK bit, which is the
hardware's response indicating the PLL actually locked.

When the CX0 PHY MSGBUS is unresponsive (e.g. after a failed s2idle
resume), the PLL register programming via MSGBUS silently fails and
the PLL never locks, but intel_cx0_pll_is_enabled() returns true
because the driver-set REQUEST bit is present. This causes all
downstream state readout and verification to operate on a PLL that
is not actually enabled.

Check both the REQUEST and ACK bits so that a PLL is only reported
as enabled when the hardware has confirmed it locked.

Fixes: bf8531990380 ("drm/i915/display: Allow display PHYs to reset power state")
Cc: stable@vger.kernel.org
Cc: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_cx0_phy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 7288065d2..4cacea802 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3581,9 +3581,12 @@ static bool intel_cx0_pll_is_enabled(struct intel_encoder *encoder)
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	u8 lane = dig_port->lane_reversal ? INTEL_CX0_LANE1 : INTEL_CX0_LANE0;
+	u32 val;
 
-	return intel_de_read(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port)) &
-			     intel_cx0_get_pclk_pll_request(lane);
+	val = intel_de_read(display, XELPDP_PORT_CLOCK_CTL(display, encoder->port));
+
+	return (val & intel_cx0_get_pclk_pll_request(lane)) &&
+	       (val & intel_cx0_get_pclk_pll_ack(lane));
 }
 
 void intel_mtl_tbt_pll_disable_clock(struct intel_encoder *encoder)
-- 
2.54.0


