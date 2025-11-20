Return-Path: <stable+bounces-195251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52CC73E00
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F6F3354B32
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A343314B3;
	Thu, 20 Nov 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRK3WJ/S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C626E6E8
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640431; cv=none; b=XQnONEWpixQPTEQZvZS9vszl8FLoI+jCh+RzX6nbK3ISk3VhGuFbWfcG1O9h8MSkrQ4Tog6kW/FPOxHuOf+ylQPoAK8dZtoQmrHZjHwI94Ohe8QL16pYqhcKw/eerGjbX3jwjIO0Uj9dnKHYb/MwxTk0t/vxB/0mT/IUZN5ZUOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640431; c=relaxed/simple;
	bh=kHIRw9JtarZwa773c9rrA7Sh/ynBxdlTXwbJEgMPosU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vkv2QFu6zmxF0rJs0Fo1nCtVyjkv/TiXuVxcq367sMUp+VC9Ha6wRSxXmR8hc4UqjRsoFyHNS22GMWYpR9+XSO5HClFQcdyOTxfBGz2Wc+fn0Tfl6Ez/INsaGe+NYKvF97OImY2gnLjnEcTn7Kyc/mYz7ye7o3yfHkPw3xfj2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRK3WJ/S; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29845b06dd2so10228165ad.2
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 04:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763640428; x=1764245228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X5oFycNEQQvwxiwtacy6vIh6YX/aGmQRlWzpW1R7bkA=;
        b=mRK3WJ/S1MRudwFG8AUgCShC7G+2EkFT6tkbhy8rYSMggoLpq6lAJGKpIKH/V7ya2v
         BHZlDwqcJyjMpTE4LVkQJd/Yq/uYXLRoo/h27kTWvhZDnnRUu6X6+f4LbllkzobmNCtm
         0lB8VUhuWMCuWl4YAL79sJhJ2FObxY37YiEgnQ5GP5doYDoaCF063/9ugRnqUsN9ivxo
         L5//TnIWZ4iZ19OF6HTq/vCiK4d4yem3V0EVAf/qk8XSiFR7nXwVdg71Be54ISKuecl2
         iHZFSE36jTIXvm8zGnlpK6TRuKT1MjDLLRYdzekNJsOKEukxFe4CVK81ntBmjqADcxVV
         yF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640428; x=1764245228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5oFycNEQQvwxiwtacy6vIh6YX/aGmQRlWzpW1R7bkA=;
        b=TYXGW2tJqRV5jLPOpprqYoDZqJm0fJkHF/UgKxfMQjm2Ptr3jAxfLEecLpZUUXNYQX
         e728LofAa7npjBtwmzaz5kYGrfQ+OhpvyOPoacHas8lbokvAF4SaBqNGcPdj4aTeDFom
         bNlXAz0VL0YEJImM+ZQ/V45UMyCddDPih66VBWKP01xbD3DoQ8idiXfHJHrsRjavgyXx
         ZtbY6KEbrRl/7TWvpAad206TeLgmo52PUt8/wTp06z3nBTXeoYDxIqyYrCzxWxipdNKS
         cvtZsFFepiDlL/1EWh1KDGfbsEAAlNN3rwnWJ6qQ2+jDg4osmufLnKFXMMyX8dNZk1T1
         rGoA==
X-Forwarded-Encrypted: i=1; AJvYcCXXMLXjCQSBEcyMexXH7qJwuCTX3GVZk1Yxqf9ipZHMfURXCpUYLws7c2fg1slMSJF8MwjfFnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyslfqKm0xgS/gXL16kfyHKTFq+xcz3l1u9CPSTeqtMRKrF0YpL
	rmlsJxJYwWNUfwS2hgb9xUxVo4t+ASIP1Vcj/1zKhMFewCFk5FuMTAU5
X-Gm-Gg: ASbGncvbK97qMWHPH0KhV/qlsXVR7calr4HXs2rtcucfASRef4Bw2DLaB43iNwqkNJl
	mdyEyDDxSqfZGxDgzEAiAAVHryL0/0VGJG2oQzhnaZNyXTxYXKwG2eeut4suWwyGA8bofbnES8p
	E4WatGBuMT/3FhOrEBWDTMmoSbJXGVpOxiwBu5kS1PAHFc7y9vlcwnaymUxzjxZVC6ydDqQrXzQ
	xqbthb14eFPgBFaDexKGpilfpKlcDWfNmiLKPOjKJ8+BF3p2wt/98tD1XIrsO2LISzdcYGk3a+U
	6rHEwNDei7Pwvtdn9RYnuV7Y+iQ+lsWaaDRlFw1i488wwJ/gpKkFv+tfqemk72V1/G6VzLIa8Mb
	bDFH7X98YCpeBe1JxlrG1prArhYevYJeJEUSE7ALUSc6egxk2q0Q28d1dMLieyFYb5xz4QvCN4p
	tvTvcPPzD77oj3Pe96pysPVcRUlzG6CAGgyp8H
X-Google-Smtp-Source: AGHT+IHFRDK28WOgfhLwyxo9fNDEJUyqOd57Tzt8s5kHu8siVkpXQv00/V1u5HV+EbRwk50S2r5gnA==
X-Received: by 2002:a17:903:183:b0:298:45b1:6c30 with SMTP id d9443c01a7336-29b5b163032mr35372985ad.57.1763640428097;
        Thu, 20 Nov 2025 04:07:08 -0800 (PST)
Received: from localhost.localdomain ([1.203.169.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111650sm24894815ad.8.2025.11.20.04.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:07:07 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: 3chas3@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3] atm/fore200e: Fix possible data race in fore200e_open()
Date: Thu, 20 Nov 2025 20:06:57 +0800
Message-Id: <20251120120657.2462194-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect access to fore200e->available_cell_rate with rate_mtx lock in the
error handling path of fore200e_open() to prevent a data race.

The field fore200e->available_cell_rate is a shared resource used to track
available bandwidth. It is concurrently accessed by fore200e_open(),
fore200e_close(), and fore200e_change_qos().

In fore200e_open(), the lock rate_mtx is correctly held when subtracting
vcc->qos.txtp.max_pcr from available_cell_rate to reserve bandwidth.
However, if the subsequent call to fore200e_activate_vcin() fails, the
function restores the reserved bandwidth by adding back to
available_cell_rate without holding the lock.

This introduces a race condition because available_cell_rate is a global
device resource shared across all VCCs. If the error path in
fore200e_open() executes concurrently with operations like
fore200e_close() or fore200e_change_qos() on other VCCs, a
read-modify-write race occurs.

Specifically, the error path reads the rate without the lock. If another
CPU acquires the lock and modifies the rate (e.g., releasing bandwidth in
fore200e_close()) between this read and the subsequent write, the error
path will overwrite the concurrent update with a stale value. This results
in incorrect bandwidth accounting.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v3:
* Expanded the commit message to describe the specific call paths causing
the race, as suggested by Jakub Kicinski and Paolo Abeni.
v2:
* Added a description of the data race hazard in fore200e_open(), as
suggested by Jakub Kicinski and Simon Horman.
---
 drivers/atm/fore200e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 4fea1149e003..f62e38571440 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1374,7 +1374,9 @@ fore200e_open(struct atm_vcc *vcc)
 
 	vcc->dev_data = NULL;
 
+	mutex_lock(&fore200e->rate_mtx);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
+	mutex_unlock(&fore200e->rate_mtx);
 
 	kfree(fore200e_vcc);
 	return -EINVAL;
-- 
2.34.1


