Return-Path: <stable+bounces-49869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D28FEF31
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C85A1C21721
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546C1C9ED5;
	Thu,  6 Jun 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AoAI84zd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AA1A2568;
	Thu,  6 Jun 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683751; cv=none; b=WiPx0ChWKYfd1hQFCSjzSXvW25pFJzAqgSHsC504Y3M98br41ojECJoIBX2GqKlmQ8XCx/S481jsLE3NEp1mL00cuuAfwvkQILnhrOfZGh+npuHnl9zG+NI1aVOaKlZvLNXS3pcKEe0NRB1U8PfuVJs5nt4tCIA8FdtEO+Z0l0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683751; c=relaxed/simple;
	bh=ChOVSZ5VMTflUxNXaQlKyOaL2fD6oZVq6yeSDJ3MmU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDSHJhxDcB4fH+Od37QHHHenUBQk226w0GW7VUiucf5nhAjVTe1m6AZRd1t9xnmPyDpv/bxiZ5hVKDwiNXR1qP1graacEN0pJqVXTIRjCNJyzqdCcPxcKFpI38o4+3uSMKpBbGQrd7dmXuYB2MDTxr+4LCcW+T4EW9sy6nc581M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AoAI84zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A0C32781;
	Thu,  6 Jun 2024 14:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683751;
	bh=ChOVSZ5VMTflUxNXaQlKyOaL2fD6oZVq6yeSDJ3MmU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoAI84zddJcfRn5bpECM44jlsExaVoueahyLN9e+BgkFDmWvt2zxeSGEoNKGID8Wg
	 z76AIw0ddWyZCypRVmq+Lw6ZxTAmV+2+mWY2C2+UQiA8s97b2fewERhxap8qKHb+HT
	 UkSVT+Jrk1rYHSfqAELG+WmNjCTad+9zmxNor8AU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 720/744] kheaders: use `command -v` to test for existence of `cpio`
Date: Thu,  6 Jun 2024 16:06:32 +0200
Message-ID: <20240606131755.561073629@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 6e58e0173507e506a5627741358bc770f220e356 ]

Commit 13e1df09284d ("kheaders: explicitly validate existence of cpio
command") added an explicit check for `cpio` using `type`.

However, `type` in `dash` (which is used in some popular distributions
and base images as the shell script runner) prints the missing message
to standard output, and thus no error is printed:

    $ bash -c 'type missing >/dev/null'
    bash: line 1: type: missing: not found
    $ dash -c 'type missing >/dev/null'
    $

For instance, this issue may be seen by loongarch builders, given its
defconfig enables CONFIG_IKHEADERS since commit 9cc1df421f00 ("LoongArch:
Update Loongson-3 default config file").

Therefore, use `command -v` instead to have consistent behavior, and
take the chance to provide a more explicit error.

Fixes: 13e1df09284d ("kheaders: explicitly validate existence of cpio command")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/gen_kheaders.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 6d443ea22bb73..4ba5fd3d73ae2 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -14,7 +14,12 @@ include/
 arch/$SRCARCH/include/
 "
 
-type cpio > /dev/null
+if ! command -v cpio >/dev/null; then
+	echo >&2 "***"
+	echo >&2 "*** 'cpio' could not be found."
+	echo >&2 "***"
+	exit 1
+fi
 
 # Support incremental builds by skipping archive generation
 # if timestamps of files being archived are not changed.
-- 
2.43.0




