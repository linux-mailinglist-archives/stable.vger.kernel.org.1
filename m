Return-Path: <stable+bounces-111357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECBFA22ECB
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D23A7A26AF
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0DE1E9B0F;
	Thu, 30 Jan 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rv+xKuyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39D1E9B0A;
	Thu, 30 Jan 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246501; cv=none; b=GPyJQsaW2/O5UGXYlqblttrT9PNFAsbcgHvvG0WZ/FgJyZ5/6puOAD862UjYwXcgE0ynkk2HlyoFW06luLQtGI65WmK6glXs/I8mWzrHXRx/NFWGc6BLZHOBVs37IryYCnqc6leLFn1s8LlxDr9yN3mTPZ2wHovJkVv84wMavDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246501; c=relaxed/simple;
	bh=fAURZL/Fn/HsnjWgxI9CqxGi4cxj9vmGDKItVMQxAjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qo+SE44TvMavsddxAjRU6lffh++o2S4C217IfD74cuMrvdPE3Azvzz70RM4yYnsJT3EK/kZXCXc+MY8Ylu0yrsRTxbaQ+vyNdFY/cLbi05rWbhLbWM0UJc9aXqz8AcDfhmvywTi30VkW/wERNvlar3JrCPfQNwNxKGWVAoDTrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rv+xKuyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ADCC4CED2;
	Thu, 30 Jan 2025 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246501;
	bh=fAURZL/Fn/HsnjWgxI9CqxGi4cxj9vmGDKItVMQxAjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rv+xKuybXUbLkGsp5MQyWMlI6V45T0FzIuJJCIakHPolLfockRefwmsYiRS6sdU/Q
	 Vd3xQsGoXFjC7Oa/BMqblgnsc7ZCrDn+04DEWmTz4cbjUO8DU7ptb82oDeSjRL7sJI
	 7JiHDphBIwZIYW7CJ53DH3lbom7h8lIB82ZmcoBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Kun Hu <huk23@m.fudan.edu.cn>
Subject: [PATCH 6.6 14/43] gfs2: Truncate address space when flipping GFS2_DIF_JDATA flag
Date: Thu, 30 Jan 2025 14:59:21 +0100
Message-ID: <20250130133459.475292847@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
References: <20250130133458.903274626@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

commit 7c9d9223802fbed4dee1ae301661bf346964c9d2 upstream.

Truncate an inode's address space when flipping the GFS2_DIF_JDATA flag:
depending on that flag, the pages in the address space will either use
buffer heads or iomap_folio_state structs, and we cannot mix the two.

Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/gfs2/file.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -251,6 +251,7 @@ static int do_gfs2_set_flags(struct inod
 		error = filemap_fdatawait(inode->i_mapping);
 		if (error)
 			goto out;
+		truncate_inode_pages(inode->i_mapping, 0);
 		if (new_flags & GFS2_DIF_JDATA)
 			gfs2_ordered_del_inode(ip);
 	}



