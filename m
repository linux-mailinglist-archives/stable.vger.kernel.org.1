Return-Path: <stable+bounces-246060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CyFAd5tA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:13:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF752711E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A49319C66F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E984D3C09F0;
	Tue, 12 May 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSvS4Qn+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D583C09EE;
	Tue, 12 May 2026 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608255; cv=none; b=JDpc/5cilva03+2FoSYJ0z/m15pV/DWr4ctlMffR8TJI5lYLlaWGBfouvxyHq8tPojZwx/TpF/MjqEescD51IuxMekUb782ECcDhFFHS6x20lncSlNG+W/nAVLeldeRqoUbNN7nZ4Qqzc08V8/NdD5NsCrxgsntUdGbyIamywis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608255; c=relaxed/simple;
	bh=uif1OnIz9QorRggJjCPrF52EdkQECJE8au8z/SZR+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdQ2Y6udHtv2hEi2r2ISQKT2AowQjc+H9oR//NrYFk8Cid8YTExB+oR/tOWZb7da9BN3gHh8oTUUzE90AywQFoW14Rv/fkyQN+75R6k2Q7xvuYOS9S1CZdpUEv3pCeCsaOMH83dhCBScCXr3rtp1sv18b2Sp2Yc9KVXg4znZUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSvS4Qn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8160C2BCB0;
	Tue, 12 May 2026 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608255;
	bh=uif1OnIz9QorRggJjCPrF52EdkQECJE8au8z/SZR+U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSvS4Qn+WsNMbtQTCSfl1A23s7ZcVfcktlDx5MTvEjGydoLSQdkGHvNC2wno2RSVF
	 Kc1FcrARkr2V9NyoDzb9PaNKOdKUld1EB+fwQD89PNqXI/PlJL7Q3dfGldf/h5QMxY
	 MPC6BNM5f/s+ldyQY9DmeMHWjpuBMPfD+G31XZYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.18 001/270] scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
Date: Tue, 12 May 2026 19:36:42 +0200
Message-ID: <20260512173938.486024762@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 75EF752711E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246060-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 772a896a56e0e3ef9424a025cec9176f9d8f4552 upstream.

target_tg_pt_gp_members_show() formats LUN paths with snprintf() into a
256-byte stack buffer, then will memcpy() cur_len bytes from that
buffer.  snprintf() returns the length the output would have had, which
can exceed the buffer size when the fabric WWN is long because iSCSI IQN
names can be up to 223 bytes.  The check at the memcpy() site only
guards the destination page write, not the source read, so memcpy() will
read past the stack buffer and copy adjacent stack contents to the sysfs
reader, which when CONFIG_FORTIFY_SOURCE is enabled, fortify_panic()
will be triggered.

Commit 27e06650a5ea ("scsi: target: target_core_configfs: Add length
check to avoid buffer overflow") added the same bound to the
target_lu_gp_members_show() but the tg_pt_gp variant was missed so
resolve that here.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Fixes: c66ac9db8d4a ("[SCSI] target: Add LIO target core v4.0.0-rc6")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026041159-garter-theft-3be0@gregkh
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_configfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3170,7 +3170,7 @@ static ssize_t target_tg_pt_gp_members_s
 			config_item_name(&lun->lun_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if (cur_len > TG_PT_GROUP_NAME_BUF || (cur_len + len) > PAGE_SIZE) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;



