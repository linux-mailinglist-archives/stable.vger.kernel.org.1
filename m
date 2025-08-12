Return-Path: <stable+bounces-167220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8388B22D55
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8511884FF9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A2A2F83D2;
	Tue, 12 Aug 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDxI2v2C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA4305E25
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015637; cv=none; b=dKV/nLWBP/kOYA4/rxKGTilcoeeVX6klsXoc0PayGwhz9kI0hx08a2SQUbIMJQrceJZxAYBWIbPgddPoXQj/3DhxZ/WgejOuB5vofyzPoaLhoMJQm9bIq62v5iscvZpjkcBG68xWqN3DIw8+h2NVOiAGvxAISyi1E3cIeULX6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015637; c=relaxed/simple;
	bh=cU+VfUccaOkyz/qUEFwbPApfs2u854BLo8YxDu9qYd8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I3Zd0vfAHA+Tm6bdaYXMjHZSWCTl1EO1DGONpxhQ0v4vPUg3wMOtlGTyEy+iizbmH/lgvWc0x9TKRMk8psoVfflzriERaXm0TwxcaEv9PcpXVrREc9e/k9vyUBW4YbhPeyO21NZluQSYUNIKrPhECcXY12ey7DaZM7VAO1e7Wxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDxI2v2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CE0C4CEF0;
	Tue, 12 Aug 2025 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015635;
	bh=cU+VfUccaOkyz/qUEFwbPApfs2u854BLo8YxDu9qYd8=;
	h=Subject:To:Cc:From:Date:From;
	b=vDxI2v2CY1GaASllpYQboeK9v0ZhM4WaSkbMgOacCviH9LlnCWc9Y1ky1aE5sNSU0
	 xxFJZwj/bfPniD85maVp2qX1iNmBPCUBxUO7Kwi9/93P7+UxznHno0umLjsf8zSTyf
	 2hPYldmZW5gUzMXvLnnardj5OOCVYvAoo//5VxV0=
Subject: FAILED: patch "[PATCH] HID: core: Harden s32ton() against conversion to 0 bits" failed to apply to 6.12-stable tree
To: stern@rowland.harvard.edu,bentiss@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:20:32 +0200
Message-ID: <2025081232-clear-humility-0629@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a6b87bfc2ab5bccb7ad953693c85d9062aef3fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081232-clear-humility-0629@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a6b87bfc2ab5bccb7ad953693c85d9062aef3fdd Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 23 Jul 2025 10:37:04 -0400
Subject: [PATCH] HID: core: Harden s32ton() against conversion to 0 bits

Testing by the syzbot fuzzer showed that the HID core gets a
shift-out-of-bounds exception when it tries to convert a 32-bit
quantity to a 0-bit quantity.  Ideally this should never occur, but
there are buggy devices and some might have a report field with size
set to zero; we shouldn't reject the report or the device just because
of that.

Instead, harden the s32ton() routine so that it returns a reasonable
result instead of crashing when it is called with the number of bits
set to 0 -- the same as what snto32() does.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/68753a08.050a0220.33d347.0008.GAE@google.com/
Tested-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
Fixes: dde5845a529f ("[PATCH] Generic HID layer - code split")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/613a66cd-4309-4bce-a4f7-2905f9bce0c9@rowland.harvard.edu
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ef1f79951d9b..f7d4efcae603 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -66,8 +66,12 @@ static s32 snto32(__u32 value, unsigned int n)
 
 static u32 s32ton(__s32 value, unsigned int n)
 {
-	s32 a = value >> (n - 1);
+	s32 a;
 
+	if (!value || !n)
+		return 0;
+
+	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);


