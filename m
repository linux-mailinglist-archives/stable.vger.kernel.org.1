Return-Path: <stable+bounces-45928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87FD8CD49A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BF91F22819
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1269B14B06E;
	Thu, 23 May 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgIrMWAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE814A62D;
	Thu, 23 May 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470766; cv=none; b=cz5DDyCtRpslAcUnGGX/Jgvo4GQSyPtx953gxR7ovEdC8cOVIOIrbfB0WMjurKj/Gvx98ST6j/D2W4SRnJsQ5kyk3LsoOzf7Jd4kGjml/PGFYAYfWZ3IXLD70kwx9rMBXmuuE5/IzfsC8eIclNi+B0xUHC5pNHIApZyWX9R3LkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470766; c=relaxed/simple;
	bh=wShmxBY5P5vu4Ak3sb9+LfI3xTZWNPUjbPBYqxMVYY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G240a2+vct/UdGnubrUrS/21hkOs9x5sDnmq3knA1KIXu4Ka91O4HMEFKatY+4UxKQj9g1meAhsUPzTUHL+/lRSbznCVefKfbk3VhXpewplrtTl1wLiY8W6f06je37m8Y2mMGbFeynatAS8QZ1GT5e9FmPnPDkMVricWzvIp/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgIrMWAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAF4C2BD10;
	Thu, 23 May 2024 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470766;
	bh=wShmxBY5P5vu4Ak3sb9+LfI3xTZWNPUjbPBYqxMVYY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgIrMWAzbsZabeLpwbh1M+q2Bb/y3N0mdRbS4KbLOG3gwfrEhyvG67qmkob3nhNlB
	 8ct4UiNfBDItykqWLl7yEVP6U6UFfgSXtNZ/FG69LOKxtvvOJ7eON9vpNXorfKNvWG
	 2pZxarQOFmJdf3iK+6thfz/waIKKaS2mpiO2pCjE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.6 079/102] ice: pass VSI pointer into ice_vc_isvalid_q_id
Date: Thu, 23 May 2024 15:13:44 +0200
Message-ID: <20240523130345.447309469@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130342.462912131@linuxfoundation.org>
References: <20240523130342.462912131@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

commit a21605993dd5dfd15edfa7f06705ede17b519026 upstream.

The ice_vc_isvalid_q_id() function takes a VSI index and a queue ID. It
looks up the VSI from its index, and then validates that the queue number
is valid for that VSI.

The VSI ID passed is typically a VSI index from the VF. This VSI number is
validated by the PF to ensure that it matches the VSI associated with the
VF already.

In every flow where ice_vc_isvalid_q_id() is called, the PF driver already
has a pointer to the VSI associated with the VF. This pointer is obtained
using ice_get_vf_vsi(), rather than looking up the VSI using the index sent
by the VF.

Since we already know which VSI to operate on, we can modify
ice_vc_isvalid_q_id() to take a VSI pointer instead of a VSI index. Pass
the VSI we found from ice_get_vf_vsi() instead of re-doing the lookup. This
removes some unnecessary computation and scanning of the VSI list.

It also removes the last place where the driver directly used the VSI
number from the VF. This will pave the way for refactoring to communicate
relative VSI numbers to the VF instead of absolute numbers from the PF
space.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -547,17 +547,15 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf
 
 /**
  * ice_vc_isvalid_q_id
- * @vf: pointer to the VF info
- * @vsi_id: VSI ID
+ * @vsi: VSI to check queue ID against
  * @qid: VSI relative queue ID
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vf *vf, u16 vsi_id, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
 {
-	struct ice_vsi *vsi = ice_find_vsi(vf->pf, vsi_id);
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
-	return (vsi && (qid < vsi->alloc_txq));
+	return qid < vsi->alloc_txq;
 }
 
 /**
@@ -1257,7 +1255,7 @@ static int ice_vc_ena_qs_msg(struct ice_
 	 */
 	q_map = vqs->rx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
@@ -1279,7 +1277,7 @@ static int ice_vc_ena_qs_msg(struct ice_
 
 	q_map = vqs->tx_queues;
 	for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-		if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+		if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 			goto error_param;
 		}
@@ -1384,7 +1382,7 @@ static int ice_vc_dis_qs_msg(struct ice_
 		q_map = vqs->tx_queues;
 
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
@@ -1410,7 +1408,7 @@ static int ice_vc_dis_qs_msg(struct ice_
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
-			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
+			if (!ice_vc_isvalid_q_id(vsi, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 				goto error_param;
 			}
@@ -1466,7 +1464,7 @@ ice_cfg_interrupt(struct ice_vf *vf, str
 	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
 		vsi_q_id = vsi_q_id_idx;
 
-		if (!ice_vc_isvalid_q_id(vf, vsi->vsi_num, vsi_q_id))
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
 			return VIRTCHNL_STATUS_ERR_PARAM;
 
 		q_vector->num_ring_rx++;
@@ -1480,7 +1478,7 @@ ice_cfg_interrupt(struct ice_vf *vf, str
 	for_each_set_bit(vsi_q_id_idx, &qmap, ICE_MAX_RSS_QS_PER_VF) {
 		vsi_q_id = vsi_q_id_idx;
 
-		if (!ice_vc_isvalid_q_id(vf, vsi->vsi_num, vsi_q_id))
+		if (!ice_vc_isvalid_q_id(vsi, vsi_q_id))
 			return VIRTCHNL_STATUS_ERR_PARAM;
 
 		q_vector->num_ring_tx++;
@@ -1629,7 +1627,7 @@ static int ice_vc_cfg_qs_msg(struct ice_
 		    qpi->txq.headwb_enabled ||
 		    !ice_vc_isvalid_ring_len(qpi->txq.ring_len) ||
 		    !ice_vc_isvalid_ring_len(qpi->rxq.ring_len) ||
-		    !ice_vc_isvalid_q_id(vf, qci->vsi_id, qpi->txq.queue_id)) {
+		    !ice_vc_isvalid_q_id(vsi, qpi->txq.queue_id)) {
 			goto error_param;
 		}
 



