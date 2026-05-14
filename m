Return-Path: <stable+bounces-247290-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA7BMgY9BmqmggIAu9opvQ
	(envelope-from <stable+bounces-247290-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708154701B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3275305B01E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 21:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243353CD8B9;
	Thu, 14 May 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZyKrAM8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3E3C3439
	for <stable@vger.kernel.org>; Thu, 14 May 2026 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793632; cv=none; b=MElOsbR98fB0cB8PgXRtL8vyOGQSIZO3/b6MTAcUu70D+nKfD79BKkYLhK0gW/4ERQlnVzGLUGDvKa82+UogLjMzHe2r832Fi8pPzr+fcpsIksnLcOHFu4lJnLmTcidAhpkln9Z0hoYo9WZqZ4aJDsep++GSSbcULjpNTkPHbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793632; c=relaxed/simple;
	bh=F7E1AyUKWuIn/QiVoKTLffZMRrUlmBr7M8fHP7P9SWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qn1gFIQjpliPk0k7qzrH1zxXRUnwGpHmdOEru7nXjB7KAXSUvw26mh1xCYOaXRUzJOnzSrNbj/DKubIMnIJc2P02YBxiq4xM49nSd2MEo5WyWTfH+qGTWs6P2NIHZKZZ0i9fsKIhzDXMmFRm1iXOxooJqJ6MbdVXApXaaIwG20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZyKrAM8; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-441209fb77eso151419f8f.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778793630; x=1779398430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fbz4sXtDTlrKke797+KCoVnjqQN3kBHCXXyo4twm8ec=;
        b=CZyKrAM8VK8np9y+JpNnn7bA1Rlw52zbpBy0OdGGM+/IMEzddQsXqdi4gi+tzwxrri
         dIDG9s3txYM1HyMBwS4oOZcm7ZWDxEDmWJ87m6T2eg4clRWfoA3H6PzO7f35oi7Sj/xD
         a2oCjVrvgnzsbyFnXd7CvEGV/+GBYUdGLkef0CD23on+xNwafvx1Bu51tSFXQpj5Zp71
         P0W44Q+tM5CdlOIeAkzDua1CTvI986UpJ1GCKIbMWJwnR5MNh0aw6U15BHd1DPvEMc7i
         PxlMQsWR4Z7VZzTQLgXm6Lse78XZ9w7OXdm42NfwGzTgx9rzEvldHKnLT2a8v66iqDJG
         IMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778793630; x=1779398430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fbz4sXtDTlrKke797+KCoVnjqQN3kBHCXXyo4twm8ec=;
        b=dldibQg914MVhP4lOO92J6N2ObYli9o+jga1dctm1BOP+C7k/m02XhWgeXOZxznY4i
         e8MUYvHWu9fjlmAstkpM4iAg6Rqf2a5+pB75NrfiJMJLHGbXjdBtSNJwuHd55G5BvOLC
         eBsnzDALSBFLff6GzhXhKg6SN48uOg6IYi6sJVVJIxJ9G0SyQEJgpJXoPulsacxXw8Yw
         lJ78IR6YQSx0ySAqknRfkUdoZ7ID15jYYJ2YS6et6JrubNEu/EAlBEUyeiRVHcp/PO8X
         XQ+T+DuHJEAtp4Na2Q+IgvN/9xvAbWwI0qFknmkj2tLhGeL5DF3HTG7JZ8oKeV79WFFy
         q3nA==
X-Forwarded-Encrypted: i=1; AFNElJ/qgG5rZZj+cqD5c9VkDdlSFQOLinad5SzTEa2JnetrJ53kLYNEqvctyNSiO4QkENnCfmTIbBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRdZecYlYCiHbr6Dn/XmcG9yK4/tg6Lr92lRfrOcTIQrVOpKE
	24fw0P8RWu7ASSrClQeUpyjmzq4m+uAw67ekcHHQcoO0wFmfn6T7t6jw8Zl9ZUI0
X-Gm-Gg: Acq92OFZZtHwj9jx0XmQ/YJriZsX9T70m/jvNSeo+0RVbEjwA2pXjiMmdIgu9wn5i61
	PI5yvtjeVoyS+BpjORqPnK9YcySAi+XOcIbv+Af2lsk1JYmBm8RP1V6LnGN1wKkxIpeX2/ZJ5yy
	G2/MpR+ltbJuoP/+TMC+GWVMtc2WSoERgi9sMKCf5V8Ji7xaku71kdbKEiR36IgFTOA/Bsfrlsj
	5eT5CeAhxAubtmSXZmyGhGID6PX2EzymWe7p2h8pw0c/xVrcut53CiCvSr/IC+NQl7+jEiGJEbM
	w7FdLvFb3SsUHuQw2V/pmsNUZ5sIgwiK07rknj3L2SnyTPxhNrvdQIP1X3f1QcmlWYMH3XQHKFq
	PdhxrLh0pnijd23crmUIjblJbNA60VPdWdDh9YPgNpOaEpFltauZX8cXgcxEJd5ZdLft0e5IUgt
	PbtuoGEdvcyyQsoBr8FnaAKq/rYt1wGBb1nClkdnkiyYMWN7W0HDq0lcZhbuezBSfllEwSX1XO4
	B5HHz+P7YokQXej7jkTVtqC6R0QzDJ5/zosjQ==
X-Received: by 2002:a05:6000:46cf:b0:445:7f70:70d3 with SMTP id ffacd0b85a97d-45d901e0ff3mr5899089f8f.5.1778793629581;
        Thu, 14 May 2026 14:20:29 -0700 (PDT)
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
Subject: [PATCH 3/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2E
Date: Thu, 14 May 2026 22:20:24 +0100
Message-ID: <20260514212024.1624517-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
X-Rspamd-Queue-Id: 3708154701B
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
	TAGGED_FROM(0.00)[bounces-247290-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/G2E (R8A774C0) is identical to R-Car E3 (R8A77990), so apply
the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
done for R-Car E3.

Fixes: ca804a5615a7 ("mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index b915e2e11d04..393d1c2238bd 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -225,6 +225,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
 static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
 	{ .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },
+	{ .soc_id = "r8a774c0", .data = &sdhi_quirks_r8a77990 },
 	{ .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
 	{ .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
 	{ .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
-- 
2.54.0


