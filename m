Return-Path: <stable+bounces-231618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BdLEbj4y2lENAYAu9opvQ
	(envelope-from <stable+bounces-231618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:39:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B072E36CE89
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6540431D6470
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF26423A71;
	Tue, 31 Mar 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wGZBCRnG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD8401A2C;
	Tue, 31 Mar 2026 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974636; cv=none; b=Y6ug4/E2SnZaAaJ1uaY0B8y7JJ9SqY4s7CM78ZMmWG822fWDi+/Eh4bTZceZaFPXpHHHsXLpHwi7mdnKs1BC3+YdG4jzTVrnDiOrhXEb/QhwqbnLgKXg1yjs6LH/oK2Dd2Pj2Oiv1+9Y7dZYiHJ4e95Ga9QhjVdImznLoB53QtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974636; c=relaxed/simple;
	bh=weRjn17jwD6uC0LQnM3y06tTR2s9R1wr9MZbCGbnylU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFPQz3tc6FGk/9JaGUamvQ5lzR53frwKwUKI3CzvuOYHRnHAv5LjjKFUAQguQgkKJ/A3gXd/I16nGk73JbXH2SXMyee+xUU6FGKxPo9igBdUXyrW3NlsGy/eEm1HHeMNLar4E8tc3/I02wmw3PYOmKBrV1/9UGSGox7miGe3dUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wGZBCRnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC321C19423;
	Tue, 31 Mar 2026 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974636;
	bh=weRjn17jwD6uC0LQnM3y06tTR2s9R1wr9MZbCGbnylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wGZBCRnGPgr7zFOy9sjFy28Y0wbTJXB/IYCqcKJnOUBL7gk7GeyNAbqImjSb+1g+X
	 QKZDbTPNszvlDtcH5VFjC89Uz7bxMV4AvdfdPD9v8N2vYxyNfySbLCg1OkiGDgL8Tz
	 hPqWeedkAaXZzb2yxYZbt1qVo9xGvVZjgjhBXnFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <olteanv@gmail.com>,
	Felix Gu <ustc.gu@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 162/175] phy: ti: j721e-wiz: Fix device node reference leak in wiz_get_lane_phy_types()
Date: Tue, 31 Mar 2026 18:22:26 +0200
Message-ID: <20260331161735.749577335@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-231618-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: B072E36CE89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 584b457f4166293bdfa50f930228e9fb91a38392 ]

The serdes device_node is obtained using of_get_child_by_name(),
which increments the reference count. However, it is never put,
leading to a reference leak.

Add the missing of_node_put() calls to ensure the reference count is
properly balanced.

Fixes: 7ae14cf581f2 ("phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver")
Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://patch.msgid.link/20260212-wiz-v2-1-6e8bd4cc7a4a@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index fc3cd98c60ff4..a28c168b35d92 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1424,6 +1424,7 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 			dev_err(dev,
 				"%s: Reading \"reg\" from \"%s\" failed: %d\n",
 				__func__, subnode->name, ret);
+			of_node_put(serdes);
 			return ret;
 		}
 		of_property_read_u32(subnode, "cdns,num-lanes", &num_lanes);
@@ -1438,6 +1439,7 @@ static int wiz_get_lane_phy_types(struct device *dev, struct wiz *wiz)
 		}
 	}
 
+	of_node_put(serdes);
 	return 0;
 }
 
-- 
2.53.0




