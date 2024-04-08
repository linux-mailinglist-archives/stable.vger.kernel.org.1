Return-Path: <stable+bounces-36917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EEE89C258
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC20281789
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3760C85654;
	Mon,  8 Apr 2024 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="omzVGlMd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890185641;
	Mon,  8 Apr 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582720; cv=none; b=CgbANTqtb/M73ZQsuMKJ6JdmGKkWqJwcEw69tIyKAN19yJczM3fweRf7fWiQMg23Wu4WhLkobT03ousx/9nDwvuC7+Giu8cXfk75BkKp1di7UKzHkxtPr5Dpvgc2zg23hZTiobBCGKowxsneLNynlcT/9sPRWSkX0RU1jnrLoiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582720; c=relaxed/simple;
	bh=jijnplkliz0h+2AFhW+zfks5EhXRqChk7s8VV6X7Yk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHryN24W3M+qjTJ2mnm+e+TQ2oUCJLuTMLTZarWndzKohPLA52MN11zCXFlKeeUU4ajIDgZMBN5wy3Uk7JObDoJ899RlYIl/QqJ4HtoMv1hqjgCDmAlg8Y/rvB1W5EAD6KJ/LZw6uwEem62Mh3lyyV6atp7fZncnZ9cG2bYeM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=omzVGlMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B124C43390;
	Mon,  8 Apr 2024 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582719;
	bh=jijnplkliz0h+2AFhW+zfks5EhXRqChk7s8VV6X7Yk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omzVGlMdfyhS7PlZ9+pRiqlO8a/qB5MRRvGQupdiJLc2gBQjLvNcs9xuUi5Iv1bVb
	 wpIEL1Zxdt22zda26JAwcZqs5W0g6kwA+TMnUjPC+peu0N70WH0+pQmP3JjY/lmAV+
	 uam0bckUFvFoKDwoTJ/qebEnmfy3zQunkIuGFJ3A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 128/138] smb: client: fix potential UAF in cifs_stats_proc_show()
Date: Mon,  8 Apr 2024 14:59:02 +0200
Message-ID: <20240408125300.213501116@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.com>

commit 0865ffefea197b437ba78b5dd8d8e256253efd65 upstream.

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifs_debug.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -648,6 +648,8 @@ static int cifs_stats_proc_show(struct s
 			}
 #endif /* STATS2 */
 		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			if (cifs_ses_exiting(ses))
+				continue;
 			list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 				i++;
 				seq_printf(m, "\n%d) %s", i, tcon->tree_name);



