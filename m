Return-Path: <stable+bounces-243044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKJHMEil+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:55:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B61E4BE1DC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19CD630087DB
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381583DE424;
	Mon,  4 May 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFNcSg+Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68F2E2F0E;
	Mon,  4 May 2026 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902873; cv=none; b=iTCIYUrwYiadXx6yQJgv7hGGVVevdS76y3LEiIRrPs/5+uG4UskLZnDVC7dhAwxyBG3VGCsEQo36JWZAUxkyDvK/Sp4s9REyyt5NKu3tdx6sl3PjsY6HLUWM27u/pw8EXOdl9hpGk4FrovaXF5Z4soHux/+I+VkUrW5Qs1LFYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902873; c=relaxed/simple;
	bh=hTtSNHShZurSqhB6u3sH7tw5SY5uf7xlpe889bWNR3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRoWJA4gdqTtfKWWxeG/HEOMNMeYzmNzqFXse2U14eGP0p20WbuOI+IGQM1+15AU3OEj/q/cwNS6Lj2qgD49CwF794jYWWLKDeZp86pxFUCcXTn01l+71QJa4rqljD2X6IQ/ohCfSwPSzh52IDrtrGQhZBsKyPP9f4S1ThwbUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFNcSg+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B767AC2BCB8;
	Mon,  4 May 2026 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902873;
	bh=hTtSNHShZurSqhB6u3sH7tw5SY5uf7xlpe889bWNR3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFNcSg+QR5XnLge/tLuElCrs3G5tfgICzgaFaxgTnHAOqlHkqHTnHFP7RlfsPXEf0
	 dMBnLnpxlfLqIQnRzqOwku2CFkSFVxAZOreP04dyNZdBrZLvWcJA+fxjymL08qhke4
	 fS7dNDrKoN5HovWaT4IFutf2XW0C5fzYhNAI3/Ns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 7.0 016/307] sysfs: attribute_group: Respect is_visible_const() when changing owner
Date: Mon,  4 May 2026 15:48:21 +0200
Message-ID: <20260504135143.439020937@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5B61E4BE1DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243044-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,outlook.com,weissschuh.net,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Weißschuh <linux@weissschuh.net>

commit 9ce4a8c07b28cdd70f6ca38b60bf688c27dbbfb9 upstream.

The call to grp->is_visible in sysfs_group_attrs_change_owner() was
missed when support for is_visible_const() was added.

Check for both is_visible variants there too.

Fixes: 7dd9fdb4939b ("sysfs: attribute_group: enable const variants of is_visible()")
Cc: stable@vger.kernel.org
Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/lkml/SN6PR02MB4157D5F04608E4E3C21AB56ED45EA@SN6PR02MB4157.namprd02.prod.outlook.com/
Link: https://sashiko.dev/#/patchset/20260403-sysfs-const-hv-v2-0-8932ab8d41db%40weissschuh.net
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20260403-sysfs-is_visible_const-fix-v1-1-f87f26071d2c@weissschuh.net
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/sysfs/group.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -517,8 +517,11 @@ static int sysfs_group_attrs_change_owne
 		struct attribute *const *attr;
 
 		for (i = 0, attr = grp->attrs; *attr; i++, attr++) {
-			if (grp->is_visible) {
-				mode = grp->is_visible(kobj, *attr, i);
+			if (grp->is_visible || grp->is_visible_const) {
+				if (grp->is_visible)
+					mode = grp->is_visible(kobj, *attr, i);
+				else
+					mode = grp->is_visible_const(kobj, *attr, i);
 				if (mode & SYSFS_GROUP_INVISIBLE)
 					break;
 				if (!mode)



