Return-Path: <stable+bounces-129858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA4A80180
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1101188C2A1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A592676CF;
	Tue,  8 Apr 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzpDoLpx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEEC19AD5C;
	Tue,  8 Apr 2025 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112166; cv=none; b=ayuOdV1d8b5qw3DrVSYCuksZFOSNVpLVI0PJ+iZTHTF1fk9LWARt848FsMFWy7cRudda/uoF72qAwcXf2SH2CjLO7jCZ6PzF+SM5VDsQTtv+rmiYEfgtFBxzR/zuCPD6QycR6iRL65VSINVlVULAucMs0QXX+orkTeThtEOTImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112166; c=relaxed/simple;
	bh=AMrZ2NS+erbzvc3i50a9Iyo+lELJzryjDnzp5Dn02QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHMTKti6RBUvzeZDieVszQMhoBCDYPsAotctty5HufS6ZFzfxH0fOzWV/+w1johwDiJ9EIIRVSDf6aYN/k2daZ+oMpJ4WPsRYah1xz8dRqr/era5m3/YG1pndRQW8hK0d0OXOui6yLRPdZ1Ktu9XAok62c/noaU4gz/MtoGv1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzpDoLpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9425BC4CEE7;
	Tue,  8 Apr 2025 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112165;
	bh=AMrZ2NS+erbzvc3i50a9Iyo+lELJzryjDnzp5Dn02QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzpDoLpxN0kNA7NUVwXE6L+Lm8VSaosWm+U/S5Rd9DPj1x46FLo+AlrKPOgDVEv+B
	 C7YyVQC1kdf5rIF4KICyWlqBi/QkQrKVbeOdoP1pW+8JGrDLIx4u7b+uoWYX0Ron1I
	 ok0dtBRIPKqKf/S0/UCu2ONaJMUdmHWTj/yltqcY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Norbert Szetei <norbert@doyensec.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.14 700/731] ksmbd: fix use-after-free in ksmbd_sessions_deregister()
Date: Tue,  8 Apr 2025 12:49:57 +0200
Message-ID: <20250408104930.550813284@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 15a9605f8d69dc85005b1a00c31a050b8625e1aa upstream.

In multichannel mode, UAF issue can occur in session_deregister
when the second channel sets up a session through the connection of
the first channel. session that is freed through the global session
table can be accessed again through ->sessions of connection.

Cc: stable@vger.kernel.org
Reported-by: Norbert Szetei <norbert@doyensec.com>
Tested-by: Norbert Szetei <norbert@doyensec.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/mgmt/user_session.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -230,6 +230,9 @@ void ksmbd_sessions_deregister(struct ks
 			if (!ksmbd_chann_del(conn, sess) &&
 			    xa_empty(&sess->ksmbd_chann_list)) {
 				hash_del(&sess->hlist);
+				down_write(&conn->session_lock);
+				xa_erase(&conn->sessions, sess->id);
+				up_write(&conn->session_lock);
 				ksmbd_session_destroy(sess);
 			}
 		}



