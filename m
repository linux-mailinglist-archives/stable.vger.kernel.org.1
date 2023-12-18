Return-Path: <stable+bounces-7272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABB8171C8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B903AB22FAA
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D445BF8A;
	Mon, 18 Dec 2023 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QETdyxx1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B037881;
	Mon, 18 Dec 2023 14:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADE1C433C8;
	Mon, 18 Dec 2023 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908021;
	bh=mE1Apztk/ZSpEHjIfSaTAeVUQvruyqIbcdXjUCSiSjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QETdyxx1J9dmYC8S+/9UbksJYzg6Tvfdnrqyj9Ia1MR2/QbBNBUhN79YJ7F1SACdk
	 XTnxz90hDXZykqudT6KV/wmY1EyAER18boSNOSedrphzSrrKI48DHQl9NGbfGlieYI
	 yCJQ1FprQWff/90xZWoIOaAoaEXPWt5yoMsQxZs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Khvainitski <me@khvoinitsky.org>,
	Yauhen Kharuzhy <jekhor@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 006/166] HID: lenovo: Restrict detection of patched firmware only to USB cptkbd
Date: Mon, 18 Dec 2023 14:49:32 +0100
Message-ID: <20231218135105.233396261@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikhail Khvainitski <me@khvoinitsky.org>

[ Upstream commit 43527a0094c10dfbf0d5a2e7979395a38de3ff65 ]

Commit 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and
stop applying workaround") introduced a regression for ThinkPad
TrackPoint Keyboard II which has similar quirks to cptkbd (so it uses
the same workarounds) but slightly different so that there are
false-positives during detecting well-behaving firmware. This commit
restricts detecting well-behaving firmware to the only model which
known to have one and have stable enough quirks to not cause
false-positives.

Fixes: 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround")
Link: https://lore.kernel.org/linux-input/ZXRiiPsBKNasioqH@jekhomev/
Link: https://bbs.archlinux.org/viewtopic.php?pid=2135468#p2135468
Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>
Tested-by: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-lenovo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 7c1b33be9d134..149a3c74346b4 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -692,7 +692,8 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
 		 * so set middlebutton_state to 3
 		 * to never apply workaround anymore
 		 */
-		if (cptkbd_data->middlebutton_state == 1 &&
+		if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD &&
+				cptkbd_data->middlebutton_state == 1 &&
 				usage->type == EV_REL &&
 				(usage->code == REL_X || usage->code == REL_Y)) {
 			cptkbd_data->middlebutton_state = 3;
-- 
2.43.0




