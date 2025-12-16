Return-Path: <stable+bounces-202243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDF6CC2E81
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F14831AEA3D
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790435970D;
	Tue, 16 Dec 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krdYJq4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A932E12F;
	Tue, 16 Dec 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887276; cv=none; b=BTTYTV1Nn0Foov/0AtP1V7wgOdTU/pwD8Sx/7v2RvIDKMmWZz6bAJWXONVa2+5+WIF9iEBmmIJH6+ADrGrkg+o0q2rSY4vOZM/YWrNMggonv3aneiSK8GVPR0HdEu1zN1jdEOy2UnD0eHE+C2anNwQa60SWyA80BbqkpULfvfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887276; c=relaxed/simple;
	bh=WI4akuseukZh2TMgbT5SsGOmJhhSHN3sGwSjq4QYk9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWZyBZ90dtcgb353fUWvi/1tPufyI4IF9/XOmRNOK1j8msXmRsCaEgWXTHJM7sjtfD46HQ4NFXxujWf8FQ8KQmhpw0Vn9QIo1omKsyk0620Sk8Q73ULqKMRuhw8Z7kWfpud2+E6jhhACqM6wYJkvAPnJZJNHOIXqxBPuUqr6RRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krdYJq4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C527C4CEF1;
	Tue, 16 Dec 2025 12:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887275;
	bh=WI4akuseukZh2TMgbT5SsGOmJhhSHN3sGwSjq4QYk9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krdYJq4AoywT1eFEsplu+95y6thdf1nvc4BUT4S2W55zZ1LmjLn1XqiRQ9A0rYGgY
	 MIY/7ewZe+aoW+9F1/klVdblO2CqIILJhKfDM7D1SEew9/4DlJIxvX44FPc5F04Aad
	 Cz2u2wG48vba+Jss1sCeLgpZB061so1gKJSln1Qk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Abramov <i.abramov@mt-integration.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 181/614] power: supply: rt9467: Return error on failure in rt9467_set_value_from_ranges()
Date: Tue, 16 Dec 2025 12:09:08 +0100
Message-ID: <20251216111407.931268131@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Abramov <i.abramov@mt-integration.ru>

[ Upstream commit 8b27fe2d8d2380118c343629175385ff587e2fe4 ]

The return value of rt9467_set_value_from_ranges() when setting AICL VTH is
not checked, even though it may fail.

Log error and return from rt9467_run_aicl() on fail.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
Link: https://patch.msgid.link/20251009144725.562278-1-i.abramov@mt-integration.ru
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/rt9467-charger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
index fe773dd8b404f..b4917514bd701 100644
--- a/drivers/power/supply/rt9467-charger.c
+++ b/drivers/power/supply/rt9467-charger.c
@@ -588,6 +588,10 @@ static int rt9467_run_aicl(struct rt9467_chg_data *data)
 	aicl_vth = mivr_vth + RT9467_AICLVTH_GAP_uV;
 	ret = rt9467_set_value_from_ranges(data, F_AICL_VTH,
 					   RT9467_RANGE_AICL_VTH, aicl_vth);
+	if (ret) {
+		dev_err(data->dev, "Failed to set AICL VTH\n");
+		return ret;
+	}
 
 	/* Trigger AICL function */
 	ret = regmap_field_write(data->rm_field[F_AICL_MEAS], 1);
-- 
2.51.0




