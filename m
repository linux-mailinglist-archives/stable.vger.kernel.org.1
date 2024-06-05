Return-Path: <stable+bounces-48105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB78FCC6C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482AF296AD9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867D3199A72;
	Wed,  5 Jun 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaZaohYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98C199A86;
	Wed,  5 Jun 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588547; cv=none; b=Tsxk/VuID93DM28HBMCP1hNzKKKu+x202xBB8pO3FoVKqMyuJEoUQMwxjK/8oOLycU+/lUwEtngYUmknHE3ehpkl/49HIbV6AZoDA+E/7KPFj/wpYp3xH/wh9qr9sSdRqZyxyP+oyzfQKUX978ZDU0BKVAQR5BYlzFDI1GDsBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588547; c=relaxed/simple;
	bh=qt56nWNkPEyaYkii4ItmJovPVXzjgXTz0F5q9bi3geY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3QvOvVQQKFXPHm1YTZu58dX3i+zdXH/OXbE2Kc7/yaXKWJ6LOI6PYAYKPEw0BZxdTXr+7dhFKoSGY6trFxWgYHCV1VRXgBcYJU2pfY3OdhOPosA+TMdNv9j/CA+QEOwTowynbuyXbB1hLimn8SJPHqHKXeihR8pygtfuyY7+jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaZaohYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F18C3277B;
	Wed,  5 Jun 2024 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588546;
	bh=qt56nWNkPEyaYkii4ItmJovPVXzjgXTz0F5q9bi3geY=;
	h=From:To:Cc:Subject:Date:From;
	b=AaZaohYGzM1zpUZYdAfbbQ2OIjXoPbphL0BGpXsOsbyUqc+16TED/c5PdXTgSohjp
	 YKbsP8PByFFx74ZSY7VY6cHMIbrsC8uTeqFf6I1zii+KfpD4e1yJcDn6965WyVGujh
	 zZFVEJlGVcB6DOwMlISdx+Vf/U4XK3yUIXYXrzeUw4Bs90LNsxh8XtkgRz8P9i4zts
	 eMNij0TmZJYbPujBttneloQ/ruX1wemtVJC23bsMygTukk1RSmKHOs4GWXmFTRi999
	 gcMXRoi5TMqhybxY7RXdUuIjRcX3gWLtzOdy6oM2idk+sP6eNcCM+UPoGFmfs32tGm
	 vvimXyIavkayg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.9 1/6] fs/ntfs3: Mark volume as dirty if xattr is broken
Date: Wed,  5 Jun 2024 07:55:36 -0400
Message-ID: <20240605115545.2964850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 24f6f5020b0b2c89c2cba5ec224547be95f753ee ]

Mark a volume as corrupted if the name length exceeds the space
occupied by ea.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 53e7d1fa036aa..73785dece7a7f 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,8 +219,11 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
-		if (ea->name_len > ea_size)
+		if (ea->name_len > ea_size) {
+			ntfs_set_state(ni->mi.sbi, NTFS_DIRTY_ERROR);
+			err = -EINVAL; /* corrupted fs */
 			break;
+		}
 
 		if (buffer) {
 			/* Check if we can use field ea->name */
-- 
2.43.0


