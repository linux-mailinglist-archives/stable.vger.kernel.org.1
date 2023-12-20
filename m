Return-Path: <stable+bounces-8063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E0681A45F
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E9128C48A
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF9C4B147;
	Wed, 20 Dec 2023 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGy/qxa3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DF41741;
	Wed, 20 Dec 2023 16:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF5EC433C8;
	Wed, 20 Dec 2023 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703088806;
	bh=0f6TecS6z0bwVRwbJVckiJILRB6ErXUmA+ycnuKtAeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGy/qxa3TPS9Pf8Bc+D8FB3T9dnBXKBoqJgKT9yf8NNnwVP+F6JRoB8hKoHxjjmBb
	 nXNLJdbSzZAjiASlFKy+dte9HVr703ul2C0FBWMqM32z2vhXoOE2P+LEmXsch1AdJi
	 SJ55/Tqap2dux2efGn2g9ybR5M89kWePP7q7bDec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 036/159] ksmbd: smbd: change the return value of get_sg_list
Date: Wed, 20 Dec 2023 17:08:21 +0100
Message-ID: <20231220160932.972444084@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220160931.251686445@linuxfoundation.org>
References: <20231220160931.251686445@linuxfoundation.org>
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

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 4e3edd0092704b25626a0fe60a974f6f382ff93d ]

Make get_sg_list return EINVAL if there aren't
mapped scatterlists.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/transport_rdma.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1085,7 +1085,7 @@ static int get_sg_list(void *buf, int si
 	int offset, len;
 	int i = 0;
 
-	if (nentries < get_buf_page_count(buf, size))
+	if (size <= 0 || nentries < get_buf_page_count(buf, size))
 		return -EINVAL;
 
 	offset = offset_in_page(buf);
@@ -1117,7 +1117,7 @@ static int get_mapped_sg_list(struct ib_
 	int npages;
 
 	npages = get_sg_list(buf, size, sg_list, nentries);
-	if (npages <= 0)
+	if (npages < 0)
 		return -EINVAL;
 	return ib_dma_map_sg(device, sg_list, npages, dir);
 }



