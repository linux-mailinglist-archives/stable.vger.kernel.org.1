Return-Path: <stable+bounces-24793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55AC86964B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B33E1F2D9DC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDE1419A1;
	Tue, 27 Feb 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AECtMlmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22A013A26F;
	Tue, 27 Feb 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043005; cv=none; b=DHohfl0QyBd2a5ovnXqciVfcphTZIKsyMV2WenDvdrxry3vloq+MsAxQ+qBPlnAZjSiwAlg/4wg6c9f09ziSqVL20KJPkj38WI+0FErYuBecfrAQIxVXVb1A++p/iXv7JiWERpT6nDN1Gt5rPQfLfdBlV6CMQ1bX4iWHGgXTIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043005; c=relaxed/simple;
	bh=tXRvbxCfe12QiNGkoWVw1iZpaSB0xo0aW0uoIR+t1Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiVxTgOYgHlHQMRhhkJPVDAKDSxyZSrZuGOgjl3HCNnJMdPK9XEpTosllTHmjzQ81EYG2ygRq+klA9lGx+eIOyd8ebjAPb/FX9ube+4X5yw5VmlDkcv/E7/ift5Y3P9vXQ9EGrG3hGRy8HJan6szCd44cwYDUi/fCujkIMxEJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AECtMlmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D807C433C7;
	Tue, 27 Feb 2024 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043005;
	bh=tXRvbxCfe12QiNGkoWVw1iZpaSB0xo0aW0uoIR+t1Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AECtMlmbXCAJFLJ6YrWvqgeGBB5M7yu6x9Y8o0vOiaLdjqF4eTeV6rhpSVbtOTXem
	 hs6OQ/fAgWZMl3w9JAq1HnYjPQsLGIMWDe1ihCzR7FgjqT76tcv+UJONXuUlGbIKSN
	 knePAONGbf/R8/4C4aGad4hoTggRlMTEph7FBoq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 200/245] cifs: add a warning when the in-flight count goes negative
Date: Tue, 27 Feb 2024 14:26:28 +0100
Message-ID: <20240227131621.689852390@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit e4645cc2f1e2d6f268bb8dcfac40997c52432aed ]

We've seen the in-flight count go into negative with some
internal stress testing in Microsoft.

Adding a WARN when this happens, in hope of understanding
why this happens when it happens.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index a8f33e8261344..b725bd3144fb7 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -85,6 +85,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		pr_warn_once("server overflowed SMB3 credits\n");
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
-- 
2.43.0




