Return-Path: <stable+bounces-48605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F58FE9B5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C551C25D31
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCD1196DAB;
	Thu,  6 Jun 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="My85ZrZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13FB196DB3;
	Thu,  6 Jun 2024 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683058; cv=none; b=fM4DI+6mdfv9AE+nZOGkIayPq0nttX/SqUk9zfplXuI7rDz9Y+ihIbgb8oct66iaKDA1wFYa6GRj+EEbcW+OzZdVxztxtI5PGWGSKJrYCJcdP8ceC4hkNT8MTgMOGd64AVmGs3NA0nfBdiwyzMdTS8BesN55FG7Qem9VhFS5JI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683058; c=relaxed/simple;
	bh=h3fSZzDrMdbMpgkDRiEmWDML/VXsGy8Y1d3nBTcHXr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5BgavN6Yw7yrrgutWPvht2CpN3tDl5ORNccn2StLxyuCI+xCTSV8LnrXQ8W5j/JKfXwidVvi48j2CsP4SIDLn77zoQbV5uXNHn8UNsCSaCHoec7V0ERB1zNcxkKjUydl/dY7an3TG26+GVZsbw4PIuArBVSORNumt73m27BUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=My85ZrZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BDDC2BD10;
	Thu,  6 Jun 2024 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683057;
	bh=h3fSZzDrMdbMpgkDRiEmWDML/VXsGy8Y1d3nBTcHXr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=My85ZrZV0UN/ATzHDvJKwzxSWx1CxUpo7Jn8SU19krbXFUTlos+up0wvctwXO4rBd
	 4EmeE/VIjCWzTAIIIAfrisCRYDIkCKahtE6/8kUjLx0ln4lcnps7NM7ma4e06MHZHc
	 zWRiHqJlk5pVtZ4vZZp3uxUMWHaaL1QpMFRJsMe0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 304/374] bpf: Fix potential integer overflow in resolve_btfids
Date: Thu,  6 Jun 2024 16:04:43 +0200
Message-ID: <20240606131702.037079817@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Friedrich Vock <friedrich.vock@gmx.de>

[ Upstream commit 44382b3ed6b2787710c8ade06c0e97f5970a47c8 ]

err is a 32-bit integer, but elf_update returns an off_t, which is 64-bit
at least on 64-bit platforms. If symbols_patch is called on a binary between
2-4GB in size, the result will be negative when cast to a 32-bit integer,
which the code assumes means an error occurred. This can wrongly trigger
build failures when building very large kernel images.

Fixes: fbbb68de80a4 ("bpf: Add resolve_btfids tool to resolve BTF IDs in ELF object")
Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20240514070931.199694-1-friedrich.vock@gmx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b31..af393c7dee1f1 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;
 
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
-- 
2.43.0




