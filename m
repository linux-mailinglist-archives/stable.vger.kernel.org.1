Return-Path: <stable+bounces-254821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG8aLDAWGGoAdAgAu9opvQ
	(envelope-from <stable+bounces-254821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:17:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBC65F0710
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6622314B9C2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFBA376A1A;
	Thu, 28 May 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1O8ThWOQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE825C80E
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962662; cv=none; b=pCHsBpAB0D/wmoZwfVmQysMDWE38DbQhFT8MwPB6kU8Efi2paDXFTkkAoEa05WDcY0EbDhHsTm0I3SQC8ONSKJTHsWJKAcyDfp47q1ntSRrd+8KB6sJnQLtTYTdgg5/S6FCAduJN3orJUmhd/ruPreAmSEeWc70qlGtyvnJHB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962662; c=relaxed/simple;
	bh=c9Dd134yDvY8GiejbjyGIsX6pUe+0OFCQP08WI+rQHA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=X+azB4n5zay1XJdcc5K2r65t47QUGq83Gn5SNWr94lZAzWcHJxC4e+P4xAuZ8NtMnCZrEOZX41o5T/zImwXSQ7Jy+tN2I+rTpk4e9Qvb2wEiin9QwZ9Pry82MLHDnHHcscU9tg4iD9MXmgBmoE8jADimCSnCTqssAoVG4FoQe/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1O8ThWOQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98651F000E9;
	Thu, 28 May 2026 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962661;
	bh=qyju9vpKny2MIdj4vl+mv3bhMQ4gtX6sjveIYoYEOB8=;
	h=Subject:To:Cc:From:Date;
	b=1O8ThWOQf7F22vXjxKkWa193jxKn/tHmndx31qPx0yZRk+XA/Cy0LTYsGDAbdqk80
	 b6O1RnqJuh4km+HrWdIBpcnx92HFyR3x8004oknl/91MLaT10Za8qTV1bbPKwSRekO
	 0GLYRVCAHMDfsaNkt9BW0ZBeZBFnwnmt3n2lJyhE=
Subject: FAILED: patch "[PATCH] ice: restore PTP Rx timestamp config after ethtool" failed to apply to 6.1-stable tree
To: grzegorz.nitka@intel.com,aleksandr.loktionov@intel.com,alexander.nowlin@intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 12:03:27 +0200
Message-ID: <2026052827-delusion-hypnotism-0979@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254821-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email,msgid.link:url]
X-Rspamd-Queue-Id: 3BBC65F0710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 975b564d195b13ca6ee1ef5e6a9561734898eb17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052827-delusion-hypnotism-0979@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 975b564d195b13ca6ee1ef5e6a9561734898eb17 Mon Sep 17 00:00:00 2001
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
Date: Fri, 15 May 2026 11:24:13 -0700
Subject: [PATCH] ice: restore PTP Rx timestamp config after ethtool
 set-channels

When ethtool -L changes queue counts, ice_vsi_recfg_qs() closes and
rebuilds the VSI, reallocating Rx rings. The newly allocated rings have
ptp_rx cleared, so RX hardware timestamps are no longer attached to skb
until hwtstamp configuration is applied again.

Restore timestamp mode after ice_vsi_open() in the queue reconfiguration
path, matching reset/rebuild behavior and ensuring newly rebuilt Rx rings
have PTP RX timestamping re-enabled.

Testing hints:
- run ptp4l application in client synchronization mode:
	 ptp4l -i ethX -m -s
- run PTP traffic
- change queue number on ethX netdev interface:
	ethtool -L ethX combined new_queue_size
- observe ptp4l output
- expected result: no "received DELAY_REQ without timestamp" messages

Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
Cc: stable@vger.kernel.org
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Link: https://patch.msgid.link/20260515182419.1597859-7-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 66642232b282..e2fbe111f849 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4104,6 +4104,12 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 	}
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
+	/* Rx rings are reallocated during VSI rebuild and lose their ptp_rx
+	 * flag. Restore timestamp mode so newly allocated rings are set up
+	 * for hardware Rx timestamping.
+	 */
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
+		ice_ptp_restore_timestamp_mode(pf);
 	goto done;
 
 rebuild_err:


