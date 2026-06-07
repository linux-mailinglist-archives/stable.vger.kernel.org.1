Return-Path: <stable+bounces-261847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JkQoGoRPJWoqGwIAu9opvQ
	(envelope-from <stable+bounces-261847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:01:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF66503B3
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 13:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Lvb3x12a;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261847-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261847-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A69D300B77C
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 11:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D346212564;
	Sun,  7 Jun 2026 11:01:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1B282F30;
	Sun,  7 Jun 2026 11:01:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830080; cv=none; b=R+H/cCKI4gYrpw01B3EHy38omIt/+6tNzw3LnBtovet0xYjSjUH8wlmvh+sL1MyQX3TXzUymE7+tPJe7R6TmnG1MM6Qvq8IIFX5afKqbdTBhpW9eLq3ONpWoKRBzO44vE7qc15Oe946nbQ+v+4WFrvpVQ69wsnrguWWmOeXHP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830080; c=relaxed/simple;
	bh=ZM3pYpttLHR/PT4SM51yf67t0300N0hKGBgz1tOQYrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu1SXA3XVGRsJgileJeI11LFqsLafpvMpCeZZkX7D9G/wjnFqTfPCphAYFE3ylmppXQJ1DrpkcEmV+WO54h0ljEMdy3vXkEDsgBnCikN3vu/8fdi1udDKNxQk4PcZwjQK1EZZFkLZIhY+LbEMuFqv22uit1XHR7WH/r8SIPaPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lvb3x12a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5BC1F00893;
	Sun,  7 Jun 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780830078;
	bh=/nnWR+oETA5cZ0fT56w4h6i/XnzOK1pXCt7eataVLvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lvb3x12a6CQRRTYcdpHdqih+x9PRToQ+fTqAy7Dfc0LhrrJgHsI1npHoLoDxYGWRB
	 kPvjsVBONbNL6sq8oYUmYzsMv631sdskR/K+/JJ1kgHeCzqT93RQeN3PuPkJCd+3vl
	 cEDNuwlDzVbsna92ZZcX5bZV/trL8L6rPF4iL3AU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 280/307] ice: fix VF queue configuration with low MTU values
Date: Sun,  7 Jun 2026 12:01:17 +0200
Message-ID: <20260607095738.013537932@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261847-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jtornosm@redhat.com,m:jacob.e.keller@intel.com,m:michal.swiatkowski@linux.intel.com,m:pmenzel@molgen.mpg.de,m:rafal.romanowski@intel.com,m:anthony.l.nguyen@intel.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCEF66503B3

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

[ Upstream commit 3ba4dd024d26372733d1c02e13e076c6016e3320 ]

The ice driver's VF queue configuration validation rejects
databuffer_size values below 1024 bytes, which prevents VFs from
using MTU values below 871 bytes.

The iavf driver calculates databuffer_size based on the MTU using:
  databuffer_size = ALIGN(MTU + LIBETH_RX_LL_LEN, 128)

where LIBETH_RX_LL_LEN = 26 (ETH_HLEN + 2*VLAN_HLEN + ETH_FCS_LEN).

For MTU values below 871:
  MTU 870: 870 + 26 = 896, aligned to 128 = 896 (< 1024, rejected)
  MTU 871: 871 + 26 = 897, aligned to 128 = 1024 (>= 1024, accepted)

The 1024-byte minimum seems unnecessarily restrictive, because the hardware
supports databuffer_size as low as 128 bytes (the alignment boundary),
which should allow MTU values down to the standard minimum of 68 bytes.

I haven't found the reason why the limit was configured in the commit
9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message"), so
with no more information and since it is working, change the minimum
databuffer_size validation from 1024 to 128 bytes to allow standard low
MTU values while still preventing invalid configurations.

Fixes: 9c7dd7566d18 ("ice: add validation in OP_CONFIG_VSI_QUEUES VF message")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260515182419.1597859-3-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied the change to ice_virtchnl.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1746,7 +1746,7 @@ static int ice_vc_cfg_qs_msg(struct ice_
 
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
-			     qpi->rxq.databuffer_size < 1024))
+			     qpi->rxq.databuffer_size < 128))
 				goto error_param;
 			ring->rx_buf_len = qpi->rxq.databuffer_size;
 			if (qpi->rxq.max_pkt_size > max_frame_size ||



