Return-Path: <stable+bounces-270947-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V49BO+mgRmodagsAu9opvQ
	(envelope-from <stable+bounces-270947-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:33:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE586FB704
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:33:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=aHGpfmOC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270947-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270947-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA90A337A1E1
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB135E1B6;
	Thu,  2 Jul 2026 16:37:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A003438A6;
	Thu,  2 Jul 2026 16:37:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010268; cv=none; b=LJUqNuKPZWWyEqP8//8kXDSYOf77/A7CpSAMwbessuwY52ZClj4UCpnjtFoJfT+ICymW8CdJqUEbZj46/0Ggw/fh1HltvQLi9fxh2nuclEr51WnfSWoqCUIoszDlwSQhZkC9EE3sV+5w6syekvDqoC1w0fMnDbr13X7rZHNbzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010268; c=relaxed/simple;
	bh=yMGnsSBV8EDDsBZcEA/TTAaFdnEzbQh7MhtIepVywqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLa34qGbu/bXpRQ/zXHP7xJPQ7HTVZF3JfIgJXbiO/Fb4KTk/DuIhJn3BNwb5UKgKoBhqMxjbZrUBIJ7Rx/GRJpSsObDy2TNtYbKjTYCa5r2swfTtfE30mjPRIYrPr5PbgTOxN9214c0v3TJj7RU904OCvL3LMoqalYxToqg954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHGpfmOC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932EA1F000E9;
	Thu,  2 Jul 2026 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010267;
	bh=aT0GI47SvvWBAAZAamiW1BetP/NPk9uCUNFavLaC2VM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aHGpfmOCf/j0X/Wx8twmQ9U/EbYbPq3bMtdKfaLiPHItkMdJGc6Xm2CDIXMwsSBw5
	 AG+HvLgPxiq8oQtw4Kp78CpJLqC102DRMSbu8nJsqL9S6ZIfyt+2w7Y4OHD3xJp6Oc
	 72Fmq4r6C/CRsQSMrkL6ONnSsvNfpQwxjH8rJEyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kevin Berry <kpberry@google.com>
Subject: [PATCH 6.12 044/204] bonding: fix NULL pointer dereference in actor_port_prio setting
Date: Thu,  2 Jul 2026 18:18:21 +0200
Message-ID: <20260702155119.578095938@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,gmail.com,kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-270947-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:liali@redhat.com,m:liuhangbin@gmail.com,m:kuba@kernel.org,m:kpberry@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BE586FB704

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 067bf016e99ad72aa4ff869d6dec1fd62a9c6202 ]

Liang reported an issue where setting a slave’s actor_port_prio to
predefined values such as 0, 255, or 65535 would cause a system crash.

The problem occurs because in bond_opt_parse(), when the provided value
matches a predefined table entry, the function returns that table entry,
which does not contain slave information. Later, in
bond_option_actor_port_prio_set(), calling bond_slave_get_rtnl() leads
to a NULL pointer dereference.

Since actor_port_prio is defined as a u16 and initialized to the default
value of 255 in ad_initialize_port(), there is no need for the
bond_actor_port_prio_tbl. Using the BOND_OPTFLAG_RAWVAL flag is sufficient.

Fixes: 6b6dc81ee7e8 ("bonding: add support for per-port LACP actor priority")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20251105072620.164841-1-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kevin Berry <kpberry@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_options.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -225,13 +225,6 @@ static const struct bond_opt_value bond_
 	{ NULL,      -1,    0},
 };
 
-static const struct bond_opt_value bond_actor_port_prio_tbl[] = {
-	{ "minval",  0,     BOND_VALFLAG_MIN},
-	{ "maxval",  65535, BOND_VALFLAG_MAX},
-	{ "default", 255,   BOND_VALFLAG_DEFAULT},
-	{ NULL,      -1,    0},
-};
-
 static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
@@ -497,7 +490,7 @@ static const struct bond_option bond_opt
 		.id = BOND_OPT_ACTOR_PORT_PRIO,
 		.name = "actor_port_prio",
 		.unsuppmodes = BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
-		.values = bond_actor_port_prio_tbl,
+		.flags = BOND_OPTFLAG_RAWVAL,
 		.set = bond_option_actor_port_prio_set,
 	},
 	[BOND_OPT_AD_ACTOR_SYSTEM] = {



