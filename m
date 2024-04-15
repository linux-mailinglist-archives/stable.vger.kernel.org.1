Return-Path: <stable+bounces-39568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296308A5344
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 861FAB22035
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56976025;
	Mon, 15 Apr 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nkhAvgpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679DC7602A;
	Mon, 15 Apr 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191157; cv=none; b=jQ1pU16XmKXx0ETKqG97xhS/Nc+tN7O5tXXyRuBFytQvZf70a+LrCDcYqz2krXss8OsWijLnhJ0ZRyPyJKZdgZ3KYAosA1ywsAs+GPtyPf7vPZ3uxYH795tQArsgCZOFC8x+rrAS78mKcqnDFZoBSmGbt3j60s8AuCTmH2nCqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191157; c=relaxed/simple;
	bh=X3/U8WnYVT/W/Aaf3BuQAxV4T/TGfJyxoYeSCVeFivc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IobsfgEA0/5Zo5WgPp/DA7ieTwxeJYcWwtVvYeT6UUohQpMXlwJ3ixeItqNLGBEG3f2CorbWcq5UrP+39fPLLuGKPBoe72JmOpUz10jgkvcQlw8l/uWbhxpfKLSCGGVEpeQaaxMD+hZdk8Az+rgndE5xCLlEm6m4+vcimkWiKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nkhAvgpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5684C2BD10;
	Mon, 15 Apr 2024 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191157;
	bh=X3/U8WnYVT/W/Aaf3BuQAxV4T/TGfJyxoYeSCVeFivc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nkhAvgpx1Eq7r6oeLSuXOEHgRNEWPWUSBIEKaNxmwJDkNk+NM9pMVgzzgjcZilQIm
	 I7QwH1lkw2h8/oJ+v6wxFnor8UerFV9fhegdMycEcaM6xG8Nk7txZJNAeVAAQcIjtx
	 AJBQrAZ5rMcnoJAfv6W/2IKjXTild7amNsKAiVNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.8 013/172] Bluetooth: Fix memory leak in hci_req_sync_complete()
Date: Mon, 15 Apr 2024 16:18:32 +0200
Message-ID: <20240415142000.386307276@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

commit 45d355a926ab40f3ae7bc0b0a00cb0e3e8a5a810 upstream.

In 'hci_req_sync_complete()', always free the previous sync
request state before assigning reference to a new one.

Reported-by: syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=39ec16ff6cc18b1d066d
Cc: stable@vger.kernel.org
Fixes: f60cb30579d3 ("Bluetooth: Convert hci_req_sync family of function to new request API")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_request.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -105,8 +105,10 @@ void hci_req_sync_complete(struct hci_de
 	if (hdev->req_status == HCI_REQ_PEND) {
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
-		if (skb)
+		if (skb) {
+			kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
+		}
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }



