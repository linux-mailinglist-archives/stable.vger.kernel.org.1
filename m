Return-Path: <stable+bounces-161112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1966AFD372
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B302168F41
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007462E041C;
	Tue,  8 Jul 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XAxcpOJV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD42DA77B;
	Tue,  8 Jul 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993629; cv=none; b=AQnDk5hP9mRO9zTu7jEtSBANUJISrjqu3QefCV/hQV79yPNq26UT2yFPWBG3sz8HuOXPS99iz2a14J9n0dxOCWaZ+5zuBACmzLsH4vCuUZRVb6F1za7uu9xqSPKCv8T7qksuJXsTu5tchcUJdiFE/h53kJsV7GnX9uiKKNIp7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993629; c=relaxed/simple;
	bh=9dBJ42AyEhaBfPFEJQTBb/y8P230tNANPNtEcbx44ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9BoInMo8iFZWy6w7p4E1OBppqPkMVafW3TdEA8xMSEdD7OypQR0egl+8BEGpr4TLGoJ5rOJM8wSmRzyhNgyXCxVbhm//bhHdRec7BS0BXdmjEOfBoi60i8gC8GqJzcUYRSPh1RFPfuC6GL2gAsXbbJYaYi6tsmjBoSgn8xEbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XAxcpOJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17ABC4CEED;
	Tue,  8 Jul 2025 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993629;
	bh=9dBJ42AyEhaBfPFEJQTBb/y8P230tNANPNtEcbx44ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAxcpOJVDuuanKh244zb3I5rwfxrdg6qz/WjiZ8VSw/0/ltMoSJ7Qx0AaY9ZY/Ie7
	 5ZTxgE+TqO3QUgDKdzY3auF/6qLurffdZ+qNBMAVGRwlDUHmE/0f+V+falAutVlS7U
	 t80x8bn6H6hmuj/LraHpgFqV967TKp60ZXj+MOvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 109/178] lib: test_objagg: Set error message in check_expect_hints_stats()
Date: Tue,  8 Jul 2025 18:22:26 +0200
Message-ID: <20250708162239.475270396@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e6ed134a4ef592fe1fd0cafac9683813b3c8f3e8 ]

Smatch complains that the error message isn't set in the caller:

    lib/test_objagg.c:923 test_hints_case2()
    error: uninitialized symbol 'errmsg'.

This static checker warning only showed up after a recent refactoring
but the bug dates back to when the code was originally added.  This
likely doesn't affect anything in real life.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202506281403.DsuyHFTZ-lkp@intel.com/
Fixes: 0a020d416d0a ("lib: introduce initial implementation of object aggregation manager")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/8548f423-2e3b-4bb7-b816-5041de2762aa@sabinyo.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_objagg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/test_objagg.c b/lib/test_objagg.c
index d34df4306b874..222b39fc2629e 100644
--- a/lib/test_objagg.c
+++ b/lib/test_objagg.c
@@ -899,8 +899,10 @@ static int check_expect_hints_stats(struct objagg_hints *objagg_hints,
 	int err;
 
 	stats = objagg_hints_stats_get(objagg_hints);
-	if (IS_ERR(stats))
+	if (IS_ERR(stats)) {
+		*errmsg = "objagg_hints_stats_get() failed.";
 		return PTR_ERR(stats);
+	}
 	err = __check_expect_stats(stats, expect_stats, errmsg);
 	objagg_stats_put(stats);
 	return err;
-- 
2.39.5




