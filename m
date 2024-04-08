Return-Path: <stable+bounces-37372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4987189C495
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7361F21D30
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9871CD21;
	Mon,  8 Apr 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0kQ6TIG1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150C7E118;
	Mon,  8 Apr 2024 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584040; cv=none; b=RA5qevv0Xdh/P2Xq8LBuAXBFb2SyOfjl2UQ919epk61zETdUh/EsnlSTd9lCcG20IVPu8R4+Oq5jpu5YUia7Tw8JuO3pyS+zkGvAmZUNLYk6PQdZ4uVU0d7uKN4FIruxjZ87uQ7q3PxAtxrMuvPvUJ5MlHVYmpiwoGJEbjrAWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584040; c=relaxed/simple;
	bh=9xWntgzwNwXvZVR5dhr+SDxY5AB1u2+IcG7DTjZv/FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3D1kJmw0tE8j/qJXzKO2Yuxr4d4+ZYrxFynrMwpyQiiC2QVwRfMcXrI0NjpcSRcs+Hg8U7KIK6pRGdRnsmFmLoU0Lu/Bhxv3QX8zrUA+B7JO8Sp9J4WXTISB0LwNrbhln+LqAqZeL+aXV+9lDGNZCIjBWocda1FYzTPKPStiVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0kQ6TIG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CF7C433F1;
	Mon,  8 Apr 2024 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584039;
	bh=9xWntgzwNwXvZVR5dhr+SDxY5AB1u2+IcG7DTjZv/FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0kQ6TIG18bO48szu2cZBLySWLmD03NtRkVtIiv0bxHJOyukZlGDLNRFyTvVxxJJSD
	 XRD3Zqz+PxVT8IHjsmtraLVghNGna5UgHYfpHPBLtM34I3fZElqOgfl6MI0gBT+o65
	 YU3rfE39nIDOPFrmpOPxJpIKlVbvc0Sgf2vd8YMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.8 252/273] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Mon,  8 Apr 2024 14:58:47 +0200
Message-ID: <20240408125317.274997517@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit 58acd1f497162e7d282077f816faa519487be045 upstream.

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/ioctl.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -247,7 +247,9 @@ static int cifs_dump_full_key(struct cif
 		spin_lock(&cifs_tcp_ses_lock);
 		list_for_each_entry(server_it, &cifs_tcp_ses_list, tcp_ses_list) {
 			list_for_each_entry(ses_it, &server_it->smb_ses_list, smb_ses_list) {
-				if (ses_it->Suid == out.session_id) {
+				spin_lock(&ses_it->ses_lock);
+				if (ses_it->ses_status != SES_EXITING &&
+				    ses_it->Suid == out.session_id) {
 					ses = ses_it;
 					/*
 					 * since we are using the session outside the crit
@@ -255,9 +257,11 @@ static int cifs_dump_full_key(struct cif
 					 * so increment its refcount
 					 */
 					cifs_smb_ses_inc_refcount(ses);
+					spin_unlock(&ses_it->ses_lock);
 					found = true;
 					goto search_end;
 				}
+				spin_unlock(&ses_it->ses_lock);
 			}
 		}
 search_end:



