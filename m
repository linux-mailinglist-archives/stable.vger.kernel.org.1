Return-Path: <stable+bounces-247289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIGkHLY8BmqmggIAu9opvQ
	(envelope-from <stable+bounces-247289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:20:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFD546FE6
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC8030417AF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956393B6374;
	Thu, 14 May 2026 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/vdd830"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C53A75B3
	for <stable@vger.kernel.org>; Thu, 14 May 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793631; cv=none; b=SeSxhT+SSwbTCS9ztEu8RKaDBds7Jfz0hWeHqHzK9BCBA8QsMKNO5YUnsLdjbNE/OkeZa/JMMR67MpqY5BDYptRaJ9lng2SthICTiz8r3lCu29oy945JrAiY+0UDpEJ7YP6sWgJVGt6HEERaikbuZhbVLWJnb9GNh0P7MXZq6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793631; c=relaxed/simple;
	bh=lhPMKEQU86GVpnKxpDjfM0xA4kJZxbopeeIHT2P/Xco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtiYYTwhoTs4wM2Umy9yMwrPwsT5pClebP29/hmqhStugSD+vtkeL90thyDJiS9p1bv1pPhSR35TqY+uBg85giob5NRudFKT56Pdcy2ezj0qHSN4yaUrTQ9iC5SitQryFmKqFHttyYkq3eUZvQbdlTxi4ibKv91WtC3TxqCue6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q/vdd830; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so7377297f8f.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793628; x=1779398428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86LPxHAuIBTZBybQT8TPj1X7ACqmLq5UiCY29MJP/cg=;
        b=q/vdd830Ia/9roJlAYZgN6CruuBjgtbNmFxobMOhrvbjzEIkKLCxDhQT6jO4GMTzxa
         fIwITcoqhWoXNOuVXDDABtxEgBGYVr790HtXOH+ikJ3OC0BUy5ot64QefRL8HTYeIGEb
         sgbEEXsklbDZlB4nRjTAu+s818KkT4tFmGORFbtlOqqSSgtShnkchCfYvoxY1r8PkfRP
         bk/1jbyS+Y+/pb9RHh6HR9ddeIv/1b5ivPvK8KE6/wG5teoUfIevyAxRYZWWL9J84HCr
         5G6mjfE4EEFgUDzg7REXV1+x4NQLtAihKBBn4C3nyOz9m/b1nIigppixsp7MmFtN6vG8
         /xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793628; x=1779398428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=86LPxHAuIBTZBybQT8TPj1X7ACqmLq5UiCY29MJP/cg=;
        b=g7jS3/k9qTZljhNOnP7ABhNM8DpHXb6uqKpiWdfT3wVF+yaA6vca8AbbenCZ62DFDv
         bFwicGzvnL1xOlqj1DY+UDNwtpUOUqv7NtfxjMdpfB/HBRMBQYiNWoey5TZ6Q7sS3e2b
         4lBoZcB3CfpOawk5ywATjGM81p9seP6n5C+/J30EtfPR3ibmSLacbWQSrg5s888cNeSH
         iFT1asC3u+AtiS3XiDLtPRNuD4oHzvAl8uUcooLgIymArjlEKlr8Y/NsD7nTaY6gguc+
         PPMGtcxy2xfy62ouI7PW3r109qqdSjoBnOMfHYb7pnRxmWA2312vUcCt99W5Q2MFU86k
         /rQg==
X-Forwarded-Encrypted: i=1; AFNElJ//oX0cESi0kfy9UmtxH9Bi44rLCpASOcRrC7qGm5IWu51zvw3XP/s+OXqoyH7Z5mtMvK+AARY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6jomRUqmMli8CKYqYEDVE+q9f+eAox2ppqVd3/CzFIz7D1g6
	KNqQ5GoEbi3h2qNn7icRgXGtEILGI4zJCozChcIBRKaHnLDEi3xN10NL
X-Gm-Gg: Acq92OFhqxnMv+iGhG2OEko5YdszQpiN9dxBdNwaicwqRd2w/08pQLxOHV4VpsHAHSu
	fASMl+6sm5XBrJBLRkZ2CwzFPzrhepieqpxrFjlJlHn5/K5Pc3ehF0nWMNkWLL8CLda8gxbDJh0
	/Q38Z/fBvSnDWzZJNIE3LQPEHGELms5WQCABer+/EkwmsPYE4JQDQ/SXglVYtvbQE+HRW4uo02B
	+KjyP6C3EXK9fubJdbE6hwKF35xfhhAdlHZwtwJVwdFF7/Kkp1lvASA1ENGpu4ZM0OXXxau/MK3
	sDhL+1Dzr5J6Y9HVKpYn2pH+L4EA0nwf3aMynqbgbyTuJsfa54jRTHg89KSYVEd0cm2HPOYbYu8
	YJdDVT0uMUSGFkJZk/GOcMAM/UikAhPwH9MV5zNtdwJVtXnElMCwlsETL/Df4zubHeDQNC4/6HQ
	kfXHOg5PDTeQAEzAqAXmUiVju9KFW89KgpoNcCLcavBWRjHak3LSeWCq0rPHA8bgqGqKUW+9HIU
	ex3qW9IuPcNE31VQFCcFdrb5B1xXkU2YPIQKwvWCAn/KoAZ
X-Received: by 2002:a5d:5f45:0:b0:455:7e5d:9142 with SMTP id ffacd0b85a97d-45e5c5953ccmr1060884f8f.32.1778793628199;
        Thu, 14 May 2026 14:20:28 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4d56:d792:6583:2fd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm10216038f8f.29.2026.05.14.14.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:20:27 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] mmc: renesas_sdhi: Apply bad taps quirk to RZ/G2H
Date: Thu, 14 May 2026 22:20:22 +0100
Message-ID: <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1EEFD546FE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247289-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bp.renesas.com,renesas.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable,renesas];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Action: no action

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Apply the sdhi_quirks_bad_taps2367 quirk to the RZ/G2H (R8A774E1)
SoC.

RZ/G2H is identical to the R-Car H3-N (R8A77951), which already uses
this quirk to avoid unreliable tuning tap positions. Use the same
quirk entry for RZ/G2H to ensure consistent SDHI tuning behaviour.

Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index f6ebb7bc7ede..e5aae7fce1cb 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
  */
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
+	{ .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
 	{ .soc_id = "r8a7796", .revision = "ES1.[12]", .data = &sdhi_quirks_4tap_nohs400 },
-- 
2.54.0


