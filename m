Return-Path: <stable+bounces-93246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC589CD826
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2421B26C37
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C578187848;
	Fri, 15 Nov 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2zGADxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42375EAD0;
	Fri, 15 Nov 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653279; cv=none; b=DAqWb4bXGyabFWlnoMtZXyP9ggpo18V5KWnX+Gc2zl9a0R4x+RXDqZI9Wd2MesJfgb0oVQUktV/h+bXJzClhE/LqkE5k5n+BPK9Ms5C8VKfLRaNLqda3mVZaxXP5FXu0f9t7qp4YH+/SB02EzWyRWDjskMbZsDfd/G5PbdKOMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653279; c=relaxed/simple;
	bh=vx/mrWjKea1CSSWBjDEyg85wWSbAKOyyFbUeLLD9zlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anlQC6aulTgrKj6V81A46DfPXzA01buXpqY7r02wj2elxmYCjXx++Fkoil+o9Eqt5F5AbDrqIwZQhHXMKGMujUmM95m72Yke5ulATkowX0/YHYZ88sK3szgRu5sURW/K7R9JBDH2xlstidJhlCttlviI/L8oyu+9x/jVsszfU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A2zGADxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAFBC4CECF;
	Fri, 15 Nov 2024 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653279;
	bh=vx/mrWjKea1CSSWBjDEyg85wWSbAKOyyFbUeLLD9zlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A2zGADxZXeCcNDBWquUR7Vo2G04H9gBhShHFtJtZeFvkGyMrRHfCm0vGrcc2WfWmF
	 LPZuIkcQwejEnmqRdc7Re2HfrpwPQ1kOxi/T1NsW62li5UNIp28mY4kkX5EsOZ83DL
	 9YlLP8tDBNXS1S4L5hk95dMFdrzza9gZhP285KCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Heusel <christian@heusel.eu>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 40/63] ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
Date: Fri, 15 Nov 2024 07:38:03 +0100
Message-ID: <20241115063727.361934674@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Heusel <christian@heusel.eu>

[ Upstream commit 182fff3a2aafe4e7f3717a0be9df2fe2ed1a77de ]

As reported the builtin microphone doesn't work on the ASUS Vivobook
model S15 OLED M3502RA. Therefore add a quirk for it to make it work.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219345
Signed-off-by: Christian Heusel <christian@heusel.eu>
Link: https://patch.msgid.link/20241010-bugzilla-219345-asus-vivobook-v1-1-3bb24834e2c3@heusel.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 601785ee2f0b8..275faf25e5a76 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -339,6 +339,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M3502RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0




