Return-Path: <stable+bounces-7482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB08172C0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743B7287954
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F504FF6C;
	Mon, 18 Dec 2023 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="As3De1nK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD214FF62;
	Mon, 18 Dec 2023 14:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B54C433C8;
	Mon, 18 Dec 2023 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908585;
	bh=KaLPZE25gPdEQU5MD7H8KoAGBXHSRmQG7oq9BRxIVUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=As3De1nKmpi8zP+ObL19deyIxy/r0Egvuh4WZLd7MJ0sIPvFMYWQtA7D5lE0ANrwv
	 cSG5g8BTTyyQOCGxa2LooKnPrvPkNcbh+EgywXvsQdR+J77Jf0n5SlgfeyOG3d6eYm
	 tLhVbck5m4qxXr8A4TsrLYIcBwteNu2BOKnVNkns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Benato <benato.denis96@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 46/62] HID: hid-asus: add const to read-only outgoing usb buffer
Date: Mon, 18 Dec 2023 14:52:10 +0100
Message-ID: <20231218135048.289484377@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135046.178317233@linuxfoundation.org>
References: <20231218135046.178317233@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Benato <benato.denis96@gmail.com>

[ Upstream commit 06ae5afce8cc1f7621cc5c7751e449ce20d68af7 ]

In the function asus_kbd_set_report the parameter buf is read-only
as it gets copied in a memory portion suitable for USB transfer,
but the parameter is not marked as const: add the missing const and mark
const immutable buffers passed to that function.

Signed-off-by: Denis Benato <benato.denis96@gmail.com>
Signed-off-by: Luke D. Jones <luke@ljones.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 52b0ef99bc955..b46fb92d28e58 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -336,7 +336,7 @@ static int asus_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size)
+static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
 {
 	unsigned char *dmabuf;
 	int ret;
@@ -355,7 +355,7 @@ static int asus_kbd_set_report(struct hid_device *hdev, u8 *buf, size_t buf_size
 
 static int asus_kbd_init(struct hid_device *hdev)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55, 0x53, 0x20, 0x54,
 		     0x65, 0x63, 0x68, 0x2e, 0x49, 0x6e, 0x63, 0x2e, 0x00 };
 	int ret;
 
@@ -369,7 +369,7 @@ static int asus_kbd_init(struct hid_device *hdev)
 static int asus_kbd_get_functions(struct hid_device *hdev,
 				  unsigned char *kbd_func)
 {
-	u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
+	const u8 buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31, 0x00, 0x08 };
 	u8 *readbuf;
 	int ret;
 
-- 
2.43.0




