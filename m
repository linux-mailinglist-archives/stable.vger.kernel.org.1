Return-Path: <stable+bounces-229691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEV6BK9swWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0496D2F8888
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E553308D9D3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB6D3C0612;
	Mon, 23 Mar 2026 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYoHZPZc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308623BED00;
	Mon, 23 Mar 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282607; cv=none; b=oyjgeX00jsxI7dYXpnVWlRgUFNg5BJK7bNB+Vgg8+YbGauAr43LkBhS8GuL2kyp2pBlr+8PKPz/l0Jlnbwl/yzOCPT/EexiEz/QAKYagg9uZ4j2waRnngoUZdI5bK1TsKDjf37J32R1/iwfA8XnInpzsh9lrOiAqQ4mInjFAc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282607; c=relaxed/simple;
	bh=u4Z2XHJwyDyzcydpoEgGcTgjGKaW130U7zmbSMKcbbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRJBVrv9sA3jmJX/j2sH7/1K0LbEOtAF9nrN6854Ejc2eL/9JaSSPdOUy0YUG1+Plw4rypDQlQsfM8gOy4/QnEWlFrLcDTHVrRF+S0Un+53rG+oHiRQ6MdXFBms344Or2AidKV96dWnSsvoBomu6Z1guDMpIRC2dRs1t3iCx4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYoHZPZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E1C2BC9E;
	Mon, 23 Mar 2026 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282606;
	bh=u4Z2XHJwyDyzcydpoEgGcTgjGKaW130U7zmbSMKcbbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYoHZPZcsUktGiGTvYB2dpSnT7wZdKrpHXA5qK/sQVsZbRGBEUORLpZj5/i7axa6/
	 JH79Lo64KkW9ZzOnwXjrRuFqtTzSE8hUKslKRmCMZTwJrxwk/DYZR956WFViPRhHu9
	 0gFzvc2nz4zb5/kjHSuQ0r0/VxHELk0FO14u321U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 218/481] usb: image: mdc800: kill download URB on timeout
Date: Mon, 23 Mar 2026 14:43:20 +0100
Message-ID: <20260323134530.466110841@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229691-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0496D2F8888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

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



