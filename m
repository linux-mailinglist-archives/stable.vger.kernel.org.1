Return-Path: <stable+bounces-226335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AVtHOmIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:01:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACE62AECCE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71605314FC2C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4F3ED106;
	Tue, 17 Mar 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JUcp8k8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFCD2E62B7;
	Tue, 17 Mar 2026 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766257; cv=none; b=aGe47HF6HuDrg/OTFloz9pr9SS66iIRv8qwv+lX0Kkb2UbktZ6z5HB8xQ2+QAqLr2xC2LpUXbeBWUe7bIFaDrmFDzVqZBy7jy7Gxt2DsylSOpQiks9eXVf3ebj6JkRXrLUKFPK6N2tY2At76tLcvBUs2EdYv5q37rB/xCX5Clco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766257; c=relaxed/simple;
	bh=WrRG++S6pZBImlQ6p1gmqlusHvf4YMWAKgaRfFC6qHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxuwPYTxRht/f/rCsdKZ4DNwZ8Np7gSquHq7t3IrGpO1zdf/pJeiQpI5huMcsW421dOuKMWBF+exVbXWnycQrCKeC8Npt7xgDhluRvvUbJb9cfa58+3CaUf3vKWkgRKlDTnCaYPviHonUV8esGQJqmPkpN4X+79kd/oYt9Y7ygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JUcp8k8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C724C4CEF7;
	Tue, 17 Mar 2026 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766257;
	bh=WrRG++S6pZBImlQ6p1gmqlusHvf4YMWAKgaRfFC6qHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUcp8k8LGcm6bmTNYcHpeNFhQZiv9IFvWanWfEUi1pxc5T9k4cZeZvbykTdil+QcV
	 NRJ5xi36u/tPPo5pMALatrBsnZYlR9gnO1sLaJgxvtCqoFPyipvj2oZb82Z8xxk2hk
	 Qlafe/DfzBB3hVNBSjeMDJUH9SR/Z0JXdvQk/FZM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Junzhong Pan <panjunzhong@linux.spacemit.com>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.19 162/378] usb: gadget: uvc: fix interval_duration calculation
Date: Tue, 17 Mar 2026 17:31:59 +0100
Message-ID: <20260317163012.971848780@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226335-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[spacemit.com:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 0ACE62AECCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junzhong Pan <panjunzhong@linux.spacemit.com>

commit 56135c0c60b07729401af9d329fa9c0eded845a6 upstream.

To correctly convert bInterval as interval_duration:
  interval_duration = 2^(bInterval-1) * frame_interval

Current code uses a wrong left shift operand, computing 2^bInterval
instead of 2^(bInterval-1).

Fixes: 010dc57cb516 ("usb: gadget: uvc: fix interval_duration calculation")
Cc: stable <stable@kernel.org>
Signed-off-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260306-fix-uvc-interval-v1-1-9a2df6859859@linux.spacemit.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/uvc_video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -513,7 +513,7 @@ uvc_video_prep_requests(struct uvc_video
 		return;
 	}
 
-	interval_duration = 2 << (video->ep->desc->bInterval - 1);
+	interval_duration = 1 << (video->ep->desc->bInterval - 1);
 	if (cdev->gadget->speed < USB_SPEED_HIGH)
 		interval_duration *= 10000;
 	else



