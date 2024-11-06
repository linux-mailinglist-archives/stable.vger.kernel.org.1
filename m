Return-Path: <stable+bounces-90012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BF29BDC8B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F164282518
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B21EE03B;
	Wed,  6 Nov 2024 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ3yrZs3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133221D223C;
	Wed,  6 Nov 2024 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859178; cv=none; b=H/0dZTBYA19XqW1u4Sxov5ogjIknXaV8iRSriLvUlbv9p/0HKAbePVjddfD/eLi3hWG7Ac7uqBbGSDs8mC2cid6VKpDfVqnQRkNQoKVh2UlsCb4sCrv6YfHmqhV3jOOUK1ubXP8qKL6OFCbzbfP6zqMXv44vOuGbhynewjaqs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859178; c=relaxed/simple;
	bh=W5AQSqACQrdGPI/xHH3xnIqrUU9q8vWOBT6w85uJwiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/zU8Bscf7J7E7SiqOzfrXbh4P3oRKn/qAzVmQqwZ2IT/7nkznYZbJtmR6OeLgWXNckzQ1bpKmBJMZwJ0I5fs4b0Nq/Yzmyy3EtywgjKOfoG4ILCtdkOupg+0G6wYYlL7jron8lAQDi35C5kRkY/rMjf1YFs3eKMhkvfoj3eUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ3yrZs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8495BC4CECF;
	Wed,  6 Nov 2024 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859177;
	bh=W5AQSqACQrdGPI/xHH3xnIqrUU9q8vWOBT6w85uJwiQ=;
	h=From:To:Cc:Subject:Date:From;
	b=QJ3yrZs3N85UPhgCcHJFVOzZ4ES8OVbhlie515b2bgrlkdiTZPX4IGswX+8DR+5wI
	 10ggqfJVx5PJsUaYgoqFx/q1WYnhVMZVcSW0H7nLd668t5IrBZiaAVCNDCz1m5eDUV
	 tRJATlHRbSQy/4MqYQQ9fAEjCVO1O162PghaSWHlsSquNcvZLvrFiybASil8F9Xx+Z
	 8djQSsTigzNnlqddzYEZJKNbq3BkY84vXMyleTaVqNFvo6FT1lO9xPxy7gdd51OpX/
	 z8gDv4hXCrq7ZH5eCkAWYoVsfC3BohHUl9XhoZCkfXNvNrQixhYHoVeYv8R6RCBkZt
	 LEDRimemdEAVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.usyskin@intel.com
Cc: stable <stable@kernel.org>,
	Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Tomas Winkler <tomasw@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mei: use kvmalloc for read buffer" failed to apply to v5.10-stable tree
Date: Tue,  5 Nov 2024 21:12:54 -0500
Message-ID: <20241106021255.183252-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4adf613e01bf99e1739f6ff3e162ad5b7d578d1a Mon Sep 17 00:00:00 2001
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Tue, 15 Oct 2024 15:31:57 +0300
Subject: [PATCH] mei: use kvmalloc for read buffer

Read buffer is allocated according to max message size, reported by
the firmware and may reach 64K in systems with pxp client.
Contiguous 64k allocation may fail under memory pressure.
Read buffer is used as in-driver message storage and not required
to be contiguous.
Use kvmalloc to allow kernel to allocate non-contiguous memory.

Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
Cc: stable <stable@kernel.org>
Reported-by: Rohit Agarwal <rohiagar@chromium.org>
Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
Tested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Acked-by: Tomas Winkler <tomasw@gmail.com>
Link: https://lore.kernel.org/r/20241015123157.2337026-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516f..be011cef12e5d 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -321,7 +321,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 		return;
 
 	list_del(&cb->list);
-	kfree(cb->buf.data);
+	kvfree(cb->buf.data);
 	kfree(cb->ext_hdr);
 	kfree(cb);
 }
@@ -497,7 +497,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 	if (length == 0)
 		return cb;
 
-	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
+	cb->buf.data = kvmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
 	if (!cb->buf.data) {
 		mei_io_cb_free(cb);
 		return NULL;
-- 
2.43.0





