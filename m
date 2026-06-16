Return-Path: <stable+bounces-265047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wRP/OACEMWp/lQUAu9opvQ
	(envelope-from <stable+bounces-265047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3F4692DA1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=063qJtk6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265047-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265047-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D28231E37E5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27F35675A;
	Tue, 16 Jun 2026 17:00:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D546478E53;
	Tue, 16 Jun 2026 17:00:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629211; cv=none; b=LrS8bLwgieQYFlCmmBr+MS+8UFFIqlpEORlCdNL27zTo7Fl2621U5ylUouFj+1baHMWfl4RkQ4NDU8veMqJ5NyuIVThiuMsHB8Kev1J2jD+znGdPs/cmi48tsoE+t/YKIMkCAmLlDKMyY9D6h+RaQoW9dONE2U5UbR3pPmKFiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629211; c=relaxed/simple;
	bh=y4mRXrEo+DK4T+o1MQ0STHlbBMBbeDtWcAM+0ibqSf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjnh3/k9UatR5NNkS0ZDbxEsEhgMadZtnAzUVQ9tXPfl2pC2VxFzRoGVBuI+L8PQyiseEUbCNGTwb6D9/8FqmTnKjjCOiwbfqr3kj80XO/6mR6skenJZeMoGr8E/wTmE2w2cC0kPO6ozB7KQ+sBg3MH8B/qho8r9anIVkZI/YXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=063qJtk6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652A41F000E9;
	Tue, 16 Jun 2026 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629210;
	bh=zKf+zjAFWTtFEwE2uY1M6Uz6llSOVooon72ODFsmjzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=063qJtk6A+NUtilV12B4D6e8w13sF2Clmm1V5RnnOyYhhC2s3RR9/WHK00X0v+8xB
	 zPKUhRpJsGdMXIBhSYRJumNzxIZCtDf5KT3tgLwXyNFmfefGCUnkAy/4dsT23G2R8b
	 kD+enin7zNITA+Dp9HQPgteiEXbrhmFZPMrvE+mc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chirag Shah <chirag@nvidia.com>,
	Andy Roulin <aroulin@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 242/452] vxlan: vnifilter: send notification on VNI add
Date: Tue, 16 Jun 2026 20:27:49 +0530
Message-ID: <20260616145130.391061278@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265047-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:chirag@nvidia.com,m:aroulin@nvidia.com,m:petrm@nvidia.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B3F4692DA1

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Roulin <aroulin@nvidia.com>

[ Upstream commit aa6ca1c5c338907817374b59f7551fd855a88754 ]

When a new VNI is added to a vxlan device with vnifilter enabled,
no RTM_NEWTUNNEL notification is sent to userspace. This means
'bridge monitor vni' never shows VNI add events, even though
VNI delete events are reported correctly.

The bug is in vxlan_vni_add(), where the notification is guarded by
'if (changed)'. The 'changed' flag is set by vxlan_vni_update_group()
only when the multicast group or remote IP is modified, but for a
new VNI added without a group (e.g. in L3 VxLAN interface scenarios),
the function returns early without setting changed=true. Since this
is a new VNI, the notification should be sent unconditionally.

The notification is not guarded by the return value of
vxlan_vni_update_group() because, at this point, the VNI has already
been inserted into the hash table and list with no rollback on error.
The VNI will be visible in 'bridge vni show' regardless, so userspace
should be informed. This is consistent with vxlan_vni_del() which also
notifies unconditionally.

The 'if (changed)' guard remains correct in vxlan_vni_update(), which
handles the case where a VNI already exists and is being re-added --
there, we only want to notify if the group/remote actually changed.

Reproducer:

 # ip link add vxlan100 type vxlan dstport 4789 local 10.0.0.1 \
      nolearning external vnifilter
 # ip link set vxlan100 up
 # bridge monitor vni &
 # bridge vni add vni 1000 dev vxlan100    # no notification
 # bridge vni delete vni 1000 dev vxlan100 # notification received

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Reported-by: Chirag Shah <chirag@nvidia.com>
Signed-off-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Link: https://patch.msgid.link/20260602185138.253265-2-aroulin@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_vnifilter.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 06d19e90eadb59..1ab78a8bb9e011 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -769,8 +769,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
 	err = vxlan_vni_update_group(vxlan, vninode, group, true, &changed,
 				     extack);
 
-	if (changed)
-		vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
+	vxlan_vnifilter_notify(vxlan, vninode, RTM_NEWTUNNEL);
 
 	return err;
 }
-- 
2.53.0




