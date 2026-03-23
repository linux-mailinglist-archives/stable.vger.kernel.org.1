Return-Path: <stable+bounces-228248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK+dBGBMwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:21:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A32F4433
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B83D30DF1FA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0593B27C8;
	Mon, 23 Mar 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mcXbTihT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9873B19D4;
	Mon, 23 Mar 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274574; cv=none; b=ueXe7FWnrAK2IDH6McOjjIU9dXYF742tuTPfx2EnU1r8aJ2JoEAwykVkj3h8wUigJBOQTkx2Y4duyk+9ZB14r9wXa/5fz1VypO6uPolG9kpRSw0Olcgo9c/9uaFshtarQJQTVhOV1yDQ6E351QA1gloTkUOkXlwlzvOqO9zIpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274574; c=relaxed/simple;
	bh=Ne64Oc6tDwdgrN7H511pU7OlPi3HVb7Q2PoxZZoNFP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcTf2GeKEr/l37Tyo27NyGcFo5rjSwXHG1LzQjP7sgCfM/ZNDHq+35DyOKPfUrELrazTng3yUuTr8TJxThpFSTrqgrEGTpljM2cYRh1//dLfGiB5LD9Gfxy0XC0M0sOye4Oi5OeCDUyn4wIzQdTsTjQ1d5AHtfyUjjb6TYjgkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mcXbTihT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D94C4CEF7;
	Mon, 23 Mar 2026 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274574;
	bh=Ne64Oc6tDwdgrN7H511pU7OlPi3HVb7Q2PoxZZoNFP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcXbTihTeFwy3qXZlRu+4X1Sxru1eBZwaWzhvIiSy/XiZ4x/rBI7CxxsaPW2kVaeh
	 pYDy1eJO/EgJ8NgLRzEp6SAXuvzvl3s+EZtCjxW6kmJfEjWk1mf6/C5BQLsmurD1yB
	 EQ9+9PXT7ijs8/y9id9RtGtaQu5Vo2WxvXq/Zxes=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 033/212] netconsole: fix sysdata_release_enabled_show checking wrong flag
Date: Mon, 23 Mar 2026 14:44:14 +0100
Message-ID: <20260323134504.812985536@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228248-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[msgid.link:server fail,linuxfoundation.org:server fail,sea.lore.kernel.org:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A40A32F4433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5af6e8b54927f7a8d3c7fd02b1bdc09e93d5c079 ]

sysdata_release_enabled_show() checks SYSDATA_TASKNAME instead of
SYSDATA_RELEASE, causing the configfs release_enabled attribute to
reflect the taskname feature state rather than the release feature
state. This is a copy-paste error from the adjacent
sysdata_taskname_enabled_show() function.

The corresponding _store function already uses the correct
SYSDATA_RELEASE flag.

Fixes: 343f90227070 ("netconsole: implement configfs for release_enabled")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/netconsole.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -503,7 +503,7 @@ static ssize_t sysdata_release_enabled_s
 	bool release_enabled;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	mutex_unlock(&dynamic_netconsole_mutex);
 
 	return sysfs_emit(buf, "%d\n", release_enabled);



