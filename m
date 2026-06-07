Return-Path: <stable+bounces-261140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CUFkJedGJWomFwIAu9opvQ
	(envelope-from <stable+bounces-261140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:24:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6364F9F5
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:24:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=eVItYnfc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261140-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261140-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F26C30479ED
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E62DB7A3;
	Sun,  7 Jun 2026 10:16:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC64071DA;
	Sun,  7 Jun 2026 10:16:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827397; cv=none; b=Nz4/DR6kIzLwd4BEs1ul71iAH8HFK3aZfkoCdCvT2IJ5ceJ6MPPetQBv1xhdQXuTuVVIjLuxKCec7k96fZ5Xf3sL4RnMCwcVi7VDHIxuYmk46pGyf5hf8zP61ahXDHRsdlm9z3BXH0fW7EZVjEE+27C9ubhGVd0mxArJecjgVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827397; c=relaxed/simple;
	bh=Gl7ozKcWJsld57XbyPti/xD3k4uPZ7xZWxRhCEHxCOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NE605JUnB+gSQHOU6mf9GWkcetYahCzf/Y887G3sB5F5n1L2ujrumh7NlDxT8MG77uEAE+ved51PNjOvXDfHlEXNqnLe/oAHAQNAzP2W/xLsOGA3hyFzaE5AJb8S7Jbpm7FVjRZqHXvFRvgMNcm91PFZ+Vh7PcLg91Bh3aiBS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVItYnfc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685C61F00893;
	Sun,  7 Jun 2026 10:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827396;
	bh=GTj+LzNmnPdQ9MCaVDxvPn9oSe0vJAuTNhFbuFyF0o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVItYnfcwPlSsJolbbfVEeemAWMOv/aPoMYO4yjdT/dE/fdS5KMmE9yu5i6+7tiat
	 BIItndhyFC3ny9gRNdqs4hty5jEJbNOZ6u4q9eJ2ZhhLkNhm+eHXrofGZZqLHVnjr5
	 EuxdNd1kiLAeJlw9h/7lC2mD49DsvNkeS3I+8VEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 070/315] ethtool: tsinfo: dont pass ERR_PTR to genlmsg_cancel on prepare failure
Date: Sun,  7 Jun 2026 11:57:37 +0200
Message-ID: <20260607095730.184765910@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261140-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:kory.maincent@bootlin.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,bootlin.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22E6364F9F5

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit c3fc9976f686f9a95baf87db9d387f218fd65394 ]

The goto err label leads to:

	genlmsg_cancel(skb, ehdr);
	return ret;

If ethnl_tsinfo_prepare_dump() failed, it has not started a genlmsg.
There's nothing to cancel, and passing an error pointer to
genlmsg_cancel() would cause a crash.

Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support several hwtstamp by net topology")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Link: https://patch.msgid.link/20260526153533.2779187-8-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/tsinfo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index fcc28fca526d82..53f12128a1a580 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -405,10 +405,8 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 			continue;
 
 		ehdr = ethnl_tsinfo_prepare_dump(skb, dev, reply_data, cb);
-		if (IS_ERR(ehdr)) {
-			ret = PTR_ERR(ehdr);
-			goto err;
-		}
+		if (IS_ERR(ehdr))
+			return PTR_ERR(ehdr);
 
 		reply_data->ts_info.phc_qualifier = ctx->pos_phcqualifier;
 		ret = ops->get_ts_info(dev, &reply_data->ts_info);
-- 
2.53.0




