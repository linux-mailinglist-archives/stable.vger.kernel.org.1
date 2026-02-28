Return-Path: <stable+bounces-220122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPRdDPspo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0621C5173
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E87B31008B9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494548097F;
	Sat, 28 Feb 2026 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luPk9op3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB88480979;
	Sat, 28 Feb 2026 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300032; cv=none; b=IMbPD7p7MA5o+ZLqUBDDVXcA9ODO3UUU3t0evEHvfqSTpO9W/GhJ9zf+/SflZ5k3GwDbE7XmJiNErOKMVeRsy2UwDRHh64g0lxe/5aT22Du8AGz4GiqYFE5GiVnEhnGo8I5CYv8Z8vTktbPgcca4UOyVj7IUhWeaXgXDs2KJmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300032; c=relaxed/simple;
	bh=HfdzIhtm/P1ivjYx+JiI04y9xYn3VxaKtR7qwfHK22Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaZ7ndEO1LgQgEEppTybz3hEHroCJbjyiOL28y61XbGr0qQoVPZl0wgY1IH79vXfeyn9dZzSn46dSfPH3YcZJ9xwiwnTUXF5aU1QnIPM1HukcKT+9Flo8hU3jIUtlGk5x2bV6J6U6QwsjWz64/Oz49W84BNfe6agxzuFsDr1xLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luPk9op3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D3EC2BC87;
	Sat, 28 Feb 2026 17:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300032;
	bh=HfdzIhtm/P1ivjYx+JiI04y9xYn3VxaKtR7qwfHK22Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luPk9op3YEbiisEcfN++v/TMwgcgWobD/kWifiZtbd8Lw9ZkXf6Rds32nADJdKDK/
	 QY6KQ8g7NBpg/WxcXW9JpcRfpYedRBn/LyHV7iJYgKA3je1UYmmP1xc3GoayL5F1GH
	 U5rrRmEihIicTs+xpnkX3l0eu3asXW2zxLD9WgBi3E24ZCtbQFkMAgX0dbHpjPx+eN
	 ZjHUrjCq7i8X6WxMd3rmVmBcopJoMhagzGwoD8fFD+TNqbbTEe4ffzyHn8CCqmHP1h
	 uuDpj+G/F+ZbQFKFNtg0G4bWkXLEKNFfjUzdOplhPqN2KC+Zi7NDtZQgLyeWC6MAjQ
	 +qlic40IBOfRQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 044/844] i3c: mipi-i3c-hci: Stop reading Extended Capabilities if capability ID is 0
Date: Sat, 28 Feb 2026 12:19:17 -0500
Message-ID: <20260228173244.1509663-45-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220122-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,intel.com:email,nxp.com:email]
X-Rspamd-Queue-Id: AE0621C5173
X-Rspamd-Action: no action

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 0818e4aa8fdeeed5973e0a8faeddc9da599fc897 ]

Extended Capability ID value 0 is special.  It signifies the end of the
list.  Stop reading Extended Capabilities if capability ID is 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260106164416.67074-3-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/ext_caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/ext_caps.c b/drivers/i3c/master/mipi-i3c-hci/ext_caps.c
index 7714f00ea9cc0..533a495e14c86 100644
--- a/drivers/i3c/master/mipi-i3c-hci/ext_caps.c
+++ b/drivers/i3c/master/mipi-i3c-hci/ext_caps.c
@@ -272,7 +272,7 @@ int i3c_hci_parse_ext_caps(struct i3c_hci *hci)
 		cap_length = FIELD_GET(CAP_HEADER_LENGTH, cap_header);
 		dev_dbg(&hci->master.dev, "id=0x%02x length=%d",
 			cap_id, cap_length);
-		if (!cap_length)
+		if (!cap_id || !cap_length)
 			break;
 		if (curr_cap + cap_length * 4 >= end) {
 			dev_err(&hci->master.dev,
-- 
2.51.0


