Return-Path: <stable+bounces-215458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHkrIC75iWn5FAAAu9opvQ
	(envelope-from <stable+bounces-215458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:11:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03319111B06
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB3030C2501
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069328312F;
	Mon,  9 Feb 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtdY3IEW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3F37BE7F;
	Mon,  9 Feb 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648859; cv=none; b=dSVkALP3UStd9pOnpkkqhl+Hx9XzFMAHPNaa0cXSsPbgGyAbof4lg/AGKa6HslXJAGsYNDFa8y+H6Drb4XZG5nCStHkdKW2bstmMCuu4KD1eKdEvBbE2cZK2rK/FXvBFTRuvFnq+InDZ+ED5YD5ZqbHb40OLmJVpcm5GRBoWOfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648859; c=relaxed/simple;
	bh=OODtnCwjRatCCojOYVqm24fvb3yHUmoMmpWYLgVg+oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmb+qNhb0hhy8XiBUQBaeU0sLqtLPe9gNZmEj2kMWjPr3u/nMKG+7cZy4LM+pqrOX4SoTqIN7/HIhxMhdRPSNPJd1VEIkoAxQPdyL5GIW5S3/58HRAipsWnac2qa/TdquFglpwwTzQXtrFAK8tG52FDyIDwdJkDp8OTNJHlQb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtdY3IEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DD1C116C6;
	Mon,  9 Feb 2026 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648859;
	bh=OODtnCwjRatCCojOYVqm24fvb3yHUmoMmpWYLgVg+oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtdY3IEWRH3MXzFv74MJOdcunCLd5CJBQnNUGd6hatWbATI+7EsCYnrPiPMwXT7KG
	 a0IrfxRhWNYV3mYhnEQTQ+yTr0Ncpxr54YTQdl1qnCpnZttsU+fNCGkUbzAw/HCvQI
	 AX9mQRooMNHWMq2IDOSWWXwCW0SqaoVJkIuyAExg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 37/75] wifi: mac80211: collect station statistics earlier when disconnect
Date: Mon,  9 Feb 2026 15:24:34 +0100
Message-ID: <20260209142303.183391394@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215458-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03319111B06
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

[ Upstream commit a203dbeeca15a9b924f0d51f510921f4bae96801 ]

In __sta_info_destroy_part2(), station statistics are requested after the
IEEE80211_STA_NONE -> IEEE80211_STA_NOTEXIST transition. This is
problematic because the driver may be unable to handle the request due to
the STA being in the NOTEXIST state (i.e. if the driver destroys the
underlying data when transitioning to NOTEXIST).

Move the statistics collection to before the state transition to avoid
this issue.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Link: https://patch.msgid.link/20251222-mac80211-move-station-stats-collection-earlier-v1-1-12cd4e42c633@oss.qualcomm.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index d1460b870ed5a..f9a5bda1f925d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1101,6 +1101,10 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 		}
 	}
 
+	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
+	if (sinfo)
+		sta_set_sinfo(sta, sinfo, true);
+
 	if (sta->uploaded) {
 		ret = drv_sta_state(local, sdata, sta, IEEE80211_STA_NONE,
 				    IEEE80211_STA_NOTEXIST);
@@ -1109,9 +1113,6 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
 
 	sta_dbg(sdata, "Removed STA %pM\n", sta->sta.addr);
 
-	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
-	if (sinfo)
-		sta_set_sinfo(sta, sinfo, true);
 	cfg80211_del_sta_sinfo(sdata->dev, sta->sta.addr, sinfo, GFP_KERNEL);
 	kfree(sinfo);
 
-- 
2.51.0




