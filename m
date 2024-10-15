Return-Path: <stable+bounces-85735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAE499E8C9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AEB1F20CE2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF241F7097;
	Tue, 15 Oct 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZO0pmzgl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9BF1F4FDC;
	Tue, 15 Oct 2024 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994120; cv=none; b=VNXrQ8Or1NlN3+nbVonOOrtpXQekA++CRDYPVFvDG1poG8v6f0IumvvafHbJZ2RzBwZBtepSTnEGcOFCNtOgdl+LMrAioeEQ39nLkj6tlhdGjHKsfeN2EfIIhak2GctwEppBWTp6JQVxIqAw0RYIkHEZxdPPPiBWkgo9NLQgKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994120; c=relaxed/simple;
	bh=LGMPO67fgTt8t6pOLDeItbIrmKbusSS1+we7lAVfmBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=loCY9OaopO89L3xab+Fe19M6MaN2dciv6cFNXwZXAPRifrhHvhJBsYx0vo/kXSUJjY1ijmhI1P7oDQYUOSAGcjkqxXtIH7WJN+EEjxsd87XOwwCKi+YHGshg6CyO3bKPsxI7LdUp9Md9MYw/meiLKMCX7b4SE7cXlHiaG5ByBlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZO0pmzgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1747C4CED3;
	Tue, 15 Oct 2024 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728994120;
	bh=LGMPO67fgTt8t6pOLDeItbIrmKbusSS1+we7lAVfmBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZO0pmzglojQvlgPXo5RPRYRCvahUzrl/aXOak6k47ogOM+OeUdQzuDjcepiKmYjFc
	 8uAryVqQfaKEfI+O9F0y1v6QufBQ+q4AaVflOJ1PhGIQMmmMGtYmjpXvZ7vvBRJ98+
	 6REEJQwb+luOU3KZgOt/65jgOfHNN4ilX+bE0rf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yunke Cao <yunkec@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 612/691] media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()
Date: Tue, 15 Oct 2024 13:29:20 +0200
Message-ID: <20241015112504.626930816@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Yunke Cao <yunkec@chromium.org>

[ Upstream commit 6a9c97ab6b7e85697e0b74e86062192a5ffffd99 ]

Clear vb2_plane's memory related fields in __vb2_plane_dmabuf_put(),
including bytesused, length, fd and data_offset.

Remove the duplicated code in __prepare_dmabuf().

Signed-off-by: Yunke Cao <yunkec@chromium.org>
Acked-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 30c8497f7c118..b66e80e6924e5 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -302,6 +302,10 @@ static void __vb2_plane_dmabuf_put(struct vb2_buffer *vb, struct vb2_plane *p)
 	p->mem_priv = NULL;
 	p->dbuf = NULL;
 	p->dbuf_mapped = 0;
+	p->bytesused = 0;
+	p->length = 0;
+	p->m.fd = 0;
+	p->data_offset = 0;
 }
 
 /*
@@ -1280,10 +1284,6 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 
 		/* Release previously acquired memory if present */
 		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
-		vb->planes[plane].bytesused = 0;
-		vb->planes[plane].length = 0;
-		vb->planes[plane].m.fd = 0;
-		vb->planes[plane].data_offset = 0;
 
 		/* Acquire each plane's memory */
 		mem_priv = call_ptr_memop(attach_dmabuf,
-- 
2.43.0




