Return-Path: <stable+bounces-48732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD668FEA40
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE1C289F91
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309F197516;
	Thu,  6 Jun 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hSclIXT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5319EEA4;
	Thu,  6 Jun 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683119; cv=none; b=uDwwgt/xnxZsbnnCIXclKIJQIgCtLRLKgoRIJF7h9LEEhigcWBfLeYgZZ1SQ3oIwzW+aEindZkyPgvJxc/693CAWD6xWCdG7VK2zCIKhkFh21r8nYPfB+sZtuoW+OWm8t5pv3DQlyR3kUxSQDlbN7OzixQfXpVz7q4102piI2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683119; c=relaxed/simple;
	bh=iF1VjjXx4MfsY7Ep7XgCPuFFNy+QdnaBTRkI8Zuca+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4RoN4wrp+dYGIJw9AFbtS0w3mWKVdQbWGUdAV80KocbawCLNyPk3ikYvpaLbvTje1YwoS/OzdUfmgvYDMN1bdLQjHQqNi85WagkCvIAuUviiISS/DjbBX2IKB+OBW9RoEHbvCbDM/iHDrhDnvNv26qYn0kH9JKwaaZIV0DuZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hSclIXT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928FDC2BD10;
	Thu,  6 Jun 2024 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683119;
	bh=iF1VjjXx4MfsY7Ep7XgCPuFFNy+QdnaBTRkI8Zuca+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSclIXT9EXmF0zSetn+qcr9p1vclV5a26f20qO8THNAZrnHbQJPoeOJotaqialwPW
	 /VL5VyxLbCEXWlRbT01d4lyANQE/YIO5Ar2YJAGTPV0nS1llyPrDLZ0a8quJi3hCOb
	 3CHOL5dbTg2e7YqUYQvKn6MgEgymFAL1TsaOD1fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"end.to.start" <end.to.start@mail.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 057/744] ASoC: acp: Support microphone from device Acer 315-24p
Date: Thu,  6 Jun 2024 15:55:29 +0200
Message-ID: <20240606131734.255211584@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: end.to.start <end.to.start@mail.ru>

[ Upstream commit 4b9a474c7c820391c0913d64431ae9e1f52a5143 ]

This patch adds microphone detection for the Acer 315-24p, after which a microphone appears on the device and starts working

Signed-off-by: end.to.start <end.to.start@mail.ru>
Link: https://msgid.link/r/20240408152454.45532-1-end.to.start@mail.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7a6b5..1760b5d42460a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0




