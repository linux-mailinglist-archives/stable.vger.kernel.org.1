Return-Path: <stable+bounces-117711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC51A3B7C3
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FFF18867F9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170DD1DE3BE;
	Wed, 19 Feb 2025 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h1RJ0IYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C711DE3B1;
	Wed, 19 Feb 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956126; cv=none; b=mj0ZUacsAUYCPPiig6z5Ej07UJryx/UschwK5NlbKg+svVr/eMDxAeupeVaIrDj+bTjBrgbmQi+a2qxi0TYJXSiJQm73lUGXimgIqkdkXAjve/eRHGIJZ5L/3TL4dZ7roSGgeXWzv38TsTtPXevkc/bgan6aMFsk74hx9Y/4Uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956126; c=relaxed/simple;
	bh=zgEIwtYBn1BsnmXP8hZFR7tMuDQybA5wGJZwXz3oENc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ00cQCHRl+vT3vaxjmT/8oIIHcEbCnk1P0tYpm+025au5NGa6mpr8etbmTTcTMKtnwny00Lf6PgMDuLORieKZVVTZM+GYBDUI62nbIt6zG0KLVI/jXKYABzhytod7TFGaUo0MSYuDNqu8v3KI3nTYia+JCkah6/ZeUBGjbhUD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h1RJ0IYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49267C4CEE6;
	Wed, 19 Feb 2025 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739956126;
	bh=zgEIwtYBn1BsnmXP8hZFR7tMuDQybA5wGJZwXz3oENc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1RJ0IYp648LuEtE0kS1bgWH36oIEyH0fCnLokzwgog71intK/T0EdTgHQO64XCC+
	 aFuoJHEaN7ftXUZGiebl/fBCfr3l0HtQYc/fsmlSZfadsuFGKvrt99AQjxBlnl95B1
	 dudpe0ff2U2b5cYdf/khrhaPAnd2IoIYB18PoCuw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com,
	Karol Przybylski <karprzy7@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/578] HID: hid-thrustmaster: Fix warning in thrustmaster_probe by adding endpoint check
Date: Wed, 19 Feb 2025 09:21:16 +0100
Message-ID: <20250219082655.717384336@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Przybylski <karprzy7@gmail.com>

[ Upstream commit 50420d7c79c37a3efe4010ff9b1bb14bc61ebccf ]

syzbot has found a type mismatch between a USB pipe and the transfer
endpoint, which is triggered by the hid-thrustmaster driver[1].
There is a number of similar, already fixed issues [2].
In this case as in others, implementing check for endpoint type fixes the issue.

[1] https://syzkaller.appspot.com/bug?extid=040e8b3db6a96908d470
[2] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622

Fixes: c49c33637802 ("HID: support for initialization of some Thrustmaster wheels")
Reported-by: syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com
Tested-by: syzbot+040e8b3db6a96908d470@syzkaller.appspotmail.com
Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-thrustmaster.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-thrustmaster.c b/drivers/hid/hid-thrustmaster.c
index cf1679b0d4fbb..6c3e758bbb09e 100644
--- a/drivers/hid/hid-thrustmaster.c
+++ b/drivers/hid/hid-thrustmaster.c
@@ -170,6 +170,14 @@ static void thrustmaster_interrupts(struct hid_device *hdev)
 	ep = &usbif->cur_altsetting->endpoint[1];
 	b_ep = ep->desc.bEndpointAddress;
 
+	/* Are the expected endpoints present? */
+	u8 ep_addr[1] = {b_ep};
+
+	if (!usb_check_int_endpoints(usbif, ep_addr)) {
+		hid_err(hdev, "Unexpected non-int endpoint\n");
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(setup_arr); ++i) {
 		memcpy(send_buf, setup_arr[i], setup_arr_sizes[i]);
 
-- 
2.39.5




