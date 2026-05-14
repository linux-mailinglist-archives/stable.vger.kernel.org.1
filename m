Return-Path: <stable+bounces-247291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNnzExw9BmqmggIAu9opvQ
	(envelope-from <stable+bounces-247291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:22:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4F547022
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D79A23065681
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F14F3CDBA4;
	Thu, 14 May 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb5PJTr2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7F3B38AB
	for <stable@vger.kernel.org>; Thu, 14 May 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793633; cv=none; b=S4TYW3wQ8WODpG2gc9Ooi/jHS8FrEYu55CvJRrR+ELs34xRkrdOks/xx0niA2zHoZdwXV1TFunaP8JmH+owdNuYSIIuBQXbhpsdISemSwAEUSvODAMRbupT9rRD0e81fyg5O+Xb+vqqkcZvMzodhiKV8eN74k/+qKGso+BgbhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793633; c=relaxed/simple;
	bh=GQ8KFtIPt1cBh3YWlA+1MNGvUA29zra7wGm26s9hJeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCPIQ6YpxlA/S1FFWdWtKIEFM2smoC3j3giQ6xPPB1sp8DmzsjQOF31woxdwuthB0LbjlotmfU3YXoKaKAtsuVmdF0niuLvlAgMnRQ9eFDQ4ujzTI6qJwjo+HsOHqiV0qe11Kws/LDvS9rwgh1+p6ORwYPlrv/URnep1LbAKaT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb5PJTr2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so1414735e9.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793629; x=1779398429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE/j4rv7wciqnS+bDA3iYPyjHebH0y7y55zTma9ff+Q=;
        b=Eb5PJTr2uzr6RSY8x/jFYliqNs4QfkN1pG0Zj5LzYtsusLgF1eMZPGQo67o/alJLSX
         VuZioO3pYZHy27WpKJ5Tw4bqjOXHm9iAIQPblbJyNqwex8TW2aZcHYg12uChIeVcUkXN
         gdH1dlaPNju2Gz3yc6M9HdYxe2XFyOjLS7iq9fj1sxffHUNtibPl9BAF8wdYeYnLWUDG
         vprt0tkR0DchrxrL+WBp7WAIRl/XzeW73yY5X4fDDn8VTvNb3Rv3KdHNuSKjwENmLvMX
         Mnt/F4zQbLYJtwEZpke7PMxlEoCWE78NsfT/D3X2kXejus2NIYIGcXD4RcdccX0iayae
         olQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793629; x=1779398429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fE/j4rv7wciqnS+bDA3iYPyjHebH0y7y55zTma9ff+Q=;
        b=rirOc4foZAF4A/C8Y50By7KkhlRf/CnDLXGeku8h3H2H7NnujYMyBQaed8j6cbSLYl
         zfcJeKFyZrpV5ocA89A2bW4EsSoWD1u5FmnOOnCg9DxVOrEAi+pyNrCm+mB2i0+riC/d
         bzYLI5ExjwiVGw7HnR2ZafQG9+fX9CqJoEOYhKZ2NoS90gHgaHzhFNgLq/AjTKMQoMoh
         da/Sm8izHMkmFP51xcgR8hRcil57PAIz++nYy5oG8O95FZSSctZEfjx/iP35/qUHjllQ
         55k2g4MY1tW1U094GGMK/WxeZGJgHNmkkIu+XA6ruc2nr4wKCHduSXSn9bTdz9HG4wCK
         z2YA==
X-Forwarded-Encrypted: i=1; AFNElJ/X7UiFD3H+jVgqrtJcEHUuX6iebM3zzcnEJhDOjGO01r8M/2XbYlhnU36VKlv4bYb4oTP4ivA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqe/x8/2lihlxmNym98VtZ40o8x1D00bne2W1oPE7leKe6i2Fm
	LWxMzLVNOWOtdZe/W7pOjlHSpD1tVXjYOsl2LemljZX2EZIW2UdeagCZ
X-Gm-Gg: Acq92OEVmruv6BFY0S88u96NhzRWAMhXwPXTv7nGfUN2t9Au4V0WqnBuKkkhEGOtU9N
	W8+DcTgtmpLlk+nfxyUmiYpRV5mfvycKKDtHpFyyG46zil6+5fafKllzMjrnXzmotvxUwUOjo4Y
	Kz4dZcIu/+NUSgQSVAVMi6YKP+PMUk6PjdA8xMOv8KoSw8WM1P2DB7T8SefYSn/gqPn1brij+D4
	KxQ7AaCciZgtWu5zzjexZ/sygdGQpOzgHXxCzJQqee+7HQ4CsTMydObSLt7JDeQytWBMaYQXPu4
	oaNO0yQZnVCjPnBo2rqfi96kOwmRk1wfKElrpLUd1fRFDLWYLrKzLUQlRE8VSxzmOjA1Had9IxB
	ZgtcwKfSvvimiMzXZmqscZA3pNxLTMy7crduiGoTIDgtMxMN8U8/zO+85XPUDSNvYnWN0KrAQ8m
	uz//rMZhTbmM5voEnRLbCMmASKCdts6STpq8fJy1L6msqyCYf9jeA+Tv8xZxU9KmZUgmBkuNGG5
	qIJHx22pEcyEX3VWqZ07jnOURH65D16kcQiGw==
X-Received: by 2002:a05:600c:6d83:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-48fd635966cmr61352925e9.10.1778793628752;
        Thu, 14 May 2026 14:20:28 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4d56:d792:6583:2fd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe13a7sm10216038f8f.29.2026.05.14.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:20:28 -0700 (PDT)
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
Subject: [PATCH 2/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2N
Date: Thu, 14 May 2026 22:20:23 +0100
Message-ID: <20260514212024.1624517-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
X-Rspamd-Queue-Id: C2D4F547022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247291-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/G2N (r8a774b1) is identical to R-Car M3-N (r8a77965), so apply
the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
done for R-Car M3-N.

Fixes: c9af138c42f0 ("mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index e5aae7fce1cb..b915e2e11d04 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
  */
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
+	{ .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },
 	{ .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
-- 
2.54.0


