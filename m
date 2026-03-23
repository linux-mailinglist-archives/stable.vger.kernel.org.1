Return-Path: <stable+bounces-229690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ2aKqRswWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:39:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F432F8861
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 469A33084B25
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1603C0600;
	Mon, 23 Mar 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gi3H+vu+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9483BC673;
	Mon, 23 Mar 2026 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282604; cv=none; b=imLBEprz9+i2CDS/GCzgZx5aJF2nA32pIKtd5mJVw2lLq6Yk0roSGn3PQ15z49zf48XnpTD7dUwHVO+FXH9Eg4DGID0n0GQK83P3RfAjvM/ynFAU5R2L7TPdpH+zoUnczRpOuWGlYyV0EOTVOX0fCoIRlqT0K9iEVRBr8PzHvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282604; c=relaxed/simple;
	bh=K0YtApIJaP5N6bGFBE1nOglm9miVjH7fYe7Cgam8a8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxuLWLDe7UlT1mq+E4cCjW/MCXfQAsYO0GHSo/GTile59TzsNZrHssSrewxpOcFEfQvFfdZ2ll/tKRnV40HWdsfInV8UJyG9ygUO8J1/kBfqfeaLMLjWrhqGdbVGPXMDlGRMQpi1ZhOj3o0uDlXsyAdZAmYiP2qhExlhD8Pi4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gi3H+vu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA444C2BC9E;
	Mon, 23 Mar 2026 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282604;
	bh=K0YtApIJaP5N6bGFBE1nOglm9miVjH7fYe7Cgam8a8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gi3H+vu++PFEtu7fVpEsUGnP0+kGNYOsijvQghcUVSsH4LofovyH7mEs89T5MOBDX
	 TcCrckx/ixLV2cBSGWqrecmxXmV8zJ/aI7DK7zt1Hb0CwxZbf8C9joI/N5D1k0Aqca
	 9OujF8S33u870dPNMtsDK7E8Q7jub29p1sLumu/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 217/481] usb: mdc800: handle signal and read racing
Date: Mon, 23 Mar 2026 14:43:19 +0100
Message-ID: <20260323134530.442926398@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-229690-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B8F432F8861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 2d6d260e9a3576256fe9ef6d1f7930c9ec348723 upstream.

If a signal arrives after a read has partially completed,
we need to return the number of bytes read. -EINTR is correct
only if that number is zero.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260209142048.1503791-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/image/mdc800.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/image/mdc800.c
+++ b/drivers/usb/image/mdc800.c
@@ -708,7 +708,7 @@ static ssize_t mdc800_device_read (struc
 		if (signal_pending (current)) 
 		{
 			mutex_unlock(&mdc800->io_lock);
-			return -EINTR;
+			return len == left ? -EINTR : len-left;
 		}
 
 		sts=left > (mdc800->out_count-mdc800->out_ptr)?mdc800->out_count-mdc800->out_ptr:left;



