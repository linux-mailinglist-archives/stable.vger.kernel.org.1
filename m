Return-Path: <stable+bounces-234405-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM4ACjCe1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234405-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:28:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B33C0C3E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A18713038A29
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B23D4134;
	Wed,  8 Apr 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aC3xuODe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A53ACEFB;
	Wed,  8 Apr 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672773; cv=none; b=YUfvnt4Foe1QsanG3xbaQ6yK5lUzz1ozmFh5AKeUFJbHDYW8I6fbXLQVMXgZgxq9d8w4g9UzlqBb2Ce/xdFcImMjxTLYAjZWGK9IL4dDMx988bXl/jXaCNxe4Bcn0vVIqHJ65Coa2EAF8xlDAxg6LAkFemZZAC+Xt1Ap/jbV9S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672773; c=relaxed/simple;
	bh=N3uxZeYvsDZR3Ar1SRAEZMWUZMYEvO07IXbAEx4d/HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKjAGeTfE7Abfkwb9Z+KxfYBc0qj4LKa1GpYCj1XWTWFI+vcDWu3sNRlHU0uKBetE5efhwQVjB5rEmQ6qBn5X/vhbIB50Bn699A/RayIp4qqOpTLK5wsi/SkDXV9F9yOhbE4WmrCCVuCYPzBog9FKtGHM2Hc58o7P7uwZ+lweUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aC3xuODe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8309BC19421;
	Wed,  8 Apr 2026 18:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672773;
	bh=N3uxZeYvsDZR3Ar1SRAEZMWUZMYEvO07IXbAEx4d/HM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aC3xuODeqlr18QJ9tsGmzc36vb8zN5qf2fWU8zFntb6SmtbOXa3oTE+P1IlfXGPs8
	 atAh9dBkMWaoJ2aymiHAnrKg+XM6xU7BzB22BGEjkvyCibKc520dfWzRAOARr26/s7
	 jNijsUEUhNcKG77wn6MUkyrIoeWwuY+g93LZmK5c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miao Li <limiao@kylinos.cn>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 104/160] usb: quirks: add DELAY_INIT quirk for another Silicon Motion flash drive
Date: Wed,  8 Apr 2026 20:03:11 +0200
Message-ID: <20260408175917.066980598@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234405-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,kylinos.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 417B33C0C3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miao Li <limiao@kylinos.cn>

commit dd36014ec6042f424ef51b923e607772f7502ee7 upstream.

Another Silicon Motion flash drive also randomly work incorrectly
(lsusb does not list the device) on Huawei hisi platforms during
500 reboot cycles, and the DELAY_INIT quirk fixes this issue.

Signed-off-by: Miao Li <limiao@kylinos.cn>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260319053927.264840-1-limiao870622@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -402,6 +402,7 @@ static const struct usb_device_id usb_qu
 
 	/* Silicon Motion Flash Drive */
 	{ USB_DEVICE(0x090c, 0x1000), .driver_info = USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x090c, 0x2000), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* Sound Devices USBPre2 */
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =



