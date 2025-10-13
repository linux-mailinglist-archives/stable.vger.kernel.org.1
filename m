Return-Path: <stable+bounces-184218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF19BD2D61
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DC189D9EA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9B1F78E6;
	Mon, 13 Oct 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CABqVTn5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE8944F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355960; cv=none; b=Uo1SLNhBW3OQlywuMAvNE70S+Yx5CG0SBi1h6FA5Dk3cbdQZeUedIydUMOzKxVgvkEhIyEAtA66bVk3Oapo6WtDTpHMLMsk6J9ImGp/hFFrZoKMtIQbyjKhq5VNNQiJsZd6jXFa5MwhRnHohMdy6/FNE+yez9zDrBsb7p94LbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355960; c=relaxed/simple;
	bh=/53ED3EwKP16ijAi1Fbn54EF4/catrtkFCnTMCPOa7w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ClBO49ZLwbU+J17zxI3sxBbwDUBziQKe8ymB9KEOF3qa64w8saEm0SGUUYx/Cs+an5CslSA8Em+nOBazwPDmw6i0wrIjAI3f+f+uNCqqh1fPMj//eM9pEnT38SrIyBMetALfNv/JHz+pOe9TuXKtwSAYldcDUEOQd5ERDF5sW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CABqVTn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2E8C4CEE7;
	Mon, 13 Oct 2025 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760355959;
	bh=/53ED3EwKP16ijAi1Fbn54EF4/catrtkFCnTMCPOa7w=;
	h=Subject:To:Cc:From:Date:From;
	b=CABqVTn5vyo2NQue8UrmuFX3RcA00lVDSLVOq8pvsa7xNZiPc0lAN2xjx4JZ5BAbw
	 iF56H972ofbJCvwD4eT+w40uK7XUrlOsVTtfY6NfIAQR66vvzKe4J2v5I02pO5OCiq
	 rdG9C/67g4Xna2GS461yeDjW07G++3/+eNPCDA8I=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix fastrpc_map_lookup operation" failed to apply to 5.15-stable tree
To: quic_lxu5@quicinc.com,dmitry.baryshkov@oss.qualcomm.com,ekansh.gupta@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 13:45:47 +0200
Message-ID: <2025101347-concept-litigate-de3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9031626ade38b092b72638dfe0c6ffce8d8acd43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101347-concept-litigate-de3c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9031626ade38b092b72638dfe0c6ffce8d8acd43 Mon Sep 17 00:00:00 2001
From: Ling Xu <quic_lxu5@quicinc.com>
Date: Fri, 12 Sep 2025 14:12:34 +0100
Subject: [PATCH] misc: fastrpc: Fix fastrpc_map_lookup operation

Fastrpc driver creates maps for user allocated fd buffers. Before
creating a new map, the map list is checked for any already existing
maps using map fd. Checking with just map fd is not sufficient as the
user can pass offsetted buffer with less size when the map is created
and then a larger size the next time which could result in memory
issues. Check for dma_buf object also when looking up for the map.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Cc: stable@kernel.org
Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://lore.kernel.org/r/20250912131236.303102-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 52571916acd4..1815b1e0c607 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -367,11 +367,16 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	struct dma_buf *buf;
 	int ret = -ENOENT;
 
+	buf = dma_buf_get(fd);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
 	spin_lock(&fl->lock);
 	list_for_each_entry(map, &fl->maps, node) {
-		if (map->fd != fd)
+		if (map->fd != fd || map->buf != buf)
 			continue;
 
 		if (take_ref) {


