Return-Path: <stable+bounces-39828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E818A54F0
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0815DB20BE0
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469B7E0F4;
	Mon, 15 Apr 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBw8PVvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091178C72;
	Mon, 15 Apr 2024 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191936; cv=none; b=BSeiKv64kG7xk3xQqO2yeXHHbGzM80M9RXTBo5Marqw/lSr+4d4yy/zPZPfQfP+5MyrLtB+l5cbmBbYm2aWfT+671QsOhZpMH3EukQV+OZ0RTr/CJt6fE6VNQIjXTkzCcOfALFlYbKvD21+hUA3DbR7JyqdP3uxpK9u+9oEAgq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191936; c=relaxed/simple;
	bh=zw/+FUF+E71i9AE9AcA6pUzAh+yX1LIDdngXq4ZGJes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJXxlgVUrDq9tA+qFubZPAotsdqVRFLoU1atLQQynrn7Oo0IMPdiH3W7cxPMbqtcF1FtsWf0QaUlDiq+lkjrZF1wVW91k9EcOj+5E6tjzMcRloGmp/jSbBcKy9popFOUTUT4JFoex5mwsPmS1pdafTDBy66+sneSBwD7vIv85yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBw8PVvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8E8C113CC;
	Mon, 15 Apr 2024 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191936;
	bh=zw/+FUF+E71i9AE9AcA6pUzAh+yX1LIDdngXq4ZGJes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBw8PVvBhCkj/qgut8u1qw0EtEgC7Ibu+MkpqFGZRy7+sgcfK8CqVIBLCv1um+DJi
	 jKAJpjdMT390oVRyCsqpGWQHDyfL/U+ZpspUl5mMelpDFohnx+zEOg2uC1WHkVK8qc
	 Z6qzkS/D6wJC/3BNNjsh8wffK3niqQgFQtok7UVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+39ec16ff6cc18b1d066d@syzkaller.appspotmail.com,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 05/69] Bluetooth: Fix memory leak in hci_req_sync_complete()
Date: Mon, 15 Apr 2024 16:20:36 +0200
Message-ID: <20240415141946.332428548@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
References: <20240415141946.165870434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



