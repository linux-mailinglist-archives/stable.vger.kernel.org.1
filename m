Return-Path: <stable+bounces-159714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13470AF7A01
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669244E35D5
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B532ED871;
	Thu,  3 Jul 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sdBiZc0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55F02E7BD6;
	Thu,  3 Jul 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555110; cv=none; b=raIA2da2El3/IQrsZAQaOmPHDe0NToi+0/YDbNLX71CGReOsHnH2EX7pr0lH8o35HtjUX0pT5qf/v16fMf49oopM5tnYqvgiWXea3X4csHE2AlkmAQ5nQgC0Tyv6eYcn09BLkZhWQIYQjitpeiNuwq/i5eOHz2af5LIg7IabFHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555110; c=relaxed/simple;
	bh=P+f8shwlC7MiSebNs3Oa7YVZMCeBIuLq85UJq9RwCsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n75P9HyYcOmyWe1cQkGV98Yp9sFnBFALj3oHNkiUrq2igi/kkfa3R5l0XJ1ayzRdIHYMw7S4GZsL/6s9/cmMJ1LF91q7HhCKxSZQuD6c3/aTMDsqRYx0rjjvZaqmFDNTTYQ5nDaF1EhApXWHocEeRyS4lTi58wNZ9loWpOc7hU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sdBiZc0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD3C4CEED;
	Thu,  3 Jul 2025 15:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555109;
	bh=P+f8shwlC7MiSebNs3Oa7YVZMCeBIuLq85UJq9RwCsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdBiZc0Fsv75/idpo1cvm+zWHKNU8rXm0IYaKgm508W5OzBAFVdwdXXxt2QrCJ0Vp
	 wQ8QEkfsDz/xN+patFS/KqkbKleCEe5PTbgr/M+pgPTyUI7GxTg8CR+cRkGcC9U5wa
	 rLfp8kPk0GigV3UC9I2nq9Uu5kPIdWPsLMp2jm2c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heinz Mauelshagen <heinzm@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.15 178/263] dm-raid: fix variable in journal device check
Date: Thu,  3 Jul 2025 16:41:38 +0200
Message-ID: <20250703144011.478663096@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

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



