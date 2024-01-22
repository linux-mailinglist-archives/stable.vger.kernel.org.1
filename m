Return-Path: <stable+bounces-14471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0C7838122
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCDB7B2C23A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0866013EFE7;
	Tue, 23 Jan 2024 01:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRbZLFU5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AE13E236;
	Tue, 23 Jan 2024 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972008; cv=none; b=Mw22f1qr1pJD4UFnP9BTleiu+LITx34IppGpW3LprZz2KRSaNhG98j3NuI3k5bGWZMBSuUNnrrQYYZQ11wppf6bUg0MejRLYnspRSfRucXSyJOIMw5d/Q66BRDBRU24O1eH33rDhi+fL3hwclR29ULEgjTwsPMaXnB5IYUV9YPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972008; c=relaxed/simple;
	bh=NaPnc82OTViF1j4+VDqO8MY/JtKJDTmfUjGhfHgbdyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW1EswcmHT3WZzkghi3sl1nrfCiyRAjsYshGJZ7q+TyWezqyTiRARni9FnBkfNbC25BApJlk7W4Ej33YYTjgqmjYMom/rQt9bZUpSFnPGED+3JCL3ZQNloPVJxSn1NEIox1ur7aa+WAA2tys7wQgHs8RoIjxtcs7Aw1baxTyn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRbZLFU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FAC433C7;
	Tue, 23 Jan 2024 01:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705972008;
	bh=NaPnc82OTViF1j4+VDqO8MY/JtKJDTmfUjGhfHgbdyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRbZLFU5N3C768jovo+Tv4XQj8rTSMCuGNgZUHw/sHfFNtnxCHqHIPHXueTGevtnV
	 LmmKkCQt4UlqLs9S6F8+1poXtAJTXbwSTxCZJJyYsbjW1vdYRI5AcA+aQ+zUuHC0T8
	 JV+LTAe7fZHnLRPVWLdQjo/QsEOkSEu/DmDYD8cY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Peter Krystad <peter.krystad@linux.intel.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang.tang@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 383/417] mptcp: strict validation before using mp_opt->hmac
Date: Mon, 22 Jan 2024 15:59:11 -0800
Message-ID: <20240122235805.038354718@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c1665273bdc7c201766c65e561c06711f2e050dc ]

mp_opt->hmac contains uninitialized data unless OPTION_MPTCP_MPJ_ACK
was set in mptcp_parse_option().

We must refine the condition before we call subflow_hmac_valid().

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Krystad <peter.krystad@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20240111194917.4044654-3-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8ed7769cae83..a7090922480e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -718,7 +718,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ) ||
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
 		    !subflow_hmac_valid(req, &mp_opt) ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
-- 
2.43.0




