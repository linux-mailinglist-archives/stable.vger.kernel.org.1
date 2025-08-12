Return-Path: <stable+bounces-169178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C26B23876
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C2656119C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F022D4802;
	Tue, 12 Aug 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X/+jzKYH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A3302CCC;
	Tue, 12 Aug 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026642; cv=none; b=cyRkmwMx5HWJ+JcTFLt2bdFMjfxaF1TM5MJ4g9QpQDQBV7ceWAmNUaZ6QjuhJODl4ak+/9+6zNya/0zViuf9WKQVQWlAY0S/pbqRD4+rxmbSnekyyRIoFP0a+Si+TUfcxyYfEiWd8oPVZrYkvRkoY5hekogW0p9kNje8oi8Z/rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026642; c=relaxed/simple;
	bh=4Nfr3NIkfADejPZNfnrUzTvck9MAv+QmjpjKs0HaPgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3jzCs+Ffk8u9p8dyQH4N1VebCU56QWv2hWdbDYTRfaUj3rbf9AMo4vCLtBijUtZT4AIFwEb9yuSEMrubloptb4VWetoaRZTfU7ndt1/NK9SfZyO7CFHGzF4gZnUF4IaK8zGAB12PP55MHCByFcp9sY9kX9FkCXgoAhIwWwlF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X/+jzKYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B620C4CEF7;
	Tue, 12 Aug 2025 19:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026642;
	bh=4Nfr3NIkfADejPZNfnrUzTvck9MAv+QmjpjKs0HaPgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/+jzKYHKfIdo5e0dvT7a+SgYUo0A1CVp0QdHBTI6fUXwWMdRzKWeHpNzQAWbqppr
	 8h/OudmGyE8bWZ/CKL4Gw9dBE9EO8SUUTsK+6E/toqtGF/HXqWnfVLzPR7s0fwTxRQ
	 ziAGyqt36O5agmNGGaq2zd0pts392cj5Ffq62C4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baojun Xu <baojun.xu@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 396/480] ASoC: tas2781: Fix the wrong step for TLV on tas2781
Date: Tue, 12 Aug 2025 19:50:04 +0200
Message-ID: <20250812174413.761437952@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baojun Xu <baojun.xu@ti.com>

[ Upstream commit 9843cf7b6fd6f938c16fde51e86dd0e3ddbefb12 ]

The step for TLV on tas2781, should be 50 (-0.5dB).

Fixes: 678f38eba1f2 ("ASoC: tas2781: Add Header file for tas2781 driver")
Signed-off-by: Baojun Xu <baojun.xu@ti.com>
Link: https://patch.msgid.link/20250801021618.64627-1-baojun.xu@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/tas2781-tlv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index d87263e43fdb..ef9b9f19d212 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -15,7 +15,7 @@
 #ifndef __TAS2781_TLV_H__
 #define __TAS2781_TLV_H__
 
-static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 50, 0);
 static const __maybe_unused DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
 
 #endif
-- 
2.39.5




