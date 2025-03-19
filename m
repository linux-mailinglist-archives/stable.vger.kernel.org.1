Return-Path: <stable+bounces-125045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC95A691ED
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8691B85577
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AB1E1E13;
	Wed, 19 Mar 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TYNePZGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E381C1F0F;
	Wed, 19 Mar 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394917; cv=none; b=S8nwizo4Gf9dr4UL9EyRpiqvblaLwm+n6FgfRGSKOf7GPI3qk8RXEDRT/szcz07rnGmB9QRLQ7iuU8XTemlA+fW+6AfOvaod8az1GqLJNfRJ4s1nsL+ru25zBa0W0/u17HdVZ5VMF2XPKDWgfplI0PCGnf+8oo5bQs6FuOC0LHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394917; c=relaxed/simple;
	bh=77/9chbvvlTo2ZOPKprMgH61kwepu76X6bkV+Wgzh84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6Ws8kMgA3fl3CvvYorlUdp9cyIyAFyyMrxxrv3pN3CfR3ZEiH+ZEnOl+McS0rjVXHu7YMISD50L4ipYEwp9HhWLZWezqCBZ0yhckqAVlkbMiKic8frjbySAVsBI5SIJSpaezZq/5Ek00CTmYKoDiUkwc7WW25YXsUKY/hFOcX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TYNePZGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A41C4CEEE;
	Wed, 19 Mar 2025 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742394917;
	bh=77/9chbvvlTo2ZOPKprMgH61kwepu76X6bkV+Wgzh84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYNePZGaHmLCwWJ7NIxf48rO5DtF8e52EauyGe9JmMs4bCsypHXKpBcPvj7dN4wss
	 Rp6jxEC0kaeE58f4bqaKTBGRuOIjQCT9nVKyAPLr6AQ9F5g2T8heOqidKyUSmV6+z9
	 Kepbzs3QTCjQCJiNFt1DGL7y1p0wtpWOQXblzCa4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 109/241] ASoC: Intel: soc-acpi-intel-mtl-match: declare adr as ull
Date: Wed, 19 Mar 2025 07:29:39 -0700
Message-ID: <20250319143030.420621070@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 20efccc53abf99fa52ea30a43dec758f6b6b9940 ]

The adr is u64.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20250204033134.92332-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index 03fc5a1870123..9b9098485b8c3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -330,7 +330,7 @@ static const struct snd_soc_acpi_adr_device rt1316_3_single_adr[] = {
 
 static const struct snd_soc_acpi_adr_device rt1318_1_single_adr[] = {
 	{
-		.adr = 0x000130025D131801,
+		.adr = 0x000130025D131801ull,
 		.num_endpoints = 1,
 		.endpoints = &single_endpoint,
 		.name_prefix = "rt1318-1"
-- 
2.39.5




