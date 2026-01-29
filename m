Return-Path: <stable+bounces-212789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SImhI/aDe2mvFAIAu9opvQ
	(envelope-from <stable+bounces-212789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:59:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06651B1BD3
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF3B73055DE7
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A829331234;
	Thu, 29 Jan 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7PD6lz8"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A53191C0
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702241; cv=none; b=cb/zpH4WCmS0anFcPUSpSVH2/e6mD0ekWtdOFsTXLM3z5vXgWN232Qwz4oXxwU4Z/IUbOoGfqIAlYsbHZ1t3x2JYGLJ5ykLdKLKvAHsgphyTd79SXov9QjtZT5TRRkwvBlisairtXiwTiDcjdIwsqVuIotch3BdY1ph96OegvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702241; c=relaxed/simple;
	bh=anusSg+ei2G8pY99kSNGBiFGkxTuVaDv4F/ejqaSEKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mR3yocOJPvBA35qVl8CvJxVWzggBUSa6nDAMAOQrRb+/7pdggIWYDWuPwYNxSZ8BcFLa5zWmkVs9g0GP6tJ+JRt31rMfoF89QXAPe7zcWHUIC1e2oltJXDBU0+8rAwDvTidFoLs+E5J3FYf7d8HWSrT7jNjE0k9SDrYl//kwOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7PD6lz8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359108fd24so723390f8f.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769702238; x=1770307038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkmQJfRqTQzrHHgjjnSwxvqZrCWnUDQPc30Wk1HVPk4=;
        b=a7PD6lz8Ttc8xY24wgLcsybL4FceJfvmLfImntsDRxyWJRtSjZXZSPodY3YCIiIYUL
         VZ9EeeEJH1bKfTHHOvUvFFh47JhMQCzcI3dAu42fCVQwASfDecQSqG4bf/VF4mG/GZ3d
         i3CCV0mIil6sGdTNgJSYmhdncnaGQ3EOzH4lwmGTWHHtAru3I70+5NEZCs3d6ay9Upau
         i3u+ZAYcHXqWyi9Oy9WEXW3vfHUk6v5t0oL/v1Npx40cw2CNN1STX/5TOCEq3MPspSXQ
         v+uC0n+zFqOpOGV8FvlFDxv2sVq/CTA70wYzpMeCevQjHlQA6fWp8f4DwLLKXvCr8md1
         exRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769702238; x=1770307038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YkmQJfRqTQzrHHgjjnSwxvqZrCWnUDQPc30Wk1HVPk4=;
        b=soH2AN4hMgmChERhxIUxFimXOV+1F5QNhC83HsdLTwPZQQ6a2PafZMFqM6VIPsYGqG
         mah6Jw2kfakqBoDNSmKC2aoKGE/t0jzFopufVIvGzL4VBrGw084UGg6PAGA77Ga9K/qd
         URgj9kpI+qomNjH4c4T87Ytse2CK9NLfhU92EqXOSneBCOByXIdgBV4owacASrOOIaox
         osB7xYEnNZh4pQi2ewX+0lKbEvSM4z57Iu0XR0z0Icwec1BxEwm/ZFLzWOA8sKhlKaHk
         1a103zcQXpBMM1WkO+Y5/ftWHmpbZdg2p77dV+ZH5TIBQVC+3ex+4DrXbTwT6qqSkNvV
         y7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUvbb3gDPuA/o25gHOOtCJHN2+7422mzXcLLLpKpgZMx/QIadGiAUofBvX62DYqNWkoxKr9gGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBghYjOo/4/ndBuS6CxA+EflsVtco38CBu7LzL5QOhlgqYX+z
	rQo8CRlRw0iizHIPHNUwtuvNtsxPhaReXOrvhhQrHMsIm8GBD6PxP7xzHQfmTaE=
X-Gm-Gg: AZuq6aKPVmsfFQnaa/DGrL6g9YM+SGVtGbWerv73uF4wqkT0bqv61usnAQHRAT6owvY
	kqnmjQAoOrEmfJVQ2PcWpOgi6X3sQ14swaTUN+dQwdGOanNIHKbBDrLMcPU9msiPnqV+RDVHHjl
	lCXzgI2lito4BC5OfLUmBDiQNo0nZIB9aUMRu8A9hfrRGPJeEGa8gnnj0QmGeOVWxwT/oADPjWQ
	vv0mPHb5ajsiRr8LMyRTF9N9PaaBdDi+MlI/M2wFJCC84ARdKtgrVC2L/0Jg5+zsdhL6kpODSpK
	mJRI65r/pmOiQJmIVr4k7+JHeL/9OvA6mLAcLj+R7em5YXin2d6kHTgev2T7W4jTGqE3d02S4PS
	c3XRzuctbyAjXhkCf0lHXFqw44+RjfbSmDeeO00elHCfHvqMGW5fwTky6oUUxeAoZiko1MiQBq9
	xmPsKtXEuy8D8=
X-Received: by 2002:a05:6000:2c04:b0:431:5ca:c1a9 with SMTP id ffacd0b85a97d-435f3a8b7bcmr106781f8f.23.1769702237655;
        Thu, 29 Jan 2026 07:57:17 -0800 (PST)
Received: from LGPC ([31.223.131.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee078sm15749231f8f.16.2026.01.29.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:57:16 -0800 (PST)
From: Luka Gejak <lukagejak5@gmail.com>
To: gregkh@linuxfoundation.org
Cc: straube.linux@gmail.com,
	dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Luka Gejak <lukagejak5@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/5] staging: rtl8723bs: fix potential out-of-bounds read in rtw_restruct_wmm_ie
Date: Thu, 29 Jan 2026 16:56:50 +0100
Message-ID: <20260129155654.5565-2-lukagejak5@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129155654.5565-1-lukagejak5@gmail.com>
References: <20260129155654.5565-1-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212789-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukagejak5@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06651B1BD3
X-Rspamd-Action: no action

The current code checks 'i + 5 < in_len' at the end of
the if statement.
However, it accesses 'in_ie[i + 5]' before that check,
which can lead to an out-of-bounds read.

Move the length check to the beginning of the conditional
to ensure the index is within bounds before accessing the array.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")

Cc: stable@vger.kernel.org

Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 98704179ad35..7dfc2678924e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2000,7 +2000,10 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	while (i < in_len) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) { /* WMM element ID and OUI */
+		if (i + 5 < in_len &&
+		    in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 &&
+		    in_ie[i + 3] == 0x50 && in_ie[i + 4] == 0xF2 &&
+		    in_ie[i + 5] == 0x02) {
 			for (j = i; j < i + 9; j++) {
 				out_ie[ielength] = in_ie[j];
 				ielength++;
-- 
2.52.0


