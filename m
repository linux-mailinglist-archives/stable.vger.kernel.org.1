Return-Path: <stable+bounces-229240-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJw1KH5bwWlKSgQAu9opvQ
	(envelope-from <stable+bounces-229240-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595B2F644C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 043E1309E7CB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A1C3ACEF0;
	Mon, 23 Mar 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nSVa0hgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E131839657B;
	Mon, 23 Mar 2026 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278501; cv=none; b=RKI7P4jU3KTQdnFjC2BeRsuf1dlD1zsk08wPIkUvMOq2zq0+5MFPpErYYHukC+mOU9HfalNaEwmvmsULjnYjgRIodfKyKegy9ro0SBox1UUMay8pRgusjUW74fg+3K0miFyFgim17A8DQrDU6thDFSjdwehSV4tPByRFEG4Wcnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278501; c=relaxed/simple;
	bh=Lfn784DPtC3qn2iT2erj82p9kqJHVTASt7bJKDZwFVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+y71wN9dEz/QzCRxRf0iWCIA8gGwVId17vtoBSqKrqj3+kwz2hF3+rT9Xb2pcO/rOKGhtv+LgIjEBYbEwRmL3Q+TvO/Gytvi+WVzDODeHiYjvBFoT7fbPUzTD/KhoEWtF7LOAJqtsDF4Tc76k+uoUVCjpcxHVCoiH1Hqk4sm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nSVa0hgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A237C4CEF7;
	Mon, 23 Mar 2026 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278500;
	bh=Lfn784DPtC3qn2iT2erj82p9kqJHVTASt7bJKDZwFVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSVa0hgXW7ut/IcgH5DhKZ4V1r26nOEO0USBGqgqhStYlAirV8gdTvOyRXwPI2BCy
	 sgnpuURHqfb8iqwrFfPH7/KjVyu1iCZ1+DAkF+1PAZMF4zhxS5dLpqvynzwx3sbH1k
	 YgPAX7ThymQ4VaNIZfLM+lidQXPJpkUu9sJO21po=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 6.6 283/567] usb: class: cdc-wdm: fix reordering issue in read code path
Date: Mon, 23 Mar 2026 14:43:23 +0100
Message-ID: <20260323134540.829521402@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229240-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,suse.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1595B2F644C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 8df672bfe3ec2268c2636584202755898e547173 upstream.

Quoting the bug report:

Due to compiler optimization or CPU out-of-order execution, the
desc->length update can be reordered before the memmove. If this
happens, wdm_read() can see the new length and call copy_to_user() on
uninitialized memory. This also violates LKMM data race rules [1].

Fix it by using WRITE_ONCE and memory barriers.

Fixes: afba937e540c9 ("USB: CDC WDM driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Closes: https://lore.kernel.org/linux-usb/CALbr=LbrUZn_cfp7CfR-7Z5wDTHF96qeuM=3fO2m-q4cDrnC4A@mail.gmail.com/
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://patch.msgid.link/20260304130116.1721682-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-wdm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -225,7 +225,8 @@ static void wdm_in_callback(struct urb *
 		/* we may already be in overflow */
 		if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
 			memmove(desc->ubuf + desc->length, desc->inbuf, length);
-			desc->length += length;
+			smp_wmb(); /* against wdm_read() */
+			WRITE_ONCE(desc->length, desc->length + length);
 		}
 	}
 skip_error:
@@ -533,6 +534,7 @@ static ssize_t wdm_read
 		return -ERESTARTSYS;
 
 	cntr = READ_ONCE(desc->length);
+	smp_rmb(); /* against wdm_in_callback() */
 	if (cntr == 0) {
 		desc->read = 0;
 retry:



