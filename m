Return-Path: <stable+bounces-120531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6188A50714
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E670818934F6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C02512C7;
	Wed,  5 Mar 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/NeTN++"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FB2505A7;
	Wed,  5 Mar 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197231; cv=none; b=eKHXZ1uAsfAYLXAq5gOssM8H9rsjOxR188jd3tXC9O4k6RcO1+xtcwlCuASzg4U+S6sr6Zd/GppTerY0EnJAYp5kXuEbM3y+TVut4Gja2k87SG2A+y9Y5P8FX/Zvs8Af1kdslKrm0UeFY/SdyasKjVQozHrIAELh5agvTLwLq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197231; c=relaxed/simple;
	bh=lv7A4BiFSaJuSpYcIj7QN6tumXJrMMegefy88z263QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jsq4WZV7gYua8Mz2P9Yuy138zRVNKBUHWJdoK3j/LT2Y+kN6uF81FdKQSp/PXzt59b6YTkkhDpR1sEuBkoLBmXJkBsXLVWplipGBiFKBKOFVcxBlN094A5h4Gc0kOUM5Eb/8+rQHDZbKJk5cKskd/THBDhkGiMhzEP3syqznzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/NeTN++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252A2C4CED1;
	Wed,  5 Mar 2025 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197230;
	bh=lv7A4BiFSaJuSpYcIj7QN6tumXJrMMegefy88z263QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/NeTN++gaLWL4TWoZAnUK95YzRencmKDuxQhdTp2u/le0+BSDXnKEq+bLP2E3O+g
	 7a0GGn9EZ4U1RQ2gYx9rDouYAJtUoVuwP4QOj7YGgKbVfN/QPRpcbvDedYPplfJ3+h
	 iNPGCNmt3Evx4PLDPqnlrncg3+h1BQQmLvYjV52s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/176] power: supply: da9150-fg: fix potential overflow
Date: Wed,  5 Mar 2025 18:47:16 +0100
Message-ID: <20250305174508.146226764@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

[ Upstream commit 3fb3cb4350befc4f901c54e0cb4a2a47b1302e08 ]

Size of variable sd_gain equals four bytes - DA9150_QIF_SD_GAIN_SIZE.
Size of variable shunt_val equals two bytes - DA9150_QIF_SHUNT_VAL_SIZE.

The expression sd_gain * shunt_val is currently being evaluated using
32-bit arithmetic. So during the multiplication an overflow may occur.

As the value of type 'u64' is used as storage for the eventual result, put
ULL variable at the first position of each expression in order to give the
compiler complete information about the proper arithmetic to use. According
to C99 the guaranteed width for a variable of type 'unsigned long long' >=
64 bits.

Remove the explicit cast to u64 as it is meaningless.

Just for the sake of consistency, perform the similar trick with another
expression concerning 'iavg'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a419b4fd9138 ("power: Add support for DA9150 Fuel-Gauge")
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Link: https://lore.kernel.org/r/20250130090030.53422-1-a.vatoropin@crpt.ru
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/da9150-fg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 8c5e2c49d6c1c..9d0a6ab698f58 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -248,9 +248,9 @@ static int da9150_fg_current_avg(struct da9150_fg *fg,
 				      DA9150_QIF_SD_GAIN_SIZE);
 	da9150_fg_read_sync_end(fg);
 
-	div = (u64) (sd_gain * shunt_val * 65536ULL);
+	div = 65536ULL * sd_gain * shunt_val;
 	do_div(div, 1000000);
-	res = (u64) (iavg * 1000000ULL);
+	res = 1000000ULL * iavg;
 	do_div(res, div);
 
 	val->intval = (int) res;
-- 
2.39.5




