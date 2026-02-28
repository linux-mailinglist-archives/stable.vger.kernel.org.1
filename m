Return-Path: <stable+bounces-220695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKPAIk9Co2li+wQAu9opvQ
	(envelope-from <stable+bounces-220695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A201C7111
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A862A332A602
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA2B3F9355;
	Sat, 28 Feb 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVTYAUcQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B53F934D;
	Sat, 28 Feb 2026 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300575; cv=none; b=nB4vEZLH5i05vgsvS4NXNOTZU16fukcDPdCZpHacpQxMARLQ+9HTiePFtBdnZ3P9w2JZQAO3gWV89VSFFDKcCUEBakfMCM/P0jIkg9kCsK+O7dqKEGiOiFs0UWVwrye6Y4JTr4zxeZt2mRNiclxiaZHi8p7SasVGzyGEZyksGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300575; c=relaxed/simple;
	bh=s3yDxUuIIIvd2yaG41DZabKKL38dVe+r2GKckN3hqmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYzKx1PFyGfkqLDzE+b/LJvZ8hK61lhvHPbzGmSMWwbVB9wEQEq5gpDLSPGTXuNIN9rWhpnH/mRcfhQW84RlopKTnux/7G5P75LEH2H55uDNMBQVYNv2YlSoq5xk5Osik9HFhvJbnGpCt68WDVm+8lnxkOdp0ThMHrikQ7Zg9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVTYAUcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A2BC19425;
	Sat, 28 Feb 2026 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300575;
	bh=s3yDxUuIIIvd2yaG41DZabKKL38dVe+r2GKckN3hqmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVTYAUcQkf2qVItTCgig5BH3VnQ5tZiA/+SL+LhzPvhiepGa8TD9KPYRox6DmWCAP
	 50hfBdHQxSKmfIAkZRMqyv7sz+kxg16Xb1XxrbCvuuMCa8Lsq0wvCbOHIZjRXWprJA
	 hus8roFgfDkFNetXn7zRCsssLqtFDkmRP6VdUdAOkUbkt1l20FDc/rczqAUJJ6JZYU
	 QOlSRP7gnoiMh28HxkWEBdp8vZ8pynhNjSkyqQC2mHD8cHci9O6j/kw5u/RaW5Tnr9
	 xCuiMCkCiqS0te++yMRLDzdFHwoDqnnu4U1HjYK7HJWS//3cd+WCXi2sArHSPe2A+G
	 /QrAt4atm9pVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mehdi Djait <mehdi.djait@linux.intel.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 616/844] media: i2c: ov01a10: Fix digital gain range
Date: Sat, 28 Feb 2026 12:28:49 -0500
Message-ID: <20260228173244.1509663-617-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220695-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: B8A201C7111
X-Rspamd-Action: no action

From: Mehdi Djait <mehdi.djait@linux.intel.com>

[ Upstream commit 91848c99ed6a98daf77f4cb7d44cf3f13bc6998f ]

Digital gain wraps-around at the maximum of 16838 / 0x3fff.
Fix the maximum digital gain by setting it to 0x3fff.

Signed-off-by: Mehdi Djait <mehdi.djait@linux.intel.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Fixes: 0827b58dabff ("media: i2c: add ov01a10 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ov01a10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
index 3ad516e4d3698..c1a7373a6311c 100644
--- a/drivers/media/i2c/ov01a10.c
+++ b/drivers/media/i2c/ov01a10.c
@@ -57,7 +57,7 @@
 #define OV01A10_REG_DIGITAL_GAIN_GR	0x3513
 #define OV01A10_REG_DIGITAL_GAIN_R	0x3516
 #define OV01A10_DGTL_GAIN_MIN		0
-#define OV01A10_DGTL_GAIN_MAX		0x3ffff
+#define OV01A10_DGTL_GAIN_MAX		0x3fff
 #define OV01A10_DGTL_GAIN_STEP		1
 #define OV01A10_DGTL_GAIN_DEFAULT	1024
 
-- 
2.51.0


