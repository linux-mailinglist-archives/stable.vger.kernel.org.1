Return-Path: <stable+bounces-90361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E029BE7EE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77FB1C20C92
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313F51DF738;
	Wed,  6 Nov 2024 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aa1fiW13"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F51DF25E;
	Wed,  6 Nov 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895544; cv=none; b=Mwp0ZAZArXuwoPccnOM7nhT1p4+aW/eCb6ryp6zmpaUeiASmST7h3g0bX+FkbIRmO5RxnnhdFfJnHaEPNvW+i1Zm75S052mWfoywjN9Pc+4Bpm/8Zk5MRF/2Ym93p6h5eFjQrIHmw0eciJXC65YHbtJmW8VoXihUlasE/Nkj+/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895544; c=relaxed/simple;
	bh=Js/W1lrfkMYaSsltn62Kk13aSa8AvoGvV5sOFuk4mcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgusKH7FS2sjymizXlSk22gVZKKBzQNumXXEHtmJQahmTqsQciE/FQWDj2TgqtKxc8ZoR6IIfN/XORBjE47cjVPmT0bkuZQbbusQAtHq10lQYxf5UaSZMTAx+Ig9FIp3STQS0D1uI5RhJboKUasK4rwqIPfe6YjnQqXEO96OlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aa1fiW13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A85C4CED4;
	Wed,  6 Nov 2024 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895543;
	bh=Js/W1lrfkMYaSsltn62Kk13aSa8AvoGvV5sOFuk4mcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aa1fiW13FDWN4phHyjR24SyYWk3lIxJBXLl++6X0jzxZ4TpxZXvRtk3h/R7vBrrsq
	 ifHawGwBipCYuD2SquSavHHlt6d7J/vn3qbH+x4bEln3eRFDNfKlROTWHM+oEfXeim
	 mgzxO26+02VuhK296oKI9c58qM8ECXtkBQNJHj9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.19 207/350] media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags
Date: Wed,  6 Nov 2024 13:02:15 +0100
Message-ID: <20241106120326.097933173@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 599f6899051cb70c4e0aa9fd591b9ee220cb6f14 upstream.

The cec_msg_set_reply_to() helper function never zeroed the
struct cec_msg flags field, this can cause unexpected behavior
if flags was uninitialized to begin with.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 0dbacebede1e ("[media] cec: move the CEC framework out of staging and to media")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/cec.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -132,6 +132,8 @@ static inline void cec_msg_init(struct c
  * Set the msg destination to the orig initiator and the msg initiator to the
  * orig destination. Note that msg and orig may be the same pointer, in which
  * case the change is done in place.
+ *
+ * It also zeroes the reply, timeout and flags fields.
  */
 static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 					struct cec_msg *orig)
@@ -139,7 +141,9 @@ static inline void cec_msg_set_reply_to(
 	/* The destination becomes the initiator and vice versa */
 	msg->msg[0] = (cec_msg_destination(orig) << 4) |
 		      cec_msg_initiator(orig);
-	msg->reply = msg->timeout = 0;
+	msg->reply = 0;
+	msg->timeout = 0;
+	msg->flags = 0;
 }
 
 /* cec_msg flags field */



