Return-Path: <stable+bounces-76679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9797BD96
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CA61C218D2
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5463189B94;
	Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeJxi2qm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A584318A95C
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668175; cv=none; b=PgwRjv0k7R8AXR5mnmT15TCx6HtACFvTPYytSBcwJiQGBpBlpqj1Cm1rW7l05svM//DmrAKSRfGRvbGpxiHaHvMHV7OTe6WtKyVQ91+MJeHtbVNQQoKkr+stCykEcrCvNnlaHhuoiFIdnR4jmL7zryLasTzdL2Rpfr6eVByGdBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668175; c=relaxed/simple;
	bh=cebb2ZM2SME4Ub4pZ57Q/NnpGgPFjx8daAhRQVl+vnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbFZxqeAXxr0LZ17WVilWzSGoOgSyp+KVWpiOBjCw1GjS0vuPQBCcRxcUU0O5VdmKX/QG2r4cWK7oayvW5MtL7KxxWNhYN51mUuIQv+PMZK7RWtYguBiKjQf827QD2tRxGfR23SX3pWfdmTO+Tn5B6Vx6BeqBaQcy0Cdyb/LKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeJxi2qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C223C4CECF;
	Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668175;
	bh=cebb2ZM2SME4Ub4pZ57Q/NnpGgPFjx8daAhRQVl+vnU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OeJxi2qm/m7w0s1H1Kq6OBp/SVTHeOeFWDz9BQnUG+aFEYhzTRxdZbF1nX51Vw5ZH
	 ykuMIEHgQ3twFdNTtJIBpY/yugSSXfQi9eBOgioIMRGLHBcq3G4UpHZl37pwqjDb7d
	 Or/fLmlMEYdA+CwZdXpcxDftGKvuCJtcEKG0W0YXsaXlb9RM06o8wQLcXWq1UZXptr
	 Sgwc3D4za040FUgL37QkuYxIbmdrnUemAIRPR53uuGoR0dZ+4alX/CFw3MzK1rVslR
	 42viRDZ/wiIKPANN1wJbP3a+KbGoI1h1I/isq324/zH74C/PNjrJokDeMwHmWpdbHq
	 7CVvJPJK6m+jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234BFCCD1A7;
	Wed, 18 Sep 2024 14:02:55 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:02:51 +0800
Subject: [PATCH v6.6 2/4] fs: new helper vfs_empty_path()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-6-y-v1-2-8731db3f4834@gmail.com>
References: <20240918-statx-stable-linux-6-6-y-v1-0-8731db3f4834@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-6-6-y-v1-0-8731db3f4834@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, 
 Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=VS5qjZw+FoCkeKMb8vRJXj6g0W3ph2xyDi9Yx9IY3/Y=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t2MkDYa4zKzhXM4cv44fH3GZUJ7zL+k1ZJTG
 FcjcXbSQ56JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurdjAAKCRCwMePKe/7Z
 bsB3EACH8lqyWASnYUFET/ssBY6eCT0d5Fm74SMPgJHa0wnNjb6kjExBi96CycF3kQ6TgSValKa
 bUeJ8ONhcKtoZWJ5wicTSzJu+RDRWBvTEv7emsDS7a0DzIBJA3KqE/ddbIdPWt2a8EMqkaT396O
 20iDaa4o+Qd6d0kwaTSHKTG2Z5zAzo2NkCV63zoSTGlaIrODT9Pt4pGDDquPB7erygjXFbnxw4l
 YL6OoGgfGaVc8rLWQzFR3Loj9djB+I4ud+jS553uWZOIxQFyKXiTRB4DqilXwWU83GPNXLnqh9r
 uF9C55oS0i97OsCD2vKO273tzgogGeFNW3V2EYzVkgp/+lnCJNl4dY2hxYSq3zrf6Djnn0B9c4l
 mgLO093mX5UH6VkWrPk++P29odnSmxoLpA7o2aY3sqwfJz64OU5h4yIeRKSMBbih4g7kG6v/JkF
 9EeXOcJUDYg3E3zBXB/g3IrD1R8MwDO4lr1igmD4/V1JuCx7tGcsnWfyax+pgaYE2deCt5NBQVw
 DbVXIJN6gt52VsqTdjCJBS7xeMPDBwqZiIczvUtQ2D6iQvm0JJ8UA1u8qeIGXqnuvsQ+JguuXBJ
 olfrfO5WdhsQpwJ4ezkql3syEYoKJ8Ns7HzlhUtfQxBL6749ni22rFlfvOEq4/VqqskKHB1KD//
 tk1Vt8JCzjLIVUw==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christian Brauner <brauner@kernel.org>

commit 1bc6d44 upstream.

Make it possible to quickly check whether AT_EMPTY_PATH is valid.
Note, after some discussion we decided to also allow NULL to be passed
instead of requiring the empty string.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/fs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a554e4045a9..809b354dbddf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3454,4 +3454,21 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
+static inline bool vfs_empty_path(int dfd, const char __user *path)
+{
+	char c;
+
+	if (dfd < 0)
+		return false;
+
+	/* We now allow NULL to be used for empty path. */
+	if (!path)
+		return true;
+
+	if (unlikely(get_user(c, path)))
+		return false;
+
+	return !c;
+}
+
 #endif /* _LINUX_FS_H */

-- 
2.43.0



