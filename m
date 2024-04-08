Return-Path: <stable+bounces-36618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C7789C0EE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F413E2861E3
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3785C7A;
	Mon,  8 Apr 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yF4lqteF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6485954;
	Mon,  8 Apr 2024 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581852; cv=none; b=Zmj9ppgtN9Z9fCrOPjPTythwm7yIgFLuHap5H9I/zoP9xhHVGn8aD7fJKI6+OZMFzell5ugC6cG/uQYjZKvYowZRoyHhFWRhHgPoeQWaUeIm855UlMtyw7ZYezkjUqVTd3K2pnkl7fTfEr1PkmmOiuzjyAmnYX0rG2fEX7pPBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581852; c=relaxed/simple;
	bh=GgzHqIMXezta75htC73tM5ZAKJgkJBRVd6C57xDHwHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGR1mr5UXUNZ11Jga1K3gQjPQ3X1z45r1weOKHfxipVQgduHQ1bVMhbFOSwWqTnWuiSUf77OpoDRKmOJh5xP9NNr59USdkeSaMxeN2I+IvFhkPGgVMakdat1jkRjcgun7GjqCJGHIgxOv332KFF84zhX/pOwqnUq7d0fdkoVqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yF4lqteF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53347C433C7;
	Mon,  8 Apr 2024 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581852;
	bh=GgzHqIMXezta75htC73tM5ZAKJgkJBRVd6C57xDHwHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yF4lqteF9KsiqpY1AeCrDZr+dtAkniz44/jeOTFtIO97Y+ESiklKlWfPKwv0XGgUa
	 M1vvfs3Hc+5BsoQK4gBSMjap5gEFMfmkt6DN6oPvcjtC4BbAV6rWD26C/1XlRJ0jYB
	 DNrNTHspPuD2xS8UYM8EbL77dNS775Xej00PflnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prasad Pandit <pjp@fedoraproject.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 025/273] dpll: indent DPLL option type by a tab
Date: Mon,  8 Apr 2024 14:55:00 +0200
Message-ID: <20240408125310.073313402@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prasad Pandit <pjp@fedoraproject.org>

[ Upstream commit cc2699268152d8e0386a36fe7c9271d7e23668f2 ]

Indent config option type by a tab. It helps Kconfig parsers
to read file without error.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20240322114819.1801795-1-ppandit@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index a4cae73f20d3d..20607ed542435 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -4,4 +4,4 @@
 #
 
 config DPLL
-  bool
+	bool
-- 
2.43.0




