Return-Path: <stable+bounces-101534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6E89EED0C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E981694AA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9D21B91D;
	Thu, 12 Dec 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x7IhaPmX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74321B8E1;
	Thu, 12 Dec 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017889; cv=none; b=SYPhbfbpUtrCo85tJGs5fNZVzhkKVKj2s5NeMYs9yu5/4foLJ9cQUbOKXcmsfYL5V7gjU3zs3hKf3R5o+7ZUQWeKdJzbbUDYkXbvn8WpwwgB/aW9aEyWBwclb4HwA4B3VBGy3SKM+ravwz5dWiNJENaz8CW4J+slLAE/AMpB7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017889; c=relaxed/simple;
	bh=pjLymWJRNTxsMo9ep9Neo7mHhy3HA3lnRDko3Ug9eB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n58R3c+WH21hb90ygqWJC+YcgeJ9I2thwQIYc+SN3IiWqds/k7RvirOmshZFIVRFktLmdfYsx+/f8FTIQluU8yHzCcNZobFkjUf/g9sNzXfiyaIIsUjMiB2GeBbzROKQLh1QFTl7+VXYiWB6bCZMpUHeNAC4GvfCvFh+abb84jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x7IhaPmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6C9C4CECE;
	Thu, 12 Dec 2024 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017889;
	bh=pjLymWJRNTxsMo9ep9Neo7mHhy3HA3lnRDko3Ug9eB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x7IhaPmXHkOLvhSTRnoEZplnE2k6oq6eCgZTJqKvxyfAdspGIOVelqw4O/EMsH+km
	 vi00Tx4milGdnT+/en0dr5WpPWoZPC7IEW4F5NcAsa6VhWI2UXzmDrSpNZs9Vk2Y4S
	 VwHfWJWzdsl6ekbC2WA7LRL05Q0GaRn4qAXkQEz8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jordy Zomer <jordyzomer@google.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 141/356] ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
Date: Thu, 12 Dec 2024 15:57:40 +0100
Message-ID: <20241212144250.212195378@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordy Zomer <jordyzomer@google.com>

commit fc342cf86e2dc4d2edb0fc2ff5e28b6c7845adb9 upstream.

An offset from client could be a negative value, It could lead
to an out-of-bounds read from the stream_buf.
Note that this issue is coming when setting
'vfs objects = streams_xattr parameter' in ksmbd.conf.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Jordy Zomer <jordyzomer@google.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6652,6 +6652,10 @@ int smb2_read(struct ksmbd_work *work)
 	}
 
 	offset = le64_to_cpu(req->Offset);
+	if (offset < 0) {
+		err = -EINVAL;
+		goto out;
+	}
 	length = le32_to_cpu(req->Length);
 	mincount = le32_to_cpu(req->MinimumCount);
 



