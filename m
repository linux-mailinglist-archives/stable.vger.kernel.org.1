Return-Path: <stable+bounces-5731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E1B80D62B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE321F21AD6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F646FC06;
	Mon, 11 Dec 2023 18:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRE9iTzj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2C7C2D0;
	Mon, 11 Dec 2023 18:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953C4C433C8;
	Mon, 11 Dec 2023 18:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702319513;
	bh=l+9ktnMuonxyNxBSJo8dYoELkLkCwH6Li83ngewwnYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRE9iTzjEzNKzKYem/eVfqp+wQvCgjkvo3s3wEzLfe2PzGczl1RHpHO4r5hSq95yr
	 lvj6bakpIOA0Q7sOunaGLaFLt9yqk06fyXnJJn4OELEpAz9w/1rw6NO2GlrVar4oCt
	 xjObwaygbkgnFrdvOfWzBZafc6w+iTBpr2WJLblg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Malcolm Hart <malcolm@5harts.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.6 133/244] ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Date: Mon, 11 Dec 2023 19:20:26 +0100
Message-ID: <20231211182051.758590722@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
References: <20231211182045.784881756@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Hart <malcolm@5harts.com>

commit b24e3590c94ab0aba6e455996b502a83baa5c31c upstream.

This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-mach.c
to enable microphone array on ASUS Vivobook GO 15.
I have this laptop and can confirm that the patch succeeds in enabling the
microphone array.

Signed-off-by: Malcolm Hart <malcolm@5harts.com>
Cc: stable@vger.kernel.org
Rule: add
Link: https://lore.kernel.org/stable/875y1nt1bx.fsf%405harts.com
Link: https://lore.kernel.org/r/871qcbszh0.fsf@5harts.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -286,6 +286,13 @@ static const struct dmi_system_id yc_acp
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 B7ED"),
 		}



