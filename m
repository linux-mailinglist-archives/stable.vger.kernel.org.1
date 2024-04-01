Return-Path: <stable+bounces-34248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FDA893E87
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F821C210C1
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEDF47A66;
	Mon,  1 Apr 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tKfCeCqt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4E47A5D;
	Mon,  1 Apr 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987482; cv=none; b=g2YducFX7FPbXLFA7lMbAezyS9vkDC/Bv08HyJV7TwRwRuBVM1LfcNuh6Zpnpw7xeSfNO6gbFIqvStxkmR8RE1NZIT/ZChtwatbnjQqmz0yE4zPsdl6cy0Cy3AeqwgxVGMmz8qawfwuJcdRZbPq0JUckyuCzG/zLSpekeDJhtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987482; c=relaxed/simple;
	bh=pkAQpuc//7M8/D8ToCa14GTNgTv7fhFjlQ4B+/mVC2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCC841hOqGl2V44w0QjQdZYG8/4rggeN5O9N4RtFPpI3FHm9kM9T4x/dln6XRw7rnzH6nopqBv/iYOaKxNxkUx20sV9GYGlb3dXgpfccF5v3vDm+MiGADkky7n68yZ5vR9abo/U5ReFMqL1QahwLcnDwmQyKmiZMDvSBZ7Y1Ggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tKfCeCqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C117C433C7;
	Mon,  1 Apr 2024 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987481;
	bh=pkAQpuc//7M8/D8ToCa14GTNgTv7fhFjlQ4B+/mVC2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tKfCeCqtVoWbh/aR9V95E8WjiWJudAjSatY4mIGqDsNxshW7prZ6YjoFNKUNu9OQQ
	 k7lhsyBz4Hx5xhE5+DMAsAtZYd1SMK6dsTT9wIKt/IUhYrL8xxE/zlGSZtZ2Ys+5gj
	 T33vbjjYzyMm9pTYmbOI3ax8ZpgaOY+ZUCZEnRwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.8 301/399] wifi: iwlwifi: mvm: disable MLO for the time being
Date: Mon,  1 Apr 2024 17:44:27 +0200
Message-ID: <20240401152558.178076753@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 5f404005055304830bbbee0d66af2964fc48f29e upstream.

MLO ended up not really fully stable yet, we want to make
sure it works well with the ecosystem before enabling it.
Thus, remove the flag, but set WIPHY_FLAG_DISABLE_WEXT so
we don't get wireless extensions back until we enable MLO
for this hardware.

Cc: stable@vger.kernel.org
Reviewed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -354,7 +354,7 @@ int iwl_mvm_mac_setup_register(struct iw
 	if (mvm->mld_api_is_used && mvm->nvm_data->sku_cap_11be_enable &&
 	    !iwlwifi_mod_params.disable_11ax &&
 	    !iwlwifi_mod_params.disable_11be)
-		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
+		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
 
 	/* With MLD FW API, it tracks timing by itself,
 	 * no need for any timing from the host



