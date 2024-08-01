Return-Path: <stable+bounces-65191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038C943F94
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C154B1C22575
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C61C68B9;
	Thu,  1 Aug 2024 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5kAzFON"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCF11A99F0;
	Thu,  1 Aug 2024 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472810; cv=none; b=cllE9jkmh0IJQlfcjo2W1XMUZbSS+2jJ7bfRveWSxZp+d5di46TKuj6YU8jh8eP23rtV9yYws0TSxeREO4THV9giXBerkcpnkBrKRHG1jBF+bo/D7Dm4DkfIN+toKLLGBBHkyCLc3bMpah5zocOPdKisroDOMYK/KxmW9tD2D8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472810; c=relaxed/simple;
	bh=wguXzFw4PTlSl66Xt0Za4x3FwfE7FPyPh62+x4i+tY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUfSujKah8uyAdHnd864syXhI0NUm5pm1mVk+eWkH/otVcxKOleVLkBRJIhVPUQYbPxUiZMaB09TrB5nbhWT5khX1Bvs0TIr1uYVkX+TRapawljxAq04C3sEBZl2cGYeJSDMWPd+AQrAJotSwRVH6TOxzHw+P7VT8rjnlYNBd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5kAzFON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C8DC4AF0C;
	Thu,  1 Aug 2024 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472808;
	bh=wguXzFw4PTlSl66Xt0Za4x3FwfE7FPyPh62+x4i+tY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5kAzFON4T3+mghcsQQGaclL5p380bQjj4/VF3bWYKKd3V+EfhoDMLSW7OzerIN1d
	 dURuODL9ImoPLARcv1dgjZshximL2qpLrIdPpMQN3TQWPLDVoSG8ksnLs2QNEScdUy
	 8LgCSXLcn6hXoaHKkGuQdJUcPAhOilu3+MkfDIEvWpV4s0d1FvNJQjbmmX8yFp+LRu
	 T943EtgC7KDCc9F4eOIWOCyWpJlnL/weRlp+yvDGsj0wROq9ckOtIAKinve3tlgeTN
	 9rmZqATfF2Oqj55ZmFKkC50QTD1eFZF74VMcl1LNtHj6Pl8evb0lPo5LtlBQj0tO8E
	 OjAoojpFREOig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Sasha Levin <sashal@kernel.org>,
	richard@nod.at,
	johannes@sipsolutions.net,
	jirislaby@kernel.org,
	gregkh@linuxfoundation.org,
	benjamin@sipsolutions.net,
	roberto.sassu@huawei.com,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 16/22] um: line: always fill *error_out in setup_one_line()
Date: Wed, 31 Jul 2024 20:38:45 -0400
Message-ID: <20240801003918.3939431-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003918.3939431-1-sashal@kernel.org>
References: <20240801003918.3939431-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 824ac4a5edd3f7494ab1996826c4f47f8ef0f63d ]

The pointer isn't initialized by callers, but I have
encountered cases where it's still printed; initialize
it in all possible cases in setup_one_line().

Link: https://patch.msgid.link/20240703172235.ad863568b55f.Iaa1eba4db8265d7715ba71d5f6bb8c7ff63d27e9@changeid
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/line.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index d6a78c3548a55..de0ab2e455b03 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
-- 
2.43.0


