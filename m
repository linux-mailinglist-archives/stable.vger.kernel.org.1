Return-Path: <stable+bounces-67310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF794F4D5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AA21F20F8D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0637C183CA6;
	Mon, 12 Aug 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kLZG+nMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F61494B8;
	Mon, 12 Aug 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480508; cv=none; b=EzBDqRF8PbVHEsKycxWDlmVQOTDtr4odVsRXl22RJF32LhrxmPe1GVcWEyM94R0gwsGlYkUYGpLic89GeSQe5WyzYvxewfOXJpINHUk/SqNVQ9FAV7CV1ZEI8JYzEzAQuK7fH1mpQiWScqCLNdHPMzcHHgyKyQLDVossDGsKdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480508; c=relaxed/simple;
	bh=+nI3x7x5whr9zJ6J32I6BORZBL4BUMG8OnTqmk9Al3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9yBiNnfrWDXCnjvv9h0KcD8mWzOk1hg7tU+dxGaJgwyGwlt0HjYizmjnw0m4oBSUCwmgMIWNKmN+VU5hj2aGLCkdXqsbVBX8ZWMiB4t+39mOye1jQafBwgFd0zycYSXS0EuR5MmySH/38JbbHIsVJ/Ujj2ySvFFVkpDQxE+nx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kLZG+nMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70F5C32782;
	Mon, 12 Aug 2024 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480508;
	bh=+nI3x7x5whr9zJ6J32I6BORZBL4BUMG8OnTqmk9Al3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLZG+nMjY3bRRibNrZfyPFyEXrb5DXrNOVla1MraFAlTTMlPa5Kx772s6wY/njBuc
	 3s/XAfJkSVlJP5Zr+Sn0psj2g5qrgkuVZ/kcht9Zj4Ym0/yHGEAUTv94ijY21WQRvj
	 7TqlBEhm4UP0f7owgo1aUbN0exZOCsppU1X0hTXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.10 216/263] ASoC: amd: yc: Add quirk entry for OMEN by HP Gaming Laptop 16-n0xxx
Date: Mon, 12 Aug 2024 18:03:37 +0200
Message-ID: <20240812160154.812604626@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 6675e76a5c441b52b1b983ebb714122087020ebe upstream.

Fix the missing mic on OMEN by HP Gaming Laptop 16-n0xxx by adding the
quirk entry with the board ID 8A44.

Cc: stable@vger.kernel.org
Link: https://bugzilla.suse.com/show_bug.cgi?id=1227182
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20240807170249.16490-1-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -413,6 +413,13 @@ static const struct dmi_system_id yc_acp
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A44"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
 			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
 		}
 	},



