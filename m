Return-Path: <stable+bounces-106567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915CF9FE9B8
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116B5162288
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F91B4F0B;
	Mon, 30 Dec 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k03Y5WLH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DF31B0421;
	Mon, 30 Dec 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582367; cv=none; b=Bklh3YdK38p66dbzTGeTWVkiG8OfgE+bODLyChyL+Hxc997ldTqyb5EdsD2ULZmcmm6sXMKWXJAYGPcc/wUSSNNtMJvpU2awKSlRg/dCVi196Ioe+lobnKolSRa5wYPHDQmyjSkYECF50mYHM416syq+V22yCBjhqEj70pXfJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582367; c=relaxed/simple;
	bh=VHfAh39yqDxJVBGGxxhbrgbDetNMrhoiejJCoo85rwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nziX+UN0EE+2O9pdEnla3q0XAKa+tXtTHTcTXXMdr5yWFNLhJKxJScSG/JXIxa8P2PtDj2DVFil9hIguBcPLcTY9FpcbVKm14VmVQbP2LQdDnohnDfZ/TvPYnDssMW1zrNlm0z32uas1Un+SZOyvssYmc+accMD2iBdvaAm+I50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k03Y5WLH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A5AC4CED6;
	Mon, 30 Dec 2024 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735582367;
	bh=VHfAh39yqDxJVBGGxxhbrgbDetNMrhoiejJCoo85rwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k03Y5WLHzOJlhoHJPGuaT6+fCBhYoDZWYukwQOl8O2GGrUiXb8KxjqgatNGlVak8y
	 7htvlSh5YD4CLZyCReR6ogt9mOAECJL+hLcyNBdH7t0tGz4TmbfqZyN67NkJqHvm7/
	 +VhZ6qBLgO79RElYMVDHeTt8awcpOXbI3WwgQWCCZEsNUJyPkrkXiun+kTT6E/4mtL
	 oUxz/yHMFQP2/REIW03tr7ymKRZls74I5pWHlhBVcVldMHpa6+IFMBxIDezTPAsuB8
	 tyVnKRMGV1Hjb8HrqK8S/UWfK0KM+0RYhY96mBBw8IsvAhIR+ILIWnxRIFB/mBUTN5
	 0NT7oRpMF3BVA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 30 Dec 2024 19:12:32 +0100
Subject: [PATCH net 3/3] mptcp: prevent excessive coalescing on receive
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-net-mptcp-rbuf-fixes-v1-3-8608af434ceb@kernel.org>
References: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
In-Reply-To: <20241230-net-mptcp-rbuf-fixes-v1-0-8608af434ceb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1198; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EJnPNuoRHjWeI+J2OzLS/vwyiccermUluT6moDDxN6A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBncuKU2GVQROqJldxKAW5PdQo4vSM8vLQZpEO2P
 zN0xBw68HGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ3LilAAKCRD2t4JPQmmg
 c3XdEACT3aJXpqF1JGbapOMhg4NHaCy8XgQw+yoGs52hWCc0nZZW6pO7kXBJ4Lk4r4NcoJHTPv6
 FebLAO04HUVJ6N4rVk7VRQZfoSEoYbmwX0tOCsmUUq8UltSSRIHlJGARBNPs+5rpA0ps8l5e9Kg
 f15JiytNZf4Xkv+jVus2xPLZ/wPg7KsvaNn4EJva234ZVvW0zrbog47xrR16fzIwjpi9unKDLui
 aR0Nlz7npyIHCKI027lprGb03Vthb28ESB3pKFtgFVS0n+0i3IQoYi1r6N+ruhf3w5bkBNcz+FI
 +c9R5D/Ogiiqkhbg7uWp4AXzLHzVLz1w9lJX4POplTXGw2QDrxz+/HFPBRpf0IpM8JulzoL0M8N
 yIhKWbkyLK1WgAxlXaBzg/2TqT5d/tIPZwYKpVqHU3P1Awbvo16oHAG46eWbPHFOb11JHYo5lXj
 ymqiv2zBdURIQK+VK6inlddEI6qo4ZiIHSFAxYcapjiUerVkqlD0EKUd4Fgy9mA1uo3TNHEOJMA
 sKICe6Mq5Gaa8oYHRxjlvG9GoPIBMnUbq2gNynmXRe5L/cuA9rNbAGqTmEoNIsvC0yNF5yAiCAL
 74NgGmgSHzbaAYhdxrBqC1vHxRwoBPZAAwsv1ayzKxZHsfPwcrgG4oF7Ur2mZ+M8zSm091A4JD+
 wYFzd2DBiwiGY6g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

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
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5307fff9d995309591ed742801350078db519f79..1b2e7cbb577fc26280f31e58adceb36987112f54 100644
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


