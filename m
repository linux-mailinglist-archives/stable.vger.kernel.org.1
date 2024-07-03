Return-Path: <stable+bounces-57081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F8925A92
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B206D1C260AC
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A092117994F;
	Wed,  3 Jul 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uc19vQ2t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434C17084B;
	Wed,  3 Jul 2024 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003786; cv=none; b=pVsckUOhljMLbFcyG7Z8R/Aw977Scs6IFc5vVZJX+ZTZq6OpSZD6cHdTleSiv3EmIqvwHTDQkC/5XdWjSr/T2Nlo140Uqc8YCscDD3nWFf/NpOSP6XE3A7HceUyorms9pyYDanqRzQhRXqUCLp3TBTClxWER3FWzPOlBImLeoG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003786; c=relaxed/simple;
	bh=bvg1rdhxw6eVeoGxTKuYg9TI5unqA2zSXiqNcQKU9Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXwtGInVFUzNXPNOcCuQ0ooZCG46nkJu0boNLIYTp/Mc6CDPAwQML23hFHrZv2rUdylf+gYd+KFTONWbfIBUlOpizuUPgY2ZwiLL38F2ObU+l5OSPo7/RE64zfRfZ31s0YoTeIYc/+DYaBu3Sq+R5iVvnWbbTc+4njFQ2oJvwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uc19vQ2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFCBC2BD10;
	Wed,  3 Jul 2024 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003786;
	bh=bvg1rdhxw6eVeoGxTKuYg9TI5unqA2zSXiqNcQKU9Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uc19vQ2t+PiumANCyhJySNCA2K418DeF+JRWoHNyeksSIMmovyC8pERNYaSTMusMM
	 R9WQ3iqVFifbHTEHaxEMzqnrLD1HrMVHhN3YKnm4pKpf3lqSJzaSyz3WVnTM7V+XbY
	 9azEzxDZyWa3zBcJKbwgkaKRtKf0GtuTXCsF7u3I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lin Ma <linma@zju.edu.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 003/189] wifi: cfg80211: pmsr: use correct nla_get_uX functions
Date: Wed,  3 Jul 2024 12:37:44 +0200
Message-ID: <20240703102841.626922289@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit ab904521f4de52fef4f179d2dfc1877645ef5f5c ]

The commit 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM
initiator API") defines four attributes NL80211_PMSR_FTM_REQ_ATTR_
{NUM_BURSTS_EXP}/{BURST_PERIOD}/{BURST_DURATION}/{FTMS_PER_BURST} in
following ways.

static const struct nla_policy
nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
    ...
    [NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP] =
        NLA_POLICY_MAX(NLA_U8, 15),
    [NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD] = { .type = NLA_U16 },
    [NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION] =
        NLA_POLICY_MAX(NLA_U8, 15),
    [NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST] =
        NLA_POLICY_MAX(NLA_U8, 31),
    ...
};

That is, those attributes are expected to be NLA_U8 and NLA_U16 types.
However, the consumers of these attributes in `pmsr_parse_ftm` blindly
all use `nla_get_u32`, which is incorrect and causes functionality issues
on little-endian platforms. Hence, fix them with the correct `nla_get_u8`
and `nla_get_u16` functions.

Fixes: 9bb7e0f24e7e ("cfg80211: add peer measurement with FTM initiator API")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Link: https://msgid.link/20240521075059.47999-1-linma@zju.edu.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/pmsr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 0c7bd1f2c55c0..0cd1cb269ab58 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -58,7 +58,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.burst_period = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD])
 		out->ftm.burst_period =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD]);
+			nla_get_u16(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD]);
 
 	out->ftm.asap = !!tb[NL80211_PMSR_FTM_REQ_ATTR_ASAP];
 	if (out->ftm.asap && !capa->ftm.asap) {
@@ -77,7 +77,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.num_bursts_exp = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP])
 		out->ftm.num_bursts_exp =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP]);
 
 	if (capa->ftm.max_bursts_exponent >= 0 &&
 	    out->ftm.num_bursts_exp > capa->ftm.max_bursts_exponent) {
@@ -90,7 +90,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.burst_duration = 15;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION])
 		out->ftm.burst_duration =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION]);
 
 	out->ftm.ftms_per_burst = 0;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST])
@@ -109,7 +109,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	out->ftm.ftmr_retries = 3;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES])
 		out->ftm.ftmr_retries =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES]);
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES]);
 
 	out->ftm.request_lci = !!tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI];
 	if (out->ftm.request_lci && !capa->ftm.request_lci) {
-- 
2.43.0




