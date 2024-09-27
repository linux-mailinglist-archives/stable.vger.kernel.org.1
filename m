Return-Path: <stable+bounces-78009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C998849D
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E341C21507
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DACA18BC1D;
	Fri, 27 Sep 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y4/PJQS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7118A95D;
	Fri, 27 Sep 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440170; cv=none; b=MfRJCVrGNaCz+zYmMtimfqDIQS29/zANFboByYNu0a60LHc2kh2R4dgiskWT/MTl92unNA7inkvXL6ToLZBPNWDBLea8hN8HDmFR1dz7AQh58yQRKUBXswusi0Qn7PDGAC/h6g/LdJltXj/MAATi4n55oQK2dXInIgxJpH3GaIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440170; c=relaxed/simple;
	bh=PK2/dzW5kivFXfejHxvV1iA6J9DTlAiF18g+cdlDFl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWSLmFj6vi3uWAT5DAnUgiYxOYWIvmrGD6GGbH7WnaL8qTq5vMr+XwVUFIILcDPvuuUUgizRbFIr+34Ql4qLCSJdGadhAY9GZ/7ZgbXrk7L9WdO2HDhXYArjVO998WT3L8cNoSP62gbtiDW2ay7O0aBuCSbOrW1wWSi3Bcxay+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y4/PJQS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAE9C4CEC4;
	Fri, 27 Sep 2024 12:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440170;
	bh=PK2/dzW5kivFXfejHxvV1iA6J9DTlAiF18g+cdlDFl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y4/PJQS6+L3jQviQk1E2Ysn52Yc30NiTqnRpG17sNJmBZGJBFHMpKNdWE/TsXv5kj
	 YYPOzSBLCd0NBboqEEvhFBA/JTrXw5ZGuBQQYYnbF/86oydyydHTf9FEO4r/SeqEIV
	 qHU6roHYUJbV0QCXFXN0F1tjZzcNvNr9q0M0W8hI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	stable <stable@kernel.org>,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Subject: [PATCH 6.10 58/58] USB: usbtmc: prevent kernel-usb-infoleak
Date: Fri, 27 Sep 2024 14:24:00 +0200
Message-ID: <20240927121721.202300761@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

commit 625fa77151f00c1bd00d34d60d6f2e710b3f9aad upstream.

The syzbot reported a kernel-usb-infoleak in usbtmc_write,
we need to clear the structure before filling fields.

Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/tencent_9649AA6EC56EDECCA8A7D106C792D1C66B06@qq.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usbtmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -754,7 +754,7 @@ static struct urb *usbtmc_create_urb(voi
 	if (!urb)
 		return NULL;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
+	dmabuf = kzalloc(bufsize, GFP_KERNEL);
 	if (!dmabuf) {
 		usb_free_urb(urb);
 		return NULL;



