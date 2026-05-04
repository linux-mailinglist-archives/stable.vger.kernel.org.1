Return-Path: <stable+bounces-242948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L12Ic5f+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:58:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9A4BAAA2
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81019300E247
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20531A80E;
	Mon,  4 May 2026 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ontJK/R+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00F341AC7
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884779; cv=none; b=fb3NmR2vYpdrkkYesaJPB/ogtOn7RxGJATpk1Q6Gh1spswVtGd1YzOyovGWRxdi910cComuZBNvOUSXqyq25Ww1y1D36JGkor/Ns73xZMur52P63QAxlPrQvHsQLUyXXRjELhsO30HpzFd5pwzEiFLOiBisl2VgU3dDcxv/k7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884779; c=relaxed/simple;
	bh=CrxwwfE9NXNO757WSPSGAYiTEx6iuY1SiBdx0Nro3ms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IIVYrrgLQJuWdTpxDBixSg8/lfObAnUnx1WYLqXzGZC14SnwQEuU2mhilR1NAP859ZzWsXTj8zvUbt+5OWld5CIB7Uz+ZXkNvy5fYCOs3G7npypYv6Un3lW3yH51nwYiol99O1joy3uiPgqce5Orb/OuZcm6ik7WtDSbgbcKQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ontJK/R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2763C2BCB8;
	Mon,  4 May 2026 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884779;
	bh=CrxwwfE9NXNO757WSPSGAYiTEx6iuY1SiBdx0Nro3ms=;
	h=Subject:To:Cc:From:Date:From;
	b=ontJK/R+GxNYsC9u5m8DSq/B2E0ThMWPLXA23spHQsp9ys0Nr9JBtEq6HoGjMTGwH
	 X1jxAEH2MmesbXGN/VBvyXWRLb7IllFImRJPLzHvdMjHTFvC6GeQKe0mdQYtyhIoqn
	 UJ8MMd7gYZ27x86nXl+NOy6qXNzaXL+zONhCss1A=
Subject: FAILED: patch "[PATCH] scsi: sd: fix missing put_disk() when device_add(&disk_dev)" failed to apply to 5.15-stable tree
To: yangxiuwei@kylinos.cn,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:52:56 +0200
Message-ID: <2026050456-overview-shaking-6135@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0FE9A4BAAA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242948-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,oracle.com:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1e111c4b3a726df1254670a5cc4868cedb946d37
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050456-overview-shaking-6135@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e111c4b3a726df1254670a5cc4868cedb946d37 Mon Sep 17 00:00:00 2001
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
Date: Mon, 30 Mar 2026 09:49:52 +0800
Subject: [PATCH] scsi: sd: fix missing put_disk() when device_add(&disk_dev)
 fails

If device_add(&sdkp->disk_dev) fails, put_device() runs
scsi_disk_release(), which frees the scsi_disk but leaves the gendisk
referenced. The device_add_disk() error path in sd_probe() calls
put_disk(gd); call put_disk(gd) here to mirror that cleanup.

Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
Cc: stable@vger.kernel.org
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20260330014952.152776-1-yangxiuwei@kylinos.cn
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 205877b1f8aa..adc3fa55ca2c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4061,6 +4061,7 @@ static int sd_probe(struct scsi_device *sdp)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		put_disk(gd);
 		goto out;
 	}
 


