Return-Path: <stable+bounces-228083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFWREBRJwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:07:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD82F3DA8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37E8930F4C02
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F621D00A;
	Mon, 23 Mar 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KPH1QZv/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EA3AC0C2;
	Mon, 23 Mar 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274072; cv=none; b=LaJJOHJkFbJUylsT91OcvUFxtQG8aXd945a1yzJAzwL07vWsC29BUv4HeMskavEaTQ5EuOJgUdN0woSZqIpN2xVHCJ/iVN7CnNTgs4CSKAFW1Kwm2vrtJd3+w7YDM0/LeAAtciYwnD6CQOlvcZDBXts1Wd1F2mo9n3Kxzb5neXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274072; c=relaxed/simple;
	bh=6Le1gOzooUTdXvCb1DqLJDN0pzHiOBU2ylmEyoGhd/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiBdO2uu9nGHQFgb1fqjegtB8IuPZMjhIMM5Ff66ifTtCsM1NIONNTzzS+AXOnjtLr/h6cgPQokdNFT6uE3o8WtcfbQ53aIgZKD5zeTpS80fShx2zu1xu8uFnpukLaJ4Pux5UhoIaYvIXcKXrmVMHcvWLaosisew5RpqBygL6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KPH1QZv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CAFC2BCB3;
	Mon, 23 Mar 2026 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274072;
	bh=6Le1gOzooUTdXvCb1DqLJDN0pzHiOBU2ylmEyoGhd/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KPH1QZv/8z5wpKQ4s2ivOOBIXs0EHgdgIBotV/dKL0aL2kexQyT/6GAw22IXIWU0s
	 P4xpfNnDKpvkvudex4plGTeuPMMJIypQl/RuLZ0zp1DHxL1Ps/7VbqelhXIoBgGh7E
	 TkrZx4mKEEoZfKTSmsz5r5l9TNyznm2tbLh0VqN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 100/220] soc: rockchip: grf: Add missing of_node_put() when returning
Date: Mon, 23 Mar 2026 14:44:37 +0100
Message-ID: <20260323134507.760649989@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228083-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,linaro.org:email,sntech.de:email]
X-Rspamd-Queue-Id: 6DDD82F3DA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 24ed11ee5bacf9a9aca18fc6b47667c7f38d578b ]

Fix the smatch checking:
drivers/soc/rockchip/grf.c:249 rockchip_grf_init()
warn: inconsistent refcounting 'np->kobj.kref.refcount.refs.counter':

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 75fb63ae0312 ("soc: rockchip: grf: Support multiple grf to be handled")
Closes: https://lore.kernel.org/all/aYXvgTcUJWQL2can@stanley.mountain/
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://patch.msgid.link/1770814957-17762-1-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/grf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 04937c40da471..b459607c118aa 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -231,6 +231,7 @@ static int __init rockchip_grf_init(void)
 		grf = syscon_node_to_regmap(np);
 		if (IS_ERR(grf)) {
 			pr_err("%s: could not get grf syscon\n", __func__);
+			of_node_put(np);
 			return PTR_ERR(grf);
 		}
 
-- 
2.51.0




