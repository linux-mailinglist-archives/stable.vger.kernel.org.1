Return-Path: <stable+bounces-218591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK5dEBFYnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9C219068A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FAAA3175508
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7232550D7;
	Wed, 25 Feb 2026 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4q04A53"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A324A05D;
	Wed, 25 Feb 2026 01:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983435; cv=none; b=kGweKQA+4Hr0VJGq7tHnNrSg7A/vnA/M49dvmJr39XdhdA97Y0s+04tphCJNva7qd1zeRgRSuCfNJtBfh/LYEhkQGmhse6oiRtqCmflQ4k0D7PZcC+vKgCozpR/zyLKNciCEhA8bJLPGO6h24iraNevMB5q4wIuphhETQ+YXg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983435; c=relaxed/simple;
	bh=jYA5eMDP8zppm7Z491Kwuq2JfIm6RpH6XFU3Ml6NVUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLrGyYD2wMS4SEiJGQlq0NYh20tpF3dJFcTfYIcXo+SjBOcuZa5df+sGRYU8qmLZwxftIr/U91ZL8uOfasLc4ozW0GUuf1IBL3LAfX8gOiHOkh5kX+WPNeSsElSJYUE4s6qbGzkLd0wZPDf33Iw/i1YZwkLpgQ+nCvKpXAu8c4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4q04A53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C658CC116D0;
	Wed, 25 Feb 2026 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983435;
	bh=jYA5eMDP8zppm7Z491Kwuq2JfIm6RpH6XFU3Ml6NVUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4q04A53aCUlqcUxzdQGmY0aCFvLGNms3pOM1QJv5pA2p03VkpyBCQYYwBXT3B3te
	 Hkt1DW9kF/XpNGNW0tx6bKGOmlzs6oRBQyosDwuuARS29YlLhIkA0XWM8N0BROsaZD
	 tlPyJtps/DCj0S8sOXjPqC513KM09BHecZYJUT3Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 553/781] clk: zynqmp: divider: convert from divider_round_rate() to divider_determine_rate()
Date: Tue, 24 Feb 2026 17:21:02 -0800
Message-ID: <20260225012413.366771675@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218591-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CB9C219068A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 30a807808c69a1907001ffb79289237a2ee97cfa ]

The divider_round_rate() function is now deprecated, so let's migrate
to divider_determine_rate() instead so that this deprecated API can be
removed.

Note that when the main function itself was migrated to use
determine_rate, this was mistakenly converted to:

    req->rate = divider_round_rate(...)

This is invalid in the case when an error occurs since it can set the
rate to a negative value.

Fixes: 0f9cf96a01fd ("clk: zynqmp: divider: convert from round_rate() to determine_rate()")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/zynqmp/divider.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index c824eeacd8ebd..de6f478d527d8 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -151,8 +151,9 @@ static int zynqmp_clk_divider_determine_rate(struct clk_hw *hw,
 
 	width = fls(divider->max_div);
 
-	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
-				       NULL, width, divider->flags);
+	ret = divider_determine_rate(hw, req, NULL, width, divider->flags);
+	if (ret != 0)
+		return ret;
 
 	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
 	    (req->rate % req->best_parent_rate))
-- 
2.51.0




