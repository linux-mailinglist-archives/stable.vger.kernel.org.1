Return-Path: <stable+bounces-24128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE78692C1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349051F2D6DF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0F13B2BE;
	Tue, 27 Feb 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2SqedV0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07413B293;
	Tue, 27 Feb 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041110; cv=none; b=fICYhnx9uRVE48VruLzG4VFkjrqlmrksUNhCx0XV9khC0KgXFIhR+PbygF0LMtPdt4tYZm2QivUqfsRkCEIF3Wa9jiHqteNgh4Txj7vxteKc0HGxy+EDF2EabMkJS/+Rth2pOhVKaMDcXaEXidaTqvUwML3nhTFMnTq58ue+Ts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041110; c=relaxed/simple;
	bh=Y5mahoa8cs/Emp/OmS/ES1vsEequwUhCXoYjdAwIfwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3aiawB5ck/QZ23KQElGK+rVG5l0VHdB98yrVd498IDgth7KHeEmewm/WnOjzD25W7jDv2UuGh4zebug5IX9IaONDZ2Wc05kdWDB4T1i8BMVAd6iQJyGszFibj/QCsNRDo7VVn27+pfoo7z2BeqAIQLYWIIPdskO1YTbvyJ+QF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2SqedV0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF12C43394;
	Tue, 27 Feb 2024 13:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041110;
	bh=Y5mahoa8cs/Emp/OmS/ES1vsEequwUhCXoYjdAwIfwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2SqedV0HiGkw/aZo8cZQqpkqaDeNCmPVQrEEMFcly+8ISiN9zaQBUKiVBbDTBuH0Z
	 QfzsrmDvfFQRP5+3dKVHNiwe3ofl32AeKmHWnCt1o7UYvfn/nQ0V+23lwMfBdQgkyX
	 WZHjmIzTGprMisD2C5SnJnrj9NIN+blkQMdKjKhI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.7 224/334] selftests: mptcp: diag: fix bash warnings on older kernels
Date: Tue, 27 Feb 2024 14:21:22 +0100
Message-ID: <20240227131638.015919949@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 694bd45980a61045eb5ec07799e3b94c76db830e upstream.

Since the 'Fixes' commit mentioned below, the command that is executed
in __chk_nr() helper can return nothing if the feature is not supported.
This is the case when the MPTCP CURRESTAB counter is not supported.

To avoid this warning ...

  ./diag.sh: line 65: [: !=: unary operator expected

... we just need to surround '$nr' with double quotes, to support an
empty string when the feature is not supported.

Fixes: 81ab772819da ("selftests: mptcp: diag: check CURRESTAB counters")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 04fcb8a077c9..e0615c6ffb8d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -62,8 +62,8 @@ __chk_nr()
 	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
-	if [ $nr != $expected ]; then
-		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+	if [ "$nr" != "$expected" ]; then
+		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-- 
2.44.0




