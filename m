Return-Path: <stable+bounces-103206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037879EF75C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D02A1795FE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D94211493;
	Thu, 12 Dec 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DAG7sb4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9A1487CD;
	Thu, 12 Dec 2024 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023864; cv=none; b=FSdWRBZ9M5KHOPaL/gqja5WJwhV2MwgVwHay/io8laRMWwlC4uGtfV9Or1Gv2JVtTJAVhpFFi5ffwveyAWdfSm1hxN+XNA8Z6TnQnA2yC87/t2Wp64hVVVr7i6RvJGRtWX/pXCEdCbHZpVUwtCxvK/XPYX4/e5rDvJOJKsL6YEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023864; c=relaxed/simple;
	bh=PeF2thYTg9zDqav32A8COhXbwleLnkU9GynRLkT7eoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A30Pd/YezQ7tXzt+3HZ3ui8v4msi3BZmGJNdutu+jpMHsNtmxjyfF6+zjtcWRkXPdmVD1EfrDob5KaPv2kPCZ/akMkiERYcZz0OCo0+p/gflPFnrtVdP2QEjr00yoCSe+nBsHyJ4dy9dPRKlV8Dlj7/upCIObMzxtHbLchEm0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DAG7sb4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841E2C4CECE;
	Thu, 12 Dec 2024 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023863;
	bh=PeF2thYTg9zDqav32A8COhXbwleLnkU9GynRLkT7eoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAG7sb4mw2Pc9G3Fi4Q20wVmBTwRRZa1o1HS22Lj8Fq21tQMs8CUiazumIz13ChXr
	 0obeAUNyX/8BLwEMQ9GI/ROdNgFHuCPaCaOb992uqq7IbNCXtWc5G/GVaLTEYo2/SI
	 JchzZ91bYrhN+MlzIF+TIWUDkypnQONlYIX5difE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 107/459] wifi: ath10k: fix invalid VHT parameters in supported_vht_mcs_rate_nss2
Date: Thu, 12 Dec 2024 15:57:25 +0100
Message-ID: <20241212144257.738548791@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 52db16ec5bae7bd027804265b968259d1a6c3970 ]

In supported_vht_mcs_rate_nss2, the rate for MCS9 & VHT20 is defined as
{1560, 1733}, this does not align with firmware's definition and therefore
fails the verification in ath10k_mac_get_rate_flags_vht():

	invalid vht params rate 1730 100kbps nss 2 mcs 9

and:

	invalid vht params rate 1920 100kbps nss 2 mcs 9

Change it to {1730,  1920} to align with firmware to fix the issue.

Since ath10k_hw_params::supports_peer_stats_info is enabled only for
QCA6174, this change does not affect other chips.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1

Fixes: 3344b99d69ab ("ath10k: add bitrate parse for peer stats info")
Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/lkml/fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> # Dell XPS 13 9360
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240711020344.98040-3-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 2bf3e66c83f63..323b6763cb0f5 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -8970,7 +8970,7 @@ static const struct ath10k_index_vht_data_rate_type supported_vht_mcs_rate_nss2[
 	{6,  {5265, 5850}, {2430, 2700}, {1170, 1300} },
 	{7,  {5850, 6500}, {2700, 3000}, {1300, 1444} },
 	{8,  {7020, 7800}, {3240, 3600}, {1560, 1733} },
-	{9,  {7800, 8667}, {3600, 4000}, {1560, 1733} }
+	{9,  {7800, 8667}, {3600, 4000}, {1730, 1920} }
 };
 
 static void ath10k_mac_get_rate_flags_ht(struct ath10k *ar, u32 rate, u8 nss, u8 mcs,
-- 
2.43.0




