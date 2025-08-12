Return-Path: <stable+bounces-167224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03304B22D65
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E96A16AF7F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604C2F7472;
	Tue, 12 Aug 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PIM064Zh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DDA2D191C
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015654; cv=none; b=SulfqLV/Egz9NcaG2gJr3YVC0cVwDkNK2x9I001+bP2O2gtDVeCA93dSER/d/uVRCaSv54nkO4TLYh1TegehROtlC1nGDwE/uHebjjSWIV3zQFcR3rIAC02xUHn5UFfUmFt0eepJLujnB0OLuq/V3lh5+o3hPdXghomoycLWgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015654; c=relaxed/simple;
	bh=z/8Dssxx026mzKptKK2oSQu0SABAFPP8pYYUKi21hvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p6xuhwmei53Cg7kz1Vyaoa2OgudNpxtThfFrZrZWZqmebin/PmZtQwJXQQ63DQ9vK4SPZrTqIEB9B6ZKGNlJK3fDaEnGc7Ql9NVQ/cAjf/XPV5loFcXX5YFOVoE3oKy4LNQsevBptXpG5943ijUVZJgaClDuSw7BKE9ZZdJkanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PIM064Zh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F6BC4CEF1;
	Tue, 12 Aug 2025 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015653;
	bh=z/8Dssxx026mzKptKK2oSQu0SABAFPP8pYYUKi21hvc=;
	h=Subject:To:Cc:From:Date:From;
	b=PIM064Zh3tYUb0P1KSKURfBGQeU4HHLU27dJVHxQMuEDAxdNMmEsAivW2m0XB9SKG
	 e0uzt6Emx3rxZAPNPBxuTXlruR0Eq9NKspQ7I+LOIM4mcsEWDgWhG3dzOmYnr3LI8I
	 2YA/prb8CISbes6ZUOymFAHipztzjMBACJEB5l00=
Subject: FAILED: patch "[PATCH] HID: core: Harden s32ton() against conversion to 0 bits" failed to apply to 5.15-stable tree
To: stern@rowland.harvard.edu,bentiss@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:20:34 +0200
Message-ID: <2025081233-stamp-fiddling-ffca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a6b87bfc2ab5bccb7ad953693c85d9062aef3fdd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081233-stamp-fiddling-ffca@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


