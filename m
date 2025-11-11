Return-Path: <stable+bounces-194181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D1CC4AF04
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBF53B49B9
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C10339B58;
	Tue, 11 Nov 2025 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nFzpLnYw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C233BBC4;
	Tue, 11 Nov 2025 01:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824996; cv=none; b=MWh2RVMgMq9HZkPh9i+bXDocXWGwOec0hYOBfh+RetUwkyKK9Y1R8u1JKLkOmrnKsRKt12wB3Q1NBiSYb5ii6aZw2Ui1rPulgKpatjwnOQvDuu4o1N423igxAeR/HwQ2csnrRvhe0yXQnmvjqkoW3tP+bhp7DmBEE+Gm2YftxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824996; c=relaxed/simple;
	bh=vNXLaB3tdgMO6CGO1mcgEWX/9IBMNMMFKdQ4852LuJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iy8gL8ctgWHYqs+KlZVes0leoszfBRL/RX6kfVVVGzyY5B5UaEqx79h8WdfzxjaYumd+psLjMFiaS0LVfuFvl9rL5EvQ3vz+zUwR3wqJd32hpHqh2CP2laxbzF2U+yW0kxO0pvnpCAvZyFVDeRL7Zq11NIWs/SbaXSkT1epPM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nFzpLnYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09BCC116B1;
	Tue, 11 Nov 2025 01:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824996;
	bh=vNXLaB3tdgMO6CGO1mcgEWX/9IBMNMMFKdQ4852LuJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFzpLnYwiJocQ8hHFCOqIXMO+idA7p7EyPcGDCgDRgGt2NAhNmIdLQOZ6/U9Jg6Vv
	 KUMXqzf93xWbuIPwV5xK/qH5BaS7AXvkjC1l5Qrna4cOdY5vLYze0VZL2CvYGmB/wI
	 DVql+wT3tOpNhbg/MVuUMId1cKktL0B6J/jMedf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niranjan H Y <niranjan.hy@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 612/849] ASoC: ops: improve snd_soc_get_volsw
Date: Tue, 11 Nov 2025 09:43:02 +0900
Message-ID: <20251111004551.222292360@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niranjan H Y <niranjan.hy@ti.com>

[ Upstream commit a0ce874cfaaab9792d657440b9d050e2112f6e4d ]

* clamp the values if the register value read is
  out of range

Signed-off-by: Niranjan H Y <niranjan.hy@ti.com>
[This patch originally had two changes in it, I removed a second buggy
 one -- broonie]
--
v5:
 - remove clamp parameter
 - move the boundary check after sign-bit extension
Link: https://patch.msgid.link/20250912083624.804-1-niranjan.hy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index a629e0eacb20e..d2b6fb8e0b6c6 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -118,6 +118,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
 	if (mc->sign_bit)
 		val = sign_extend32(val, mc->sign_bit);
 
+	val = clamp(val, mc->min, mc->max);
 	val -= mc->min;
 
 	if (mc->invert)
-- 
2.51.0




