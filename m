Return-Path: <stable+bounces-117625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9991DA3B7E6
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722CA3BCC39
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695A71DE4D4;
	Wed, 19 Feb 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pLvTJyKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F917188CCA;
	Wed, 19 Feb 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955870; cv=none; b=MgnE05NN3bc2Lkw83i5rERqjHicpZfeoY88L7RQDrC4rteMxX31MqSVrExF30pvv0Eynuc6+FYKLCcji9IL7LWhup41/N6gSzciRm5UNaVEqg6aMOJZrwrD9cIbK3Szgokvy8eDLDNGWaz4Gt4uiERP5Mb+uB1GfuWjboa0X1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955870; c=relaxed/simple;
	bh=djru/d3PNXvx5dHChTIonw9qLAsuwBfw8tk4fWiCe5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptWD2b1s0sHv+NzufcOuBCxyC7/KtOko64pD19aV8D366/0pnAAR2Q1kH6Jot012OEAJPy8GhfZCNMYzc7Y3feTvASw1HvouL0rjJQT3m6Kjo2RBicQRgQdivKtgNrSUFE6uHHjBWNDlzyE25u5CIC0+1sKz2MPMASNIlPq+wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pLvTJyKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C372EC4CEE7;
	Wed, 19 Feb 2025 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739955870;
	bh=djru/d3PNXvx5dHChTIonw9qLAsuwBfw8tk4fWiCe5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pLvTJyKVDfgLUS2zNLgScImqrDeV/anRa+MxDWI8+Ek8BJCHrGRkneuWyYBdQZekf
	 nQlgirAVxSWX/3zslMjLZUi2M4jCQxf2VD025dghNClRSK1yWjxvkNSYspDusk5zkE
	 k3F/zivL0JcfFEz+B4bOFYFytUBPjkVUTBylQ3PA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Xiao Ni <xni@redhat.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH 6.6 141/152] md: add a new callback pers->bitmap_sector()
Date: Wed, 19 Feb 2025 09:29:14 +0100
Message-ID: <20250219082555.624883164@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
References: <20250219082550.014812078@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

commit 0c984a283a3ea3f10bebecd6c57c1d41b2e4f518 upstream.

This callback will be used in raid5 to convert io ranges from array to
bitmap.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Link: https://lore.kernel.org/r/20250109015145.158868-4-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -661,6 +661,9 @@ struct md_personality
 	void *(*takeover) (struct mddev *mddev);
 	/* Changes the consistency policy of an active array. */
 	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
+	/* convert io ranges from array to bitmap */
+	void (*bitmap_sector)(struct mddev *mddev, sector_t *offset,
+			      unsigned long *sectors);
 };
 
 struct md_sysfs_entry {



