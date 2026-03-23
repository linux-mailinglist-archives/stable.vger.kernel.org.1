Return-Path: <stable+bounces-229197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBKANgldwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:32:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B162F671A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE6B3327A084
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE29F3BADAD;
	Mon, 23 Mar 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkwU4gRI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B813BAD9B;
	Mon, 23 Mar 2026 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278367; cv=none; b=qxuSfUXKQt2VRubqdPiZ6hD4/Bny6BragEw53NixwY9UR1Ri4ncSJxCicl1xvZXt2DIKSAQX1oy+DT62mGY9pSzAu9+PbJ++9W/nErliSIwNs7LHjEzg/aj99KeIRldbhnxHusZN07UiuKI/JxkSJXuZzCBYKSN9BYgbiOG4U/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278367; c=relaxed/simple;
	bh=gKwun3kvcEVFj3lfmCOtyQbXMT3F/uG/j7UvhVDZKEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2h/aLunsnJ7/mjcaFAJhyYpreI2FQIQ26AghH5fNkd7OHhAAi3KN9DMSl3y2WyP0C0AB6dG62orQHwD0qcevHyPPsYCxKcimplw/3in1AfmzbaZN6KdJD2hxEXWZUUKHU81S2nFc6vR2G5qFo48XBJU6rzuRJE5gluVG8Siztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkwU4gRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E42C4CEF7;
	Mon, 23 Mar 2026 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278367;
	bh=gKwun3kvcEVFj3lfmCOtyQbXMT3F/uG/j7UvhVDZKEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkwU4gRI7+YbK2EGJTuJhmbd0wsTShwBAKuajWwLkmdAYD3SlXuUpvpuI97IHf2Ja
	 kFiVHRPvflOzc6xbhhVcTAkf1EJW41cg3eBOogQsLmxFIe8+sGRLCILzbE8xw5fj+U
	 KMmaHUpuHWDU/juNbrdMCjeFBtxPnRusw/sm4/f8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 286/567] usb: image: mdc800: kill download URB on timeout
Date: Mon, 23 Mar 2026 14:43:26 +0100
Message-ID: <20260323134540.903163800@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229197-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 34B162F671A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

commit 1be3b77de4eb89af8ae2fd6610546be778e25589 upstream.

mdc800_device_read() submits download_urb and waits for completion.
If the timeout fires and the device has not responded, the function
returns without killing the URB, leaving it active.

A subsequent read() resubmits the same URB while it is still
in-flight, triggering the WARN in usb_submit_urb():

  "URB submitted while active"

Check the return value of wait_event_timeout() and kill the URB if
it indicates timeout, ensuring the URB is complete before its status
is inspected or the URB is resubmitted.

Similar to
- commit 372c93131998 ("USB: yurex: fix control-URB timeout handling")
- commit b98d5000c505 ("media: rc: iguanair: handle timeouts")

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260209151937.2247202-1-n7l8m4@u.northwestern.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/image/mdc800.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -731,9 +731,11 @@ static ssize_t mdc800_device_read (struc
 					mutex_unlock(&mdc800->io_lock);
 					return len-left;
 				}
-				wait_event_timeout(mdc800->download_wait,
+				retval = wait_event_timeout(mdc800->download_wait,
 				     mdc800->downloaded,
 				     msecs_to_jiffies(TO_DOWNLOAD_GET_READY));
+				if (!retval)
+					usb_kill_urb(mdc800->download_urb);
 				mdc800->downloaded = 0;
 				if (mdc800->download_urb->status != 0)
 				{



