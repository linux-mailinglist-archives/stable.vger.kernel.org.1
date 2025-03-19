Return-Path: <stable+bounces-125131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B4A68FA0
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1B47A99C1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494941F874A;
	Wed, 19 Mar 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IGUcmkBk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EFE1DDA36;
	Wed, 19 Mar 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394976; cv=none; b=Hdij0BBFZkAytAi2R1Z+1+w/5KbYhJgpGTOm8y38xYWU8dHESfUVuq08OOGESYgA2c4czjb98NXHuxbEV+zkkATfKuxm/DKG5xuTvcZnWnWgm/fK7sEJ5DFken9TYJmN4+vkriWLTF4bctEAx2gTiZSsxdgY3NlrzAgdYISSd/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394976; c=relaxed/simple;
	bh=6TS9stL3s4EqzJ2kkj0gsg+Sk7Zo0r1N2TXlssGLbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmO1Uk04qsoLIIF4CTW50Vsq8ulQttcQfvQpjcHHERIKvJ46df6KHGFQYEaPI8Uv8NRz1V2cOfQkP8rRo74fey/EOR6Psnaa8MTDqHQHoFs7+z20LYzVlG11T7+ZWXkvIrTZZcZLbFvA41T3hLm/3C+BxsZQXqxMyoa4b3j8+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IGUcmkBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF57CC4CEE4;
	Wed, 19 Mar 2025 14:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394975;
	bh=6TS9stL3s4EqzJ2kkj0gsg+Sk7Zo0r1N2TXlssGLbHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IGUcmkBkUgvXK2OeWFWEKQ0iPm4JWJGd00tu9e2ZkuNtKP//oNdXA4ddWpVYeJ6xn
	 1ZQWEYaQ4nDYwzZqVBtMsnQY4yWkM1TFyAmgYDIdSNmMNXSsDLb7Cn62uTRw+GtLUh
	 XHf8SsiIPBTn1m8h5Rh1CCB/jlAFYxNS4BJZaXVI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Mizrahi <thomasmizra@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.13 195/241] ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model
Date: Wed, 19 Mar 2025 07:31:05 -0700
Message-ID: <20250319143032.544874540@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Mizrahi <thomasmizra@gmail.com>

commit 0704a15b930cf97073ce091a0cd7ad32f2304329 upstream.

The internal microphone on the Lenovo ThinkPad E16 model requires a
quirk entry to work properly. This was fixed in a previous patch (linked
below), but depending on the specific variant of the model, the product
name may be "21M5" or "21M6".

The following patch fixed this issue for the 21M5 variant:
  https://lore.kernel.org/all/20240725065442.9293-1-tiwai@suse.de/

This patch adds support for the microphone on the 21M6 variant.

Link: https://github.com/ramaureirac/thinkpad-e14-linux/issues/31
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Mizrahi <thomasmizra@gmail.com>
Link: https://patch.msgid.link/20250308041303.198765-1-thomasmizra@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -252,6 +252,13 @@ static const struct dmi_system_id yc_acp
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M6"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
 		}
 	},



