Return-Path: <stable+bounces-246332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBXPDJBrA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:04:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB649526A5F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C32EF305371B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9A3EDE5B;
	Tue, 12 May 2026 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5V60hIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0573EDE47;
	Tue, 12 May 2026 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608953; cv=none; b=oH1EJnWBJKv/MOnluU4rO5bOwESB9DmeU5y3+Cr7W7zlgmA7/8wU05hv6A45ONKjeDI6NlvUsHyc2ul3nT5u2cJABVDzGJpACg68jkcptQoBnpunvQpULTF2oDB+AKY1ALrVtwNG00H83ENrSMa6+xMvo+2InkpC8YQWlpOZyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608953; c=relaxed/simple;
	bh=VfuOOsZlcsglSRMrKoQR4flhL1DBpm3VX13FUNE85Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGs8rmYd3v3MZlWK/A2px9SwNtFQfZKC3Pn0L8+QuiT/eytM5mxyoYzwSWqCvHPFr4FZFXve/F/k++5Ut/nossabzdFYgOXNBD3yJ1WZmBNX84UeaCNljTLwaNR3f7SJ+AYohAnLnDZwr+Yk2zsnWProZ3BfQ5zSDUq0mM1/bpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5V60hIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524E4C2BCB0;
	Tue, 12 May 2026 18:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608953;
	bh=VfuOOsZlcsglSRMrKoQR4flhL1DBpm3VX13FUNE85Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5V60hIxWVGeuxeMYxJ7yv8hd5z+LU3u5Xb7HkK2nGAvvPrA+qUhTf8JAuTNMx0Os
	 7pmXv4u0GYOO31dX9dpWi1ndauWyCB0krC2ztZyI7msRSQcFUBwWzCO+Fa9X4WNqFD
	 y/vzt3kjT+dwCCWYtgfj1nDNZiqz1deSPYOCW0Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 7.0 001/307] scsi: target: configfs: Bound snprintf() return in tg_pt_gp_members_show()
Date: Tue, 12 May 2026 19:36:36 +0200
Message-ID: <20260512173940.151076220@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: EB649526A5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246332-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3227,7 +3227,7 @@ static ssize_t target_tg_pt_gp_members_s
 			config_item_name(&lun->lun_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if (cur_len > TG_PT_GROUP_NAME_BUF || (cur_len + len) > PAGE_SIZE) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;



