Return-Path: <stable+bounces-159449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35725AF78C7
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288CC1C88031
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7D02EE96B;
	Thu,  3 Jul 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y5asgPHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAB2EAB69;
	Thu,  3 Jul 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554271; cv=none; b=RYng8Xf/neNcrRGTqFutnRSfd7FOZxfkRr+zl1uhSnS1HjdzABMgUjhESthW/+xqeb94ShM0qsSRMTodfZevlSGw57f+UF7x14iR9XzP7wseMZ1yArTsgcPiGPYHmvzzLz8rm04m4LLuvHHzCcykjAn+z5EFsRRQhlPZGeX30YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554271; c=relaxed/simple;
	bh=j/jnPqZTUQsStZbjoXGmOuLTT0gl/3iNy5eykUekbbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJWLpCVOEnvXyBIb/2fTYVXbgzjiifuwRg6KmDQ22h6hLoblHZDimp2Svv3QDD7Us1t3JlDPbEgNxuQFOyQkZEImHnshPbZWRs2aXS4AEdqJKlk7qWRirHNNYVSVW69FCQ83dzfyeABN8BwQB8sDnHIEJdQY4AdHl7+NNBl3rKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y5asgPHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8CBC4CEE3;
	Thu,  3 Jul 2025 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554271;
	bh=j/jnPqZTUQsStZbjoXGmOuLTT0gl/3iNy5eykUekbbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y5asgPHWHT+SWCpaIyreaSVDe7QxpdaGaxQEFFYGSMpQkC2tZDQ7XvcLp+0ogJtud
	 YkRJwVLXJIURpBST2WxNXrAIp1kQjnL2GXb7XVEdGC3MRBwHdt3pQTo8DALVCPHEEY
	 Xq57MMGISzDhqH00DmF/1jAFOkq9Vq56xhqNWnDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heinz Mauelshagen <heinzm@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.12 134/218] dm-raid: fix variable in journal device check
Date: Thu,  3 Jul 2025 16:41:22 +0200
Message-ID: <20250703144001.472676743@linuxfoundation.org>
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

From: Heinz Mauelshagen <heinzm@redhat.com>

commit db53805156f1e0aa6d059c0d3f9ac660d4ef3eb4 upstream.

Replace "rdev" with correct loop variable name "r".

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 63c32ed4afc2 ("dm raid: add raid4/5/6 journaling support")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2410,7 +2410,7 @@ static int super_init_validation(struct
 	 */
 	sb_retrieve_failed_devices(sb, failed_devices);
 	rdev_for_each(r, mddev) {
-		if (test_bit(Journal, &rdev->flags) ||
+		if (test_bit(Journal, &r->flags) ||
 		    !r->sb_page)
 			continue;
 		sb2 = page_address(r->sb_page);



