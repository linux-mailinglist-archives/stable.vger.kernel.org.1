Return-Path: <stable+bounces-91994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD09C2C57
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0249E1F21B76
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE2014D456;
	Sat,  9 Nov 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xcmlUav+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75512F5B1
	for <stable@vger.kernel.org>; Sat,  9 Nov 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153393; cv=none; b=nIsvOtzs2S9qq+kZ8RE86anIkO5PQzVCW/Eun5H9QBcMktl0KBt3wpUBq0VO+aQIUVyGIkQiSv6R8DvbwZCyn/m7KRJBSyWWOj0wsBC6C4ff6Y2TyaSHWfWYLMRog1o23pfnbHcJNI/bnOPtqmR4ipgrNlbMHEE61vlXdU/GL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153393; c=relaxed/simple;
	bh=uk7aw6zNit63xlBixUNyVSsK92duCwodoClYJSmmKM4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MYHgBTuKMCBJ/QC1r1O9e8p3Ldqpj1BCBrkfG1xD9xOa51B/OD3u/lRDa+LN/czzK0GonrDD3hVYAawhfJwxx9MSNC7zu8EBEQze+QEjhCxO9kfhsXcGWSRXAxYWLx2Ptv1dNStQlpUZWqDmern8WQLSqOj5SfTORRcSjs1MtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xcmlUav+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7FDC4CECE;
	Sat,  9 Nov 2024 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731153393;
	bh=uk7aw6zNit63xlBixUNyVSsK92duCwodoClYJSmmKM4=;
	h=Subject:To:Cc:From:Date:From;
	b=xcmlUav+i60gKNSSzX6t07iIxXzwBkC/zj5/WnfJsMyVMHoX1TfMIXeQKhmAEj/b8
	 fKAjyODnzb++GtsTY2JqnR6zjfX9vJzobW9CsPgfL12D8jslK1RseApCJdTkG6OJfU
	 Za8oCuEz4DnPAPJtjuesPC0MviG+fwWCYR2qsrDI=
Subject: FAILED: patch "[PATCH] ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,norbert@doyensec.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Nov 2024 12:56:30 +0100
Message-ID: <2024110929-darwinism-jailbird-48ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0a77715db22611df50b178374c51e2ba0d58866e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110929-darwinism-jailbird-48ab@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a77715db22611df50b178374c51e2ba0d58866e Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 2 Nov 2024 18:46:38 +0900
Subject: [PATCH] ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create

There is a race condition between ksmbd_smb2_session_create and
ksmbd_expire_session. This patch add missing sessions_table_lock
while adding/deleting session from global session table.

Cc: stable@vger.kernel.org # v5.15+
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 9756a4bbfe54..ad02fe555fda 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -178,6 +178,7 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 	unsigned long id;
 	struct ksmbd_session *sess;
 
+	down_write(&sessions_table_lock);
 	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
 		if (atomic_read(&sess->refcnt) == 0 &&
@@ -191,6 +192,7 @@ static void ksmbd_expire_session(struct ksmbd_conn *conn)
 		}
 	}
 	up_write(&conn->session_lock);
+	up_write(&sessions_table_lock);
 }
 
 int ksmbd_session_register(struct ksmbd_conn *conn,
@@ -232,7 +234,6 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 			}
 		}
 	}
-	up_write(&sessions_table_lock);
 
 	down_write(&conn->session_lock);
 	xa_for_each(&conn->sessions, id, sess) {
@@ -252,6 +253,7 @@ void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
 		}
 	}
 	up_write(&conn->session_lock);
+	up_write(&sessions_table_lock);
 }
 
 struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,


