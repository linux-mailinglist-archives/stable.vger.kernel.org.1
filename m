Return-Path: <stable+bounces-54340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F990EDBE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72AB21C22080
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB114EC42;
	Wed, 19 Jun 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dke46IyT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCC614B95F;
	Wed, 19 Jun 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803290; cv=none; b=FE9qaHAMhfZ4VC95hntxAhsLTf4/9NpazkWJCX2ZGNnK7EAV4whsQQfS76mKsjPzaYjYEBOFkPtTN72XKLjyOiQmnD6TpptFB5XK4ITSE+L0SDxdABrTc7FgsgHdsgJQ0Uc1e5sBauilKOeKWwFEMAIHjpit2HyM123FvUPeDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803290; c=relaxed/simple;
	bh=bKkFbpnDkg+/q1y08CtDs0GNDmjWqmBaz4ybv6TKlU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxPFeWlMLQoAYRX9K1CzJtSDL712veYL/iALctJR4YUED9zc6+rbhQStsFhvcwyETWU8CWK5FQkeu+SZiOxA2ah7l8FYr1UzGEmaVTmyBJLDdHdaLWPBOA5gl1QfyqembBj7J93lBGUbOA21d8iy3V8nTxn+08R/V+A0dqAXFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dke46IyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1253C2BBFC;
	Wed, 19 Jun 2024 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803290;
	bh=bKkFbpnDkg+/q1y08CtDs0GNDmjWqmBaz4ybv6TKlU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dke46IyTnqpKTqKOZdLihP8tDqYb3xmp+eOOXPhxYaWB3sLBXo2qyDt2s7gFbGxS1
	 dv7ekUsplDwJZQ/O1lvJun+oAkookLlmUJ6VZ6VR6uFNE9MFbcvSwkRF6nl8+ZKosA
	 BJPrPRB1QPP2Omux8of1Vkiq+qysMmvz4JmPnjm4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Christoph Paasch <cpaasch@apple.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.9 210/281] mptcp: ensure snd_una is properly initialized on connect
Date: Wed, 19 Jun 2024 14:56:09 +0200
Message-ID: <20240619125618.040628284@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 8031b58c3a9b1db3ef68b3bd749fbee2e1e1aaa3 upstream.

This is strictly related to commit fb7a0d334894 ("mptcp: ensure snd_nxt
is properly initialized on connect"). It turns out that syzkaller can
trigger the retransmit after fallback and before processing any other
incoming packet - so that snd_una is still left uninitialized.

Address the issue explicitly initializing snd_una together with snd_nxt
and write_seq.

Suggested-by: Mat Martineau <martineau@kernel.org>
Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240607-upstream-net-20240607-misc-fixes-v1-1-1ab9ddfa3d00@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3731,6 +3731,7 @@ static int mptcp_connect(struct sock *sk
 
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
+	WRITE_ONCE(msk->snd_una, subflow->idsn);
 	if (likely(!__mptcp_check_fallback(msk)))
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVE);
 



