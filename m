Return-Path: <stable+bounces-9229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7FC8225EE
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 01:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B83B28463C
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11EF36D;
	Wed,  3 Jan 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmlhH5D6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE47364
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 00:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479E5C433CA
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 00:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704241758;
	bh=kxfwKYt+hEkj7gYJnIe4RDLWgUV1ATQ7v7O6ddUgemg=;
	h=From:Date:Subject:To:Cc:From;
	b=FmlhH5D6f+3NRQ/4aWD9TXZzbgcD2RP0/jy8UajyTT1v2AUEYyYWP4Bcw6kOZzR9X
	 KKWJKAZ9PyKuYKijNqWcym11JypZmODKe5wHsgHkj1hREf+ZFOIdDzJMj5dJWEpSXQ
	 wmYPejzcSay7ZoZre2GoOrWCpQcv4BtyD26tnwFPhoR9Xz/Kl9C2jN3vgwe0AGd4Tt
	 GJcdMQtOskJcXVdetOSjMzSzbZs/K41xNNV3xpmGBTX2KzPbgT63fR7IZdh4pV+H4o
	 Tha+tYYfKUgDzdL7HOQ05Cyqx5XIXEfB4mochYy3pguPEVaY0gv1Syc+e6viW2yIC/
	 XWf58rTpODoWA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc20b4595bso2866993a34.0
        for <stable@vger.kernel.org>; Tue, 02 Jan 2024 16:29:18 -0800 (PST)
X-Gm-Message-State: AOJu0Yya0bCNPTLMn9sjnyiUS8x4+CnhvbleMeULr2CHWdHr/u+0s0wV
	zLh5TjZuK4hqnopEoKBOf2gbvLYGR9yWUaukBws=
X-Google-Smtp-Source: AGHT+IEF7lI/f1VMA5bxWdVjxw3wO+4a/39VOFTNgW6aydlVwIUwSsHkIfnLDiZr2dhJxxYdamNisB0xZ9RDxdvrpNU=
X-Received: by 2002:a05:6830:2784:b0:6dc:3dae:dcb9 with SMTP id
 x4-20020a056830278400b006dc3daedcb9mr4253773otu.28.1704241757564; Tue, 02 Jan
 2024 16:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:d42:0:b0:511:f2c1:11ee with HTTP; Tue, 2 Jan 2024
 16:29:16 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 3 Jan 2024 09:29:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9kQaQYwBuc_=gMi2mKz3aggjxDvkbTCtYM_oJ5i0Rq4Q@mail.gmail.com>
Message-ID: <CAKYAXd9kQaQYwBuc_=gMi2mKz3aggjxDvkbTCtYM_oJ5i0Rq4Q@mail.gmail.com>
Subject: [PATCH 5.15.y ] ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()
To: gregkh@linuxfoundation.org
Cc: lometsj@live.com, stfrench@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit d10c77873ba1e9e6b91905018e29e196fd5f863d ]

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
---
 fs/ksmbd/smb2misc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 39e523f115d2..4d1211bde190 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -107,16 +107,25 @@ static int smb2_get_data_area_len(unsigned int
*off, unsigned int *len,
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
-- 
2.34.1

