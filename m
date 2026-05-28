Return-Path: <stable+bounces-255828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDtjFnCoGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E966D5F9524
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C3BE328732A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFB0254B1F;
	Thu, 28 May 2026 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XAImBWvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED09DDC5;
	Thu, 28 May 2026 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999993; cv=none; b=Iblstdda2w7S+2bUKlaxeEJE91zzJmZmWGTrVuUDz6OCegw7LJ3jEqQAcOr8guE2gsp+wyq0CgKFJ2AD/bvCxi2LVaGEVKDiWM+Qw/2ngXp+mdS8taYdvpC9JTiRuBK7ke3i3TxAyo1xovOZCW4yYC3UF8q4QmGGIV5XZoXn0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999993; c=relaxed/simple;
	bh=AdYlzPA+Qwhq4GH+/rcKsAmkxwJsSiqcv1eVmXogZOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnZoirfp9PS4u1opQaTr/m7YzaH9MU1L+2qMk4CNBxuTQ7Sf0y8YprgBOXa3sCNdCZkuHyvX+K/O7eypQzIqOInqwo6+Vky4vqdPRe33z/hdKAAynuNRtjN0Np0xI7FYZF/ODGLzcNg3KIcn+qq02aCfcmxNHe/zIIkX2Iavk+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XAImBWvv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D271F00A3A;
	Thu, 28 May 2026 20:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999992;
	bh=eVh3FVJyVq1KengrbXNeTVjcOuhtjtjdrOWRaJ6l7UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XAImBWvvAyt3vHtsmuaFH4GAXq5DXU0eZ0dJzrxQ1eFt0LQqDv/gRHNr9HauxKMOH
	 glJEoOXcYXYamBdE1c83ifmIifrHlAfLqw14j+6ftd6LPz++so+Pm8o0xwCBMnciIe
	 EsbFs35JsGJGE+Ay5R9aGlklBGZJzgIu3ifwJ84s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 263/377] net: shaper: enforce singleton NETDEV scope with id 0
Date: Thu, 28 May 2026 21:48:21 +0200
Message-ID: <20260528194645.982539983@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255828-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E966D5F9524
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit b62b29e6de6711f5918940aa6ff2bbab6d6af502 ]

The NETDEV scope represents a singleton root shaper in the per-device
hierarchy.  All code assumes NETDEV shapers have id 0:
net_shaper_default_parent() hardcodes parent->id = 0 when returning
the NETDEV parent for QUEUE/NODE children, and the UAPI documentation
describes NETDEV scope as "the main shaper" (singular, not plural).

Make sure we reject non-0 IDs.

Fixes: 4b623f9f0f59 ("net-shapers: implement NL get operation")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20260510192904.3987113-10-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/shaper/shaper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index b2d85963243fa..d65008b819dc9 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -482,6 +482,12 @@ static int net_shaper_parse_handle(const struct nlattr *attr,
 	else if (handle->scope == NET_SHAPER_SCOPE_NODE)
 		id = NET_SHAPER_ID_UNSPEC;
 
+	if (id && handle->scope == NET_SHAPER_SCOPE_NETDEV) {
+		NL_SET_ERR_MSG_ATTR(info->extack, id_attr,
+				    "Netdev scope is a singleton, must use ID 0");
+		return -EINVAL;
+	}
+
 	handle->id = id;
 	return 0;
 }
-- 
2.53.0




