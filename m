Return-Path: <stable+bounces-18279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8A848218
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971141C24064
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD8719472;
	Sat,  3 Feb 2024 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UfNOSPix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7218EC0;
	Sat,  3 Feb 2024 04:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933681; cv=none; b=s5b1u6ysh909ITYQP24mKIRCIdlBnHaPu0iGbfNER7XJEg0klL7dUJevix5WPuLyFxqI5dbfeQRpwVbispISZsjPjHJT6s6RqvUG9wDiBnkO1eItUHwpIpc3UTyMh3ggglCRVQcNauHE3zoZAFHqlYp/hkye8/cIpk8oIhx7wyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933681; c=relaxed/simple;
	bh=dIXTov5io4Rxm8/gFl/W98nDQ4tte3h5O1hS3AXA/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3HI7p5CiLvJFTrgBRW2glO2KwK2HR3U7aqTs6ZqLvUVK9JgqGWb1c2z9i4Brnu4Mj48nbU9ycFeuuvYrbqXPbpla5zSy22xkp24Z2YaOqIH8a2rBcq68CLN2e1x9JXsQNdXhdod8/3IkR7Q7ZAofa486v4JyVW/GDMREI57J9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UfNOSPix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41112C433C7;
	Sat,  3 Feb 2024 04:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933681;
	bh=dIXTov5io4Rxm8/gFl/W98nDQ4tte3h5O1hS3AXA/9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfNOSPixgepBJq4Z6lSt9MYzoPWGJ/MeNX4MGrCgxpesNwW29Szz4a5uUE53JJmf/
	 Dp0mEH6UyhJmsZdd5cLBoFI+1ZI3acDe55iahWC76sBp+UtTkYzTOm0W0gN4HYRP4v
	 dLM13R7Pk55upP/Ysolt9zFx01iYp+xEJ0wq8BLk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 275/322] selftests: net: add missing required classifier
Date: Fri,  2 Feb 2024 20:06:12 -0800
Message-ID: <20240203035407.983057474@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit d3cb3b0088ca92082e2bebc40cc6894a632173e2 ]

the udpgro_fraglist self-test uses the BPF classifiers, but the
current net self-test configuration does not include it, causing
CI failures:

 # selftests: net: udpgro_frglist.sh
 # ipv6
 # tcp - over veth touching data
 # -l 4 -6 -D 2001:db8::1 -t rx -4 -t
 # Error: TC classifier not found.
 # We have an error talking to the kernel
 # Error: TC classifier not found.
 # We have an error talking to the kernel

Add the missing knob.

Fixes: edae34a3ed92 ("selftests net: add UDP GRO fraglist + bpf self-tests")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/7c3643763b331e9a400e1874fe089193c99a1c3f.1706170897.git.pabeni@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 413ab9abcf1b..56da5d52674c 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -51,6 +51,7 @@ CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NET_ACT_CT=m
 CONFIG_NET_ACT_GACT=m
 CONFIG_NET_CLS_BASIC=m
+CONFIG_NET_CLS_BPF=m
 CONFIG_NET_CLS_U32=m
 CONFIG_NET_IPGRE_DEMUX=m
 CONFIG_NET_IPGRE=m
-- 
2.43.0




