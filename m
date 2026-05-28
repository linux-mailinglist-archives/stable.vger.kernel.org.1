Return-Path: <stable+bounces-255780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPovJOSlGGrClggAu9opvQ
	(envelope-from <stable+bounces-255780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:30:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E025F8D73
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E0BA3123BF2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511E33D4E2;
	Thu, 28 May 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N5BpjBr9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFC301472;
	Thu, 28 May 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999862; cv=none; b=aJVlAEGbryAZCIP9VKJ5Tm8OG0grOl41o58tALFAX6oekHQ4meL4mSzn64r4URTB9D330+jT8hpCRsUzacs45D4orqqGKt8S7pXbH4/FYi6c8f+xXXOcZmdpVwEK8JRv6QzGP1OqwOwof3gSk0pGMVyZcwyvKR5vidKW1+mByvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999862; c=relaxed/simple;
	bh=leTr3spSpQiZbpvcW8Mstkyz34RyvB4MJim669cenRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqpEGmPvcOQeAg0May6yXkwrVz4pUeJKFAATVCUWhfzuyF780AdRUKUCIhmwjg7KzG8GXQEPqIbtEUNeIGw4IOH0H7AkbXCG6W1rOEGKRveI+Ki6Yu0S6jZEAQUqZqjzznc33phax3PEFPxbnAlerqyGYosFH+ge2WKfPFJ39K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N5BpjBr9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06541F00A3E;
	Thu, 28 May 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999861;
	bh=dzhkwgwr4TDkMrQUsC1MhIQvQq/oX6S5/wUTc4l/k6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N5BpjBr9VWJbqJr04P7WUOSxFDdZlRWP0xoflyhIWGvWla5aC0zuh3LIErmIechAT
	 pb0LegM53zsmlCcvAC5U5Hoyz7Bj/GLi6vpdFfumJKFydqqIwPw8XsGXa+wcYTAVdz
	 1ycJBKd+MlEnV9+EwpxDYEUj7CWhXb7k/F3pqEEA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mac Chiang <mac.chiang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 217/377] ASoC: sdw_utils: Add quirk to ignore RT712 CODEC_MIC
Date: Thu, 28 May 2026 21:47:35 +0200
Message-ID: <20260528194644.681802120@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255780-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 11E025F8D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mac Chiang <mac.chiang@intel.com>

[ Upstream commit 9c37daee7c17fa17e8d41089ee1f658b06cb672a ]

Some devices do not use CODEC_MIC but use the host PCH_DMIC
instead. Add a quirk to skip the CODEC_MIC DAI when it is not present
in disco table, ensuring the correct capture device is used.

If CODEC_MIC is present, it continues to be used as default.

Fixes: 9489db97f6f0 ("ASoC: sdw_utils: add SmartMic DAI for RT712 VB")
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20260508093224.1246282-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdw_utils/soc_sdw_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 3848c7df1916f..050ca17ff105d 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -170,6 +170,8 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.dai_type = SOC_SDW_DAI_TYPE_MIC,
 				.dailink = {SOC_SDW_UNUSED_DAI_ID, SOC_SDW_DMIC_DAI_ID},
 				.rtd_init = asoc_sdw_rt_dmic_rtd_init,
+				.quirk = SOC_SDW_CODEC_MIC,
+				.quirk_exclude = true,
 			},
 		},
 		.dai_num = 3,
-- 
2.53.0




