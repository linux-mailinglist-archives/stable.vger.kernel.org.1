Return-Path: <stable+bounces-98889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A813D9E628C
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 01:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D2A283993
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAB84438B;
	Fri,  6 Dec 2024 00:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eLeNS1rW"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F13BBEA
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733446392; cv=none; b=lijq6b9Ibj85g7nMw6jWkGcKDUDcw0bp7T9uWzbP23dbsEFpc/u3BGjpI8nPC7jkJkYApaQwGkxOrcV9LJOwTFsEm5kJ7xm60dKoXndn6bCD5ZpXpfpVU8ibMPhvsLCQM/cCrTROM6WYg9syh6oyiquM0eJ2lOS1upwNbtfFLG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733446392; c=relaxed/simple;
	bh=Wwz17/zhfYFbbFxy81RaIgqyHTpcJu8VU0c4FjQZIqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pwe0mdLZeYSU9PfLzvzy0g24JzI7ha4ZhwbsWGxQScWG/3hiQykySEc7K01gZtvRBATmHkDfZ06PLpiWFVT3nyrEWSykw0ovFjyU+PLkzSwh/lqqJuSswMQjhmfmHaqS97/DKhQF57gjSnwdS20LADZ7xvy19Q01dE0APGuI364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eLeNS1rW; arc=none smtp.client-ip=17.58.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733446390;
	bh=Z8FxYowJt8L03PaNytmuPjkcdXVFkhckag7aRnXxAiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=eLeNS1rW03NcojFnd0UQ7um3nBqmjQXtLh6FEjC31VkcTdYLrqSUpCwJiuhYO5GVW
	 QWHX2XiGfKdt668M93bqV4J8xJCV+WebgvLVvvxXtyqgNTUfaxc6KnQFkEnzdDO7u1
	 r4+C6D0fz7+zSc5shNvuyxLF76Jb4Vh6OE4rtHFfqBU/Lb81KAqEdbGDQFxu4BDMXH
	 sGE6GQV6yRzmcy+pT8UbSn36TLqqQ5VKkeDatUfriOEPBaOg0bERuAY8LEG8PL5zLe
	 pWpi3OtKf22Ww5Z3ZuesLuFGBMw9qk37Y9TEQb8rVjz/MI5TY1kRjce4mGFnHuD0S0
	 3FNwBFnVXnv+A==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 42E30A02C3;
	Fri,  6 Dec 2024 00:53:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Fri, 06 Dec 2024 08:52:27 +0800
Subject: [PATCH 01/10] of: Fix alias name length calculating error in API
 of_find_node_opts_by_path()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-of_core_fix-v1-1-dc28ed56bec3@quicinc.com>
References: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
In-Reply-To: <20241206-of_core_fix-v1-0-dc28ed56bec3@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Leif Lindholm <leif.lindholm@linaro.org>, 
 Stephen Boyd <stephen.boyd@linaro.org>, Maxime Ripard <mripard@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: JLWXoN9J3ROI2oJSfcVDAoO7hFSlu5j_
X-Proofpoint-ORIG-GUID: JLWXoN9J3ROI2oJSfcVDAoO7hFSlu5j_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_16,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=878
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412060006
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Alias name length calculated by of_find_node_opts_by_path() is wrong as
explained below:

Take "alias/serial@llc500:115200n8" as its @patch argument for an example
      ^    ^             ^
      0	   5		 19

The right length of alias 'alias' is 5, but the API results in 19 which is
obvious wrong.

The wrong length will cause finding device node failure for such paths.
Fix by using index of either '/' or ':' as the length who comes earlier.

Fixes: 106937e8ccdc ("of: fix handling of '/' in options for of_find_node_by_path()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 7dc394255a0a14cd1aed02ec79c2f787a222b44c..9a9313183d1f1b61918fe7e6fa80c2726b099a1c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -893,10 +893,10 @@ struct device_node *of_find_node_opts_by_path(const char *path, const char **opt
 	/* The path could begin with an alias */
 	if (*path != '/') {
 		int len;
-		const char *p = separator;
+		const char *p = strchrnul(path, '/');
 
-		if (!p)
-			p = strchrnul(path, '/');
+		if (separator && separator < p)
+			p = separator;
 		len = p - path;
 
 		/* of_aliases must not be NULL */

-- 
2.34.1


