Return-Path: <stable+bounces-95100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCC79D76B4
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 18:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D68DBE347E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5410F227B84;
	Sun, 24 Nov 2024 13:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv5qCoQI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD821C19D;
	Sun, 24 Nov 2024 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456015; cv=none; b=FCYgP/ZnBbMje/7i5EiWbkE3OQ5BTLmrkN6eUeFCVYqyK5zOoLDLe9SIA2adgCMNVV4AI7UxbaHSKcAASSeLHr8R8Yossh8ysf3lw6/hGnS6mB5QIpEjvIyjf8DLSFpf5PCbGYsriX3gMtp4rQHSo1qYf2bONwx/dVrPP1vSX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456015; c=relaxed/simple;
	bh=8eDtMxpYkuH4vxN5BukeO7RRsyiwytQ7TOglpbiabXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkXsADap/zsSX2h62EWIKXrxra//UDWzyFEM/ZkgzKydg5MpF9pFMGpjoul1/fbGX//r547rNqZJw6x5zd4Qr42Jgo+ksrHY37HqIum8dC0j1i5yMj18oiONlxpfmB2NpashWsd9N7YcA0Aa93qg7BTcAOwVrEk6N+TeoiZbtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv5qCoQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3367C4CED6;
	Sun, 24 Nov 2024 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456014;
	bh=8eDtMxpYkuH4vxN5BukeO7RRsyiwytQ7TOglpbiabXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xv5qCoQISjdkmQ4cCKh++JpICzZPttq55RAfqJGv0eJfcQnxF1q5yU7n1znTrDcmt
	 bdIU4tzwHeMQttkKnDBhDQRyBIXgaTVKw06WPdu2/UnV2JrrzDkHa3FIgzhpaKR1QR
	 zI+F0LlG7J2GWl1UURNH3X2+jdxbzPDxpDHTQoNNl/hnz9jcoKT3ZY/W5ftaACH5aw
	 v488Hy9yP8hY3FDv5X5pMpYNtLOHlj2SP/FphAri/Ln9fg+azP5e4GQRmMP1o0TiW5
	 EY7+BpgxPgqVQr0WsAQIOwMlCGSqgb659JAOahI05tdrBL2Ocl4IVuaeZuKaI+Fc65
	 9JcqxQcKCL78g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 10/61] dlm: fix possible lkb_resource null dereference
Date: Sun, 24 Nov 2024 08:44:45 -0500
Message-ID: <20241124134637.3346391-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134637.3346391-1-sashal@kernel.org>
References: <20241124134637.3346391-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
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
index 652c51fbbf768..6712d733fc90b 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2698,16 +2698,14 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
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


