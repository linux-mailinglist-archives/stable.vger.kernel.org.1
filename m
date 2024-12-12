Return-Path: <stable+bounces-101179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D549EEB3E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4135D166EAE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8769D215048;
	Thu, 12 Dec 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jp2ZuSoQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224A2EAE5;
	Thu, 12 Dec 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016636; cv=none; b=urnXe0YTXpaHY0vqhvk1eKZNdxJI0wgtHhL2uwWSbwfqzlawFNsn3GpqJTAcqAOPecTAStsSHyNFHP9WVB3sofUtj2k3MNF5ee3PrnTXRML6Cmk1aFU35oS1xu9vuMb4xhhWNNMEi+akAsXnAH7J+9Pl3Engmaa4/rYi1aDVl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016636; c=relaxed/simple;
	bh=7NaYJI/lDZfD/AydWhKwYxb9TOiv02TOhgV5dBzBi74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmlOOSr0L/fMbH22Q9EWwQmjJVIDMWygo91UzRH9uXniQC8agTpp9NPKkmGg4O6qvTwB1LJF7hLiI5HAktYBelCz8PyvOSfOv0AUnegkZWxakaQjXupJ0GnenCrxR7O4r6wejZmacC/vFl4AieGucRhzI2+/MJFgS0Zotv+ioV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jp2ZuSoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A461CC4CECE;
	Thu, 12 Dec 2024 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016636;
	bh=7NaYJI/lDZfD/AydWhKwYxb9TOiv02TOhgV5dBzBi74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jp2ZuSoQBdy922y/llEQhKD5boziYrbxQfcSwjXX/H3+NWdY3CsjK4cCRppe0QTCC
	 onJCeXv9ig3MTLLQYOAl4FHEwE3WuHJjrtN88Z4iGqxm5fTNJgvtHzB11q+NtmZP6O
	 MlUrTek2bnjQlRCcP32Hkn5rtRMuOt9TKNNtNRCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 253/466] drm/xe/pciids: separate RPL-U and RPL-P PCI IDs
Date: Thu, 12 Dec 2024 15:57:02 +0100
Message-ID: <20241212144316.781763437@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit d454902a690db47f1880f963514bbf0fc7a129a8 ]

Avoid including PCI IDs for one platform to the PCI IDs of another. It's
more clear to deal with them completely separately at the PCI ID macro
level.

Reviewed-by: Sai Teja Pottumuttu <sai.teja.pottumuttu@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/4868d36fbfa8c38ea2d490bca82cf6370b8d65dd.1725443121.git.jani.nikula@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_pci.c   | 1 +
 include/drm/intel/xe_pciids.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 5e962e72c97ea..8563206f643e6 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -383,6 +383,7 @@ static const struct pci_device_id pciidlist[] = {
 	XE_ADLS_IDS(INTEL_VGA_DEVICE, &adl_s_desc),
 	XE_ADLP_IDS(INTEL_VGA_DEVICE, &adl_p_desc),
 	XE_ADLN_IDS(INTEL_VGA_DEVICE, &adl_n_desc),
+	XE_RPLU_IDS(INTEL_VGA_DEVICE, &adl_p_desc),
 	XE_RPLP_IDS(INTEL_VGA_DEVICE, &adl_p_desc),
 	XE_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_desc),
 	XE_DG1_IDS(INTEL_VGA_DEVICE, &dg1_desc),
diff --git a/include/drm/intel/xe_pciids.h b/include/drm/intel/xe_pciids.h
index 644872a35c352..7ee7524141f10 100644
--- a/include/drm/intel/xe_pciids.h
+++ b/include/drm/intel/xe_pciids.h
@@ -120,7 +120,6 @@
 
 /* RPL-P */
 #define XE_RPLP_IDS(MACRO__, ...)		\
-	XE_RPLU_IDS(MACRO__, ## __VA_ARGS__),	\
 	MACRO__(0xA720, ## __VA_ARGS__),	\
 	MACRO__(0xA7A0, ## __VA_ARGS__),	\
 	MACRO__(0xA7A8, ## __VA_ARGS__),	\
-- 
2.43.0




