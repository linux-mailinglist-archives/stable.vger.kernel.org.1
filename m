Return-Path: <stable+bounces-167223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C429B22D64
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A02D16ACF0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087B2F83BD;
	Tue, 12 Aug 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Li3ZYYTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DD156CA
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015650; cv=none; b=jCcamZVYfN4XLKDkKE/L4HbryEGAthSNX97rJ15L9BF/KUZsj1yWjIKf8bJ6N7JaMjop53CCVyDBwA7xM1SDPCB/ht7Zz5d3pH9NFz5hGxFASHgoD3yqndlWE4yhYpDHBi8MkBKcOH6dn5Cn4ubd6X+5Gzz7tU6dVVkWQdUiCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015650; c=relaxed/simple;
	bh=ZMuJwZQNVMblvpmZgeI+rYVTQXCFVbZahbGgKjZBu3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qc2ZDqYQhprVUqqTrXVZVo8K1MataxEkMFaSE8V8yIWRCnlFgx0tyOhD78s94iUmQ2jeu11TwOk3XlzN3496aK90PV2Kl73Vb8Pq+fYZXiwPcZ4UwlNkcZib1vY2mT9feJSjTZpdhx4jcZJ/31IdlDPN0W47uNEIu1NLtxnxAoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Li3ZYYTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F342C4CEF8;
	Tue, 12 Aug 2025 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015650;
	bh=ZMuJwZQNVMblvpmZgeI+rYVTQXCFVbZahbGgKjZBu3M=;
	h=Subject:To:Cc:From:Date:From;
	b=Li3ZYYTxTsHgEJpvj74cJiDnlLNi9qZkGp/rDr2VUWcnYKYzpKsuJtyce6ctmWOjJ
	 u3sScLI+FQrWqWGfMPBsskEbnt0XhrHZ+ku0n/T86acW2nya3QKkZ1/Q1JGCCktI7F
	 o55+44H7c/4b9SzNzuE3W+7uEkfD0cdSlz+/qItE=
Subject: FAILED: patch "[PATCH] HID: core: Harden s32ton() against conversion to 0 bits" failed to apply to 5.10-stable tree
To: stern@rowland.harvard.edu,bentiss@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:20:34 +0200
Message-ID: <2025081234-unmapped-serpent-9b0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a6b87bfc2ab5bccb7ad953693c85d9062aef3fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081234-unmapped-serpent-9b0d@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


