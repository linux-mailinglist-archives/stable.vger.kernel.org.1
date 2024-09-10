Return-Path: <stable+bounces-75100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294799732EC
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC501C246B2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF919006F;
	Tue, 10 Sep 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ltc7pBBS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD5D172BA8;
	Tue, 10 Sep 2024 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963749; cv=none; b=E4MO7tDgM+/mzjgW61fYY9RFUuP1SGxEAqJVxAQWafeEAb/VPmHhU8A0qu8qQFddSYdyaez+VJXyU8826H06fnekOt2wBGByhzIhxDiHuYTeUZ8NDI5lVwulvNgcqDsXPs3pDJ3TRzzwxXW8cFufkC59iVdEtisuSy1JimdBoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963749; c=relaxed/simple;
	bh=h6CYhKJnTBJOQGROUJE4UrpXxzfMZDKBIp2/DbqPoDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9rH4QMNQw50U1N5TpZJLe5nkx7Ad7wkmUGd8P76HtujDnfAJeY61PGlPpo6mx9w9lC0rmgP71xsW7qPvg3KkqlII5gBOWqic7W7DHv3jmlUGxegISidvmn/ehSrTmMT8aj2eZhdQbdGHJP8nJFt5O4RERWXgP8nFD2rXQirtXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ltc7pBBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FD9C4CEC3;
	Tue, 10 Sep 2024 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963749;
	bh=h6CYhKJnTBJOQGROUJE4UrpXxzfMZDKBIp2/DbqPoDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ltc7pBBS9CUKWz7D5Bklms9QlobHN2ldFftN+buCD8yzD80/UJK6SNJN3mze4Fp+p
	 TuquYm62/he5XgdueqhSLKB6YugPMJzhbkgyZRcTmpotDhJpr02GxxPqqOW7Ks0Kgg
	 l7/YTNUaG7y2rvGpC6QeX08QxuxtHirEGYftM9nQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+24c0361074799d02c452@syzkaller.appspotmail.com,
	Camila Alvarez <cam.alvarez.i@gmail.com>,
	Silvan Jegen <s.jegen@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 163/214] HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup
Date: Tue, 10 Sep 2024 11:33:05 +0200
Message-ID: <20240910092605.347147903@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Camila Alvarez <cam.alvarez.i@gmail.com>

[ Upstream commit a6e9c391d45b5865b61e569146304cff72821a5d ]

report_fixup for the Cougar 500k Gaming Keyboard was not verifying
that the report descriptor size was correct before accessing it

Reported-by: syzbot+24c0361074799d02c452@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=24c0361074799d02c452
Signed-off-by: Camila Alvarez <cam.alvarez.i@gmail.com>
Reviewed-by: Silvan Jegen <s.jegen@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-cougar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index 28d671c5e0ca..d173b13ff198 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -106,7 +106,7 @@ static void cougar_fix_g6_mapping(void)
 static __u8 *cougar_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				 unsigned int *rsize)
 {
-	if (rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
+	if (*rsize >= 117 && rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
 	    (rdesc[115] | rdesc[116] << 8) >= HID_MAX_USAGES) {
 		hid_info(hdev,
 			"usage count exceeds max: fixing up report descriptor\n");
-- 
2.43.0




