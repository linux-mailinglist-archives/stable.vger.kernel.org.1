Return-Path: <stable+bounces-57559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ABA925F6D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29EAB3D6D6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09F176FB4;
	Wed,  3 Jul 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pa1ecDls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DC176AA4;
	Wed,  3 Jul 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005251; cv=none; b=VuCt4PH22GwSB2BddINx6qpUwEQaV/QvSpHk5vN9u0EtNO4SCkN0q/tRFiuwR2oJlIzdI4hhrgXZSMHr3gIHUfAQfFtSHSksCkZw6OliwtWjZBPKZhqSHimQmYPogVK5XdydxOXyBdUPmBF92NNICvXk6jKKdRsnPPePkK0sNxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005251; c=relaxed/simple;
	bh=a6fCh9UFZ3gRRcIIowUrAHfflk7YH+v5EUkdQJkrtiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqkh/jFIf/HKvMtajj515fC/LTe9Rf5n6yLWklcq6YCn7rs1LTXF2vDpqloSjx34/kyDFwKrVTzYZBgeHSu7voEAhlv1HGfbA1lBNf12ZPlR/3jkBjcXeDkfrdrMOCm5N9JzWEi5W0q8UkevxrDHaQB0cjwJvpLeS8hDegXFVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pa1ecDls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06B1C2BD10;
	Wed,  3 Jul 2024 11:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005251;
	bh=a6fCh9UFZ3gRRcIIowUrAHfflk7YH+v5EUkdQJkrtiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pa1ecDlsmAgvDmaidqlRxHPhPUHEcONHZ4zjX0qieI737oMrO/12M8+ykgxg9q5Od
	 PszSuHDkBIvrrcALHJGdjsWuFUMVOTGCLxkFGZYeNOj8wdDQ0icZBiUD66YHn7sehw
	 98yMhqa9K1jzWfWS0RKFqk+LxWmNDyUrmdxXyRJI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/356] ptp: Fix error message on failed pin verification
Date: Wed,  3 Jul 2024 12:35:55 +0200
Message-ID: <20240703102913.827094094@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karol Kolacinski <karol.kolacinski@intel.com>

[ Upstream commit 323a359f9b077f382f4483023d096a4d316fd135 ]

On failed verification of PTP clock pin, error message prints channel
number instead of pin index after "pin", which is incorrect.

Fix error message by adding channel number to the message and printing
pin number instead of channel number.

Fixes: 6092315dfdec ("ptp: introduce programmable pins.")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Link: https://lore.kernel.org/r/20240604120555.16643-1-karol.kolacinski@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ptp/ptp_chardev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 9311f3d09c8fc..8eb902fe73a98 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -84,7 +84,8 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 	}
 
 	if (info->verify(info, pin, func, chan)) {
-		pr_err("driver cannot use function %u on pin %u\n", func, chan);
+		pr_err("driver cannot use function %u and channel %u on pin %u\n",
+		       func, chan, pin);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.43.0




