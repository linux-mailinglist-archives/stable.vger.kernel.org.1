Return-Path: <stable+bounces-69421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54E9955F5F
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C52814CD
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 21:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91900154C0C;
	Sun, 18 Aug 2024 21:44:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B471CF93
	for <stable@vger.kernel.org>; Sun, 18 Aug 2024 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724017473; cv=none; b=lKF9rKIYe9hGgb86SHQ4yxoiG0Elm0m5teXR6+HPFsKOoG3INVygaGqlkNKlb4zEgwiM4fbucjjEoffPu0m33ReXcesUGNyTyWFjNKmsRWxt3b+KlN6tJkmS9kJWOtobJls08umslWgchbQn4mHJ5V7Z2JyAFSElEoDxE/Zkh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724017473; c=relaxed/simple;
	bh=iYqM+WNsd0qP3VQanTa53sZkW7HHHtbN4fJbspbI6dg=;
	h=From:Date:Subject:To:Cc:Message-Id; b=mq3z4FvMreBSTqOr1hIzYpb7wR6Aj7cIwZ2y5XTAP1orv3oKQON6AelzPPhF5h5ZYmMnAceQ8u9LRB46cK0Ok4A+dWb146o2+oKloG8nuDSqGCDC0vt/8Ai2U5rrhwbT7WtGGecIj+35wzt9f+kcuL+WqYSjTVd1vOqfmC6I38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1sfnhP-0000p8-0i;
	Sun, 18 Aug 2024 21:44:31 +0000
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Thu, 08 Aug 2024 13:23:21 +0000
Subject: [git:media_tree/master] media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags
To: linuxtv-commits@linuxtv.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sfnhP-0000p8-0i@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: uapi/linux/cec.h: cec_msg_set_reply_to: zero flags
Author:  Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:    Wed Aug 7 09:22:10 2024 +0200

The cec_msg_set_reply_to() helper function never zeroed the
struct cec_msg flags field, this can cause unexpected behavior
if flags was uninitialized to begin with.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 0dbacebede1e ("[media] cec: move the CEC framework out of staging and to media")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

 include/uapi/linux/cec.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

---

diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
index 894fffc66f2c..b2af1dddd4d7 100644
--- a/include/uapi/linux/cec.h
+++ b/include/uapi/linux/cec.h
@@ -132,6 +132,8 @@ static inline void cec_msg_init(struct cec_msg *msg,
  * Set the msg destination to the orig initiator and the msg initiator to the
  * orig destination. Note that msg and orig may be the same pointer, in which
  * case the change is done in place.
+ *
+ * It also zeroes the reply, timeout and flags fields.
  */
 static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 					struct cec_msg *orig)
@@ -139,7 +141,9 @@ static inline void cec_msg_set_reply_to(struct cec_msg *msg,
 	/* The destination becomes the initiator and vice versa */
 	msg->msg[0] = (cec_msg_destination(orig) << 4) |
 		      cec_msg_initiator(orig);
-	msg->reply = msg->timeout = 0;
+	msg->reply = 0;
+	msg->timeout = 0;
+	msg->flags = 0;
 }
 
 /**

