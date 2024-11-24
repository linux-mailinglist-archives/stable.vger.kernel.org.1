Return-Path: <stable+bounces-94916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EB9D713B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08FDB3E8D1
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DAB1B3925;
	Sun, 24 Nov 2024 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8NfbkSJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4418A921;
	Sun, 24 Nov 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455227; cv=none; b=JdY6w///5KPybzscrw8Gq60w98yGfxmPE2PxVeta1C7iS3UktdQgbx0HOxRTEDrW6MGYnb1oitXfDJotV9EhJeyoCIRxjuYPcsNx+KL3+Byh6rw+f5ruNYn/uocu/4eACQZNPd+l6r78tREWIj571uGWTkRmMPdPVxxr0K0v8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455227; c=relaxed/simple;
	bh=j/EBlPHv7AaXJAE74y29GG/YwHsapybQ0+H1ZU8HR8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZE4S6bQ6NRP+H62ilICkz1y/KuMDT520Xfwmr5qqYKNTnrYw+SJfMmcTZAcSTVQn1b0tEzrdDFi3RkM5obBTVVRVIIvHSOYOYaBNjU/pz/lXx47rFjvk2N/IaDWn4vf3KV0Jg/qlZvp9S49ioZ+GJ9srU79U5B4Oic2OO6nBmYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8NfbkSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FE3C4CECC;
	Sun, 24 Nov 2024 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455226;
	bh=j/EBlPHv7AaXJAE74y29GG/YwHsapybQ0+H1ZU8HR8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8NfbkSJZx4GfedO3OF9NjTX1HleqZy+2chm+/JPRGx5Gp2lFHGMT1/wrMfbiXawH
	 f54VfUKQC5QQCQPm4hLhpJgRQ61TlAFhu41p1DQ3CyTb45I7gAV+8W9ZOv1uA11Fgc
	 ZXgRQJhEdn+bZ2pE8mvUsF6BTVJhileMyQJvWiCVK4NWtWKe+SCXcX/KNh9oXBjhMU
	 YelC5MW2Q3GBGmstoz4DUaqfzGmfly5GZr1fTSQ4GbeXExiOPb45I+G3ma9yaWcY50
	 MMHtayUxmpc43Rb7lODHXx4z4+xIsGsvn8tJyGqUooYWOXp3mjqV50mMp/yUMVVi7W
	 I477KXk+NBx9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 020/107] dlm: fix possible lkb_resource null dereference
Date: Sun, 24 Nov 2024 08:28:40 -0500
Message-ID: <20241124133301.3341829-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 865dc70a9dfc4..dddedaef5e93d 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2861,16 +2861,14 @@ static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
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


