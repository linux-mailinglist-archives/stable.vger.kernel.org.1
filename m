Return-Path: <stable+bounces-218586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePlvKM5Tnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4F618FA25
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8243316F5C5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93191256C6C;
	Wed, 25 Feb 2026 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HxvqHLQ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575721FE45D;
	Wed, 25 Feb 2026 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983429; cv=none; b=QGJMiUkCxPQ4EErn6Uq4SMUfR101HmaGnKN7lHwnMTKoaQjRvcpPge5ipWou4uSLakSy7gBh4/PZWQ0yp9oF7xSdl+mzOQO/6N8ErSn/OFhVBqehh6JM1CzBPjxnrE3zH3iJCEnj391Glss5fikvQ6Fc3imzw8EWRWWZgutPxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983429; c=relaxed/simple;
	bh=scEEyVqellmKsnyX421hEZjtoCBpnpJ2hdBU8BKvm5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKRW2iyoq8LBj2VB6uW7Hwnm041COMJKzcmnb3GP3RGxKvi9FxYEH2ttbc9po8p8MBZoHKjRElaB52sWkId9196fSczgRjufo678idJpkhyJi48cvesUKW10RfM/b5s6nGGWa714F5HaC4dLIJq9oZNUBZS2T+P4BoTv7rh3RY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HxvqHLQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1450CC19423;
	Wed, 25 Feb 2026 01:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983429;
	bh=scEEyVqellmKsnyX421hEZjtoCBpnpJ2hdBU8BKvm5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxvqHLQ4yZGG6mfPB3pAhBZQ57y37Fw3fvwxtLaU3WbHl2hW1yZKSN3cBcZ1FhTdJ
	 5yDv4eqP9KcnWg8qIZTK0kAeu/62UykVCzWZnqoQnuSt8QtsulQtB1Yo+1R+lJVhpJ
	 ya9L1co+Yk2VfSJnBLYwlhttIkYrPISQ2XoiVCJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 548/781] clk: sprd: div: convert from divider_round_rate() to divider_determine_rate()
Date: Tue, 24 Feb 2026 17:20:57 -0800
Message-ID: <20260225012413.243010812@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218586-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A4F618FA25
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit f78fb9422980ceeb340fa3a2e370ae8845798ec7 ]

The divider_round_rate() function is now deprecated, so let's migrate
to divider_determine_rate() instead so that this deprecated API can be
removed.

Note that when the main function itself was migrated to use
determine_rate, this was mistakenly converted to:

    req->rate = divider_round_rate(...)

This is invalid in the case when an error occurs since it can set the
rate to a negative value.

Fixes: deb4740a5ff8 ("clk: sprd: div: convert from round_rate() to determine_rate()")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sprd/div.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/sprd/div.c b/drivers/clk/sprd/div.c
index 0134238819680..cd57163a7204c 100644
--- a/drivers/clk/sprd/div.c
+++ b/drivers/clk/sprd/div.c
@@ -14,11 +14,7 @@ static int sprd_div_determine_rate(struct clk_hw *hw,
 {
 	struct sprd_div *cd = hw_to_sprd_div(hw);
 
-	req->rate = divider_round_rate(&cd->common.hw, req->rate,
-				       &req->best_parent_rate,
-				       NULL, cd->div.width, 0);
-
-	return 0;
+	return divider_determine_rate(&cd->common.hw, req, NULL, cd->div.width, 0);
 }
 
 unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
-- 
2.51.0




