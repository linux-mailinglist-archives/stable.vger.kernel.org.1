Return-Path: <stable+bounces-218914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HL5E51WnmkKUwQAu9opvQ
	(envelope-from <stable+bounces-218914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AD4190370
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2D6D30DF43E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0067128640C;
	Wed, 25 Feb 2026 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7iVopLv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8750248F54;
	Wed, 25 Feb 2026 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983807; cv=none; b=rS6puzk6K9xAuigwsxX3d4Nvtl3zQ6sjCzmzvpp5qR2KFpN5SFB2p5dyCKWJRpAhAaJcbVrC3FeRicKLdUmi3k4aOt/tLl4JM7pUpu3R+pKnQJvI7molrywocf1prq/x2/dn9U5SmFkvKqOimtNWC88hjKZGYmm68hqoyd9g63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983807; c=relaxed/simple;
	bh=hmCUlpsurcJYA50YdrQhNmb0ThRdokZUgwGXp3A30/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEoJEJeJlm+ZKsWZuBOFlSfvdy3AsW/tMQ5vpI9ugPiZJMAGev3snagwU46N2kmqyVRcKGgYNHJGJVOGVHU3hOrPq2L2nPw/CcZmpMrDw3UrD8TBy0p+1fqXDJao4erLAYKub0Qi2SICXOYSHqN2ll+SIAuaaoZ9utOsD+xeN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7iVopLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBAFC116D0;
	Wed, 25 Feb 2026 01:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983807;
	bh=hmCUlpsurcJYA50YdrQhNmb0ThRdokZUgwGXp3A30/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7iVopLvl8KvFBIPqu6mVxwfrg8Yj6oPWTm2UTZMsOQ9iY4UOfp1r5fKXMHNaOSsD
	 sM4wPK6takm25NC5w7OvceGGPnWrk2NigDN7hsAmApR9mgrSzGC4+kcGkL1bWRRgu9
	 tpjIcXYvptUrxuBh3miSC8LeLyhL6MaDFG9YoOQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 050/641] thermal/of: Fix reference leak in thermal_of_cm_lookup()
Date: Tue, 24 Feb 2026 17:16:16 -0800
Message-ID: <20260225012350.247498695@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218914-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,arm.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: A7AD4190370
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit a1fe789a96fe47733c133134fd264cb7ca832395 ]

In thermal_of_cm_lookup(), tr_np is obtained via of_parse_phandle(), but
never released.

Use the __free(device_node) cleanup attribute to automatically release
the node and fix the leak.

Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
[ rjw: Changelog edits ]
Link: https://patch.msgid.link/20260124-thermal_of-v1-1-54d3416948cf@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1a51a4d240ff6..b6d0c92f5522b 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -280,10 +280,10 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
 				 struct cooling_spec *c)
 {
 	for_each_child_of_node_scoped(cm_np, child) {
-		struct device_node *tr_np;
 		int count, i;
 
-		tr_np = of_parse_phandle(child, "trip", 0);
+		struct device_node *tr_np __free(device_node) =
+			of_parse_phandle(child, "trip", 0);
 		if (tr_np != trip->priv)
 			continue;
 
-- 
2.51.0




