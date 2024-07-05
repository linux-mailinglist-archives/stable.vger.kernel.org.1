Return-Path: <stable+bounces-58130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6190928648
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 12:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5E2B21496
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 10:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A30143C7B;
	Fri,  5 Jul 2024 10:01:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9513A252;
	Fri,  5 Jul 2024 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720173696; cv=none; b=JP3qTl3CqNuEUudrPIRQKYMizjTtk10TmQFrdLtwoV6ZV7xe036pd3IlAfMQP/y584acxTe1OOw4S4lztREQVKt0KVByeSpNmZHIv6Jot/pIm5jWw7WXLoGsyxeuWIB1lBIVQQZvRUtGzjhTQgV9ms9uc36775Ux2V/kfQcuoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720173696; c=relaxed/simple;
	bh=8ggn2Gtnn/u2RvU2sioDLfNnICoKxTU5C3l1Z6azTC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J1VJ6HumIz/NZxrlJYAt2X+20VYbIO0s5ys3R8A7YlMztY7IiUBZV/stNFrhTSuELzQof4jVwV/vN93Fn3biuIGg/NMPPenKcHuWCyt72nYJOY9CgkKQAH3DL3YNAcuuRUP619OG8MBWi6OB+H6HKIhEGb4Y32zygFJqvHOw6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpsz4t1720173669twdmk4r
X-QQ-Originating-IP: ZFWWM7NHnITK1MzzQCRyJIo0W03FFO1hJRONed26+oA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jul 2024 18:01:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15895109735684369604
From: Wentao Guan <guanwentao@uniontech.com>
To: stable@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	guanwentao@uniontech.com,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: [PATCH 4.19] Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt
Date: Fri,  5 Jul 2024 18:01:06 +0800
Message-Id: <20240705100106.25403-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1

From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>

Please apply the upstream commit:
commit cd9151b618da ("Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt")
 
Solved kernel BT Err  "Bluetooth: Unknown advertising packet type: 0x100"

-------------------------------------------------------------------------

In ext_adv_report_event rssi comes before data (not after data as
in legacy adv_report_evt) so "+ 1" is not required in the ptr arithmatic
to point to next report.

Cc: stable@vger.kernel.org # 4.19-
Signed-off-by: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3e7badb3ac2d..4f972c9e9dbe 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5402,7 +5402,7 @@ static void hci_le_ext_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 					   ev->data, ev->length);
 		}
 
-		ptr += sizeof(*ev) + ev->length + 1;
+		ptr += sizeof(*ev) + ev->length;
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.20.1


