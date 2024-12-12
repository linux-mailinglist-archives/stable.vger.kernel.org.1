Return-Path: <stable+bounces-103421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CA9EF80E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A2B189B7B5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4FB21CFEA;
	Thu, 12 Dec 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jEbOLlLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0FB216E3B;
	Thu, 12 Dec 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024517; cv=none; b=WUwvI359639zFgOLMnVKqU0ZkM4Hk7z8eMmQg8JfDC38EEQ+GfOofIY6En8ichp0Y3KOu8ISum+aw6mlpOm+J5TaLfpE/Zc7nVVpI38Bw3UOIiiFK2aKQLCoOKeEQP+wv81drrr2m4u1lAkwRiIGo0o3IHtFwpQkNNoCGDO8HB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024517; c=relaxed/simple;
	bh=zFpPhaBXylhU5eea6N0yjF+nhg2x3quaeXr7hLYRbTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhaQTs8WhM1v4Hik4w+Cp6vjqf3pMmQeLIwxznFt4PhKJcb54set63hUyo+t+dy1ooCJjJQp39TcbXXUjRXi//73ZnotPtQuX0odbOOEMFgmFOzkri1rMNaBc4rDYoeUOE/apk4zCDrCH2DhQVEXjPKMjum/HrWfzfBFo+pR7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jEbOLlLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008E9C4CED3;
	Thu, 12 Dec 2024 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024517;
	bh=zFpPhaBXylhU5eea6N0yjF+nhg2x3quaeXr7hLYRbTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEbOLlLDf7suCDT+SiQ933V3KXeRRq77OUvSLJxMHdn4X3zd0Ii5AbYeHtAqfIRPs
	 aHDY9dxqTgh5Lmd4KDWBJGUuHWfqyalHlbnsaice3pIuijglu52BXyMKckUGpZEt+7
	 w0wFXVu4dTZmkLG2Mc4vovVKFU1okU/OxrFx1efg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH 5.10 323/459] btrfs: dont BUG_ON on ENOMEM from btrfs_lookup_extent_info() in walk_down_proc()
Date: Thu, 12 Dec 2024 16:01:01 +0100
Message-ID: <20241212144306.421471432@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit a580fb2c3479d993556e1c31b237c9e5be4944a3 upstream.

We handle errors here properly, ENOMEM isn't fatal, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4878,7 +4878,6 @@ static noinline int walk_down_proc(struc
 					       eb->start, level, 1,
 					       &wc->refs[level],
 					       &wc->flags[level]);
-		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
 		if (unlikely(wc->refs[level] == 0)) {



