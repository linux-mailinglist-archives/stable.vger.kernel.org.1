Return-Path: <stable+bounces-193903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D13C4A914
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0609434192A
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3CD347BA5;
	Tue, 11 Nov 2025 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eNyprWNR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9032DCF6E;
	Tue, 11 Nov 2025 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824335; cv=none; b=t+VaXfYED45KZNJIvo8kFMy7Go+192/i8zwoofLLhwT2zjbgMmeM1hQeutOhLWFZT20t4amfOBS3IviV6mlwkzg9nmveIHUUz3Xu76Ly8P3Q7EHDqqnnydTCHVQlVubrxIBXQU+IzQjkfASJWvKxmVUyD37/nJLQGTegiDLxZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824335; c=relaxed/simple;
	bh=7s/I8tLltkMnqpIzA7BTHs1HQpfqlPynzl7HPh9A7z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4qg+fAkLChVxUvZceyZ9jX8aHFDP+gPxFJFVWDXs5zrUeQB0it/OcjQ7eNSKe3KsC1k2QKIL0W/7VtQKi/74FLmha/iE5DhSPHN9ZJfRSzD5IiQ4fjvNN+pc2d1stJfCQMcFFm5euVO6iNMj5DtNHYUS4e8g98XCHvJQIx0iVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eNyprWNR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E979C116B1;
	Tue, 11 Nov 2025 01:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824334;
	bh=7s/I8tLltkMnqpIzA7BTHs1HQpfqlPynzl7HPh9A7z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNyprWNRmu3spqRDCnoTZMHZ5BEBg5crT9toqlR5b7xz1uoM2Nz/WBppUKfCTaTPm
	 QilYyU7nYCHOpko32dk8HlqT+tPTGutRyhql2fQw88zD3GdNAKIzOuuCp/5Z4bIX+U
	 o2tncdNJrMPgVj2cNl6d3iGI59yCpCNXPsCt03Y4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomer Tayar <tomer.tayar@intel.com>,
	Koby Elbaz <koby.elbaz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 424/565] accel/habanalabs: return ENOMEM if less than requested pages were pinned
Date: Tue, 11 Nov 2025 09:44:40 +0900
Message-ID: <20251111004536.401495847@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomer Tayar <tomer.tayar@intel.com>

[ Upstream commit 9f5067531c9b79318c4e48a933cb2694f53f3de2 ]

EFAULT is currently returned if less than requested user pages are
pinned. This value means a "bad address" which might be confusing to
the user, as the address of the given user memory is not necessarily
"bad".

Modify the return value to ENOMEM, as "out of memory" is more suitable
in this case.

Signed-off-by: Tomer Tayar <tomer.tayar@intel.com>
Reviewed-by: Koby Elbaz <koby.elbaz@intel.com>
Signed-off-by: Koby Elbaz <koby.elbaz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 11c55fd76db58..0f27fd841f3ab 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -2332,7 +2332,7 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 		if (rc < 0)
 			goto destroy_pages;
 		npages = rc;
-		rc = -EFAULT;
+		rc = -ENOMEM;
 		goto put_pages;
 	}
 	userptr->npages = npages;
-- 
2.51.0




