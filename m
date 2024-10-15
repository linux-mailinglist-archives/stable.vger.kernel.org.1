Return-Path: <stable+bounces-85893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D00399EAAF
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADE91F2181E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C931C07D4;
	Tue, 15 Oct 2024 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FRh64dKX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BF21C07C2;
	Tue, 15 Oct 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997054; cv=none; b=iWAS9oWlSaTS3dTmMZ53cZ2TMcXgD0/Iy+tg+ycd7ObSrWJf8fXqfQmDk+8Vd05EEr0/QeO9Nq4lZCiwiX+VWdw/CA/UgMwOWiCrFFilHAv/eq7tbs6RdjDJb5dzHQLAu+cWhD1R+qVukRVi4gS0g9CqyIhgRgLuK8hTv3i92lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997054; c=relaxed/simple;
	bh=p7T78SwfvItGQj6DR3A3lm1K65xN7noNlfXCLe4eNkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfTvAfkkoIR3I6R5VlzF2yc01fzr8lNIaZ6/6EnnBVAbsL8CXmasgamUgefYYl+vLcU9Iry56tPC41TjtQKOg1hHHXJzrAv4ZmvfqK/Nan+Ml7OD/eisPFXcLa0Kb4aIznWggo2Hpo0f0v3sufPGXCTYOahpa4ydY9RO2Rfakr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FRh64dKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4497FC4CECF;
	Tue, 15 Oct 2024 12:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997054;
	bh=p7T78SwfvItGQj6DR3A3lm1K65xN7noNlfXCLe4eNkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRh64dKXTMFF77tS6vBmWUMypJfGuFwcvYqfVaSiRYsYKMyoIKfBT9Thq5w6iPrla
	 c20POl1Ciz1zIzNQjEffYCfMYNsQBju2rxl9XuRZ2q7UMSj79e4bGQG/zDqCP2BagG
	 mAyrBo3aBMunqeltkpi4utolwYupf7ywJeKS9fGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawei Ye <jiawei.ye@foxmail.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 075/518] wifi: wilc1000: fix potential RCU dereference issue in wilc_parse_join_bss_param
Date: Tue, 15 Oct 2024 14:39:39 +0200
Message-ID: <20241015123919.895964134@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawei Ye <jiawei.ye@foxmail.com>

[ Upstream commit 6d7c6ae1efb1ff68bc01d79d94fdf0388f86cdd8 ]

In the `wilc_parse_join_bss_param` function, the TSF field of the `ies`
structure is accessed after the RCU read-side critical section is
unlocked. According to RCU usage rules, this is illegal. Reusing this
pointer can lead to unpredictable behavior, including accessing memory
that has been updated or causing use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the TSF value is now stored in a local variable
`ies_tsf` before the RCU lock is released. The `param->tsf_lo` field is
then assigned using this local variable, ensuring that the TSF value is
safely accessed.

Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/tencent_466225AA599BA49627FB26F707EE17BC5407@qq.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 3f167bf4eef35..5f363653ed9de 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -366,6 +366,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	struct wilc_join_bss_param *param;
 	u8 rates_len = 0;
 	int ies_len;
+	u64 ies_tsf;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
@@ -381,6 +382,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 		return NULL;
 	}
 	ies_len = ies->len;
+	ies_tsf = ies->tsf;
 	rcu_read_unlock();
 
 	param->beacon_period = cpu_to_le16(bss->beacon_interval);
@@ -436,7 +438,7 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
 				    (u8 *)&noa_attr, sizeof(noa_attr));
 	if (ret > 0) {
-		param->tsf_lo = cpu_to_le32(ies->tsf);
+		param->tsf_lo = cpu_to_le32(ies_tsf);
 		param->noa_enabled = 1;
 		param->idx = noa_attr.index;
 		if (noa_attr.oppps_ctwindow & IEEE80211_P2P_OPPPS_ENABLE_BIT) {
-- 
2.43.0




