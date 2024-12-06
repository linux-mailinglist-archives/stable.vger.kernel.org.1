Return-Path: <stable+bounces-99667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9249E72C4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD312879EC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7DC20B206;
	Fri,  6 Dec 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LYs4fsal"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3D148832;
	Fri,  6 Dec 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497952; cv=none; b=H4K1kh9JfuZfsbRY0hmo0427PL8Bxk1fdxzyILBN/13yjzxRajQalKxhGmFITmea3+ZJAKxh7VShd3hkfLozqGnMtu3hf+56+rG7l/bQkjnH4XbisuHNg4CwoL+wLqJloypPN9iZ/7/8fz931QSw8LlrbyY2AiCGCdBxjBOt4Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497952; c=relaxed/simple;
	bh=9XzJJ4bXS9KV49LlcLXoM2L5Hb8n2AwWOCYCgnoM5WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5YIiBhh3PhQ8WYJrf/Ld0HB4P/+SDxwZak9iFa93EGtbyL44GFFwBWz+2pOWmoSQoYwE31xamKlyHjW9AGcI/0RGB0XoWwKne7E/Xf5g5S2i4uciEg+cgTd5xH/lzo8EpSEd7xfCIWd63NLLAkRqAr/cTcp8OGua6kuifY7u+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LYs4fsal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B3BC4CED1;
	Fri,  6 Dec 2024 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497951;
	bh=9XzJJ4bXS9KV49LlcLXoM2L5Hb8n2AwWOCYCgnoM5WI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYs4fsalxySvt/mYki9ItJyyyPlE3avB5uj9w2VeVAU/SSdhfpr6m64VIvOR81pNi
	 Vg8UeAYQV6MvKM9bmSs9VSw0iqRaUZm9l354BJoDI6Gn/c04pA0MNWym1NFPQXDz8M
	 ulVlbMY3wE1AjIsiG3wwLmHM5pfIBqx/hwnUqmmU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 441/676] ASoC: amd: yc: Fix for enabling DMIC on acp6x via _DSD entry
Date: Fri,  6 Dec 2024 15:34:20 +0100
Message-ID: <20241206143710.583732530@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit 4095cf872084ecfdfdb0e681f3e9ff9745acfa75 ]

Add condition check to register ACP PDM sound card by reading
_WOV acpi entry.

Fixes: 5426f506b584 ("ASoC: amd: Add support for enabling DMIC on acp6x via _DSD")

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://patch.msgid.link/20241127112227.227106-1-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 04700e7471ca5..f3c0db24bc76b 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -537,8 +537,14 @@ static int acp6x_probe(struct platform_device *pdev)
 	struct acp6x_pdm *machine = NULL;
 	struct snd_soc_card *card;
 	struct acpi_device *adev;
+	acpi_handle handle;
+	acpi_integer dmic_status;
 	int ret;
+	bool is_dmic_enable, wov_en;
 
+	/* IF WOV entry not found, enable dmic based on AcpDmicConnected entry*/
+	is_dmic_enable = false;
+	wov_en = true;
 	/* check the parent device's firmware node has _DSD or not */
 	adev = ACPI_COMPANION(pdev->dev.parent);
 	if (adev) {
@@ -546,9 +552,19 @@ static int acp6x_probe(struct platform_device *pdev)
 
 		if (!acpi_dev_get_property(adev, "AcpDmicConnected", ACPI_TYPE_INTEGER, &obj) &&
 		    obj->integer.value == 1)
-			platform_set_drvdata(pdev, &acp6x_card);
+			is_dmic_enable = true;
 	}
 
+	handle = ACPI_HANDLE(pdev->dev.parent);
+	ret = acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
+	if (!ACPI_FAILURE(ret))
+		wov_en = dmic_status;
+
+	if (is_dmic_enable && wov_en)
+		platform_set_drvdata(pdev, &acp6x_card);
+	else
+		return 0;
+
 	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
 	if (dmi_id)
-- 
2.43.0




