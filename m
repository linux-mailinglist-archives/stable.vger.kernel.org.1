Return-Path: <stable+bounces-159465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFDDAF78BC
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0A35651D2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E82EAB70;
	Thu,  3 Jul 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uC6UZPRd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203819F43A;
	Thu,  3 Jul 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554318; cv=none; b=auw+WuN0qwAjKWO3TV71mZCcGc/dr6o76fSkt30UEeZqxUNUuSdUo4YQ55HCy31fZgHmAm+E4WlDH5WiOuDPiIi8xzKi1cM4+ONyNIdWWlqhj/gdMkxl0Of2hu2hqaMDFv4O6exni0G2g+zDGy5d9AVpu1gpyQAP0k32noc+vc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554318; c=relaxed/simple;
	bh=6lgh4b0rr5pqpOWKdnkeRkdXMdBwVrgwFtbkk3fP1m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thtuI5UEc1d0R5d5jrVwxntxUMwpeE/7E1ET4WQHzrbj/yBBSDZmhPCsBC9nkHdDfATXarwYE+P0oDqoNii2oll05A4gKkn/rDZ26Aj8uMcHspMJmIFKy//HdS7IGe1XMjFNVNOcazcHGuqsRIAksUuKvIgr1fguY9aYr1/amZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uC6UZPRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D11C4CEE3;
	Thu,  3 Jul 2025 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554317;
	bh=6lgh4b0rr5pqpOWKdnkeRkdXMdBwVrgwFtbkk3fP1m4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uC6UZPRdb8qPDk/Nu9Wu72DxPOcgfvFUf7tW+4a/AZ7cf1JvO9Nj/gux2VLAhjhkx
	 QEGvzVpQEWa5IM/W3YC8/qC184JsTGMKwzhds5J9zsyTIg8SAlfpgR0hGlnE76aB+l
	 ybsBHhjQLXvKdNCdDyM+unU4bUprdh4l+4KITOW8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.12 148/218] drm/ast: Fix comment on modeset lock
Date: Thu,  3 Jul 2025 16:41:36 +0200
Message-ID: <20250703144002.059245614@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
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

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 7cce65f3789e04c0f7668a66563e680d81d54493 upstream.

The ast driver protects the commit tail against concurrent reads
of the display modes by acquiring a lock. The comment is misleading
as the lock is not released in atomic_flush, but at the end of the
commit-tail helper. Rewrite the comment.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 1fe182154984 ("drm/ast: Acquire I/O-register lock in atomic_commit_tail function")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.2+
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://lore.kernel.org/r/20250324094520.192974-2-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ast/ast_mode.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1319,9 +1319,9 @@ static void ast_mode_config_helper_atomi
 
 	/*
 	 * Concurrent operations could possibly trigger a call to
-	 * drm_connector_helper_funcs.get_modes by trying to read the
-	 * display modes. Protect access to I/O registers by acquiring
-	 * the I/O-register lock. Released in atomic_flush().
+	 * drm_connector_helper_funcs.get_modes by reading the display
+	 * modes. Protect access to registers by acquiring the modeset
+	 * lock.
 	 */
 	mutex_lock(&ast->modeset_lock);
 	drm_atomic_helper_commit_tail(state);



