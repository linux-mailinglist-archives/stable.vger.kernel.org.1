Return-Path: <stable+bounces-95021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC579D724C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE171632BC
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59A1F76D2;
	Sun, 24 Nov 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKOWx9vz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969A61F76C8;
	Sun, 24 Nov 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455702; cv=none; b=XIwDB5grSv9XyRwyw4nw9FPfD8TxqHGgkVE0fIZhCRaIIXBq+thOhDkMrlnXUQsFTPtzoY0nWO66lMuQHvxsZzFRshwReLEl9CLGd74iGx5tXEH3si0TRfSXjiHvY+qKVgrILwr0sGGR0jS9/SakfzWdASKF3HlO0c1S0sMcfi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455702; c=relaxed/simple;
	bh=fKs88F/Jk2nLNm6RnXizYQPkispFU+XqVnCT6wSnsR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prizGvEVWd4A05qAhmqDvfMgpAPKb5YXfypu7c/hRiFQ3imGp6AmwmHwvzCh2XoFN67do0dCz4Zr8qsaloKKtdyvPhofKxkbxofxj3yNTxapAJPJKu+aKaf08RfCooOTg1uW9mi290oo1smnis+5L4DTdGOsJiqW6P6g5fT2PRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKOWx9vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62A7C4CED6;
	Sun, 24 Nov 2024 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455702;
	bh=fKs88F/Jk2nLNm6RnXizYQPkispFU+XqVnCT6wSnsR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKOWx9vz6Ws09dlUK0RpCpUCGSBRxq0Ao0vVCVlLf4mVlGpIUtp1qbllKsNB0Xkqv
	 zb+RyFs95EpDvE3qX2eX1oy0PtPZLJFwMKEylkhRdRSgIpbAlxvBKBXMQX0WbCrSjz
	 t6U9DzIupChIMJoAgb7EPUBrKtSZt5iNlcWwoLC8b8Q4ArjtB8tLO6kdtpI1VMI1HB
	 eGWNXyY2p/u0UTXpBTiKUdplrfq6ayJerO7Qdribcbr9+qGhwzpDqji3/fK4SeD1Ml
	 6AMaSKSHuEGX6KVOov+qypWFzPmyIdgZyMllzpiGkmvW3zSYIf0mDPkW8iZlb/D4gX
	 esjByRgZc3NsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 18/87] dlm: fix possible lkb_resource null dereference
Date: Sun, 24 Nov 2024 08:37:56 -0500
Message-ID: <20241124134102.3344326-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit b98333c67daf887c724cd692e88e2db9418c0861 ]

This patch fixes a possible null pointer dereference when this function is
called from request_lock() as lkb->lkb_resource is not assigned yet,
only after validate_lock_args() by calling attach_lkb(). Another issue
is that a resource name could be a non printable bytearray and we cannot
assume to be ASCII coded.

The log functionality is probably never being hit when DLM is used in
normal way and no debug logging is enabled. The null pointer dereference
can only occur on a new created lkb that does not have the resource
assigned yet, it probably never hits the null pointer dereference but we
should be sure that other changes might not change this behaviour and we
actually can hit the mentioned null pointer dereference.

In this patch we just drop the printout of the resource name, the lkb id
is enough to make a possible connection to a resource name if this
exists.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lock.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 8bee4f444afdc..5974567260cfa 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2859,16 +2859,14 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
 	case -EINVAL:
 		/* annoy the user because dlm usage is wrong */
 		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %d %d %s", __func__,
+		log_error(ls, "%s %d %x %x %x %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 		break;
 	default:
-		log_debug(ls, "%s %d %x %x %x %d %d %s", __func__,
+		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
 			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
+			  lkb->lkb_status, lkb->lkb_wait_type);
 		break;
 	}
 
-- 
2.43.0


