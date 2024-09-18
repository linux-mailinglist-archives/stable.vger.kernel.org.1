Return-Path: <stable+bounces-76681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A635797BD9C
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BEA1C212C7
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D218B463;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3/AZBUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47440189B94
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668247; cv=none; b=g9kR23EkVOl5z3WUMcg9lrBlRKYEuJtKsAACSU7xhw6DW/3GCoggRu5qDA1GarT6zsR7X/Ie2svlbztak4P2mDoVuQ7ELXzycvv5rFrlSDaZknGPufNn6Vg7T1OJkSXrXDA7uZwW1KA5c/ckR3VKhbQ8JdiUtaAvTM/G4sIxKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668247; c=relaxed/simple;
	bh=nlgR/1hhiEZZUKkh+caGlWnMVutKXJn35pAm3LZDAdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Win/dIFl7zqljinXYzCLffw3ANQWOvbcFk8+SSXnDvz2z9frYyO6g7WY/JuBLbLAsK6OLyx/fyTkBiaE07LYvaTEXkKyfv/I76aDM0Me02OGHlgEYm2S+ASEBqgpzR4Hj2dWdL7NmNnmPgg1SM/J9S+pSm9GpLjk6yyefXmK0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3/AZBUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B05DC4CECE;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726668247;
	bh=nlgR/1hhiEZZUKkh+caGlWnMVutKXJn35pAm3LZDAdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=F3/AZBUJCea4O0+pk5XUtejHFfBtRZ8cReD44UlMnYdwdlDDb3J2a0cIr56YenUjZ
	 OrvAD38jLeGS7/vdbSlpjfTlDnT6Ac+pQPLduYiyg6RPQM2ellwKtAOcFzFK3J1vgx
	 NgQzgjt5RxMJekdrVA1q3h8N7HdRxBepURixmAZvcsPhJPDFCX760pVlrWyPtWPqPn
	 MisjFP+x+O24GT61hQfdn+jOK8n85h8jH/TxRGMBiJvaCUPEfXm2R/JCH33inipNzO
	 DAj5bjDVIv9/TD28klLv+WwA/ZIrJaM7IGNDZOGp5WbxLYBcn4h/BNB9d+Z2JdoQpU
	 uNg6IFBwvsoWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1305BCCD1AB;
	Wed, 18 Sep 2024 14:04:07 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 18 Sep 2024 22:03:58 +0800
Subject: [PATCH v6.1 2/5] file: add fd_raw cleanup class
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-statx-stable-linux-6-1-y-v1-2-364a92b1a34f@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=931;
 i=shankerwangmiao@gmail.com; h=from:subject:message-id;
 bh=XON4BDwsa+hxqLqygmHBBmblYX/h+QaejNN2ENhk19I=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBm6t3U76r3DAs4+64W5q44SmnJ3oIBH9Z93C5/K
 O3aQCe5aSqJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCZurd1AAKCRCwMePKe/7Z
 bvCjD/9epvrQt6tb9IUFFm7WcZOUDhRve8+gcdsnluBNl4dHkmFTNnBeJQ+w7DX2FOTr7s+q9sL
 G6a3qiC3O7tFdAYVlhJsQCPPz9/5dnGmrJdmT3BLwL+LhzWkDAP9BsQWBTyfm8ff/RBU1CBCkTA
 iI+t+RQ9wUVTYuhCB/8DJFNpSzlnMkY9TE004A7580QfRFke0W9QVDWouu6ImbTsUrFmbPGcUai
 B0U+J7l9XVJTQLydY4tutahsrj4b5aW7ptMNJb98z7KGMxIBBNwu4To0NEz5bom+x6umb8lVFe0
 wIARqSLR9tI6RgqPbGAjyfxgn2SPM/np3jAwm/kTIQG/RX9Tm28KJAZDns88ou4nD1nPIhZmS0Q
 7agpEe0epzKcgexef91C06+TQh7pSLYLYDvtYqzaUFYu1YQd1L/2svV5ZA2p5Pdwo3bL95gEqRQ
 8kJfBrQJwHT0CIpowRu4Wf/9L3Bc4Tx/spnBz9z2eTUwbFtyzo9rpNgqovsoMSwC63CZeikgs6Z
 Ju81+6CiSugskx6qwjxv4uqq/qnKURlyzNWUa1iuqWhxQ98ScmOylCFjbXaYda0yqu1CgPsUTj4
 8g5BBCnYGqQDIo6GqVCRsJqGeyXKXTBWU5LpURmAaWyHsrZ2lnyfnqgwhGb95CKLRrVChVTSdMo
 DJTuxAhvgoirB1g==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/default with
 auth_id=189
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Reply-To: shankerwangmiao@gmail.com

From: Christian Brauner <brauner@kernel.org>

commit a0fde7e upstream.

So we can also use CLASS(fd_raw, f)(fd) for codepaths where we allow
FMODE_PATH aka O_PATH file descriptors to be used.

Signed-off-by: Christian Brauner <brauner@kernel.org>

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
---
 include/linux/file.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 6e9099d29343..963df2dc4f61 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -82,6 +82,7 @@ static inline void fdput_pos(struct fd f)
 }
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
 
 extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);

-- 
2.43.0



