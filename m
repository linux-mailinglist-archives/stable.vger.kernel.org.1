Return-Path: <stable+bounces-254818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPKCHR8WGGrKbggAu9opvQ
	(envelope-from <stable+bounces-254818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:17:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D59A95F06F2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B424C31429CE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EE535E1D3;
	Thu, 28 May 2026 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="soLePTcK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020AB36683D
	for <stable@vger.kernel.org>; Thu, 28 May 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962614; cv=none; b=BC0EZruVWSFlyB101E03jT0kGvAOfhnYpsaAruykyDwEImrvJ+MK+ypm6xZ4PZEiYuDmrgaUJwmEjc4pQmtQDWik9eNq1iotIrkFVS5IBJkuRpFHZQC6q1lULWIETU+U/3RHZ4N+uDnNfcEAVCPqk7ai0zkMXsxRUHw3mig37kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962614; c=relaxed/simple;
	bh=r00DKQXPvv9iBFSzbkKq64ACa+SVeIr7w4AFGXVVARs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q1IhcVrggjnSpMn2I4LZQRuhxojsY+FGHKWQEnJprpksajTGcYBUkSfCTZkw7uUdPFEBoAIpI4OHYJX3Z45xfodHqOdyuX0qtgqGXA1NaSxf5ov8hRM5Z5HlCUEpBLhnHHIJe+dKR44P7qDj7Vmcg7EPozEoV1gMBamn8lRTdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=soLePTcK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E31F000E9;
	Thu, 28 May 2026 10:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779962612;
	bh=TkAefmp97Eeoc1uorSFH2X9SFtPWOy003QY9P2NV81s=;
	h=Subject:To:Cc:From:Date;
	b=soLePTcKD56TSyYlrTLxyUqKupdlZpqNZ8ZNkvdNfTx0qlMFN0onGbA9PGtab359Y
	 LgC+1tr/4iLVa4q8nSlHa1qVjAO+omZHEMjphP7mc0YCISSdL5Nf85J3bRfGWnW59Q
	 xOND4SJSNvQ500k4VeAONwIhQ5/sa/WgSvj7E9kU=
Subject: FAILED: patch "[PATCH] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index" failed to apply to 6.1-stable tree
To: sam@samdaly.ie,andrew+netdev@lunn.ch,gakula@marvell.com,gregkh@linuxfoundation.org,hkelam@marvell.com,kuba@kernel.org,lcherian@marvell.com,sbhatta@marvell.com,sgoutham@marvell.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 12:02:31 +0200
Message-ID: <2026052831-chair-shed-69f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254818-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Queue-Id: D59A95F06F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c0bf0a4f3f1f5f57aa83e1400ba4f56f0abfd542
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052831-chair-shed-69f0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0bf0a4f3f1f5f57aa83e1400ba4f56f0abfd542 Mon Sep 17 00:00:00 2001
From: Sam Daly <sam@samdaly.ie>
Date: Wed, 13 May 2026 18:42:53 +0200
Subject: [PATCH] octeontx2-af: CGX: add bounds check to cgx_speed_mbps index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cgx_speed_mbps has 13 elements but RESP_LINKSTAT_SPEED can yield values
0-15. If it returns a value >= 13, this causes an out-of-bounds array
access. Add a bounds check and default to speed 0 if the index is out of
range.

Fixes: 61071a871ea6 ("octeontx2-af: Forward CGX link notifications to PFs")
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Linu Cherian <lcherian@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: stable <stable@kernel.org>
Signed-off-by: Sam Daly <sam@samdaly.ie>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026051352-refined-demise-e88d@gregkh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 4f33a816bc7a..2e94d5105016 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1294,13 +1294,18 @@ static inline void link_status_user_format(u64 lstat,
 					   struct cgx_link_user_info *linfo,
 					   struct cgx *cgx, u8 lmac_id)
 {
+	unsigned int speed;
+
 	linfo->link_up = FIELD_GET(RESP_LINKSTAT_UP, lstat);
 	linfo->full_duplex = FIELD_GET(RESP_LINKSTAT_FDUPLEX, lstat);
-	linfo->speed = cgx_speed_mbps[FIELD_GET(RESP_LINKSTAT_SPEED, lstat)];
 	linfo->an = FIELD_GET(RESP_LINKSTAT_AN, lstat);
 	linfo->fec = FIELD_GET(RESP_LINKSTAT_FEC, lstat);
 	linfo->lmac_type_id = FIELD_GET(RESP_LINKSTAT_LMAC_TYPE, lstat);
 
+	speed = FIELD_GET(RESP_LINKSTAT_SPEED, lstat);
+	linfo->speed = speed < ARRAY_SIZE(cgx_speed_mbps) ?
+		       cgx_speed_mbps[speed] : 0;
+
 	if (linfo->lmac_type_id >= LMAC_MODE_MAX) {
 		dev_err(&cgx->pdev->dev, "Unknown lmac_type_id %d reported by firmware on cgx port%d:%d",
 			linfo->lmac_type_id, cgx->cgx_id, lmac_id);


