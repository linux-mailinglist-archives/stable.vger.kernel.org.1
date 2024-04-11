Return-Path: <stable+bounces-38880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06128A10D0
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E9828ADE5
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6793146A95;
	Thu, 11 Apr 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNcv0CCS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6521113C9A5;
	Thu, 11 Apr 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831865; cv=none; b=RbPhcb+zYTj1HwiZVJ/FcBmlBpmbGXiZ9t+G7ayo18cFnoZMipoQdkFjv++TkI9WLcoKyxsbgsEEZL6ybPhLPWVmHxzesyG+GjZLpoP5iQBW91/CiBXc/aP0CZmcEPZ9J1gWivhrEe8NPw8Ao+9EILXMbIuRqAbahrmGaISqr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831865; c=relaxed/simple;
	bh=vUuS/OlCZMDwtzaeInBC29Y16JcZ6IuD33hZZZfzNc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tux7DcnwEwQu9YAaoSSlW8Q8e+FIBYolPDEu1K0NJIrly4Jch2nVSyt8AKbHEuH5toJ+9L/Ys+t1kdruuonNcNYLE6TdGNDCxwSafVnU/eE0hVj5QP6pqMxmi0wq7AeIdtCETdK/obuyQ5b5lx4tc3cuBjKAgkLVVlxDS3/tjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNcv0CCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22DDC43390;
	Thu, 11 Apr 2024 10:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831865;
	bh=vUuS/OlCZMDwtzaeInBC29Y16JcZ6IuD33hZZZfzNc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNcv0CCSE3BdJuTn9mOT/2XxBQp5HZHtQSN6SlWAS+Nu4BHPNvK7uKA7xLj+TE65B
	 nZ3bVJ3TLNW+PZ/TC/ReDvcXrgnEbxy2T26jkp27zqC9tjI4h9Ch+ifBhtURHg+uoU
	 T7EOjD7GYy7oeMUl6Lv2YvGWC85sElJ6HgoBBU54=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH 5.10 153/294] mm/memory-failure: fix an incorrect use of tail pages
Date: Thu, 11 Apr 2024 11:55:16 +0200
Message-ID: <20240411095440.255388804@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

From: Liu Shixin <liushixin2@huawei.com>

When backport commit c79c5a0a00a9 to 5.10-stable, there is a mistake change.
The head page instead of tail page should be passed to try_to_unmap(),
otherwise unmap will failed as follows.

 Memory failure: 0x121c10: failed to unmap page (mapcount=1)
 Memory failure: 0x121c10: recovery action for unmapping failed page: Ignored

Fixes: 70168fdc743b ("mm/memory-failure: check the mapcount of the precise page")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory-failure.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1075,7 +1075,7 @@ static bool hwpoison_user_mappings(struc
 				unmap_success = false;
 			}
 		} else {
-			unmap_success = try_to_unmap(p, ttu);
+			unmap_success = try_to_unmap(hpage, ttu);
 		}
 	}
 	if (!unmap_success)



