Return-Path: <stable+bounces-213482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPtkAB1dg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:52:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 443AEE77E5
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135F2300FEF6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F5293C44;
	Wed,  4 Feb 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AnS55Ai/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14228B7EA;
	Wed,  4 Feb 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216487; cv=none; b=ngSL3rsrXP2p2VMdYZVUkSkMA9KvffJvkylgfFX/n4/FjBiZrsy1YlZNgvHemFbPfwmEWC3VqYarx5sX07akTc5FclsgzXSlKX1r3KoZ+I7uKLSDssSGL2aJUbl5fzp2PRKDv3hZy5JG47B2JUeLnYsZQqKSQwFfzXzR+wYFNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216487; c=relaxed/simple;
	bh=0HzR3i9abPaTRDApo3qiniaRW/IJvZkMCAtwdwVUDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SAxo4BI7Fb4RocQqZ35opTP7V5JXUvMnbX6RJWYjVTv/M172HY9SDlkZV7YedCzlmD62ygt5NG3C4dVCqwks3B+CQD9C/2GjMLWGnUkIE02+TqYKbRwtO7H63dyw0y7sI9PTWHYvG7Vq11vKppu+H8kcmkhu2uNwEVBklOvABgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AnS55Ai/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067BDC116C6;
	Wed,  4 Feb 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216487;
	bh=0HzR3i9abPaTRDApo3qiniaRW/IJvZkMCAtwdwVUDPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnS55Ai/JhXUGEGa0Qb7EpX+6nYyv80B02uzgjagqtT/PYmm2xdv1lTA8Ox3WZ5IX
	 TbaFqskp2QdoAV38inCJVa1CgutB2Ft/snle3bQhdJ6HNlLylVxl5q9XgcBR08eNAF
	 NhUNyKCkcgR7w+N6XNSyd+fJdCnneAMvrPZ+i83g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 069/161] scsi: storvsc: Process unsupported MODE_SENSE_10
Date: Wed,  4 Feb 2026 15:38:52 +0100
Message-ID: <20260204143854.239661696@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,microsoft.com,outlook.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-213482-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 443AEE77E5
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>

commit 9eacec5d18f98f89be520eeeef4b377acee3e4b8 upstream.

The Hyper-V host does not support MODE_SENSE_10 and MODE_SENSE.  The
driver handles MODE_SENSE as unsupported command, but not for
MODE_SENSE_10. Add MODE_SENSE_10 to the same handling logic and return
correct code to SCSI layer.

Fixes: 89ae7d709357 ("Staging: hv: storvsc: Move the storage driver out of the staging area")
Cc: stable@kernel.org
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://patch.msgid.link/20260117010302.294068-1-longli@linux.microsoft.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1154,7 +1154,7 @@ static void storvsc_on_io_completion(str
 	 * The current SCSI handling on the host side does
 	 * not correctly handle:
 	 * INQUIRY command with page code parameter set to 0x80
-	 * MODE_SENSE command with cmd[2] == 0x1c
+	 * MODE_SENSE and MODE_SENSE_10 command with cmd[2] == 0x1c
 	 * MAINTENANCE_IN is not supported by HyperV FC passthrough
 	 *
 	 * Setup srb and scsi status so this won't be fatal.
@@ -1164,6 +1164,7 @@ static void storvsc_on_io_completion(str
 
 	if ((stor_pkt->vm_srb.cdb[0] == INQUIRY) ||
 	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE) ||
+	   (stor_pkt->vm_srb.cdb[0] == MODE_SENSE_10) ||
 	   (stor_pkt->vm_srb.cdb[0] == MAINTENANCE_IN &&
 	   hv_dev_is_fc(device))) {
 		vstor_packet->vm_srb.scsi_status = 0;



