Return-Path: <stable+bounces-67055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6187594F3B1
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5A32B2200E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6864B186E20;
	Mon, 12 Aug 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l5voUNSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEF183CA6;
	Mon, 12 Aug 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479654; cv=none; b=NBJEObt+qSAUA1ng0bHRLSLKr3JUHeWQqJy7cI9t7FGJeHhYFWMOJJxErv/BbiixB2nbavPf4aiSaerH78oHWAZv/JzeJdg9hQQZZrCNP58ygCOaNL1WiXn2QQw/xKGf3GJUd//wAY1Ohsq3fNn46CyHdv5YFThZzn1WW/8LXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479654; c=relaxed/simple;
	bh=9LxrvFeGdcuIFv1RUqZNRSsmasaS04gIbNgoOc3Pw4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbMwktTEWZiW4sMtSQ6vpWB4kYeVugMVE7zu5/2Yusja4F5B7pAZijOJAIgAm3AZbcdI8B7J3c5Jfa3TL0agvOuS6FRLYvTUz1v8fYgaspdBuo4D88Ti4xE3VbD0trVuKt9xhn0+gMFpeUR0BMQAJaGMoa7Z7K+WpuCTEziTrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l5voUNSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C5C32782;
	Mon, 12 Aug 2024 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479654;
	bh=9LxrvFeGdcuIFv1RUqZNRSsmasaS04gIbNgoOc3Pw4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5voUNSGlQRhG5P+lXorFPFhqVDFiYbi3/HXHzagE/FBC06vd7/QbuYXyARDGhxCs
	 fHXXgyy/tb1pEMUQogLX09Csw/sW/Ux2jIBDWR62er+9Z1rBBtONqhvDlOqx9lmw7K
	 8sistH+uSW4IcEZt/Pu5/qtL5FKdjDgr65a1/OV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mathias Krause <minipli@grsecurity.net>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.6 152/189] eventfs: Use SRCU for freeing eventfs_inodes
Date: Mon, 12 Aug 2024 18:03:28 +0200
Message-ID: <20240812160137.993519949@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

From: Mathias Krause <minipli@grsecurity.net>

commit 8e556432477e97ad6179c61b61a32bf5f1af2355 upstream.

To mirror the SRCU lock held in eventfs_iterate() when iterating over
eventfs inodes, use call_srcu() to free them too.

This was accidentally(?) degraded to RCU in commit 43aa6f97c2d0
("eventfs: Get rid of dentry pointers without refcounts").

Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20240723210755.8970-1-minipli@grsecurity.net
Fixes: 43aa6f97c2d0 ("eventfs: Get rid of dentry pointers without refcounts")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/tracefs/event_inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -113,7 +113,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	call_rcu(&ei->rcu, free_ei_rcu);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)



