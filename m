Return-Path: <stable+bounces-232194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NmmND//y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB236DE89
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F4B430DF6E2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239CB421EE4;
	Tue, 31 Mar 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="om5RNsQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA03423149;
	Tue, 31 Mar 2026 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976119; cv=none; b=j4dhWNg4pMYzfcYfQbhNrG+xOi+w2Lcf4BuY77FkznNHUwNyia3aD6/7bm4X5s60aAJaUwhyzLI9t0spMA7p75ruKAZR7ImbRMfrGiypfgrhTD9Y3j+z210GigaDtb7nQiyP9RUboAhmi4R73IjKF7Zrnj3DRXPY8CoZd2SmEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976119; c=relaxed/simple;
	bh=z+0ltH223pVM473NXM5FacEZNE8DLzZSjE+gRYjcJHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9rXT4rkcmPojWSANNU42Fgx2WR6h6fBekulo3fi6U7mxyl15p9FXRAsMr+GlCeHWRm/4aJVb2HTXoNZymykZPBp0DPrt2khHiSTLbGh63w5l68Yf/uv6QIv0LmTmDeHEZh9s4vtK3BH+ne7ktNzwK5JSqcTFoONk/dTqeW3LcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=om5RNsQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A7BC2BCB1;
	Tue, 31 Mar 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976119;
	bh=z+0ltH223pVM473NXM5FacEZNE8DLzZSjE+gRYjcJHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=om5RNsQVqxM355VngN4NyrELvXRpt+IWd/a4GyunHrC+cYKSozZsq+9AV/xwptwVV
	 IwgMr1Q0vUzxLlKlCwRHIEk7m4SCPGfqnAw/nGoZ0XFtnUEqlJjw20yWRn6JSuI+W5
	 x1iu3WmKV3FJyFk/5wQnr8mCAlVMhfYGOJwe7eM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Darrick J. Wong" <djwong@kernel.org>,
	Long Li <leo.lilong@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12 181/244] xfs: dont irele after failing to iget in xfs_attri_recover_work
Date: Tue, 31 Mar 2026 18:22:11 +0200
Message-ID: <20260331161748.442745756@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232194-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 63DB236DE89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Darrick J. Wong <djwong@kernel.org>

commit 70685c291ef82269180758130394ecdc4496b52c upstream.

xlog_recovery_iget* never set @ip to a valid pointer if they return
an error, so this irele will walk off a dangling pointer.  Fix that.

Cc: stable@vger.kernel.org # v6.10
Fixes: ae673f534a3097 ("xfs: record inode generation in xattr update log intent items")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_attr_item.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -658,7 +658,6 @@ xfs_attri_recover_work(
 		break;
 	}
 	if (error) {
-		xfs_irele(ip);
 		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, attrp,
 				sizeof(*attrp));
 		return ERR_PTR(-EFSCORRUPTED);



