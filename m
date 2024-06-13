Return-Path: <stable+bounces-50941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D7906D87
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C2AB20A72
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193AD1448DE;
	Thu, 13 Jun 2024 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZgN+k1Pg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0C1459E9;
	Thu, 13 Jun 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279838; cv=none; b=m3gEBtNA4pS2Y5G5BzodMh7T+B+IaHMEfl1ptVxyMev8PsknCSZJDTUbSuUkVjAMvkH5XBJ+0Rt5NQT3bsUcC/5NPetsG1EkHBxJxDQRn0VHinuFpLzx2UlqXN8NA4kIq33VaIhAxOaYYQ4/ewlAeqVAqr6LEllltlzkdQGP2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279838; c=relaxed/simple;
	bh=6TH9b4tt0al9GybfE2imBC4vscmQ1Ogci8lxUtKxaY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0ykiYejWQa8hKICYLn4QzYiJd+vjTQu1IRY/m27J8g1QSSseoRuqEWQOUTUcLP5hlSCoqW4ioVR7jlcp7KO7vRV71uawat7+r77l60zLxzeIqtwBEgxtyJ9IswqCx2VwsqyZsWGzyYa9r+k49RgG3jp3ChovuQVDopOb1AvA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZgN+k1Pg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CB3C4AF1A;
	Thu, 13 Jun 2024 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279838;
	bh=6TH9b4tt0al9GybfE2imBC4vscmQ1Ogci8lxUtKxaY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZgN+k1PgBnJlZeIaL0UNGIYBuPSA0g5gSt0r1SIGW6+sN0uv/RKl+q4wN+Mw+UOUj
	 j7gCF620typ/zsud8IGFp618BfSHphlBuKER7h2wVW8po/8JoyT6a0FMMHyU+KVUQ3
	 vVWg1S42eO7pjNcRtM6tDYG5koP54uTHThLPM3ZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 023/202] s390/cio: fix tracepoint subchannel type field
Date: Thu, 13 Jun 2024 13:32:01 +0200
Message-ID: <20240613113228.663570068@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit 8692a24d0fae19f674d51726d179ad04ba95d958 ]

The subchannel-type field "st" of s390_cio_stsch and s390_cio_msch
tracepoints is incorrectly filled with the subchannel-enabled SCHIB
value "ena". Fix this by assigning the correct value.

Fixes: d1de8633d96a ("s390 cio: Rewrite trace point class s390_class_schib")
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/trace.h b/drivers/s390/cio/trace.h
index 4803139bce149..4716798b1368a 100644
--- a/drivers/s390/cio/trace.h
+++ b/drivers/s390/cio/trace.h
@@ -50,7 +50,7 @@ DECLARE_EVENT_CLASS(s390_class_schib,
 		__entry->devno = schib->pmcw.dev;
 		__entry->schib = *schib;
 		__entry->pmcw_ena = schib->pmcw.ena;
-		__entry->pmcw_st = schib->pmcw.ena;
+		__entry->pmcw_st = schib->pmcw.st;
 		__entry->pmcw_dnv = schib->pmcw.dnv;
 		__entry->pmcw_dev = schib->pmcw.dev;
 		__entry->pmcw_lpm = schib->pmcw.lpm;
-- 
2.43.0




