Return-Path: <stable+bounces-232229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB7YAv8FzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:35:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7136EF77
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8265130E348F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9753F8E04;
	Tue, 31 Mar 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XB3bxV+H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B373A1E8C;
	Tue, 31 Mar 2026 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976210; cv=none; b=FxxSPQVjKpaLC1Z7D/lT9sHDucoLR5YFHoWBolMU6I6fMdwbD+Ms7+S54vaQqeZkZ85jdXPsJzlCpVaRA2sp32a+v1ujMM2HZ0MfOUmz4n+3edIvt476qUlfVBM7wQxwjQhG9dgvuaiHWFKzRrrNzAkPYCyCSQa2XE44fVBMykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976210; c=relaxed/simple;
	bh=SUlPh5pDvwYnYUCzu7wBERKG1p+dM/PO6b5kHU1uxcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sptwqhx1WKTomJeyzJHYc3VAIPFUImctQ4Ma6KitkkiRup41+kKPD7sAyT/O4l66n3CmuTGSWn1K4y4IrmYuwf1KI/RppEVIFAgEBu8ojz5Fx5SVm5atMBf51yTBwgDZP6qqSMDg3heW+B2rz9ToIgOnLNAoIbMJm2451oPSsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XB3bxV+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88205C19423;
	Tue, 31 Mar 2026 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976209;
	bh=SUlPh5pDvwYnYUCzu7wBERKG1p+dM/PO6b5kHU1uxcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XB3bxV+HtQL5sMMxN75eqtcRsJnK1F+CcCMGzRWNrwYPfSbFIa7hirAq+YoM9MqqU
	 pl8hN7slxXW6WDzd88fiWjPUofcVTFsjvZMlJ4zW1c8loC9oba+4BgsF8sNz9ttiwE
	 hXwXmW0fbqwpAiZHdLW//uNh1A/qdQXWtwLzdv/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12 217/244] ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()
Date: Tue, 31 Mar 2026 18:22:47 +0200
Message-ID: <20260331161749.778447068@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232229-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8DB7136EF77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

[ Upstream commit 1388dd564183a5a18ec4a966748037736b5653c5 ]

Fix using the untrusted value of proto->raw.pkt_len in function
ice_vc_fdir_parse_raw() by verifying if it does not exceed the
VIRTCHNL_MAX_SIZE_RAW_PACKET value.

Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit 1388dd564183a5a18ec4a966748037736b5653c5)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c |   24 +++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -832,21 +832,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		      struct virtchnl_proto_hdrs *proto,
 		      struct virtchnl_fdir_fltr_conf *conf)
 {
-	u8 *pkt_buf, *msk_buf __free(kfree);
+	u8 *pkt_buf, *msk_buf __free(kfree) = NULL;
 	struct ice_parser_result rslt;
 	struct ice_pf *pf = vf->pf;
+	u16 pkt_len, udp_port = 0;
 	struct ice_parser *psr;
 	int status = -ENOMEM;
 	struct ice_hw *hw;
-	u16 udp_port = 0;
 
-	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
-	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
+	pkt_len = proto->raw.pkt_len;
+
+	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
+		return -EINVAL;
+
+	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
+	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
+
 	if (!pkt_buf || !msk_buf)
 		goto err_mem_alloc;
 
-	memcpy(pkt_buf, proto->raw.spec, proto->raw.pkt_len);
-	memcpy(msk_buf, proto->raw.mask, proto->raw.pkt_len);
+	memcpy(pkt_buf, proto->raw.spec, pkt_len);
+	memcpy(msk_buf, proto->raw.mask, pkt_len);
 
 	hw = &pf->hw;
 
@@ -862,7 +868,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	if (ice_get_open_tunnel_port(hw, &udp_port, TNL_VXLAN))
 		ice_parser_vxlan_tunnel_set(psr, udp_port, true);
 
-	status = ice_parser_run(psr, pkt_buf, proto->raw.pkt_len, &rslt);
+	status = ice_parser_run(psr, pkt_buf, pkt_len, &rslt);
 	if (status)
 		goto err_parser_destroy;
 
@@ -876,7 +882,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	}
 
 	status = ice_parser_profile_init(&rslt, pkt_buf, msk_buf,
-					 proto->raw.pkt_len, ICE_BLK_FD,
+					 pkt_len, ICE_BLK_FD,
 					 conf->prof);
 	if (status)
 		goto err_parser_profile_init;
@@ -885,7 +891,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		ice_parser_profile_dump(hw, conf->prof);
 
 	/* Store raw flow info into @conf */
-	conf->pkt_len = proto->raw.pkt_len;
+	conf->pkt_len = pkt_len;
 	conf->pkt_buf = pkt_buf;
 	conf->parser_ena = true;
 



