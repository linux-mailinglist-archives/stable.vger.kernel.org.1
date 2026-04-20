Return-Path: <stable+bounces-239434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFa+JdlX5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:44:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E128B42FECA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11090335DCFE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D1343D85;
	Mon, 20 Apr 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqriQD6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7B33AD99;
	Mon, 20 Apr 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700243; cv=none; b=Y9+ZyMbD+uh9/8i3Jk3NpAuZ4s82NWLuTeHFFv/saN+IGImZh6VPu73ZOGV/7At8fmUQxMOtMUtRZgYkVg3tcilGMzIkqZ9YJmdpGmfaupFk12VotlVi55Mqu32uqS39ZUaYwO0nNxzU6vb+aV69vLxnrYamgWO7uGoNAjE15ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700243; c=relaxed/simple;
	bh=p5SscrKmoQL5PyNYrOGfzx6j+tbiWHMRe0paPspHkqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJW/avh2s5mSmlGT0YNXtSkMYAi7AEHLlA9LTp5USwu1pYlm+hvTsRQVnB10GfpSyz7LT6ha1riF772WBUugqSe+Vthi7Yq7Ct0Xw4IhfxwphmuSXnQk1ZghP9PzSwBOXrCetnOthuKZ78cwexnekx9aR+E7NtB3jmulXv1IWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqriQD6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CAFC19425;
	Mon, 20 Apr 2026 15:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700243;
	bh=p5SscrKmoQL5PyNYrOGfzx6j+tbiWHMRe0paPspHkqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqriQD6YuOw38Sdh6jDFFFDn/Kz4zYnGtVKM7wb9FHrovvactjCcOaIpI4bLWwO1B
	 GLgP+AL6c88tHFJfCZby4XKCClnfMnJ+FX4hHS87D5FVx+z3qktoFHU3QDOeV6WL9l
	 sve/6V7j04gnWXVmsJx6X6xzojA9E7XLo03EE1S4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 096/220] ASoC: SOF: Intel: Fix endpoint index if endpoints are missing
Date: Mon, 20 Apr 2026 17:40:37 +0200
Message-ID: <20260420153937.490346465@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-239434-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus.com:email]
X-Rspamd-Queue-Id: E128B42FECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit 86facd80a2a37536937f06de637abf9e8cabdb4b ]

In case of missing endpoints, the sequential numbering will cause wrong
mapping. Instead, assign the original DAI index from codec_info_list.

Fixes: 5226d19d4cae ("ASoC: SOF: Intel: use sof_sdw as default SDW machine driver")
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20260402064531.2287261-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 686ecc040867a..882198308319e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1197,7 +1197,7 @@ static struct snd_soc_acpi_adr_device *find_acpi_adr_device(struct device *dev,
 						 codec_info_list[i].dais[j].dai_type))
 				continue;
 
-			endpoints[ep_index].num = ep_index;
+			endpoints[ep_index].num = j;
 			if (codec_info_list[i].dais[j].dai_type == SOC_SDW_DAI_TYPE_AMP) {
 				/* Assume all amp are aggregated */
 				endpoints[ep_index].aggregated = 1;
-- 
2.53.0




