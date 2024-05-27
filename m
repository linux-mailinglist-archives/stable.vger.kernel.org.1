Return-Path: <stable+bounces-46680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B98D0ACE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F331F22782
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4898715FD01;
	Mon, 27 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C4MmAImD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B871DFED;
	Mon, 27 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836577; cv=none; b=aCZLrjYOH6Coy1Y9Dqn5i0FB8uotuEAbxDXnw5gekUV75pgG542mUYfCAQYR5nroKlkNucNI1R3+4s5hN3d+bImKaaOhydzXne8w+W3pmzdF4obBJOkjxJT1LX/h+ebkboRXBMNpdXxNnILT+qPeGXenayiuI1NQIYit1IEw3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836577; c=relaxed/simple;
	bh=Di3me2f4BGV2Rsm5wl7QNMR/MnQ2Ixtn33EdZe2rWic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3g8wTTiAsw8baIzNThG56oh27EeOkLzsMP6FCo+3S+N40tR2bmtI7aLC1I0KNB87auavMAZ5xQKp1WQvw/l6YRLC/++DfCVvZqObAuCkBrHSTztmJPkUMmIOAHhdHgtPyRaiAdZ5ChG/LO1Eeh7OWsFombuHJ+obH4MfXlmR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C4MmAImD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9487BC2BBFC;
	Mon, 27 May 2024 19:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836576;
	bh=Di3me2f4BGV2Rsm5wl7QNMR/MnQ2Ixtn33EdZe2rWic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4MmAImDa3hNfM/Hh+EvDhVhW505MHRIZz5bhRAXdoj7iw+E/QtkF2G5zhxvHMOGf
	 4rogxMgaRMbS4HHOEEntUROlvBkji5m4fR2ayqmQA/cb0NPkndx2BpwV6rMiwCVCPl
	 +nLjZnwZ8Ow5BGcv304tfLivr4kOKaq2agwwJdhU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 091/427] wifi: brcmfmac: pcie: handle randbuf allocation failure
Date: Mon, 27 May 2024 20:52:18 +0200
Message-ID: <20240527185610.229689229@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 316f790ebcf94bdf59f794b7cdea4068dc676d4c ]

The kzalloc() in brcmf_pcie_download_fw_nvram() will return null
if the physical memory has run out. As a result, if we use
get_random_bytes() to generate random bytes in the randbuf, the
null pointer dereference bug will happen.

In order to prevent allocation failure, this patch adds a separate
function using buffer on kernel stack to generate random bytes in
the randbuf, which could prevent the kernel stack from overflow.

Fixes: 91918ce88d9f ("wifi: brcmfmac: pcie: Provide a buffer of random bytes to the device")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240306140437.18177-1-duoming@zju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c   | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index d7fb88bb6ae1a..06698a714b523 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1675,6 +1675,15 @@ struct brcmf_random_seed_footer {
 #define BRCMF_RANDOM_SEED_MAGIC		0xfeedc0de
 #define BRCMF_RANDOM_SEED_LENGTH	0x100
 
+static noinline_for_stack void
+brcmf_pcie_provide_random_bytes(struct brcmf_pciedev_info *devinfo, u32 address)
+{
+	u8 randbuf[BRCMF_RANDOM_SEED_LENGTH];
+
+	get_random_bytes(randbuf, BRCMF_RANDOM_SEED_LENGTH);
+	memcpy_toio(devinfo->tcm + address, randbuf, BRCMF_RANDOM_SEED_LENGTH);
+}
+
 static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 					const struct firmware *fw, void *nvram,
 					u32 nvram_len)
@@ -1717,7 +1726,6 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
-			void *randbuf;
 
 			/* Some Apple chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
@@ -1729,10 +1737,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 				    sizeof(footer));
 
 			address -= rand_len;
-			randbuf = kzalloc(rand_len, GFP_KERNEL);
-			get_random_bytes(randbuf, rand_len);
-			memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
-			kfree(randbuf);
+			brcmf_pcie_provide_random_bytes(devinfo, address);
 		}
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
-- 
2.43.0




