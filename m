Return-Path: <stable+bounces-154201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2DDADD8AA
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57BB1944597
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE52EE602;
	Tue, 17 Jun 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wa4BnRoL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210F2DFF32;
	Tue, 17 Jun 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178429; cv=none; b=FTeQHzBLW2v+/XPHh2BD05kjcIUHpq65kezeqVmIDWiyl+85hJ8r/JODg/dRsmacY1NXJK4eAjEHt/aEihMchlnd/dNhD0W0+kf+Oljpn7A38EZZb2vzrZtPfqlN+PhkOtg0O0Krg6cnta4WVesmaHky0FoptXuuZDCaiEPw9ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178429; c=relaxed/simple;
	bh=qTrNK0NnX3vT7Qvy9hUZM4htgFtyx9yC/Q0KMPms4kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYytPfwGiDDwIIbJav67PzfJmX3E5MAJFXue4DC/frAjkN2D9h5v11D1l8KhxKLZtaHWh1++Pcz+dTDMS2CCo3HZzr0DWz/xAvcgI40cf9Pun2tJD7W6e1zsxL8gX6TTFjhSRSqYONUaHqICRbHlLILdBj2H+H785Tzh3BnPESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wa4BnRoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ADBC4CEE3;
	Tue, 17 Jun 2025 16:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178429;
	bh=qTrNK0NnX3vT7Qvy9hUZM4htgFtyx9yC/Q0KMPms4kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wa4BnRoLajLRC2sA8SYv5KMvFWx5fZDUdfGgLkd7cKTghrBtbeKiLozHh6mZeyQXU
	 cdTFw9bmrcd2c27LPTTP5dyYUT2LisnhFP7wt+poObrBtq+fI4ImOzKhFjH+35GAQP
	 tJ+xanIEeR50htG9q4h1YxLEj9pQmzk8T2wtKPOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	v9fs@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.12 498/512] 9p: Add a migrate_folio method
Date: Tue, 17 Jun 2025 17:27:44 +0200
Message-ID: <20250617152439.800755173@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit 03ddd7725ed1b39cf9251e1a420559f25dac49b3 upstream.

The migration code used to be able to migrate dirty 9p folios by writing
them back using writepage.  When the writepage method was removed,
we neglected to add a migrate_folio method, which means that dirty 9p
folios have been unmovable ever since.  This reduced our success at
defragmenting memory on machines which use 9p heavily.

Fixes: 80105ed2fd27 (9p: Use netfslib read/write_iter)
Cc: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: v9fs@lists.linux.dev
Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250402150005.2309458-2-willy@infradead.org
Acked-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/vfs_addr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -160,4 +160,5 @@ const struct address_space_operations v9
 	.invalidate_folio	= netfs_invalidate_folio,
 	.direct_IO		= noop_direct_IO,
 	.writepages		= netfs_writepages,
+	.migrate_folio		= filemap_migrate_folio,
 };



