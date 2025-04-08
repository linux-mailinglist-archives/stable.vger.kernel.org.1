Return-Path: <stable+bounces-129716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C78A80153
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D614621C1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331F82698AE;
	Tue,  8 Apr 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jrc6O22g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0B268C6F;
	Tue,  8 Apr 2025 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111789; cv=none; b=ctdzVufZGgAlhJkZCUrh9PUxc528yuMR9vSo12jnopIfD1LWEFTD4CZOAoShdJLvte5vTbBIHarz7v8Fv8OLB387b6ZedrOXlbRqiEAwg5fhJD0xcM7Hht7C9nXu9k47dBeokVOUatSzf3m7n+F5RT+vxmwK0rj1QEgTzJpyoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111789; c=relaxed/simple;
	bh=aKMieBuES7FlZi0EeXloDCJiWsN0tzO7w3e82R6iLzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOrWSFn2Mt59ux2vOvU0Flm/UPWQFZhTs9gLI0z+uUMzxOaAZnGHTyd7gDAf/3fC/6VhUWGbpCcYyIxbFoFhzkcDM9vtDj4gQ9TTyQXyi0JQfJAq3DvlxDdLbZotkfjJz9qiROUfb7XjUAShv66whz3uIksNRXhtjM2TFgLZN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jrc6O22g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7745EC4CEE5;
	Tue,  8 Apr 2025 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111788;
	bh=aKMieBuES7FlZi0EeXloDCJiWsN0tzO7w3e82R6iLzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jrc6O22gnDtdCSc2wlKNE5jODh8wArob/7fOv3J3eyDnWkaH4XjR6Yc7g35WInZYQ
	 oomkC1juBDUG+SfDBhZIQ6D/+zURHQD+mVSrDGh1Y9SqjioWmOm8YOa9TYDEL2x64m
	 DkkqXkUey/aLOfvlACE2RhhO3A6qRDSpjvIFiBck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feng Yang <yangfeng@kylinos.cn>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 561/731] ring-buffer: Fix bytes_dropped calculation issue
Date: Tue,  8 Apr 2025 12:47:38 +0200
Message-ID: <20250408104927.323758639@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Feng Yang <yangfeng@kylinos.cn>

[ Upstream commit c73f0b69648501978e8b3e8fa7eef7f4197d0481 ]

The calculation of bytes-dropped and bytes_dropped_nested is reversed.
Although it does not affect the final calculation of total_dropped,
it should still be modified.

Link: https://lore.kernel.org/20250223070106.6781-1-yangfeng59949@163.com
Fixes: 6c43e554a2a5 ("ring-buffer: Add ring buffer startup selftest")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb6089c2951e5..510409f979923 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7411,9 +7411,9 @@ static __init int rb_write_something(struct rb_test_data *data, bool nested)
 		/* Ignore dropped events before test starts. */
 		if (started) {
 			if (nested)
-				data->bytes_dropped += len;
-			else
 				data->bytes_dropped_nested += len;
+			else
+				data->bytes_dropped += len;
 		}
 		return len;
 	}
-- 
2.39.5




