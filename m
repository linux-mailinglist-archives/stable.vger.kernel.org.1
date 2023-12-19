Return-Path: <stable+bounces-7873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9178182C8
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123A61F27674
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B6DDC8;
	Tue, 19 Dec 2023 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XcTLxKdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A31171C
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 07:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181BDC433C8;
	Tue, 19 Dec 2023 07:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702972702;
	bh=alcUEUjme+bNxynfPwnC0hfmCisMW1LMNJEjIkoKzCw=;
	h=Subject:To:From:Date:From;
	b=XcTLxKdRpOS0m9XxKrdbNKi5EfKmHlR8dBE6k6Jy7KudCbhsAQh9qBVaGa3z5m7fk
	 iMYZw5QGTksqt267ht9T+EbgSHPRglKUpTHP6rI5KFhYV9umhLT+OlUO1/Qkmv/geE
	 KE2iKEHdji5VAnynMw22dw6mQOqJulDmZe2/gDDs=
Subject: patch "bus: mhi: host: Drop chan lock before queuing buffers" added to char-misc-testing
To: quic_qianyu@quicinc.com,manivannan.sadhasivam@linaro.org,quic_jhugo@quicinc.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 Dec 2023 08:57:42 +0100
Message-ID: <2023121942-frill-hypnotism-3b60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    bus: mhi: host: Drop chan lock before queuing buffers

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 01bd694ac2f682fb8017e16148b928482bc8fa4b Mon Sep 17 00:00:00 2001
From: Qiang Yu <quic_qianyu@quicinc.com>
Date: Mon, 11 Dec 2023 14:42:52 +0800
Subject: bus: mhi: host: Drop chan lock before queuing buffers

Ensure read and write locks for the channel are not taken in succession by
dropping the read lock from parse_xfer_event() such that a callback given
to client can potentially queue buffers and acquire the write lock in that
process. Any queueing of buffers should be done without channel read lock
acquired as it can result in multiple locks and a soft lockup.

Cc: <stable@vger.kernel.org> # 5.7
Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1702276972-41296-3-git-send-email-quic_qianyu@quicinc.com
[mani: added fixes tag and cc'ed stable]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/host/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index ad7807e4b523..abb561db9ae1 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -644,6 +644,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 			mhi_del_ring_element(mhi_cntrl, tre_ring);
 			local_rp = tre_ring->rp;
 
+			read_unlock_bh(&mhi_chan->lock);
+
 			/* notify client */
 			mhi_chan->xfer_cb(mhi_chan->mhi_dev, &result);
 
@@ -669,6 +671,8 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 					kfree(buf_info->cb_buf);
 				}
 			}
+
+			read_lock_bh(&mhi_chan->lock);
 		}
 		break;
 	} /* CC_EOT */
-- 
2.43.0



