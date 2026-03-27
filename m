Return-Path: <stable+bounces-230593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD9AAjg2xmm7HgUAu9opvQ
	(envelope-from <stable+bounces-230593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:48:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B713409C1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 08:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0329301DBAD
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 07:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAAD3CC9EE;
	Fri, 27 Mar 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpoxDDFT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE335B65E
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597645; cv=none; b=MLDylQ9Z9RZBuWyuQKX60MVy2waIt1Ok/TiamukEiCG5pZZks407DRGQtkE0a5RoglmhDEzaHwPeVJD16+6ZodU494h3+eMDgFvz8kE3lW2HPcutcvZdSnisd/4tXlDv4uAkg5WZQ3zfded+LBsxWfjmi76BLCucXnGEvAetGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597645; c=relaxed/simple;
	bh=0/WtdtXwB4HbLOBB/i29YghftIrngRbaQdXqbmrmeMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nO6TtKxddK18nQ2DFmiSjx0wiWww9oQEEfzJ7qJadXtCTM4qHfLpPiftCvThNChFsTu6LcqEHJi5Z4SDYTt5JlyhLEawDs+mbGA4eupnvCFlN37qjTsyB872xitQxN8hC/7II8jaM2Z1T+AA8ItiPNWUUWNjJQv3UOHI9ErN/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpoxDDFT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774597636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+Ya0OKIOhrl1q5883EggLqKidONP4W3BL2eswWDJDRg=;
	b=QpoxDDFTQsXBTn1so9EpYon771VvXH5Wv12Yt0cDsyjov27NTfR+His29nX3ByzkpEvWQX
	1z0AsqumbJ1FlNMy7ZCFFCzM8VHENBQiDIyY1rUQDxDTpquWATT9sj1TxQ3Plg5r3xstUc
	Ga6aliKT+Vk0QU6kYW/4SH1Xlyu3BsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-LCiNJ1KkO36QsokeeGwf6A-1; Fri,
 27 Mar 2026 03:47:11 -0400
X-MC-Unique: LCiNJ1KkO36QsokeeGwf6A-1
X-Mimecast-MFC-AGG-ID: LCiNJ1KkO36QsokeeGwf6A_1774597629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CACD318002CF;
	Fri, 27 Mar 2026 07:47:08 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.45.224.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F2B11800671;
	Fri, 27 Mar 2026 07:47:03 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net] ice: fix PTP timestamping broken by SyncE code on E825C
Date: Fri, 27 Mar 2026 08:46:58 +0100
Message-ID: <20260327074658.2963328-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230593-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78B713409C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The E825C SyncE support added in commit ad1df4f2d591 ("ice: dpll:
Support E825-C SyncE and dynamic pin discovery") introduced a SyncE
reconfiguration block in ice_ptp_link_change() that prevents
ice_ptp_port_phy_restart() from being called in several error paths.
Without the PHY restart, PTP timestamps stop working after any link
change event.

There are three ways the PHY restart gets blocked:

1. When DPLL initialization fails (e.g. missing ACPI firmware node
   properties), ICE_FLAG_DPLL is not set and the function returns early
   before reaching the PHY restart.

2. When ice_tspll_bypass_mux_active_e825c() fails to read the CGU
   register, WARN_ON_ONCE fires and the function returns early.

3. When ice_tspll_cfg_synce_ethdiv_e825c() fails to configure the
   clock divider for an active pin, same early return.

SyncE and PTP are independent features. SyncE reconfiguration failures
must not prevent the PTP PHY restart that is essential for timestamp
recovery after link changes.

Fix by making the entire SyncE block conditional on ICE_FLAG_DPLL
without an early return, and replacing the WARN_ON_ONCE + return error
handling inside the loop with dev_err_once + break. The function always
proceeds to ice_ptp_port_phy_restart() regardless of SyncE errors.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 094e96219f4565..60bc47099432a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1296,12 +1296,10 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	if (pf->hw.reset_ongoing)
 		return;
 
-	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825) {
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
+	    test_bit(ICE_FLAG_DPLL, pf->flags)) {
 		int pin, err;
 
-		if (!test_bit(ICE_FLAG_DPLL, pf->flags))
-			return;
-
 		mutex_lock(&pf->dplls.lock);
 		for (pin = 0; pin < ICE_SYNCE_CLK_NUM; pin++) {
 			enum ice_synce_clk clk_pin;
@@ -1314,15 +1312,19 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 								port_num,
 								&active,
 								clk_pin);
-			if (WARN_ON_ONCE(err)) {
-				mutex_unlock(&pf->dplls.lock);
-				return;
+			if (err) {
+				dev_err_once(ice_pf_to_dev(pf),
+					     "Failed to read SyncE bypass mux for pin %d, err %d\n",
+					     pin, err);
+				break;
 			}
 
 			err = ice_tspll_cfg_synce_ethdiv_e825c(hw, clk_pin);
-			if (active && WARN_ON_ONCE(err)) {
-				mutex_unlock(&pf->dplls.lock);
-				return;
+			if (active && err) {
+				dev_err_once(ice_pf_to_dev(pf),
+					     "Failed to configure SyncE ETH divider for pin %d, err %d\n",
+					     pin, err);
+				break;
 			}
 		}
 		mutex_unlock(&pf->dplls.lock);
-- 
2.52.0


