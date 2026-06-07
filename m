Return-Path: <stable+bounces-261418-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jio0FUZJJWqQGAIAu9opvQ
	(envelope-from <stable+bounces-261418-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750564FD0A
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:34:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VXzKbmgT;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261418-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261418-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8797B300371F
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F03112A5;
	Sun,  7 Jun 2026 10:34:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A6257855;
	Sun,  7 Jun 2026 10:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828479; cv=none; b=IAPn15JYsa/X6stbN8ET/od+ZKgTX+1ik6ITK2vIZaUWCCuB6OUBRHdnmrFw8PwMH6zjU02UexvTqKpC4F8fvEMcCzyodjm4V2oHlfFPRliMgEh7fvPpiTYAxuTsu+CQfUW4Y+Gi4vVDY/P5GT/GOkHupR3CKeLOKkFP9sW/pW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828479; c=relaxed/simple;
	bh=dBNu1MdqepYWAB65gpaGeQqtkuVo/+z2PFVmIw5rP5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQO73h3MLZ1+0UBn/fuIi1ixS2JMAJeXoY+KWvMIyxK1Cfv58ybwO3zBHjQYLHorsh6piP22LpM8U9WZjZWGTWo0yK7o81DVpnOyNPu6qOKUoM91vUwcldbtpVMlIG41EPbO+X21IdLy1SFv/xnt2tBYJBp93RH5BjS+QagCBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXzKbmgT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C911F00893;
	Sun,  7 Jun 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828478;
	bh=BiLgifYMEw00pbeviRRaFdVNsdcDp0f9bd/+cGI0FWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VXzKbmgTz0v4PBWwyDgMAlgs3DzyuSVfMJNxiLXVUKefSmHIOsBTodMUmn3rB3SSd
	 7Tg+gv5Ww1PiFl17hBzCPS8ouRUvRZj16VtoQc2qgTMckCzju1SeMm4xCXEA/mLYoF
	 q89w+1HrNmOQgiRT+Ee1uE/BYfWFPchi8uhRQbc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6.18 166/315] iio: ssp_sensors: cancel delayed work_refresh on remove
Date: Sun,  7 Jun 2026 11:59:13 +0200
Message-ID: <20260607095733.689475237@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261418-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sanjayembeddedse@gmail.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,vger.kernel.org,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5750564FD0A

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

commit eedf7602fbd929e97e0c480da501dc7a34beb2a8 upstream.

The work_refresh may still be pending or running when the device is
removed, cancel the delayed work_refresh in remove path.

Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
+	cancel_delayed_work_sync(&data->work_refresh);
 
 	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);



