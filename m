Return-Path: <stable+bounces-232325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMfdI8n/y2koNQYAu9opvQ
	(envelope-from <stable+bounces-232325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178236E048
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E20E230F3BCE
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A62D2D7DD7;
	Tue, 31 Mar 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HE/MJNjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8522C21F8;
	Tue, 31 Mar 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976459; cv=none; b=EYWSOx9764eTcEifLNtur4y3JwAL2g174Tw9dU5seKRfzmfA0nHoMayPOH1XiG6Kk0QDPDptJNfGFt/kVbkdhYkaoXFBfmCm4FGD6S2KLgmKr8iYYwITmIUTlZMbx17MCfsVqwA3LDOrVlG6EM2iA6AWoE4PyKrCmvlnWMjIQ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976459; c=relaxed/simple;
	bh=bF6zCXnuacN51BrQX7tP86OPex3I0KE3WILVFOM+TVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZFqwjvxQEKpF9xH6BB/7M7c3QOnbKVVuNaA93q1ZwnUAw+LA3k67cdIaG4lUfrJ7yS+uhvOt9R6b+O+sFDOZUuezadjz9E8sb7EepwTvBoEvA0vpTZeymxnbFtaNdNmu3SS+36L1ndcrHRL19Xj/D4s4wKrZj1eyonvQSo5yIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HE/MJNjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961A3C19423;
	Tue, 31 Mar 2026 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976458;
	bh=bF6zCXnuacN51BrQX7tP86OPex3I0KE3WILVFOM+TVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE/MJNjweR8QIDqfcg+GR6Nne6H0qzhn/g4O0whx4U6T+oQPGNonU1UTj3JR+axHR
	 wp+8tfcTCpy/eXDpPaIM3vGk/75LXSWXMp8GSKTQc47xIlMoEjYoYKMMXX/AFyGyql
	 q8zctiBZH1cuQ/Ewo1af68E21E/dn9bjRjqK1FBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Yuan Tan <tanyuan98@outlook.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 093/309] openvswitch: validate MPLS set/set_masked payload length
Date: Tue, 31 Mar 2026 18:19:56 +0200
Message-ID: <20260331161756.914147427@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,outlook.com,ovn.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-232325-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 1178236E048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yang <n05ec@lzu.edu.cn>

[ Upstream commit 546b68ac893595877ffbd7751e5c55fd1c43ede6 ]

validate_set() accepted OVS_KEY_ATTR_MPLS as variable-sized payload for
SET/SET_MASKED actions. In action handling, OVS expects fixed-size
MPLS key data (struct ovs_key_mpls).

Use the already normalized key_len (masked case included) and reject
non-matching MPLS action key sizes.

Reject invalid MPLS action payload lengths early.

Fixes: fbdcdd78da7c ("Change in Openvswitch to support MPLS label depth of 3 in ingress direction")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Link: https://patch.msgid.link/20260319080228.3423307-1-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/flow_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 2d536901309ea..2dc4a6c2aecec 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -2953,6 +2953,8 @@ static int validate_set(const struct nlattr *a,
 	case OVS_KEY_ATTR_MPLS:
 		if (!eth_p_mpls(eth_type))
 			return -EINVAL;
+		if (key_len != sizeof(struct ovs_key_mpls))
+			return -EINVAL;
 		break;
 
 	case OVS_KEY_ATTR_SCTP:
-- 
2.51.0




