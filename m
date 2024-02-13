Return-Path: <stable+bounces-19908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D340A8537D6
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E13628A2B0
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16A5F54E;
	Tue, 13 Feb 2024 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iup7iYL6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF15FF0B;
	Tue, 13 Feb 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845409; cv=none; b=heRAtQbEJuTrXckZZlsjD1g3u8Z5VHrWou3b0jNLyIHMJjQ+KWsmlU/otqQHHCVmNrLznUGyhNlMHyoBN0jH7/iFN+txqrYWT/Wtngy7jb5oh2HONu+hWbiohfgpNPsT1/7uhcS5y/NE2SeGJd8189kz+d1omTOpV4HAOqBq12A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845409; c=relaxed/simple;
	bh=hgmTlZZ3iqaA5ItYOOJ+Jhcwro4jUSBtoLpwQgRO+fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C68HrD8WV/5RaGtv3Uwj1WH7gl2XtMXIVEL7HAhuQ38ELALUDskq9A+q9aDAZugo4xdj7Pp8EdVho6M+NwBlftBGhnqQ/lHS173FVJx0wmxqBVF0KHP60p8GdgWR2b0accegY+PI9xsxuVp8m5vRe6cbcrOOFts1kxbrYPBL5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iup7iYL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4875FC433C7;
	Tue, 13 Feb 2024 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845408;
	bh=hgmTlZZ3iqaA5ItYOOJ+Jhcwro4jUSBtoLpwQgRO+fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iup7iYL6r84d8OzYJwkHKYKi/O0iFXx2xz2qlnqtg/LgVbpg/B5DT1CEWXZrvR2RJ
	 d54/moMS0l7S1F8mtWpbALhE1awe2JPPMVrf407A/8j5M09qhO6+QLZ9WmLX8AXfUE
	 ZyJo8/mmeOgL9F3uFZUAeZCWCE2rlDeI7fIjLlTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 069/121] selftests: net: let big_tcp test cope with slow env
Date: Tue, 13 Feb 2024 18:21:18 +0100
Message-ID: <20240213171855.009937367@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
References: <20240213171852.948844634@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit a19747c3b9bf6476cc36d0a3a5ef0ff92999169e ]

In very slow environments, most big TCP cases including
segmentation and reassembly of big TCP packets have a good
chance to fail: by default the TCP client uses write size
well below 64K. If the host is low enough autocorking is
unable to build real big TCP packets.

Address the issue using much larger write operations.

Note that is hard to observe the issue without an extremely
slow and/or overloaded environment; reduce the TCP transfer
time to allow for much easier/faster reproducibility.

Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/big_tcp.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index cde9a91c4797..2db9d15cd45f 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -122,7 +122,9 @@ do_netperf() {
 	local netns=$1
 
 	[ "$NF" = "6" ] && serip=$SERVER_IP6
-	ip net exec $netns netperf -$NF -t TCP_STREAM -H $serip 2>&1 >/dev/null
+
+	# use large write to be sure to generate big tcp packets
+	ip net exec $netns netperf -$NF -t TCP_STREAM -l 1 -H $serip -- -m 262144 2>&1 >/dev/null
 }
 
 do_test() {
-- 
2.43.0




