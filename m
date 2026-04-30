Return-Path: <stable+bounces-242179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPCEA3qT82mL5AEAu9opvQ
	(envelope-from <stable+bounces-242179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:38:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30B4A684A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 571B230080AA
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F04779BB;
	Thu, 30 Apr 2026 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b="b3xAbvZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905A47277D
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777570669; cv=none; b=Ll4L3QTIJdf2a7WPHXtsSLO6nj5Pp1Kldj9CHH+P7zm6twpjzMWFcYJ81zTLl1z4yaq6KzCL1+EWVGt2ZPTAG3ECgAe3T7Eigk4LrmZAhwBiSso3eBtcsaqCsvuvsvJFUtNwgLluU1U/1c3WWhw/zUpU2RMYWxn9UB/rB4Y1QQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777570669; c=relaxed/simple;
	bh=5gnK1tx9R1TIqAr0DRz3D3VEyLs5AMY8kWNvCmjXrIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uiAw7uYy1KFHa5BDmloBYBpKSY3kzVUeEoBaC8SC6ofQMJHGRFVoilcCaAdW2CtJTR1YuebXDYDCqStRAc2InZnPDFKe5Cli+zOVGVl2DRpdx1teoti07HmBNp6McFp9W/dR72/fqlYGUvBELQLYCURIgA6yQbdnM9BCbol9XkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com; spf=pass smtp.mailfrom=embeddedts.com; dkim=pass (1024-bit key) header.d=embeddedts.com header.i=@embeddedts.com header.b=b3xAbvZK; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=embeddedTS.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedts.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso16753836d6.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedts.com; s=google; t=1777570667; x=1778175467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwA7m5EZ1edlmfqcnWuJCjFmtNnRxo71q5/2JyXSmfY=;
        b=b3xAbvZKBh+Sv1rUR+6E8p65WT3rDeNjsvM3i9KEfaGSzM+KLEwNJaDwBZPve0HDsO
         Sd7AD3pPkEk4ev/z2peub/8mpkr9EexfZK8vQABZFfeIETzS8SVZpEmBIsnX3D90ahrE
         Qy+KbhnCNXnPCUI/8fZ/uupQmCBnw9KH2SpDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777570667; x=1778175467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwA7m5EZ1edlmfqcnWuJCjFmtNnRxo71q5/2JyXSmfY=;
        b=lKshlwtWSAl+7DSH2QsxRRkQjTRM555QK3bsjCIuPb2KQlzdogWVCIEs53YVrXdWMb
         cel88I9ZO5fdz5hP8W26kGbE4x6DJaeuBzOEX1ulwn2jJFLE3Y5gkibmu63SO5MyjlY5
         hi+YH/JwpfBBM+Vw14fKywM5ivsLi+L3f5IwlhxIWPxrZk0fGPz2IbY3k/KUINt1h649
         AgjoXsG08jmdqLm319N1foSAAyuyFazZez9z5k6QZzOOOgGol28rxI8Ch24FT5N7ktMx
         iDrcpI5CMomxDNv/0ThnEDG1X8PONIbH52/ereoX3NABrz20NW394/CHBFLMHsdj08pm
         4AuA==
X-Forwarded-Encrypted: i=1; AFNElJ+E+s0e1OstBNGDvVP+PecWgqJavYdRmCkLg6vweZX1rVgnyyhV40uS7+20Zv9ZU0oPgggWwB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlO42y28Do6A7+0ZHj1px0eDObrzCu/CxDpOdLnOdo+tJq6Z0a
	2dscBRxW0/F/z3hGX/KKjbw+3wFJQcek9IWaTAkPZmJqpF/pDUDlHSF4gktWq80a2RpZxMgJ0aR
	oj5A3aru5RAX3E3qDVUupH7vXPqPLjxLOGMUZ
X-Gm-Gg: AeBDieuiV4D8+AR+lBestw4rziVhFFp7FnHpXWJ1hjnsUaibxf7AYkeCBNKVcDFk2Jw
	1vBVn91DOsmnyWj3L6LDiFk/D4WAPZdKH1WAOg0wahx3EDmE5Nj2JBQ7m5uBI4rSzcyiYDwznVh
	RiXNfceP21aKWv2TLVKe4X4IC7kmjMTTOaXdgGYHy1j5iHj3+qj1tpORThh+ZITJ5rgJskc3whL
	45t0j8jVtmJNPDoDAnludjCaD3HnYUDmUdJ+of0jzQwijZUmE/4Mejc5B7SwA8aMVAHJ6GeXdy/
	Ztd23nYpmRxSKa6iEtpUfUSOzV4wEDSvkAxBuJwCMrOIDHBErJJXIZtC2rbwdw+JQzHsO1tQWCy
	2itUsH/Np8NSjh3AytIxe6XJAPC3SAAfRyBgWckyUZ6nwErIf+ncVDbVHmZQ=
X-Received: by 2002:ad4:5bea:0:b0:89c:8a0f:55a0 with SMTP id 6a1803df08f44-8b3fe7b6ab2mr56073336d6.16.1777570667338;
        Thu, 30 Apr 2026 10:37:47 -0700 (PDT)
Received: from tornado.. (wsip-70-191-90-18.ph.ph.cox.net. [70.191.90.18])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b3ff315986sm1535706d6.6.2026.04.30.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:37:47 -0700 (PDT)
X-Relaying-Domain: embeddedts.com
From: Kris Bahnsen <kris@embeddedTS.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Marek Vasut <marex@denx.de>
Cc: Kris Bahnsen <kris@embeddedTS.com>,
	stable@vger.kernel.org,
	Mark Featherston <mark@embeddedTS.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Input: ads7846 - don't use scratch for tx_buf when clearing register
Date: Thu, 30 Apr 2026 17:37:38 +0000
Message-Id: <20260430173739.3843425-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C30B4A684A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[embeddedts.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[embeddedts.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242179-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kris@embeddedTS.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[embeddedts.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,embeddedTS.com:mid,embeddedts.com:dkim,embeddedts.com:email]

The workaround for XPT2046 clears the command register, giving the
touchscreen controller a NOP. The change incorrectly re-uses the
req->scratch variable which is used as rx_buf for xfer[5], so by
the time xfer[6] occurs, the contents of req->scratch may not be
0. It was found that the touchscreen controller can end up in
a completely unresponsive state due to it being given a command
the driver does not expect.

Instead, rely on the spi_transfer behavior of tx_buf being NULL to
transmit all 0 bits and use the scratch variable for the rx_buf for
both the 1 byte command to and 2 byte response from the controller.

This change was tested on real TSC2046 and ADS7843 controllers,
but not the XPT2046 the workaround was originally created for.
Confirming that the original modification to clear the command
register does not impact either real controller.

Fixes: 781a07da9bb94 ("Input: ads7846 - add dummy command register clearing cycle")
Cc: stable@vger.kernel.org
Co-developed-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

V1 -> V2: Don't use rx_buf when clearing command reg
V2 -> V3: Modify original 2 xfer command to eliminate dev_err()
          output on xfer with len and NULL buffers

 drivers/input/touchscreen/ads7846.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4b39f7212d35c..488bcc8393293 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -403,8 +403,7 @@ static int ads7846_read12_ser(struct device *dev, unsigned command)
 	spi_message_add_tail(&req->xfer[5], &req->msg);
 
 	/* clear the command register */
-	req->scratch = 0;
-	req->xfer[6].tx_buf = &req->scratch;
+	req->xfer[6].rx_buf = &req->scratch;
 	req->xfer[6].len = 1;
 	spi_message_add_tail(&req->xfer[6], &req->msg);
 

base-commit: dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b
-- 
2.34.1


