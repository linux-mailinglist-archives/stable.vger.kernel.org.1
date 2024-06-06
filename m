Return-Path: <stable+bounces-48959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E58FEB45
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D741C25030
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E51A38FE;
	Thu,  6 Jun 2024 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TyRtiLZS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEB1A38F6;
	Thu,  6 Jun 2024 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683231; cv=none; b=P3lff0B+2xcdFma+orT8stuYe/t7Ftw8gHV0SLO+HRQUfiDfguUKrKlC/bugjMjcjJ1HcrQ4KbzTjmWZV4Y+f7sAoHWLgTf648vsmNpZ9SmmYeyAm856FoQ21vI6QnPYrL7f6qNIqK1K3gyx+uGlFezXyWauJ9mG7KcqGZG1VtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683231; c=relaxed/simple;
	bh=rdZDgFXI551dOFodu8rAiz00ZHp3dm2RFAHkomEVXZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smGXFOJEbt1yk0/RMKSxZab573odnk0asno1LwHWRlkaRVjznCbdEOFxOGqE6NM2oZ+/JU31iNMaM2DPWwLblOVcwhIKKaz+DEhh73WYkIMwbIYsAUrw/rakKJYF81JCe2cqk9dlh+R1tBUoV8Da5zZ4KcW2YoEMKtkvkfOOyq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TyRtiLZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A82BC32781;
	Thu,  6 Jun 2024 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683231;
	bh=rdZDgFXI551dOFodu8rAiz00ZHp3dm2RFAHkomEVXZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyRtiLZSq20ATibG0qFzrW+wS2OxW8/xf4KIuDiyx5HtiDgnWcJWQwNYnf2iS95B+
	 RsZVNUxMOvAmcHiQASw3iN4ZHd0Fc+izSJJO18l7MNezP5zmlHsRxW+qqFWmCszDBC
	 g5gSa3wZA6v9mbTHRPsyiWb5WXmXKkCMPTm4Budw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 077/473] s390/cio: fix tracepoint subchannel type field
Date: Thu,  6 Jun 2024 16:00:06 +0200
Message-ID: <20240606131702.460974807@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 86993de253451..a4c5c6736b310 100644
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




