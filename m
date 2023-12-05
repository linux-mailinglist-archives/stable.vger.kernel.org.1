Return-Path: <stable+bounces-4035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34058045BB
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203711C20C8F
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644866AC2;
	Tue,  5 Dec 2023 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fTAmv5H+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F879F2;
	Tue,  5 Dec 2023 03:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF0FC433C8;
	Tue,  5 Dec 2023 03:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746448;
	bh=le9XKNg7dXT/kvm3AMM6xABDb7hXRyRZyoRq9YoOyL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fTAmv5H+eTb8JMQ08VZINWw9Hta4JyjEgZvQqZYch90JRHonnKFE2IsUlO1a2+4LL
	 OmKcMyJUS3+prbnRYjft78Nr3fYfgEhM9wvZAPrt0ykyNHvoJ5gjpKL/g8ymnFc2TV
	 d9qqijPHAGP4pZqV4u6tM9ND5gV5nObHkAu8umHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 004/134] smb: client: fix missing mode bits for SMB symlinks
Date: Tue,  5 Dec 2023 12:14:36 +0900
Message-ID: <20231205031535.474474291@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
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

From: Paulo Alcantara <pc@manguebit.com>

commit ef22bb800d967616c7638d204bc1b425beac7f5f upstream.

When instantiating inodes for SMB symlinks, add the mode bits from
@cifs_sb->ctx->file_mode as we already do for the other special files.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -748,7 +748,7 @@ bool cifs_reparse_point_to_fattr(struct
 	case 0: /* SMB1 symlink */
 	case IO_REPARSE_TAG_SYMLINK:
 	case IO_REPARSE_TAG_NFS:
-		fattr->cf_mode = S_IFLNK;
+		fattr->cf_mode = S_IFLNK | cifs_sb->ctx->file_mode;
 		fattr->cf_dtype = DT_LNK;
 		break;
 	default:



