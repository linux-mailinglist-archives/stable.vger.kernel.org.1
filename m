Return-Path: <stable+bounces-175227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95118B36708
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C948C1C26D51
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BC734DCFA;
	Tue, 26 Aug 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+7UTzdN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598034F46B;
	Tue, 26 Aug 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216478; cv=none; b=WCktu8C71cnBCE37Es6kS4AUe2uhm9vfgrM8ZTW+x//+RY3lh75q9S+A6tk8SZm0QFGO+nxfAj+gCAvnhVm7DFvtgGj6zVPDheHab5WN2u68Jm3YACGw6faNxAKnLnuElfsgKp9HUn7KIlEZo3Dl/aw2KkugnqpuFU2x3B8xrIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216478; c=relaxed/simple;
	bh=CDsSN9FySRlSqlka3OLtY3OIpIdslMtYkG84w84VcVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5vlIGpdkwFGgFNTW/owCw3HpWC43a158D3HnDFdaJ1u4LSVXjtW2MtAwpxtspqlR3KW6oYrTsgpEnBkq04bL5WLxR5zmSL9JH9I5PhXtdRdBpvv1a4wh4FpB3HumWRAOh2w4s7CTZVYSklFRPGQfUyaxB5+8789g9nxLR0iIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+7UTzdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26842C113CF;
	Tue, 26 Aug 2025 13:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216478;
	bh=CDsSN9FySRlSqlka3OLtY3OIpIdslMtYkG84w84VcVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+7UTzdN5VTaI4x12nUOvowSsRgIQxhouWH3zXn8jgfeaaFa4fEYmei2eT9LOEfIX
	 GRHi9U0VgsAa8JX00Z2xZPunOjL+h919/RuLEGjrKxTDevn6uewRQk3yK8ztjO+Xeq
	 ubBYibQ8Mpw1UScvigMH4S7dUMV/bKE/VTmx1K9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masahiro Yamada <masahiroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 425/644] kconfig: gconf: fix potential memory leak in renderer_edited()
Date: Tue, 26 Aug 2025 13:08:36 +0200
Message-ID: <20250826110956.991377068@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit f72ed4c6a375e52a3f4b75615e4a89d29d8acea7 ]

If gtk_tree_model_get_iter() fails, gtk_tree_path_free() is not called.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/gconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
index 87f8a4db5bc6..3c726ead8f7e 100644
--- a/scripts/kconfig/gconf.c
+++ b/scripts/kconfig/gconf.c
@@ -783,7 +783,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 	struct symbol *sym;
 
 	if (!gtk_tree_model_get_iter(model2, &iter, path))
-		return;
+		goto free;
 
 	gtk_tree_model_get(model2, &iter, COL_MENU, &menu, -1);
 	sym = menu->sym;
@@ -795,6 +795,7 @@ static void renderer_edited(GtkCellRendererText * cell,
 
 	update_tree(&rootmenu, NULL);
 
+free:
 	gtk_tree_path_free(path);
 }
 
-- 
2.39.5




