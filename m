Return-Path: <stable+bounces-36962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30D89C287
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FF51C21BD2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBCC7EEF4;
	Mon,  8 Apr 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kKY6EFUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6C7E0E4;
	Mon,  8 Apr 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582851; cv=none; b=YzWptvuBqjnKA1K4oXxiuZsrKvtDxvJoPo+E4lDbBiiniw+epMRNaCUJ2e2fMbV9eLWTXIUafWHzzMQSA6l+sSkd86W4Fy1sAwY55V/lS8ZsEteqQ9lBDgodmNfpmSmTkqTURKghRmJc30HKs8tGZCnDdLg+pjRkesZmP4cFpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582851; c=relaxed/simple;
	bh=vwxC8xGQ6Ga323TXqJfXcGCI+bsJ/pyjxNAhgXU2edQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoUp58o+H6Zj25j1lw0fdifJN9S6V6fQjyoatjAa+45Zbpm/t77ZZhx+clak0hiNleaAsmC/nJGJ821Labi4QeWX0LfkKWYWKz2C74C6lTPKSD+nW8E8LKsrrXcuj+DnCwW+5EUXCS+GFAIenztNBSTuVHinWiEdmyBgQGmReHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kKY6EFUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2335EC433F1;
	Mon,  8 Apr 2024 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582851;
	bh=vwxC8xGQ6Ga323TXqJfXcGCI+bsJ/pyjxNAhgXU2edQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kKY6EFUtwYRshFwd8B4SSlQpU644AVFYELiCIToGAJw0P8uIDQeYVr5hUmroYa8ey
	 PmX130GL2lqu2VUlE27ZfYL7Fsxz1hw3TX9Ar8pabSmlYpsd6NbQ7wlBAsNSiNE6dl
	 687zSGfWj33EN7W994grwHR/creGPG3npFZtUeTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Oros <poros@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.8 110/273] ice: fix enabling RX VLAN filtering
Date: Mon,  8 Apr 2024 14:56:25 +0200
Message-ID: <20240408125312.718105443@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Oros <poros@redhat.com>

commit 8edfc7a40e3300fc6c5fa7a3228a24d5bcd86ba5 upstream.

ice_port_vlan_on/off() was introduced in commit 2946204b3fa8 ("ice:
implement bridge port vlan"). But ice_port_vlan_on() incorrectly assigns
ena_rx_filtering to inner_vlan_ops in DVM mode.
This causes an error when rx_filtering cannot be enabled in legacy mode.

Reproducer:
 echo 1 > /sys/class/net/$PF/device/sriov_numvfs
 ip link set $PF vf 0 spoofchk off trust on vlan 3
dmesg:
 ice 0000:41:00.0: failed to enable Rx VLAN filtering for VF 0 VSI 9 during VF rebuild, error -95

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
@@ -26,24 +26,22 @@ static void ice_port_vlan_on(struct ice_
 	struct ice_vsi_vlan_ops *vlan_ops;
 	struct ice_pf *pf = vsi->back;
 
-	if (ice_is_dvm_ena(&pf->hw)) {
-		vlan_ops = &vsi->outer_vlan_ops;
+	/* setup inner VLAN ops */
+	vlan_ops = &vsi->inner_vlan_ops;
 
-		/* setup outer VLAN ops */
-		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
-
-		/* setup inner VLAN ops */
-		vlan_ops = &vsi->inner_vlan_ops;
+	if (ice_is_dvm_ena(&pf->hw)) {
 		vlan_ops->add_vlan = noop_vlan_arg;
 		vlan_ops->del_vlan = noop_vlan_arg;
 		vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
 		vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
 		vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
 		vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
-	} else {
-		vlan_ops = &vsi->inner_vlan_ops;
 
+		/* setup outer VLAN ops */
+		vlan_ops = &vsi->outer_vlan_ops;
+		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
+		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
+	} else {
 		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
 	}



