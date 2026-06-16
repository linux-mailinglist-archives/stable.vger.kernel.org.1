Return-Path: <stable+bounces-265048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BayIBAeEMWqClQUAu9opvQ
	(envelope-from <stable+bounces-265048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B78692DAC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xxvVRK6M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265048-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265048-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6694031E76BA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E824779B1;
	Tue, 16 Jun 2026 17:00:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A74657CF;
	Tue, 16 Jun 2026 17:00:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629216; cv=none; b=nmafty9lCULaqji/m69A/p0uai6Q/mzLcE8TIJ/Vmval2YE3xtvT8BBpgbg30dHEMy4WRsma9IB1E7L1xsLCa4FJMbnb4Jl83eeRZb14H8mOhDWWcZtXd3XY4rs4jJWsxiiWT77x8mFLVOhscjfRCtXvHAJbk9lyZKRU8mv+YtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629216; c=relaxed/simple;
	bh=w3g18Q8pNAdhjDQNqUCw1rekszMJz+YJkjuUxG3OZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACmfEi2LyjsZmCD7xcljBJhH/0giOC56SgvK9JcUa3Nr5eov4HM2GDdomrxEozuk5JxyYRTH/ZMpJQa9wvJCdbv3bQCnTsdSOaxId1er+KEVNRPo46u5hJe8nmwnLV/vUH0TGFO/lULBHe4UOhj5Og1O/JdYQNRlnLPVzSGHYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xxvVRK6M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30D41F000E9;
	Tue, 16 Jun 2026 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629215;
	bh=UCrlKJhEGSOUNg/L780FcMlGExjruyFx+T4xwr4Z63s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xxvVRK6MD/9+HO6Gu8VQfa2vqVwn0GgTJuzoVYyNWIylEWEbhtIaL8FcBeNiIq8bk
	 4cuuhx3w1mDxDC9RoecrlNt13ksB6bPqSpngmB09XWhzUvLMcOfbDSIkj2AEPtVl3c
	 s7KoI9uGFs/eNqPvZa+B1uwnEkNmGYL56KQRBfpU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Roulin <aroulin@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 243/452] vxlan: vnifilter: fix spurious notification on VNI update
Date: Tue, 16 Jun 2026 20:27:50 +0530
Message-ID: <20260616145130.437722236@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265048-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:aroulin@nvidia.com,m:petrm@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92B78692DAC

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Roulin <aroulin@nvidia.com>

[ Upstream commit 84683b5b60c7274e2c8f7f413d39d78d3db5540f ]

When a VNI is re-added with the same attributes (e.g. same group or no
group), vxlan_vni_update() sends a spurious RTM_NEWTUNNEL notification
even though nothing changed.

The bug is that 'if (changed)' tests whether the pointer is non-NULL,
not the bool value it points to. Since every caller passes a valid
pointer, the condition is always true and the notification fires
unconditionally.

Fix by dereferencing the pointer: 'if (*changed)'.

Reproducer:

 # ip link add vxlan100 type vxlan dstport 4789 local 10.0.0.1 \
      nolearning external vnifilter
 # ip link set vxlan100 up
 # bridge monitor vni &
 # bridge vni add vni 1000 dev vxlan100
 # bridge vni add vni 1000 dev vxlan100  # spurious notification

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Link: https://patch.msgid.link/20260602185138.253265-3-aroulin@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 1ab78a8bb9e011..272fa31ef07454 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -671,7 +671,7 @@ static int vxlan_vni_update(struct vxlan_dev *vxlan,
 	if (ret)
 		return ret;
 
-	if (changed)
+	if (*changed)
 		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
 	return 0;
-- 
2.53.0




