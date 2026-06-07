Return-Path: <stable+bounces-261085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +PxdNFBEJWq8FQIAu9opvQ
	(envelope-from <stable+bounces-261085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:13:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D6164F6B9
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:13:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=j2lHbiwu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261085-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261085-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8DE530034A9
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B0C308F0A;
	Sun,  7 Jun 2026 10:13:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732131E98EF;
	Sun,  7 Jun 2026 10:13:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827211; cv=none; b=eOQk605sE1ny0GAEnrSptCCjSuzEjFq8B1aAPz7UTnuAIVMc8AzFobkQAYidntPC25JwBzY+F718/0f9oDxD8BRL8r/UEGYpedyXVw9CnR0/JXIq8yXsMM082XNDgmGHZEycByFpOrNTC71z1HFNTKO/IfyMUYlSSiHMqTGhhFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827211; c=relaxed/simple;
	bh=1QE4ZM4r15Lm3Om8yfst5/iYRItQZuzXac4jB4rIj4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVlbZ6Yf7Sa3gqRJpX970kpnAmIMhrq3o+xHfWwk3SptBnKQGkaPY460XkRaJX80bKrLRzsG1VMjciPWushZ6N/9OnxWGQof/LBAAWxDr5+ubRZOy0z09ySC9xGFcVeAjKAZ8X2zbiGM26x4yxAc3ziN12UqgkzMfbD45Gp30nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2lHbiwu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B658D1F00893;
	Sun,  7 Jun 2026 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827210;
	bh=kDrZy5Irjqb4x2uiTsV6GwlTYuNARRp630CZdGduat4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j2lHbiwuEOMGJ7+3Pal6XBDJdFtd3HMsC+CcHOa4t6rOtj5jnCHzpBQH/K1Y/Dc+3
	 q4MhAwOHl46uwYDTnmCfOo0I6V5Fa5NnoeeSiqvKeZQwBnBQdqICX34LwthHcT9A3Z
	 HTL3Lq1jOka5OKTGeiobW4UrykZM0QdMWTf1MaUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 050/315] ethtool: cmis: fix u16-to-u8 truncation of msleep_pre_rpl
Date: Sun,  7 Jun 2026 11:57:17 +0200
Message-ID: <20260607095729.430074182@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261085-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:maxime.chevallier@bootlin.com,m:danieller@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,bootlin.com:email,nvidia.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2D6164F6B9

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 3e8c3d464c36bb342fe377b026577c7ec27fdbb4 ]

ethtool_cmis_cdb_compose_args() accepts msleep_pre_rpl as u16 but stores
it into the u8 field ethtool_cmis_cdb_cmd_args::msleep_pre_rpl, silently
truncating values >= 256. Seven of the nine call sites pass 1000 ms
(it's the third argument from the end).

Fixes: a39c84d79625 ("ethtool: cmis_cdb: Add a layer for supporting CDB commands")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
Link: https://patch.msgid.link/20260522231312.1710836-8-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ethtool/cmis.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 4a9a946cabf05d..778783a0f23c0b 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -63,9 +63,9 @@ struct ethtool_cmis_cdb_request {
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
  * @req: CDB command fields as described in the CMIS standard.
  * @max_duration: Maximum duration time for command completion in msec.
+ * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @read_write_len_ext: Allowable additional number of byte octets to the LPL
  *			in a READ or a WRITE commands.
- * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @rpl_exp_len: Expected reply length in bytes.
  * @flags: Validation flags for CDB commands.
  * @err_msg: Error message to be sent to user space.
@@ -73,8 +73,8 @@ struct ethtool_cmis_cdb_request {
 struct ethtool_cmis_cdb_cmd_args {
 	struct ethtool_cmis_cdb_request req;
 	u16				max_duration;
+	u16				msleep_pre_rpl;
 	u8				read_write_len_ext;
-	u8				msleep_pre_rpl;
 	u8                              rpl_exp_len;
 	u8				flags;
 	char				*err_msg;
-- 
2.53.0




