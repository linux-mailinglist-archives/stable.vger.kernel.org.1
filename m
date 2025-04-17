Return-Path: <stable+bounces-134270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF4AA92A1C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF571B62F09
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B9253340;
	Thu, 17 Apr 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KtbuGBaF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1261A3178;
	Thu, 17 Apr 2025 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915616; cv=none; b=cMHiuRmhhkPb41csixcYKbKy2WnAni4CldXj7y5JOpGIwB3w+dVLCGCihNZ9HgKK3OdLN1ga9xSvYtP1c40Sf3CPHrlgka80b4ayBJIVBZdySUXHVyrUwqQQ8nOpa+8P+yDjtw7VSd+nliPQZJkzylKXSo72p6Hal5xWRhsX5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915616; c=relaxed/simple;
	bh=e/0P4zVR/Nb4cv9pW7QjvT9jFCbhTjGV5CtK0pd8pPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSSH8VHNqLaOisZ9rlCoN3nSP/mPBUjEQa6+IObeOQTeAsZEXXRpiHtaeHB0Sf7fHdrtXAwARfO9bGefTVFDMsd1kWpKumv55fBv339KkfeE5uLisNXFUSRaSgZ/u2n8G2YfLWVrLllb2CY1hfyC8m4sa+WAVhUWACtcNpK2J6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KtbuGBaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F3DC4CEEC;
	Thu, 17 Apr 2025 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915616;
	bh=e/0P4zVR/Nb4cv9pW7QjvT9jFCbhTjGV5CtK0pd8pPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtbuGBaFlts8xgpkPUZGnA8xTzBIQ77F/uSvUyR5iKosvmC0BK6p7Dpfptl7x2L2Y
	 6A1mBYtusOkAWBfdyx7+JXWOhO+Qk0mScQFGxfytmQTwyQUMyNGvgJsw5gnLLxASnM
	 tXfQR8ZQHoKIHu3ru+f53HjYZ5oWYBeD9Bx/OrIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 183/393] HID: pidff: Clamp effect playback LOOP_COUNT value
Date: Thu, 17 Apr 2025 19:49:52 +0200
Message-ID: <20250417175114.954668009@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit 0c6673e3d17b258b8c5c7331d28bf6c49f25ed30 ]

Ensures the loop count will never exceed the logical_maximum.

Fixes implementation errors happening when applications use the max
value of int32/DWORD as the effect iterations. This could be observed
when running software both native and in wine.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index ffecc712be003..74b033a4ac1b8 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -690,7 +690,8 @@ static void pidff_playback_pid(struct pidff_device *pidff, int pid_id, int n)
 	} else {
 		pidff->effect_operation_status->value[0] =
 			pidff->operation_id[PID_EFFECT_START];
-		pidff->effect_operation[PID_LOOP_COUNT].value[0] = n;
+		pidff->effect_operation[PID_LOOP_COUNT].value[0] =
+			pidff_clamp(n, pidff->effect_operation[PID_LOOP_COUNT].field);
 	}
 
 	hid_hw_request(pidff->hid, pidff->reports[PID_EFFECT_OPERATION],
-- 
2.39.5




