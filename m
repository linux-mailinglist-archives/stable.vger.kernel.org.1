Return-Path: <stable+bounces-102382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858F9EF270
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF92E189348F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7E22FDF1;
	Thu, 12 Dec 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tDwWCpgF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCB2144C0;
	Thu, 12 Dec 2024 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021027; cv=none; b=ss/+AHQCsAOE8SwhQx+5NE4p9phPcpBTsOF1rzNISPgF3pbwsGZRauztKMtvq/+4/8Z5I+wNzY5FljXeIu5wrKQeW2SyIW4RccLKWNfLS9ZP/36D6e0Nw/1bwpHc1hUEVsa/vUahpW0scS2rl3NpdyBr3L6YHKhfcXOxdMfYdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021027; c=relaxed/simple;
	bh=1DdVehWgt/PyU1EtJcDp1Q4e1FBpBcu5LnyFxCa6dcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gq3vC1X8W/6XEe2fCMK0aZ/P76KyLmpwVMKAT0BrTgjiizyzpkrUBhQAp9eAZKJcO2cVeCoQqSqY9py2Y7QbPE9Z5vGTpnw+KlzOutlBPaB9NzTaGkYlTQ9nfuwPRFEpB/gDrbyH138f5cRpUqfjOlHsYuYqfmCtue+oGZOuf68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tDwWCpgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39278C4CECE;
	Thu, 12 Dec 2024 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021026;
	bh=1DdVehWgt/PyU1EtJcDp1Q4e1FBpBcu5LnyFxCa6dcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDwWCpgFg8fmx0OtYqqdxsSZ1yBUMst9f8aFgdrttOChANQPty3V+ruFDc2EV/fqQ
	 uJlsaaJ7komDhUiyayzo5gRrZVwHEv3aYrRjbxy05UfiNebfqlyXK84j43y/f/RIhT
	 wIOX9jsS8KvBFZFvN0d9cffv4u/ZLAEgBqzHYtdA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Imre Deak <imre.deak@intel.com>
Subject: [PATCH 6.1 626/772] drm/dp_mst: Verify request type in the corresponding down message reply
Date: Thu, 12 Dec 2024 15:59:31 +0100
Message-ID: <20241212144415.804886189@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imre Deak <imre.deak@intel.com>

commit 4d49e77a973d3b5d1881663c3f122906a0702940 upstream.

After receiving the response for an MST down request message, the
response should be accepted/parsed only if the response type matches
that of the request. Ensure this by checking if the request type code
stored both in the request and the reply match, dropping the reply in
case of a mismatch.

This fixes the topology detection for an MST hub, as described in the
Closes link below, where the hub sends an incorrect reply message after
a CLEAR_PAYLOAD_TABLE -> LINK_ADDRESS down request message sequence.

Cc: Lyude Paul <lyude@redhat.com>
Cc: <stable@vger.kernel.org>
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12804
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241203160223.2926014-3-imre.deak@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c |   31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -3862,6 +3862,34 @@ drm_dp_get_one_sb_msg(struct drm_dp_mst_
 	return true;
 }
 
+static int get_msg_request_type(u8 data)
+{
+	return data & 0x7f;
+}
+
+static bool verify_rx_request_type(struct drm_dp_mst_topology_mgr *mgr,
+				   const struct drm_dp_sideband_msg_tx *txmsg,
+				   const struct drm_dp_sideband_msg_rx *rxmsg)
+{
+	const struct drm_dp_sideband_msg_hdr *hdr = &rxmsg->initial_hdr;
+	const struct drm_dp_mst_branch *mstb = txmsg->dst;
+	int tx_req_type = get_msg_request_type(txmsg->msg[0]);
+	int rx_req_type = get_msg_request_type(rxmsg->msg[0]);
+	char rad_str[64];
+
+	if (tx_req_type == rx_req_type)
+		return true;
+
+	drm_dp_mst_rad_to_str(mstb->rad, mstb->lct, rad_str, sizeof(rad_str));
+	drm_dbg_kms(mgr->dev,
+		    "Got unexpected MST reply, mstb: %p seqno: %d lct: %d rad: %s rx_req_type: %s (%02x) != tx_req_type: %s (%02x)\n",
+		    mstb, hdr->seqno, mstb->lct, rad_str,
+		    drm_dp_mst_req_type_str(rx_req_type), rx_req_type,
+		    drm_dp_mst_req_type_str(tx_req_type), tx_req_type);
+
+	return false;
+}
+
 static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
@@ -3891,6 +3919,9 @@ static int drm_dp_mst_handle_down_rep(st
 		goto out_clear_reply;
 	}
 
+	if (!verify_rx_request_type(mgr, txmsg, msg))
+		goto out_clear_reply;
+
 	drm_dp_sideband_parse_reply(mgr, msg, &txmsg->reply);
 
 	if (txmsg->reply.reply_type == DP_SIDEBAND_REPLY_NAK) {



