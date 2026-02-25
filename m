Return-Path: <stable+bounces-218675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FojF3dUnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:46:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB97618FCD9
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2AFF306DF3A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B526AA91;
	Wed, 25 Feb 2026 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXXJb6A2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DA24A05D;
	Wed, 25 Feb 2026 01:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983531; cv=none; b=leYGJN3pd2N4KjLKlt9qIQo6Gzt6JaFFgWSKWCtQ4fvheOHDlsGIpq5YZNu2cqKJp1lGS5S6vGxILnqxQ5huk7Ok3O1Yv479JsjKMZIIrDbFnS0Q5IZAbjvIZooO8fqL4q3V5eGsgqH2ghThYVmPFkuZ7+OLbCcFL6+O26g5T+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983531; c=relaxed/simple;
	bh=hBxQC8DR8c8H8U4as7BjO8mS1KKrk+H8Z0P/FX3tR38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJgmNvgAXXJjo1RDP4Vs/8S7eVyzsqFOrbGg1TkMvyomXg4DGMl7SLFTERmvLKTSa+Jb8+vya5aagkBhBxMmuYayFLX5QKtCiZy337XRvVdl9vOjAHApD/WzjppMl4VzbOL7mb3u9w3poGNPA/iHq/I2zDvkAZlbDZkkddvMTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXXJb6A2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F45C116D0;
	Wed, 25 Feb 2026 01:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983530;
	bh=hBxQC8DR8c8H8U4as7BjO8mS1KKrk+H8Z0P/FX3tR38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXXJb6A2duJjCvCwDb6SenVzMntpFlDYIAtWFsXDXA1lQuoLFyjuJkcTfLNGk4SOz
	 6EWIIOlWM9pR1zNX2qWSbLzVuKM6Fy5DTHm0PM2IpXOC5lNMhsyFFHQn9TZCHP2Lrw
	 YiE+t10EBB2JkE1vwNdP9M2KHJOGIHvuUTOaRGxQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yue Haibing <yuehaibing@huawei.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 637/781] selftests: net: lib: Fix jq parsing error
Date: Tue, 24 Feb 2026 17:22:26 -0800
Message-ID: <20260225012415.429783591@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-218675-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: DB97618FCD9
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yue Haibing <yuehaibing@huawei.com>

[ Upstream commit 10ec0fc0ccc525abc807b0ca8ad5a26a0bd56361 ]

The testcase failed as below:
$./vlan_bridge_binding.sh
...
+ adf_ip_link_set_up d1
+ local name=d1
+ shift
+ ip_link_is_up d1
+ ip_link_has_flag d1 UP
+ local name=d1
+ shift
+ local flag=UP
+ shift
++ ip -j link show d1
++ jq --arg flag UP 'any(.[].flags.[]; . == $flag)'
jq: error: syntax error, unexpected '[', expecting FORMAT or QQSTRING_START
 (Unix shell quoting issues?) at <top-level>, line 1:
any(.[].flags.[]; . == $flag)
jq: 1 compile error

Remove the extra dot (.) after flags array to fix this.

Fixes: 4baa1d3a5080 ("selftests: net: lib: Add ip_link_has_flag()")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Link: https://patch.msgid.link/20260211022146.190948-1-yuehaibing@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 0ec131b339bc4..b40694573f4c7 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -577,7 +577,7 @@ ip_link_has_flag()
 	local flag=$1; shift
 
 	local state=$(ip -j link show "$name" |
-		      jq --arg flag "$flag" 'any(.[].flags.[]; . == $flag)')
+		      jq --arg flag "$flag" 'any(.[].flags[]; . == $flag)')
 	[[ $state == true ]]
 }
 
-- 
2.51.0




