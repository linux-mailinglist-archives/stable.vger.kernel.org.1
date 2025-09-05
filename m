Return-Path: <stable+bounces-177814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BBB45614
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B984A177F77
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAF34AAE0;
	Fri,  5 Sep 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN/gZiQy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DE34A333
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757070902; cv=none; b=arMBnLO++wsOw3t0l17ROcmahAAGBi+4ACsRX8xvMuck+tU1t32WTVArG5aJ8JoLfvsnCZBQIfTSOHP8Kp9yyy6u1YKQ+WYpHUu8Jqemr/DK0jjg4/vyG2betk0oSvO3obt9tIQQsFINipOAXDHkaEVIvie+ZOCs3oWfuqbuvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757070902; c=relaxed/simple;
	bh=cvwzQQz20d0jNv8ol0Z3BzQXzBbvPGTacxd0sJDnC74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XliNvAHVlExtEqIgM2RQuKlMgxRnkwokZShUJXVfFpNH7K0WoWOVhQFpnI/JXUxWS9ngXOR4yJdgRlxeDAPjr14mDamf/Tlj1SvNaiVd/ezLDKtLTyl/aUcESmgFPfpjEooCpEWbqwzzuvXjdxVktF77qtZKa0nndgmFLqQ6KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eN/gZiQy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b043da5a55fso294315166b.0
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757070898; x=1757675698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPGWjhihTe1kg8wbOKpqskH3/nQSENZdhlUEbXeePyk=;
        b=eN/gZiQyO76V3ZMTS+FlGaXk80sG1hTM69R20Kpq59EHFLndw7kkOsRWrS14o4PBLT
         IJmAZ3hIYsJHisF2oqKNOYPjk3+qEhEg6TK6u890jBE9HjjN7mLVzJ7A7vJlnUo52itr
         VvNzhCmQsotNebo6wwmHc+9BF1gOf2MNAdzuCVzOBdHIpNFSxzzVemFoNPj/xns2/t0b
         Z/sWISzdfwWh4H7VgTLd/xTQ986GLn6kqNb6fC2UtO5fxlfvD7Qtob5JYwDhI//sbEVg
         jL4A3cci8QdDSLh6C8wtiaM3TXt2Lg6zxTsvJJKEFJaLowcZoNMJvMi52/CVOTTbSvek
         fv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757070898; x=1757675698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPGWjhihTe1kg8wbOKpqskH3/nQSENZdhlUEbXeePyk=;
        b=iYBcPcwS9gzNt5xnEY4fHynQEIoVJlnI0yt8ExkC6bB+Bedzg+H0EMzzAgvLK6IOEm
         hGAWWb6QvEMo/ERPY9CSrd0VUoc4aP0yTo0w6GtJKJeq94q/GvWBn26x0F9v87hmhJ8x
         UKLdq2cljnzdwnHOnrL3PBoRfAX22Sow0wHw/3+Vtjv/l5DX0YLthrCafZpi8cGFHKOW
         L8PrrK1GdOFOYn5jkPQVdj6lhfrvRKp9f3tFVs2FmR9ZVdf/eo7ZEBGnmbt4FqG9xSwv
         hqU/c2HjCLeaYIJogJjM0XOYusFuPYflVKfoYdIiNVKDORwXMdKUhvADOy7HeDXHMmld
         kITQ==
X-Gm-Message-State: AOJu0YxzEB0JglB8HnCMs/LdfJItNFjALk5cLm67iQaii5kppA5D3GG1
	PVaOlZeNDpcwP54fV6AEksUB9Oq9xCSl+XIqWIOyEzP2wb7bwvcyves+TFIFwUwL
X-Gm-Gg: ASbGncsfYwSx/Tjif5zvJPLf5txA1opTcPM0+BTlCgOgFRtfWHsB2/LqoFqv5/OWGUv
	D49cnhavg4yWSveVPY77YOH1V9amcgSlgeKAh4kZaLJtXKdZvfDX3hCvBu1h4L1FIWQ6MRAgytQ
	jz7VaB4U4/zyE5xZFXTDwuAHrh0oj6zwiNIMv0N/H4kp7O4iT2Yi5Z5P3AUIjvOKOBsuSE+PSsI
	OTqvNQSeBuoNMdnlnJymVvsMlqUBG0Lh2hiWNXn4p8iHNB9/WQ7XZXbT0pBGbSHC3b9w7oE27bf
	5CO1d1PF5D9s5ptiGo5ezgO5RM8IEi7lU5wBcbR1rO0OU2ixAQ1W6YNgddH7WygRaRniUbzR0S1
	J1jO8dwHc5HtrmzLjRuYrmahBTe4OBtvwwJO19WmWO5mI0eTcQ2SFdL4=
X-Google-Smtp-Source: AGHT+IEjszx3tz8lmsbudhMhdLog8rYFdBGsxb2Ff84Hh/ehiJZK1U/eZfUF4XDcg3X84LCmpvI27g==
X-Received: by 2002:a17:906:6a04:b0:b04:a2e4:89b4 with SMTP id a640c23a62f3a-b04a2e490d8mr97806466b.49.1757070898128;
        Fri, 05 Sep 2025 04:14:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:d0c3:9f59:659d:5459])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f888b95sm557231766b.34.2025.09.05.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:14:57 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: stable@vger.kernel.org
Cc: Jonathan Bell <jonathan@raspberrypi.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keita Aihara <keita.aihara@sony.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v1 1/1] mmc: core: apply SD quirks earlier during probe
Date: Fri,  5 Sep 2025 13:14:29 +0200
Message-ID: <20250905111431.1914549-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Bell <jonathan@raspberrypi.com>

Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks are
referenced in sd_parse_ext_reg_perf() prior to the quirks being initialized
in mmc_blk_probe().

To fix this problem, let's split out an SD-specific list of quirks and
apply in mmc_sd_init_card() instead. In this way, sd_read_ext_regs() to has
the available information for not assigning the SD_EXT_PERF_CACHE as one of
the (un)supported features, which in turn allows mmc_sd_init_card() to
properly skip execution of sd_enable_cache().

Fixes: 1728e17762b9 ("mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier")
Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
Co-developed-by: Keita Aihara <keita.aihara@sony.com>
Signed-off-by: Keita Aihara <keita.aihara@sony.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240820230631.GA436523@sony.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/mmc/core/sd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 592166e53dce..7b375cebc671 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -23,6 +23,7 @@
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "quirks.h"
 #include "sd.h"
 #include "sd_ops.h"
 
@@ -1468,6 +1469,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
+	/* Apply quirks prior to card setup */
+	mmc_fixup_device(card, mmc_sd_fixups);
+
 	err = mmc_sd_setup_card(host, card, oldcard != NULL);
 	if (err)
 		goto free_card;
-- 
2.43.0


