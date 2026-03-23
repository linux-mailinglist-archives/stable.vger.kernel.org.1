Return-Path: <stable+bounces-229675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HIqBe9rwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:35:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C902F864E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7AFE328D577
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E825A359;
	Mon, 23 Mar 2026 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MjqDZJoF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D493BE166;
	Mon, 23 Mar 2026 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282564; cv=none; b=rnL65ocrcECcT6S1EJCdeua/8OiJbUUeU8Cyr2Ut6nkn5rGOHtoqTLvmGwdFUAk4BLbXxg+8J8/F7B8KIrQx9Zr0lou0Q5meiv/xZQ/G1WWb3xdosIZtp2efJPTH9FW5JgIJYnh+K2WaSgczT+/juclFRd6EXcIdqTlqqQCIMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282564; c=relaxed/simple;
	bh=QQAeiDncgIPoQDE61+fRMb0wMUgMAzn706eaxWwyAzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIl/cpxl4Z36yKY3JrJrsZZ+249rwcVenC/mNBwI7AqcspKQe8m+DrPFpGaTV3gk2+JY4HYdDPTNB4YLb/Utd9oyISlyLwyc7UVY2f+HODH/SLtXgrk2F2JDcx/b8iuvFGE/wL/5CTnxNiFS1LUcr2vROtGJq3bw+CVQnsybfJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MjqDZJoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A257C2BC9E;
	Mon, 23 Mar 2026 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282563;
	bh=QQAeiDncgIPoQDE61+fRMb0wMUgMAzn706eaxWwyAzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjqDZJoFHL8dPDrefeATO5iz3y5ieckww8Xug1ikRfTWR6R//iLPRYkSYDA+GBdjr
	 VDXpoNWglWl/B18YG/7PnCfpB4PjG6qrJq52Mzc++fooxcmG8Tp6AklD4TxCLe+ya/
	 Wg4V39alJxai2Pty6Z/ANdoiKY1+XeIjxZg6faMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 186/481] i40e: fix src IP mask checks and memcpy argument names in cloud filter
Date: Mon, 23 Mar 2026 14:42:48 +0100
Message-ID: <20260323134529.735611501@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229675-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 96C902F864E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit e809085f492842ce7a519c9ef72d40f4bca89c13 ]

Fix following issues in the IPv4 and IPv6 cloud filter handling logic in
both the add and delete paths:

- The source-IP mask check incorrectly compares mask.src_ip[0] against
  tcf.dst_ip[0]. Update it to compare against tcf.src_ip[0]. This likely
  goes unnoticed because the check is in an "else if" path that only
  executes when dst_ip is not set, most cloud filter use cases focus on
  destination-IP matching, and the buggy condition can accidentally
  evaluate true in some cases.

- memcpy() for the IPv4 source address incorrectly uses
  ARRAY_SIZE(tcf.dst_ip) instead of ARRAY_SIZE(tcf.src_ip), although
  both arrays are the same size.

- The IPv4 memcpy operations used ARRAY_SIZE(tcf.dst_ip) and ARRAY_SIZE
  (tcf.src_ip), Update these to use sizeof(cfilter->ip.v4.dst_ip) and
  sizeof(cfilter->ip.v4.src_ip) to ensure correct and explicit copy size.

- In the IPv6 delete path, memcmp() uses sizeof(src_ip6) when comparing
  dst_ip6 fields. Replace this with sizeof(dst_ip6) to make the intent
  explicit, even though both fields are struct in6_addr.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1bba77347efbb..73ef73c69bd0a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3755,10 +3755,10 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		cfilter.n_proto = ETH_P_IP;
 		if (mask.dst_ip[0] & tcf.dst_ip[0])
 			memcpy(&cfilter.ip.v4.dst_ip, tcf.dst_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
-		else if (mask.src_ip[0] & tcf.dst_ip[0])
+			       sizeof(cfilter.ip.v4.dst_ip));
+		else if (mask.src_ip[0] & tcf.src_ip[0])
 			memcpy(&cfilter.ip.v4.src_ip, tcf.src_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
+			       sizeof(cfilter.ip.v4.src_ip));
 		break;
 	case VIRTCHNL_TCP_V6_FLOW:
 		cfilter.n_proto = ETH_P_IPV6;
@@ -3813,7 +3813,7 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		/* for ipv6, mask is set for all sixteen bytes (4 words) */
 		if (cfilter.n_proto == ETH_P_IPV6 && mask.dst_ip[3])
 			if (memcmp(&cfilter.ip.v6.dst_ip6, &cf->ip.v6.dst_ip6,
-				   sizeof(cfilter.ip.v6.src_ip6)))
+				   sizeof(cfilter.ip.v6.dst_ip6)))
 				continue;
 		if (mask.vlan_id)
 			if (cfilter.vlan_id != cf->vlan_id)
@@ -3901,10 +3901,10 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		cfilter->n_proto = ETH_P_IP;
 		if (mask.dst_ip[0] & tcf.dst_ip[0])
 			memcpy(&cfilter->ip.v4.dst_ip, tcf.dst_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
-		else if (mask.src_ip[0] & tcf.dst_ip[0])
+			       sizeof(cfilter->ip.v4.dst_ip));
+		else if (mask.src_ip[0] & tcf.src_ip[0])
 			memcpy(&cfilter->ip.v4.src_ip, tcf.src_ip,
-			       ARRAY_SIZE(tcf.dst_ip));
+			       sizeof(cfilter->ip.v4.src_ip));
 		break;
 	case VIRTCHNL_TCP_V6_FLOW:
 		cfilter->n_proto = ETH_P_IPV6;
-- 
2.51.0




