Return-Path: <stable+bounces-9193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D71821D9F
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471C11F22B06
	for <lists+stable@lfdr.de>; Tue,  2 Jan 2024 14:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383E111A5;
	Tue,  2 Jan 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xXiO3cfU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82111195
	for <stable@vger.kernel.org>; Tue,  2 Jan 2024 14:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD13AC433C8;
	Tue,  2 Jan 2024 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704205725;
	bh=aNj2oClbg4rKnyWNfsMlIWP/70u1gfVh2uAz8eTaYXg=;
	h=Subject:To:Cc:From:Date:From;
	b=xXiO3cfUJP45KYttirHK8+EkZapSeG+L1VBz4JokRjm0XnRzCEmBiWheYE/yk3Lw2
	 3/CUy9KsTzvSLoh+UvSPO8ceAIzCcAkX5PXjQB9cq5qjLNh6OyTZFg6Vz6hBqS0Axu
	 w2HaSXv2dS4OzlPmp022IxCjKJhL2fVQFb6DCQ94=
Subject: FAILED: patch "[PATCH] ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()" failed to apply to 5.15-stable tree
To: linkinjeon@kernel.org,lometsj@live.com,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 02 Jan 2024 15:28:42 +0100
Message-ID: <2024010241-define-gangly-9bf9@gregkh>
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
git cherry-pick -x d10c77873ba1e9e6b91905018e29e196fd5f863d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010241-define-gangly-9bf9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

d10c77873ba1 ("ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d10c77873ba1e9e6b91905018e29e196fd5f863d Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 20 Dec 2023 15:52:11 +0900
Subject: [PATCH] ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

If ->NameOffset/Length is bigger than ->CreateContextsOffset/Length,
ksmbd_check_message doesn't validate request buffer it correctly.
So slab-out-of-bounds warning from calling smb_strndup_from_utf16()
in smb2_open() could happen. If ->NameLength is non-zero, Set the larger
of the two sums (Name and CreateContext size) as the offset and length of
the data area.

Reported-by: Yang Chaoming <lometsj@live.com>
Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
index 23bd3d1209df..03dded29a980 100644
--- a/fs/smb/server/smb2misc.c
+++ b/fs/smb/server/smb2misc.c
@@ -106,16 +106,25 @@ static int smb2_get_data_area_len(unsigned int *off, unsigned int *len,
 		break;
 	case SMB2_CREATE:
 	{
+		unsigned short int name_off =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
+		unsigned short int name_len =
+			le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+
 		if (((struct smb2_create_req *)hdr)->CreateContextsLength) {
 			*off = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsOffset);
 			*len = le32_to_cpu(((struct smb2_create_req *)
 				hdr)->CreateContextsLength);
-			break;
+			if (!name_len)
+				break;
+
+			if (name_off + name_len < (u64)*off + *len)
+				break;
 		}
 
-		*off = le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
-		*len = le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+		*off = name_off;
+		*len = name_len;
 		break;
 	}
 	case SMB2_QUERY_INFO:


