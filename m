Return-Path: <stable+bounces-49478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413298FED6C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B0CB25ED0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF6D1BA891;
	Thu,  6 Jun 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZncqGDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED84198E8C;
	Thu,  6 Jun 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683485; cv=none; b=EWhWP+rS7MGufDllv5uGOxpBLHdOjUQytWyKmgI15499nyRx+d+GbNByjeLl/SGgmbAF57yeJerIuBhtapKvvGyAOhgmeOqs4MH0ELONP+dUJaHxvsl7N9DW0dXbXgGdq0+rLhcVWbIxiUN01HdivvNRC5++U2Yb4kyM2Fh0ElQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683485; c=relaxed/simple;
	bh=IomuwyPTm365lLJNz8bLhfasbvJgSXT2ozggnUUBuMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvd05PzYoIIwBQyDMSgGhS5zraRl9wUIG+buQ0iguTAYn8CwV5zeeQZCQDzmzZB5eGwFeEn5EfkrrKpEA2TskWg3ZmW958Iy8MJeMZ/1O8M4UEGM+BRgl4lY/iCu1+l+rIDvOnlV9J+x98dXj+42CrN/5We14sBUHCJdGTYyQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZncqGDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6384DC2BD10;
	Thu,  6 Jun 2024 14:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683485;
	bh=IomuwyPTm365lLJNz8bLhfasbvJgSXT2ozggnUUBuMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZncqGDQc95ndcdkPKeShXIW9YYebQC5ZDV8ToAIe4LZCe84oKiEU+8Qew5HQ6uuY
	 MjC96AUhMZ69jLv5NZl0h/jYSUx+jAFW73uT3Y1M6ysiA9hgoHWgJfUOpj7HWfps8a
	 bYOp1DSLFZyqJrAxhcnmFF5PLy7LGAI936Nj19IY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	William Breathitt Gray <william.gray@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 399/744] counter: linux/counter.h: fix Excess kernel-doc description warning
Date: Thu,  6 Jun 2024 16:01:11 +0200
Message-ID: <20240606131745.256456610@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 416bdb89605d960405178b9bf04df512d1ace1a3 ]

Remove the @priv: line to prevent the kernel-doc warning:

include/linux/counter.h:400: warning: Excess struct member 'priv' description in 'counter_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: f2ee4759fb70 ("counter: remove old and now unused registration API")
Link: https://lore.kernel.org/r/20231223050511.13849-1-rdunlap@infradead.org
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/counter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 702e9108bbb44..b767b5c821f58 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -359,7 +359,6 @@ struct counter_ops {
  * @num_counts:		number of Counts specified in @counts
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
- * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
  * @chrdev:		internal character device structure
  * @events_list:	list of current watching Counter events
-- 
2.43.0




