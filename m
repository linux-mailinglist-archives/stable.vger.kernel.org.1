Return-Path: <stable+bounces-101985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF69B9EEFF2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F033A1890AB1
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FC323098A;
	Thu, 12 Dec 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vO4zrUYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A849B2236EA;
	Thu, 12 Dec 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019527; cv=none; b=OfPHEOBePex+rfJqOEmzCvGtj1d3mFXS6+PGxQVaeDAa4KUcHAOUroSphvU2EtXYmKXqEMgNt/M0tdgZzt6oFkm37y7/RvceuJ07vklJjcuyXQkQRUINfyNLE4ttcziVWJA6MpKdLPcyvs/A5j9USk/iXK6XLbf8ok80+IPOIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019527; c=relaxed/simple;
	bh=H6og7SWPpjpaZae0lxfR1ywJwL7R2SvmnU0jWgz54qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXOUisTz+z+3d77QYkuI/Lumu5YwyDro+N1+4WJ0LL/GLh339kZG3pnc8qPEYpLwBaXYkxnD6JM/7mKgDY3AQ6t31PwmC7QSHSugp3q3Oko4OfnN7UpafRrAfivNIcEPgGwJ3wDrTWDs4bvatf89xB6cGkgTjHG4pueXIMJZ79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vO4zrUYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1135FC4CECE;
	Thu, 12 Dec 2024 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019527;
	bh=H6og7SWPpjpaZae0lxfR1ywJwL7R2SvmnU0jWgz54qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vO4zrUYkQZ4jfU/zpU467kmZQoAbdCoQ4yvtRr/p8NNJtRCjYvz3O7C+FdedWj7SO
	 r5I/yn457c4wDS1NzzfzNO9UXuAVxKSd5WLD6YT61EVCfLT94EWg3JWBzQzM3D2Ee5
	 YMSebAsiBmZtjdwDOaW0p76AzhsS24Bop1vF3GC0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 190/772] selftests: net: really check for bg process completion
Date: Thu, 12 Dec 2024 15:52:15 +0100
Message-ID: <20241212144357.795704552@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 52ed077aa6336dbef83a2d6d21c52d1706fb7f16 ]

A recent refactor transformed the check for process completion
in a true statement, due to a typo.

As a result, the relevant test-case is unable to catch the
regression it was supposed to detect.

Restore the correct condition.

Fixes: 691bb4e49c98 ("selftests: net: avoid just another constant wait")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/0e6f213811f8e93a235307e683af8225cc6277ae.1730828007.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 00ab4c6e40446..dbfa56173d291 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1932,7 +1932,7 @@ check_running() {
 	pid=${1}
 	cmd=${2}
 
-	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "${cmd}" ]
 }
 
 test_cleanup_vxlanX_exception() {
-- 
2.43.0




