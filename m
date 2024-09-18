Return-Path: <stable+bounces-76682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65297BD9D
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544C01F227D7
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CC818B472;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keoLXEIE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC318A6CD
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668247; cv=none; b=tDL55XPm5vzXpos9tl6i5N8qP1opUR8Rkzgc6YdTjlUidxVNswv3/4RTexKng9TKnpCro3Wmb1iMit5Ei/kjEggW7dmaJAzlFq2EgUcy1Cx6lti465SH7i8kNptuSe/HhQLRpVvP77TJtqJZPvZxhp12WmlGMVGfNH1zm28VOVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668247; c=relaxed/simple;
	bh=ReCvHcTC1MUnkaLzoS9tCdHqfwFvExhYqwx47dsbmu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xlzu/wVutTsvuilqBibiCAtnG/KUe0h71d/l/VgCBGeBovrtxce3VH2DoQh+H/CCAhx2PCifTnxKzQe+U+Khjh7h19rHz2qlsSZqWzOh6Nzh4E0sCXZ+nSVX2aNXljg4amTbbXNIJ0u4pHncwIPAnc2tSfcNpt4LqUeot+eT7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keoLXEIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29D4EC4CECF;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668247;
	bh=ReCvHcTC1MUnkaLzoS9tCdHqfwFvExhYqwx47dsbmu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=keoLXEIEZ2YFU2lOtQctaa2xILXzKrmOUanowzanIxIGtGweeAd4OQ7Y96/SDiYE8
	 tNYltDhSJ2muJaMNxXiWhMuPWXlUDaF+5WkNFlRv4vbCP3juyYCnVGU9iCmyJkU+UU
	 FgYtzsmUQx5JySn5Zh43B3o0UgNQLPKRk3NsMb/NJTWaQrCY8lJ3apHPwJXrU7+5l3
	 /q6e4O+md3gYgCpdL02KV4DKdvTLrGlxYKFKU5/qXAgSgatunUX337NZTkl2Y1Jgyj
	 TXdFLpOE6XRChpa9KGOPs0CM3UTusFXXHVXPYMMICibUifBXkzj9oEhCAnnI6GvgFw
	 qfREKyPWdGh+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153ECCD1AD;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:03:59 +0800
Subject: [PATCH v6.1 3/5] fs: new helper vfs_empty_path()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-1-y-v1-3-364a92b1a34f@gmail.com>
References: <20240918-statx-stable-linux-6-1-y-v1-0-364a92b1a34f@gmail.com>
In-Reply-To: <20240918-statx-stable-linux-6-1-y-v1-0-364a92b1a34f@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>, Mateusz Guzik <mjguzik@gmail.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 stable@vger.kernel.org, Miao Wang <shankerwangmiao@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=0Ym6bd1bjrK++KLUiMNu6AnkYMC8fXIq9/WmZjyb8hw=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t3UtvCDlyr3DdCz8bva21nbsM6sK6a7ng16K
 REfgLN6bL+JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurd1AAKCRCwMePKe/7Z
 bl2cEADXbrDZCYc22iKd4nqQXj5NqmQD6ytsw8u03ADv+ykcKOdASt+1vLWdyvapup4gccgr+BL
 GoxqvzcCcGbc44ukjEEnQO2PKIkBEwTfBGXkBc/WoeA2Z/9zk+pwtO3DEltP4JuBlOmwlwZIZI8
 eunXKlRuC2GivCwmL+ESIiCRTu+8lUi9vmggx5PFXt0NbEMQxT1bxDI/4hweKUipfIA8355Er/z
 3HwF+c0oHE1Z/iQgc0DNQxYldYSYAo40YjskolLXTAUux0d7bM9z6MtN/fC60Uyk92OVtTlBBpU
 UuV1xllalmrqaIcXnTS++dpN489Ts5dmBiUYpei7OkfNB9Oga3mEbgD1P+hW82e1u0esfAO6n3L
 9m1CopN8qX7GKt/fIgEv5jv0yw/NCkX240fJxntGO74/crD20xoYjRiCJWuZh+6DW0FxsiCeazg
 fPuQYAYapEknHGVgiDrcM1bXd2EmKiM3m/Fo8UbIrkcn2aRrNBRimntboVK7m5pIudeSh6ZmHNe
 BXPrSPtmXNOUC+dQERx9VipGL9k8gszy3HFueGoqZkhbj/Wj1Up23Q4by4jSV63mVA4J1Dlnf7I
 dkWLPoLg3+WV0BLp0t7ZAjsgQbqcASvZ+FdsDGsQZkLvLkvG+0c3sm5BquBA4EW2o7ABQFcAdkR
 lTRrQG3ionsH0tQ==
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

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/fs.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f2206c78755a..deb0abe728a7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3692,4 +3692,21 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
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



