Return-Path: <stable+bounces-53357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508A90D145
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21B5287E48
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2ED15821D;
	Tue, 18 Jun 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1PxA2XPM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A8149DEE;
	Tue, 18 Jun 2024 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716089; cv=none; b=k8p2eNB/pi9DaVOCH6JVfju7+g8r4EzTnkf/jCsnVWhScCW5g9uqRwa/1QzExnmapJ9t8iXblyLJU/vczojoeVq6qf0tTMZ/tdsIfCyLpK6mpbS0PpMBCYq+uyixrc9H2Z+62UWzkGI5E3xOnyZ+bUx2z/4JsJqzOhlWCYJfx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716089; c=relaxed/simple;
	bh=4KDnLU64IUSiMLlF8jqPkZDG2S8SL4jRpOB6iqOhqXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAJ6188v6JKqLNpIw9I05ax/FE/KZECB4YnLyWy3gkjjkLCiIt98MipQTUIoUv+quNg3orl6OJ99IgbfZj14kKHI5QZxMxnjWcV7zi9YKJEmaB5+kSUI+BdvQUwP73q1RzPfHiwIddouYv4U900NFulpZtvtT/lZwu65tHXLiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1PxA2XPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D667CC3277B;
	Tue, 18 Jun 2024 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718716088;
	bh=4KDnLU64IUSiMLlF8jqPkZDG2S8SL4jRpOB6iqOhqXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1PxA2XPMUjEoF/GB0VgW9G4GZMqhOzEc+UXtPuHC9FKE7BW9obhOvORmEzZcSBWyx
	 sXwjBicvHp0aU2f5fbkyHwDoDvVgx9lnmItEstBSgCBrWkNCPPSP4ow6cLTqentxgM
	 sOSc9ZP4uJa5kqXcdka+NXYW4HE7OZhCXjNGQ48s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 529/770] NFSD: Clean up the show_nf_flags() macro
Date: Tue, 18 Jun 2024 14:36:22 +0200
Message-ID: <20240618123427.733746016@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit bb283ca18d1e67c82d22a329c96c9d6036a74790 ]

The flags are defined using C macros, so TRACE_DEFINE_ENUM is
unnecessary.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/trace.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index c4c073e85fdd9..8ccce4ac66b4e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -703,12 +703,6 @@ DEFINE_CLID_EVENT(confirmed_r);
 /*
  * from fs/nfsd/filecache.h
  */
-TRACE_DEFINE_ENUM(NFSD_FILE_HASHED);
-TRACE_DEFINE_ENUM(NFSD_FILE_PENDING);
-TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_READ);
-TRACE_DEFINE_ENUM(NFSD_FILE_BREAK_WRITE);
-TRACE_DEFINE_ENUM(NFSD_FILE_REFERENCED);
-
 #define show_nf_flags(val)						\
 	__print_flags(val, "|",						\
 		{ 1 << NFSD_FILE_HASHED,	"HASHED" },		\
-- 
2.43.0




