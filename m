Return-Path: <stable+bounces-239654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC0uLfhm5mmlvwEAu9opvQ
	(envelope-from <stable+bounces-239654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:48:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CF4321E2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFBFC31F778A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34033E377;
	Mon, 20 Apr 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gccye7NJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD3933D6FC;
	Mon, 20 Apr 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700880; cv=none; b=EPA6CYj2pzsL4qK/W2SzbhFF2WG2j6ZWwaz2Owsa7KkvRzE+oC9j2mq8WP8QiL1YnXSdOPzulfPuSHs9XntNmNy09jiGHl9YHxTFJs27B9d1KimCE0oPWFDJj6MM6qZ9MbnByFRvAQvK6XGacPL7fahrgU36+AxqOOeGzbX+Zas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700880; c=relaxed/simple;
	bh=VZFtceVuq6BwT9GzVD1JHjI5dcc1JRoIGh4fQmYs2kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFLGaD3Xml7Z4geI9dDhfVGh7RzjvDR1YX6sIxG73VqjhPlhDlExZjlvMa/STOlMPuvK3T6qTAHWU4v1zIVSwEq6xQggVbFgHV2RMVnUxjPpCGQRtoDAIkQjFkeRVtg/eoCGwdElfdv4aNSe7BzLpXkluLFhyd/yH9X1h1LOWrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gccye7NJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2206C19425;
	Mon, 20 Apr 2026 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700880;
	bh=VZFtceVuq6BwT9GzVD1JHjI5dcc1JRoIGh4fQmYs2kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gccye7NJY1QmlQMX0mYVbvPkwHmrYRZ2ri5icqTXN2KR+OCMF3qHmIiv3Ga3cRNY5
	 YtMn4LtYSpz6yI9durmDvtT4QqoPHFCG33bKojoy634LjfJTZa859fNKQZlzqJ3FmS
	 Af0EpJZ88ozLcuW3oe5mdbbXzrerzuKcjxB1QDrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 095/198] ASoC: Intel: avs: Fix memory leak in avs_register_i2s_test_boards()
Date: Mon, 20 Apr 2026 17:41:14 +0200
Message-ID: <20260420153939.025462877@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239654-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,sea.lore.kernel.org:server fail,linuxfoundation.org:server fail,intel.com:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 3B6CF4321E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit c5408d818316061d6063c11a4f47f1ba25a3a708 ]

Caller is responsible for freeing array allocated with
parse_int_array().

Found out by Coverity.

Fixes: 7d859189de13 ("ASoC: Intel: avs: Allow to specify custom configurations with i2s_test")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://patch.msgid.link/20260407085459.400628-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/board_selection.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 52e6266a7cb86..96dc637ccb20c 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -520,7 +520,8 @@ static int avs_register_i2s_test_boards(struct avs_dev *adev)
 	if (num_elems > max_ssps) {
 		dev_err(adev->dev, "board supports only %d SSP, %d specified\n",
 			max_ssps, num_elems);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	for (ssp_port = 0; ssp_port < num_elems; ssp_port++) {
@@ -528,11 +529,13 @@ static int avs_register_i2s_test_boards(struct avs_dev *adev)
 		for_each_set_bit(tdm_slot, &tdm_slots, 16) {
 			ret = avs_register_i2s_test_board(adev, ssp_port, tdm_slot);
 			if (ret)
-				return ret;
+				goto exit;
 		}
 	}
 
-	return 0;
+exit:
+	kfree(array);
+	return ret;
 }
 
 static int avs_register_i2s_board(struct avs_dev *adev, struct snd_soc_acpi_mach *mach)
-- 
2.53.0




