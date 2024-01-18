Return-Path: <stable+bounces-12090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C973E8317AE
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D151C23542
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA06200AA;
	Thu, 18 Jan 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u7XILURs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03832377D;
	Thu, 18 Jan 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575577; cv=none; b=AQ0D5PiamfLSJUycTWjkU3T65PMgmPbiKbe+XC6pbO1D9RV0h6cWTe/fspcNOGl7YmyPzA0SQyK77vLpcgYsAAu5yBFgD6Xxfm1guH3k/Wu1uh0Nz19na4IsQHI5Zc7WfORMEkT7pNZK9jJWyOPwsZEO2/zWhjgRuNsKN3Wf0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575577; c=relaxed/simple;
	bh=BE2br4gPWuf/HboJsz/px0b49OD4LleAQCHXmmhgr7Q=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=TAPwPPFLV97woI3BttsqzdvNAH1UkFkNiHSixYRmTpWEN6CzEB33y/ouQOs2puVIr0RLcaODL3nMVUsEDROqbOaEdN7kzWmR+6t0DppUUXN1EyKLq0Pe31xTiDr5f42RKy9R9XbRmYcaE7nrsAqnTVdDYpk8vJ7l5DIk/53Q1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u7XILURs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2D5C433C7;
	Thu, 18 Jan 2024 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575577;
	bh=BE2br4gPWuf/HboJsz/px0b49OD4LleAQCHXmmhgr7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7XILURs16oE4QB64y0Gcn1s7JTnnSlujjs3nBd9YFhVYnmHForW+vRLzay/1I46Q
	 XH8NsE0Wl3X4p8Fjdep1JIA5kZGtO/QYakdlYrYX3HQXkS2Pq+kcOWYNknQr3qeZBF
	 DIY0/YRfpyt0o2F8YUa5sfvAkkEM3mlihCi4AvpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 004/100] mptcp: fix uninit-value in mptcp_incoming_options
Date: Thu, 18 Jan 2024 11:48:12 +0100
Message-ID: <20240118104311.074366350@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
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

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 237ff253f2d4f6307b7b20434d7cbcc67693298b ]

Added initialization use_ack to mptcp_parse_option().

Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0c786ceda5ee..74027bb5b429 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -103,6 +103,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-- 
2.43.0




