Return-Path: <stable+bounces-250034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOXkIQDrDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:10:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13228593059
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C325D312094B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1A39B4AE;
	Wed, 20 May 2026 16:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vLF9/R3C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7033A3E60;
	Wed, 20 May 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294370; cv=none; b=DmpOPGMAN/H2IJJYQ8X+/29O5N10ITfh08PPnv9EhJlYPZS8OipPr2Df0mcLHCdETksgeWqRhdi6y/9pyi6vmzZCOOzaxvSYgR44NitW3XuxXUftVR5NCxg0FimgpcdSEkPe/k5eqqTMDP6CWOAXemginSLssvtq4AOYooG49oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294370; c=relaxed/simple;
	bh=iGwlHlO9GVE8o4fq6CKKqMJ9Hk9fnHDdU0b7u/xZtgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmwaWE322M/mxeszglB9Rvt3L1LozIgCc59R70Us2+2+DPKEvkPJZ6ZIbf6R4oGZYfDbt6CgkcUYBAjyagZbRwGcMq17P1DgDm9gy3YW9oTkoWyIatVE3Wqfwf8ZUgkCIRZMG9Cejgkd2PLpXU1EQPS9CxqBCBIupReJqXTI0Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vLF9/R3C; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187B11F000E9;
	Wed, 20 May 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294368;
	bh=elM+aLhycjVa3os88sokOqRaNxE7y/E/iERILg81htk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vLF9/R3CP8bEp+BKZgmmUk2lNCJvEhVzUnJxDmwx/iznELP0UGWLK6xPfhL+WXikd
	 pphqZrZaBEyg1XU0C3KXo7QGhw/q5RBHOQfuuQHBrntUbygjfpBI53Sb4RnypA3wBD
	 UTsqn7Penhs0u6FNxwKn6Vs1FK4O17qRJGWPtGJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0014/1146] erofs: include the trailing NUL in FS_IOC_GETFSLABEL
Date: Wed, 20 May 2026 18:04:24 +0200
Message-ID: <20260520162148.713679169@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250034-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vivo.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,xiaomi.com:email]
X-Rspamd-Queue-Id: 13228593059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhan Xusheng <zhanxusheng1024@gmail.com>

[ Upstream commit d6250d49da4d8f11afc0d8991c84e0307949f92e ]

erofs_ioctl_get_volume_label() passes strlen(sbi->volume_name) as
the length to copy_to_user(), which copies the label string without
the trailing NUL byte.  Since FS_IOC_GETFSLABEL callers expect a
NUL-terminated string in the FSLABEL_MAX-sized buffer and may not
pre-zero the buffer, this can cause userspace to read past the label
into uninitialised stack memory.

Fix this by using strlen() + 1 to include the NUL terminator,
consistent with how ext4 and xfs implement FS_IOC_GETFSLABEL.

Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Fixes: 1cf12c717741 ("erofs: Add support for FS_IOC_GETFSLABEL")
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chunhai Guo <guochunhai@vivo.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4b3d21402e101..a188c570087ae 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -351,7 +351,7 @@ static int erofs_ioctl_get_volume_label(struct inode *inode, void __user *arg)
 		ret = clear_user(arg, 1);
 	else
 		ret = copy_to_user(arg, sbi->volume_name,
-				   strlen(sbi->volume_name));
+				   strlen(sbi->volume_name) + 1);
 	return ret ? -EFAULT : 0;
 }
 
-- 
2.53.0




