Return-Path: <stable+bounces-250162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNvgMqbuDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D285593A2D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970E9361B55B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21982372EDE;
	Wed, 20 May 2026 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJ6qQAn1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3EA368941;
	Wed, 20 May 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294706; cv=none; b=hETvM9cSRkaB7nyIBP2l27TzNl17+WYTjBov3AsMFbLSQciM6FviJ8iLx48lhZ3V+LEsyBAeGSTRTb6qH6MV7+ES7TKicPjrHaX6v/Rdr/O4HWoNUm+kQGuWZZkQ0XWnnJwaft594vHIy8bEOiqnQNmP83CdgVfDqNBPy+6NjRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294706; c=relaxed/simple;
	bh=VccHE1WkymadYA5nz/r/ZGT3ZGwlPF9uCfytkHeAxOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtJdTjjNyLCFcuw6KbGeeFw0TALD6w6IkvaYxC6weSCL8Pyv3nPtEOwxxEr8zkxVUf8ShEvDo6esxtIUWH0+ahRW9b/2Md/Y440wT+Wa6CplwNi1bgxXDga8WEzpSZjW3KTmbt6Cqjd6R38MUXDKyNLsz1JnmdKrbJGRjOmwI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJ6qQAn1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E83D1F00893;
	Wed, 20 May 2026 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294705;
	bh=ha8j/vXsGKps9CwQa6UHFecP/weT1z6OMTX/qK1+s3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJ6qQAn130io2rZ9NroEanaPjQJD8Mm4efolPWeCeZUp5CZORQ31QNfpy7SVEvFC6
	 R2phQwo4uWpH/e3hccZM8ljinaURJYAshjisTqFwowBVckoUJjvq9VYRa2WTpEVDgn
	 iWq+v3ztXJOuA+2jRV6E+HLghvQ5zOppkWxWmDNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Lo <michael.lo@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0124/1146] wifi: mt76: mt7921: fix 6GHz regulatory update on connection
Date: Wed, 20 May 2026 18:06:14 +0200
Message-ID: <20260520162151.135540305@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250162-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3D285593A2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Lo <michael.lo@mediatek.com>

[ Upstream commit 3dc0c40d7806c72cfe88cf4e1e2650c1673f9db4 ]

Call mt7921_regd_update() instead of mt7921_mcu_set_clc() when setting
the 6GHz power type after connection, so that regulatory limits and SAR
power are also applied.

Fixes: 51ba0e3a15eb ("wifi: mt76: mt7921: add 6GHz power type support for clc")
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
Link: https://patch.msgid.link/20260211095025.2415624-1-leon.yen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 42b9514e04e71..3d74fabe74085 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -800,7 +800,8 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
 	}
 
 out:
-	mt7921_mcu_set_clc(dev, dev->mt76.alpha2, dev->country_ie_env);
+	if (vif->bss_conf.chanreq.oper.chan->band == NL80211_BAND_6GHZ)
+		mt7921_regd_update(dev);
 }
 
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-- 
2.53.0




