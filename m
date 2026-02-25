Return-Path: <stable+bounces-218953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMPcF9RZnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:09:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC51909D4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1572532576F6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3228A3FA;
	Wed, 25 Feb 2026 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wwD0zJTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2923D7CF;
	Wed, 25 Feb 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983853; cv=none; b=k4Jmf6brA6Zgq9CghnIrnbb2ja0w2cuzyrS93b2OL9hWSi5tKqRHJFVoXzxUSlO9KEOHuMlg/i3JCBTwMeYjozdMEbbLTe0My3W/BSk9+83p7yPxENIG1NKnJyd3ypMSLlUjhKOoqMrTcetH4elcczLTsU9ozK7WOeKywE+CxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983853; c=relaxed/simple;
	bh=CB/bSVIJOXwaFplOrX4zp29+X2f1s7OgE6KEgmcPvv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqLfAE1tOWI3mQ6Hj7dHVLHt3fwv0GNxPDSSEpfyVWnfebr3JJVKDuGR8HxArpfsdsCBzTpVFsuIDRLt4IbeUGS2aK0OydiaNjtUYqFPdUQM8Qs8atPE/F1pEO4wiYRWsz82kSUT7berz4tllHeYS9ryUuzj2M6pyyE12DVGrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wwD0zJTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AD8C116D0;
	Wed, 25 Feb 2026 01:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983853;
	bh=CB/bSVIJOXwaFplOrX4zp29+X2f1s7OgE6KEgmcPvv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wwD0zJTjTD90STP3CszGzl2Ee2+gQIQb/QEyI/4KAyqTkvOd05Obsb6k2HFIpht8U
	 G2GZbrRBdYkohwg/96SfjCR0RsOyzpIPqNAHk7mvAZN+5SlVkzpdalS9kkwBHbmHK+
	 uUB1NxKHGQZFGKnzFRmf1P5K0ZkWkQ2briWbK9ms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 129/641] EDAC/i5400: Fix snprintf() limit calculation in calculate_dimm_size()
Date: Tue, 24 Feb 2026 17:17:35 -0800
Message-ID: <20260225012352.275457875@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218953-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linaro.org:email,intel.com:email]
X-Rspamd-Queue-Id: E1AC51909D4
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 72f12683611344853ab030fe7d19b23970ed2bd8 ]

The snprintf() can't really overflow because we're writing a max of 42
bytes to a PAGE_SIZE buffer.  But my static checker complains because
the limit calculation doesn't take the first 11 space characters that
we wrote into the buffer into consideration.  Fix this for the sake of
correctness even though it doesn't affect runtime.

Also delete an earlier "space -= n;" which was not used.

Fixes: 68d086f89b80 ("i5400_edac: improve debug messages to better represent the filled memory")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://patch.msgid.link/ccd06b91748e7ed8e33eeb2ff1e7b98700879304.1765290801.git.dan.carpenter@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/i5400_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index b5cf25905b059..fb49a1d1df112 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -1026,13 +1026,13 @@ static void calculate_dimm_size(struct i5400_pvt *pvt)
 		space -= n;
 	}
 
-	space -= n;
 	edac_dbg(2, "%s\n", mem_buffer);
 	p = mem_buffer;
 	space = PAGE_SIZE;
 
 	n = snprintf(p, space, "           ");
 	p += n;
+	space -= n;
 	for (branch = 0; branch < MAX_BRANCHES; branch++) {
 		n = snprintf(p, space, "       branch %d       | ", branch);
 		p += n;
-- 
2.51.0




