Return-Path: <stable+bounces-127123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDA0A768CB
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2793AF49B
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA73422AE4E;
	Mon, 31 Mar 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvRoCcdK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FFD22ACF3;
	Mon, 31 Mar 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431826; cv=none; b=ZhQto5krsaDnDkNwcb4bCDYTrjncNvON3cL7xIM5vU6hvv0cl4FoA5DtM5/SlvpPMunk8LJoUWgfrldHcIKYBMlQvrRpiB1DpO3CDq5dQ05lpMfnK0EmznwRpwhPJt65FY9LpTvAVM3I4pIsf6RKP/WwPmgx3333WF11+DXm/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431826; c=relaxed/simple;
	bh=nel+CNbtIcIbXhGVRK9Wmqiu+JKidiJ+yS/1506Ry7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jvbJlUx8rlCU0FGjmn/oIEmw8NgmMFheD0JK/Le6dNvMNzFrzEoSiZT9R1d6TlnMjp7AWCy2A55yGkuwRpuK/dFhlBIQP+QaUTzyT6srzi1aYqwdLdxsPEwRRTPwnZ3p9hfEmxaAw8Ks9vwwDxLBngqP4cTt1n3p/hmknf01yWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvRoCcdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6F9C4CEE3;
	Mon, 31 Mar 2025 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431826;
	bh=nel+CNbtIcIbXhGVRK9Wmqiu+JKidiJ+yS/1506Ry7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VvRoCcdKyM1YnC2sLw7PYo9EeSljwzmSUm6IOBs9F51uoW0ikGvvCqMyRi28mgbjE
	 U3JlYr2tYH3GTXGIi5DuBZjp7Wb/pTTV2KO0FWMV+pomjIciJlATP1xL/TEauuoODc
	 pU+QIQOq7EdJ9GF9qKmjyqt8FPxp/OczmZwpryi69pm5yH0erY5lmBOGNjmsLTPISt
	 ZXXS1i/xOJ3AmUUja5vab3TU2tK5xh5pAx/4wYmpAKuo1h6Ec3eg5rIYWFRnytEUwv
	 DopSbC+PFM71ttxarOSHsHaQo3NlPgTFnvnS6sdNWOysyXWb7OOvORjonbTH8Nxalt
	 /NalOVFlD34vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 5/6] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 31 Mar 2025 10:36:50 -0400
Message-Id: <20250331143652.1686503-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143652.1686503-1-sashal@kernel.org>
References: <20250331143652.1686503-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 1c3dfc7c6b0f551fdca3f7c1f1e4c73be8adb17d ]

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250310222234.work.473-kees@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/xen/interface/xen-mca.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 7483a78d24251..20a3b320d1a58 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -371,7 +371,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.39.5


