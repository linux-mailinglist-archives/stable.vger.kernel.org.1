Return-Path: <stable+bounces-239604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIZmN1xZ5mmtvAEAu9opvQ
	(envelope-from <stable+bounces-239604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6E43017E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00005314BC91
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFF33B970;
	Mon, 20 Apr 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ji93EyjY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DD322749;
	Mon, 20 Apr 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700682; cv=none; b=OK4P+ovNd1q6ooz/equIdQArQOst6oiZ4ihRyRTec59iCvUY/HVI7hjaYUdYie5bNAaGO7K0JVEkNai2//zyN9rx37C/oMx/H9bXZkrZS7P8MlQGbDjHqCRnwVFzFwb5e/jUXIg0XcUTo5TD5e7hWEuu6qhQBLcFVXZ4VVuawH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700682; c=relaxed/simple;
	bh=rWadQ8rEMrUcuqopHTb4hzRpnm1jyezo3XqCKTyijNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhMWtzwIXPJoW7dHfJVb1AycktMOcfFlhqhMy5+R94qAJ0g0pE6fUxGff2U0fBXM1G5kSGI+NaOK5oqh+EpFBit3mEDodZ5N7KVa4lWq6MgahboNswyzf+0z/jbaAmIVJKYAwaHrJXN06VNlqPZRfv8FkO7osMGGQywinC802io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ji93EyjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533AAC19425;
	Mon, 20 Apr 2026 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700682;
	bh=rWadQ8rEMrUcuqopHTb4hzRpnm1jyezo3XqCKTyijNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ji93EyjYlakQK6KnvtoSRCe1NpXxxphJOkjaHkRjrXVxjFYCq/cBBhvGlFa8x+Tx/
	 2V6TWMRTO4LawFwb6haP2NCMU9aJ75gB5W8DreXNVZtclgrl7JlD43NJwYipR30Xb5
	 TsW5N36pCrRKYVBCCUPZmUvAQnAgx4Eww+uuisG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel J Blueman <daniel@quora.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 047/198] arm64: dts: qcom: hamoa/x1: fix idle exit latency
Date: Mon, 20 Apr 2026 17:40:26 +0200
Message-ID: <20260420153937.310572635@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239604-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quora.org:email]
X-Rspamd-Queue-Id: 6FC6E43017E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel J Blueman <daniel@quora.org>

[ Upstream commit 3ecea84d2b90bbf934d5ca75514fa902fd71e03f ]

Designs based on the Qualcomm X1 Hamoa reference platform report:
driver: Idle state 1 target residency too low

This is because the declared X1 idle entry plus exit latency of 680us
exceeds the declared minimum 600us residency time:
  entry-latency-us = <180>;
  exit-latency-us = <500>;
  min-residency-us = <600>;

Fix this to be 320us so the sum of the entry and exit latencies matches
the downstream 500us exit latency, as directed by Maulik.

Tested on a Lenovo Yoga Slim 7x with Qualcomm X1E-80-100.

Fixes: 2e65616ef07f ("arm64: dts: qcom: x1e80100: Update C4/C5 residency/exit numbers")
Signed-off-by: Daniel J Blueman <daniel@quora.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260220124626.8611-1-daniel@quora.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 6d97329995fe7..efe8d5e7079fe 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -281,7 +281,7 @@ cluster_c4: cpu-sleep-0 {
 				idle-state-name = "ret";
 				arm,psci-suspend-param = <0x00000004>;
 				entry-latency-us = <180>;
-				exit-latency-us = <500>;
+				exit-latency-us = <320>;
 				min-residency-us = <600>;
 			};
 		};
-- 
2.53.0




