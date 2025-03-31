Return-Path: <stable+bounces-127091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41CA76850
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2F5165A2E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CFE222594;
	Mon, 31 Mar 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/nnhhYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8456E222592;
	Mon, 31 Mar 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431723; cv=none; b=SK/FYDT/OxZscjeRo9hWmmi9MvFuaLydCj2S2YPWQvPTn3vW7NTLZ9fv2PDPeiRhDWb/7EMwvKoHfBtAVpwWL49nxamM04Kuy1dELG3WVbSaY5BeL3QeT1h71E1YLi0tv89neyF/f4EoeADRkHA+H4V0O8jYeeNVwiKOWBRRd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431723; c=relaxed/simple;
	bh=xaEMZxbQp1Qr9ivAjB59KF4a/0OwWMSbOUS1BmmeD7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7R53oA3/TfNvK8gE6WGf6fpBa6HUeLnHkYmKo9DzDBBXQkRbBgJKUZurZ13xnFQlFGGCZaYBFlEFCC6JMCDzM8QH+EBMMzJ+c/RjP0Z6Jm6QizNM0cvcqF+svmqQ/kyvwfs9pLrRY5nQpdV1TOKAa6qkwIyHEOVaUeDLqAW09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/nnhhYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7597AC4CEE3;
	Mon, 31 Mar 2025 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431723;
	bh=xaEMZxbQp1Qr9ivAjB59KF4a/0OwWMSbOUS1BmmeD7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J/nnhhYyj3OQeyhGvZqlY0j0F55GYJDn42J/aSoZf95LdaX2R8vYW9EQYh68w+0r6
	 4juIMWe6/J5OUZ7XUSEM2Uz2FKdSAqIKIr2D5x5uvnYXCp9FwBFGfLh28qkRDCxvQq
	 Nb8nWuwqpFac0/njVvkUic5IBtpNJzj1p9SKOH+GWvbwVZPgDXCt9R21jbpkGted+m
	 nDkT+/RJ5LCLPI58U3ZFJYh7kZ9dtugV0Cpm1hYrZopq3eRlwnalcfGAEIRNuC5qdU
	 AxF3M6s623wHYvwmSylSFBoKnIbB8OuejaJK0MsG1m/ogXCFV94M42KeqCdONBCMa5
	 2DSD3faoTwFRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.13 13/16] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 31 Mar 2025 10:34:47 -0400
Message-Id: <20250331143450.1685242-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 464aa6b3a5f92..1c9afbe8cc260 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -372,7 +372,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.39.5


