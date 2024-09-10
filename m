Return-Path: <stable+bounces-74688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D39730BA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F7C286E53
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03318FDB0;
	Tue, 10 Sep 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbpHTTCz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96518595E;
	Tue, 10 Sep 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962535; cv=none; b=gpropX6f8nbefgCWQ5bLcy0Dkw0ZDebPPYAfUBDDuguWSm83JQBf6wWcVsEnvhHj2B9OMzbfu20JX5cvimN5xguDEPmaAxC4nSpO2YIOK+Fn+MCcEJQtlj5ydgQApG+lYNwZDBZGHEvl31pKcYS92/LTfhKVowBSExEY6j793TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962535; c=relaxed/simple;
	bh=ye2iKNGVoLcnHgpFLm7QCR58TjVdXu5ccQ/63orpOn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/ghLgGeLXSNT47Yb/NYt7FQCKNd0YcKEt/rnzODr2ac1xPe034z0NSpBbSiaXUouyOD2BDTiK/tsUfjkBHG1nl5CVu4ehzaCV4gLsKmeQRno26/pM/uPRGMwh6bvyknUuC8GOvDpIP70/rDnb6/C/yBEaBG8GkBdWoSZoJ9AEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbpHTTCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC79BC4CEC3;
	Tue, 10 Sep 2024 10:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962535;
	bh=ye2iKNGVoLcnHgpFLm7QCR58TjVdXu5ccQ/63orpOn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbpHTTCzQjNill3jJAnQcgZ8Ql/rm42hsp4heMHahumxpoirEG9tVtyTs2oWi3Hno
	 rStoTgiJG4et/s3ebtzsqCbB5Jj/whbryEbhv5jgizJmNIF8Aa8hGfw3m8MeEd04mn
	 l56SBHmKqXh7toD9M1FRNWFsA5L5hujKSUOaUOVE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@bisdn.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 067/121] net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN
Date: Tue, 10 Sep 2024 11:32:22 +0200
Message-ID: <20240910092549.045181277@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

From: Jonas Gorski <jonas.gorski@bisdn.de>

[ Upstream commit bee2ef946d3184e99077be526567d791c473036f ]

When userspace wants to take over a fdb entry by setting it as
EXTERN_LEARNED, we set both flags BR_FDB_ADDED_BY_EXT_LEARN and
BR_FDB_ADDED_BY_USER in br_fdb_external_learn_add().

If the bridge updates the entry later because its port changed, we clear
the BR_FDB_ADDED_BY_EXT_LEARN flag, but leave the BR_FDB_ADDED_BY_USER
flag set.

If userspace then wants to take over the entry again,
br_fdb_external_learn_add() sees that BR_FDB_ADDED_BY_USER and skips
setting the BR_FDB_ADDED_BY_EXT_LEARN flags, thus silently ignores the
update.

Fix this by always allowing to set BR_FDB_ADDED_BY_EXT_LEARN regardless
if this was a user fdb entry or not.

Fixes: 710ae7287737 ("net: bridge: Mark FDB entries that were added by user as such")
Signed-off-by: Jonas Gorski <jonas.gorski@bisdn.de>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20240903081958.29951-1-jonas.gorski@bisdn.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_fdb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 83d6be3f87f1..89e0a6808d30 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1138,12 +1138,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
-		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used = jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-			/* Take over SW learned entry */
-			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		} else {
 			modified = true;
 		}
 
-- 
2.43.0




