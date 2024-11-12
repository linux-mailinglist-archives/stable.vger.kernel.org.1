Return-Path: <stable+bounces-92507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151A9C5495
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C3B1F20EEA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4921CF9F;
	Tue, 12 Nov 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nbnz7fN1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A621D20B;
	Tue, 12 Nov 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407815; cv=none; b=lwCl9oYmCEktKnfWTeGJoGa3EKBSDFxxuCninPHWHNtaIEetf3sJ2YxV0fRLa0FD4v+PtPXXcJQeqJ88cGRVKTUC1XMXhjBReCyxxx6eQxfW96Tqc3cQUk5ItzEb3geej1NIqxYMYY68LWH/8KTlPDkjs7DDDdwUojmkMKzMRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407815; c=relaxed/simple;
	bh=PzeOA8w+AECUnUVCa08aeQFCwhtB+Ux77+jEn8m2cbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImrMhDooMQPTDXdgF6gORe89SKm0rZb/+RA3T3qGT+jbQosnx3p2fmmtfSiv7vfnz805C6JfeefCOJUHGEH4hHYfQhthg2IXHLe5hdXVmap6Z9efyrwDK5zyFnalrBlSptvjSkmuuCmEnaDi6TQwGYYMPZpZOKRoRaaLwCqcjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nbnz7fN1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3597C4CED6;
	Tue, 12 Nov 2024 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407815;
	bh=PzeOA8w+AECUnUVCa08aeQFCwhtB+Ux77+jEn8m2cbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nbnz7fN1SztRrR/Hq3R0ez+5fBEl2Y0k5MN5MGNycWQ+wbSFMoesVlIk5liEKnGKA
	 3sQ3jabYKrxnMyc3HroEEN6gS8FHVuwMOWKxuNzKzqVN87F3pHsYBpYDdwpGOy0f+U
	 gbA71bFTRGf/JdBm9G5f2S5t0aiWiQOC8O3z/AIIEt2AtDbVSoYeLXdyijz319NPoS
	 mcEzAeTC3MymE/Ab5CBgpqkoA2boZq2kZA20i4661gfAMLpr+0UDYW8agG2vuFsCHl
	 3b1kTkUzJYo87WgVsYlNOh4kn/lttoJtB0763AtbD7IVIE78XN+JIHtHjYBW9VEl8p
	 pJiUuV+pLAdjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/15] ASoC: tas2781: Add new driver version for tas2563 & tas2781 qfn chip
Date: Tue, 12 Nov 2024 05:36:27 -0500
Message-ID: <20241112103643.1653381-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
Content-Transfer-Encoding: 8bit

From: Shenghao Ding <shenghao-ding@ti.com>

[ Upstream commit fe09de2db2365eed8b44b572cff7d421eaf1754a ]

Add new driver version to support tas2563 & tas2781 qfn chip

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
Link: https://patch.msgid.link/20241104100055.48-1-shenghao-ding@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2781-fmwlib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 629e2195a890b..1cc64ed8de6da 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2022,6 +2022,7 @@ static int tasdevice_dspfw_ready(const struct firmware *fmw,
 		break;
 	case 0x202:
 	case 0x400:
+	case 0x401:
 		tas_priv->fw_parse_variable_header =
 			fw_parse_variable_header_git;
 		tas_priv->fw_parse_program_data =
-- 
2.43.0


