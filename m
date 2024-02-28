Return-Path: <stable+bounces-25407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C5A86B626
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 18:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602FB288C61
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7115A480;
	Wed, 28 Feb 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT4vfpkp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0036129;
	Wed, 28 Feb 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141855; cv=none; b=rBKQ0WzWivD/+qDTIyvbYEcDEvM+7cI3eZomCLhXxI6EnoiI0wWyvPsm3HWNJaOrmF/8om7Dz7DuhO632ulQf0l07CeeGyETnBpqAWoJ7SYb0BFFAf4Ksw7l4JuvY/FdNdgTCss0EoYTCei/bgiV2XqSIUE+lwIDF6glDbGjSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141855; c=relaxed/simple;
	bh=ps+Puel8dncwghUsDAGEZX6pdM1glgAZebbTHA8jqtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cez5Ebg42g4P/PQXvdrcMXTkZbDooMJxTYVTOUf9a0SBJIuDhhqrU2Bz2ogY7cOp5H18Mj8CUbeka80Un2xfJ8VtjBzv2OugW3tbCgMgcTp0V1WVwrwr5St7MNv0Ba9CkposaBysH5m9WMyQ4+Lh3Z66xK/HD2Vzf8n8WWojkvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT4vfpkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE549C433C7;
	Wed, 28 Feb 2024 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709141855;
	bh=ps+Puel8dncwghUsDAGEZX6pdM1glgAZebbTHA8jqtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT4vfpkp4Qhn8r0GNw5SE8TETMEozAyTrj1BOTr0E7kZOFiTwQK7Y1TzSHUYZBc5O
	 TQ9FDdxYkPc60+/ByISlm02rSWrFwVD5Z38cQ8WOsmoHHxKUOnFm5/bje20du8Vrzu
	 4AlHXXglNgbznjwxZg+T0Uvbdp8nKHinymOSR/E/UTmDD3aKgNlX8Tj+2qSLGhCR78
	 RYjsIX7qTS708Bu7ZII5mOAACVCNbQavi1n0aamTiVsAION9PVZEAZ+HbrcXjd1I1D
	 /t+fJJhlFK3cyy9XnKZupr+CL9fGilIHaMaiC2q/wZmsduXJSAUj/eDQG7YWkRd76d
	 xnfbgWVR3OxDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Jean Sacren <sakiwit@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.15.y 1/2] mptcp: clean up harmless false expressions
Date: Wed, 28 Feb 2024 18:37:15 +0100
Message-ID: <20240228173714.262012-3-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024022732-wrought-cardiac-a27a@gregkh>
References: <2024022732-wrought-cardiac-a27a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=matttbe@kernel.org; h=from:subject; bh=EUL/Nrn6D+P9SJUgHWInrLAzrE7lYLJjREe/LVRzWPs=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl329KAu3/W8NwU0Wki4EJwiPMdn56b77XK8G2S weQVZ9lg4KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd9vSgAKCRD2t4JPQmmg cwrQD/9J8fLDqQraGZDFm2ZjRghW8IQvtyoaC3nXERTNTvDKg8KamBDnH29xG1BTEgOZjtwn/S/ cKu58OULwUZu94gsZaH4dm5aTGjPQ4ls0AFau1F1vRDiITGfZ4WX7RywcfgGxPbKb280nZ+WtUI kMBUE938yAAg5yrq4f1h1E44aq1byZnHaV4L41m8Ti7h2O6OE68IpJuLj+dMXmckmKZjDVEditO SLkxqYV3OjG27moe9rbeugZ3Zebb3/eHfsOZLU2TYivBGptKebGlzHCgSvRcm4tj87cvcjBovX9 3/H3GzX8DwlAm+n/g0YRkAUjAWgO/JJxJI1adm80/cm46tEw98WjrTMWOXqmNUI8gekg7Kt9RDT 9y1Ngw9AxB8Z52Oz7zcqOnTdvQOYOJ34ZEs00lf1fznQSDOM9ovcPgc3ACQIESb2/V/X2aFuH4p z/W8k+3KuPE4WBS0HRZMa7DfrVcp3LyBcBdZXEZkciw3xrShVE4JswS5J1YDkESmBM3peirKi89 QOXcCsyXrUKCPSTbusFPPTnvdhEw/pxHN0nbY5ohNk4cjIk1ZoRvSCxNTKNqNYkFQ5VaGWSvvYl W7yJJRiAJLM3l/vj75PArh6lgDExmtmqx/LOYCqg78ulgt7ZMrMY2IP8Y7xTMG+HS5lF5GGQtGS rjTjToFauzDy/qQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Jean Sacren <sakiwit@gmail.com>

entry->addr.id is u8 with a range from 0 to 255 and MAX_ADDR_ID is 255.
We should drop both false expressions of (entry->addr.id > MAX_ADDR_ID).

We should also remove the obsolete parentheses in the first if branch.

Use U8_MAX for MAX_ADDR_ID and add a comment to show the link to
mptcp_addr_info.id as suggested by Mr. Matthieu Baerts.

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jean Sacren <sakiwit@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 59060a47ca50bbdb1d863b73667a1065873ecc06)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Needed to ease the backport of 584f38942626 ("mptcp: add needs_id for
   netlink appending addr").
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 935f351751740..6018d9641e0b0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -38,7 +38,8 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 
-#define MAX_ADDR_ID		255
+/* max value of mptcp_addr_info.id */
+#define MAX_ADDR_ID		U8_MAX
 #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
 
 struct pm_nl_pernet {
@@ -854,14 +855,13 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MAX_ADDR_ID + 1,
 						    pernet->next_id);
-		if ((!entry->addr.id || entry->addr.id > MAX_ADDR_ID) &&
-		    pernet->next_id != 1) {
+		if (!entry->addr.id && pernet->next_id != 1) {
 			pernet->next_id = 1;
 			goto find_next;
 		}
 	}
 
-	if (!entry->addr.id || entry->addr.id > MAX_ADDR_ID)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
-- 
2.43.0


