Return-Path: <stable+bounces-114463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D278A2DFA7
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025391645EE
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DAD1DFE00;
	Sun,  9 Feb 2025 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbWPdf9j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFAD1D934D;
	Sun,  9 Feb 2025 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123840; cv=none; b=LwYNEqCcPUVipacz5laQisCgmpdlG0J90XYrf5IWdznclBShpzlGqJ8MIDauPJnokRmrC/U/rMmGiErbjijOptbByT8/ET9jzgwKJvuX4EGAbHJ4t1HggGw/ofDdvLfGpkJrfhE9ByA4QvBVRVFZa2CfvOhom4ybKrcLD/p6OPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123840; c=relaxed/simple;
	bh=EC7veTffKAd5tVYaCGrZbWssybzZhYfYxEDOCHodY+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tKFH4wqp2zKjhcObId96UdLvTe+aSuwreobU61KtPmnDWj4GTu7XPJIS4mkWkjVi/ag6G7asTeHiquvnNv7GpFfsDbU7kxq3SwaIsN1QP/UVFSRgXVtSfvPpS/tqku7QfiplTs3YiJ2/3KyhDbbFmBqK6kws+VOizCPc2mQho3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbWPdf9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F0DC4CEDD;
	Sun,  9 Feb 2025 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739123838;
	bh=EC7veTffKAd5tVYaCGrZbWssybzZhYfYxEDOCHodY+E=;
	h=From:To:Cc:Subject:Date:From;
	b=VbWPdf9jLqIOwOut8//F8lPBUwQ+DMKYUh4agRZfCMFgbaFR0Of33F7Yq/5WqqSp8
	 1ArtX6acOJ831WrC0SEwkHgh85VBt3ldcqbyMDhr52ZnT8yyJ5dZoHhAukdBcan2bv
	 d+KFv+L/n6TLsTTzVEu/Vzzx/88bd9Me9B6VeKxT0lZDMZvEC4J1iV0su9BonGkiwv
	 +PwSx95n5FhW+0XupHhHOAI/hTUv5PZGn020/4svalU7wUvdl6cs8rPaReaAVpWZEf
	 PLAD0Dvhg03ZwDMrZxh2beWTaCI400yGZrsYYZi878CX4sPibHGOzreIbXOkWhqnFA
	 4LHCy85a8OjyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] mptcp: prevent excessive coalescing on receive
Date: Sun,  9 Feb 2025 18:57:12 +0100
Message-ID: <20250209175711.3408345-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=matttbe@kernel.org; h=from:subject; bh=thxsP8TyGc5dK4aecRo00/XRyPcVGAuaWLiqmY5zTpY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnqOx3a4kSHqN7mjeqr+VIS3IYiBkS5SAS2qhbn NaRGS7AbrOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ6jsdwAKCRD2t4JPQmmg c8j/EADXKgfe9+8kADx6258rKfpkgrImopeHfkycgVZU+fZlQtA7UQiqOOftphjO1uXwD7zAqPC VYXqHFpR+vihAeH1mxMjNH8FYA10gi8R/AUvn1aT8XszNdFSnXORpZlFI4UdL8LAfMUaHY3MrLm CnXwiTEfOmFqOcxyq/Wcu6ZmIJyEJBvu8+S+Gk1qUuvut/MXkTOBCiJwR7ZoS2LT/m97b7vuY1K q2sDgsWz/xG6ETNZN4ZW4pstyv0JmfqmPMvIPDuajNkC63mHwR3on9YqgmSc6qcsZ4R9VMQiXZW Qq0qM2Pn/f04jfMXPG1cxiHA3ZzwYNFx/cnAkbQRS7/r8QakH70Y3oCVVTy9R7maI44J1rkHeMC 4RYKle2fiLoHP5wFqLVPe7O++7sdJS9XzYSipHzxCPFyFdUPkANYzhqhslChzOFK4gpoGlynGQc xyg59VeEeN+H2+tT+UyJwN9vglWa+g+yMhu9SIBbQeaNIADANitK7dhdX093QNu7FAmcpMqkeRB uG5exk/FcTudkNapYEkd+xY0JQYQ7sqeDHuUg9u7CMEn0r2hbNvh2cKBIjCgDbrz7bppJ5Vgfwv tulwgy+Sj/c79L2EV2TW6qjbLYCHEEqYuW/9xfh/phGUhbt0OvsMEFvCVNlgQz0QzzgVHVwpFmD l7NP73rwPwHnJpQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 56b824eb49d6258aa0bad09a406ceac3f643cdae upstream.

Currently the skb size after coalescing is only limited by the skb
layout (the skb must not carry frag_list). A single coalesced skb
covering several MSS can potentially fill completely the receive
buffer. In such a case, the snd win will zero until the receive buffer
will be empty again, affecting tput badly.

Fixes: 8268ed4c9d19 ("mptcp: introduce and use mptcp_try_coalesce()")
Cc: stable@vger.kernel.org # please delay 2 weeks after 6.13-final release
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - We asked to delay the patch. There were no conflicts.
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fac774825aff..42b239d9b2b3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -136,6 +136,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct sk_buff *to,
 	int delta;
 
 	if (MPTCP_SKB_CB(from)->offset ||
+	    ((to->len + from->len) > (sk->sk_rcvbuf >> 3)) ||
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 
-- 
2.47.1


