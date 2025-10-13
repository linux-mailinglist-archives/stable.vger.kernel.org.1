Return-Path: <stable+bounces-184219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5D2BD2D64
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2048C4F0525
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E06204F99;
	Mon, 13 Oct 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSN2Ar95"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7458944F
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355962; cv=none; b=WpNbfkkCC8TsUblfFGr+6YBvBpeQ3FenxH2KD5+iS2HcrAjIe/bFuWlrVdwJGlOoKVolKtxSsniQhBpQWKkXX3vm+8FzF2qR6SkK7BC7IfpaaSV8Pt5EHXP2sKUPHVyDAeRoWeSyNrjbda4W2ye07WUYAWEJOegW+rHyfFoc8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355962; c=relaxed/simple;
	bh=SrFofuxDQH5XLMWTiwimc0a+8Vo+ECLms3ew9XuTke4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f/nSQJRSVfpu+R9BS/TRmGt65ua2vQc6ZGjf9gnOd0TCjcyAamowKM2lGzyyVYN+mRyRkfmqS6eWx+4WcceFxhoXa3ghuSHvv4EVbShf2DwP7vfJMOvWP+GIqjkbAr8y0cVDtCeTIkthAfBUvUaTTeH5d9FRbylBU/sKQLKAEKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSN2Ar95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62834C4CEE7;
	Mon, 13 Oct 2025 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760355962;
	bh=SrFofuxDQH5XLMWTiwimc0a+8Vo+ECLms3ew9XuTke4=;
	h=Subject:To:Cc:From:Date:From;
	b=gSN2Ar95Ib9B0xsPnMGoRLzsS80UGGgWArf9gAUWzx9tZTFUxUL1OqKUPzfQFwMny
	 GELnLsd2B4V7TLsZwmF6KdyPIrzc6tGfmrEGDjyvoJmzLGt0mZnVVZDjouqAd3XsBc
	 94Ae84+rQBh3NmqRbivAZdJ9J9CSBZ9qHN4Bmis4=
Subject: FAILED: patch "[PATCH] misc: fastrpc: Fix fastrpc_map_lookup operation" failed to apply to 5.4-stable tree
To: quic_lxu5@quicinc.com,dmitry.baryshkov@oss.qualcomm.com,ekansh.gupta@oss.qualcomm.com,gregkh@linuxfoundation.org,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 13:45:48 +0200
Message-ID: <2025101348-drapery-clean-43c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 9031626ade38b092b72638dfe0c6ffce8d8acd43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101348-drapery-clean-43c1@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


