Return-Path: <stable+bounces-92446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA029C54AB
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A081FB2DADA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D5F2144D2;
	Tue, 12 Nov 2024 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B9pTnw/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C421315C;
	Tue, 12 Nov 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407684; cv=none; b=NQs3TQ4VeXD6ZNHMiJoZyzGb54tplLxS+AVy1EpASuJvP8J48X81Qjk4Mf+J6FGeWMs7bi8OmVvb65K6SGrQVDSq2ME6n0cP5RrqRbnQkuO3jaAp6hlPlObIm+AN/fTHYmtmtPBLho24VqIBF+pycmV0cX4UPSsekfj+Sb6N+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407684; c=relaxed/simple;
	bh=EUActtaa6pYWsVW/4lFm/Z9wxnNFtsW4bcL8qtLWfes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5Ud/sA5HrmyU0A1LKhbooJMg8cAKPiSuyXFUGjxETHK7cRQEUURC704cIJQGT6iFXc08rcvjQg/rResL9LWaGxJinaFfgH4OXYzf+VEiugdDgLmw3DdiyaMGUtxKP1/R88Cxr/yO55kQuPB/mqo2bEDp4yTJSLBCFd1makbHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B9pTnw/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C4C4CED4;
	Tue, 12 Nov 2024 10:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407684;
	bh=EUActtaa6pYWsVW/4lFm/Z9wxnNFtsW4bcL8qtLWfes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9pTnw/kNaRN6y4RpDQf4U9rvTJxhVJDOu+oICzEEP3MTeX0Pb/8FSpbHfWBx6k16
	 R66gzs2mWoNT8KesRaYFMvi7xWgP2tlkjrjuKUXwLwHSHVK7IqC9wsJPft1Vihz4LW
	 USC3QnLtKCa2LYgiCq5bKjfw/DjGRiH4hUfk0ksI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 6.6 051/119] media: stb0899_algo: initialize cfr before using it
Date: Tue, 12 Nov 2024 11:20:59 +0100
Message-ID: <20241112101850.667739163@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 2d861977e7314f00bf27d0db17c11ff5e85e609a upstream.

The loop at stb0899_search_carrier() starts with a random
value for cfr, as reported by Coverity.

Initialize it to zero, just like stb0899_dvbs_algo() to ensure
that carrier search won't bail out.

Fixes: 8bd135bab91f ("V4L/DVB (9375): Add STB0899 support")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/stb0899_algo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/stb0899_algo.c
+++ b/drivers/media/dvb-frontends/stb0899_algo.c
@@ -269,7 +269,7 @@ static enum stb0899_status stb0899_searc
 
 	short int derot_freq = 0, last_derot_freq = 0, derot_limit, next_loop = 3;
 	int index = 0;
-	u8 cfr[2];
+	u8 cfr[2] = {0};
 	u8 reg;
 
 	internal->status = NOCARRIER;



