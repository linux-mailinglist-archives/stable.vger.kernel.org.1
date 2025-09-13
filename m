Return-Path: <stable+bounces-179489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D8B5615C
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF64C7AB695
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104782F0670;
	Sat, 13 Sep 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyDdKTYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D702ECE9C
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772632; cv=none; b=jQNvFxdsitUFoIKbDozTrmg/4sNiVD+J4dnckLmkz5jq1998C5Ze6pw8df9o6H7AIA36wVeUxwmgT2XyMR0G+Kgy2wdNE0CvBpxQMOvOmP4+ZJUXtODOD0lpGP/dYSpjRF6q9kV+pEhCrARyRSUJszUqNoP7g8C/jvzHgj9blCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772632; c=relaxed/simple;
	bh=0pXjICjYX3aL5hHtuPdVRmkIIJbBo/pwHMWa6Rp+u8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvUjhlVrV3RLBVq/JgNYeAlvz2uJJ5j5ghIfBXilaT17XvFQjz928mD68kf+H6mfO9F8CZ3rI2w9Lh5Q/XG2gticTin1G+7aDjaNFpneiW2teytnMQ+a4V4dljUb/XkOvzKgu5jBzENPBubEMed5TTTBJ7B2QBxRoC5b6Zeigt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyDdKTYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8052C4CEEB;
	Sat, 13 Sep 2025 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757772631;
	bh=0pXjICjYX3aL5hHtuPdVRmkIIJbBo/pwHMWa6Rp+u8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyDdKTYmvjitP/pri2+S413VdFdbCSBO0euH4g1lJKZhogK3SbxCZ5T/ecrD2Zkni
	 5ODw6v0UynQ4y0+5g0l8CsVCZMBHRIImPoGKlDsKLDpq4o/r7j2akDr5DqCsV3iJcM
	 Ymp1ryg+h8qQ9lIO9wZDJ1ZpZbOZCSIS0CnRdeRhSrBxwtXJDt4IQVTheEMGxX88vS
	 SA2h1UjFcQj2J5LFoX2M8f7Up+bMnH4vuNRsrfcGYlJv++lPGkQuFDcPZ71QHJpxKK
	 JIoITOot2ozxWccatMu/8Xmi/uAoxkX+E++t8XCS/65dBhorZdcP52gDLHKNd55NJ7
	 rfE4Rt1eA4Fmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] netlink: specs: mptcp: fix if-idx attribute type
Date: Sat, 13 Sep 2025 10:10:26 -0400
Message-ID: <20250913141026.1362030-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913141026.1362030-1-sashal@kernel.org>
References: <2025091346-avenue-afterglow-5b42@gregkh>
 <20250913141026.1362030-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 7094b84863e5832cb1cd9c4b9d648904775b6bd9 ]

This attribute is used as a signed number in the code in pm_netlink.c:

  nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))

The specs should then reflect that. Note that other 'if-idx' attributes
from the same .yaml file use a signed number as well.

Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index 170903a624a84..7e295bad8b292 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -256,7 +256,7 @@ attribute-sets:
         type: u32
       -
         name: if-idx
-        type: u32
+        type: s32
       -
         name: reset-reason
         type: u32
-- 
2.51.0


