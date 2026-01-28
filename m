Return-Path: <stable+bounces-212162-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKc0GLg1eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212162-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:13:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C9BA54A4
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E8FF316E778
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01552D6605;
	Wed, 28 Jan 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U4qeZdpf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36572D0C62;
	Wed, 28 Jan 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614598; cv=none; b=pKAPswEtXwvx7zk5/BEOGMTrVEw1IZaSiMrUvqya8MfcKqlP43xa5RB0oB+rv9VNLKoYB5ljATdELdYzSlPT6Ddi7T4DhU9tcV6Js5ShDNkhDHVoqhnxAwll5xYspGQnlREw1lf4cm/iKSU8ZQg2/0KTWi1d3EvaSVyaXVuzPzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614598; c=relaxed/simple;
	bh=mEOjuoiQwgV4KtbHMonZxgGvj96FSO+j0Emc3xl6+WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MS8S/dzVlP6rkGIlCAXqV7ttzlt1yTDnyGFm7J31/FkSb50SEly8UodobypvCSRq0paoQnEn8fecfgGlSc2peVN8Gwiqk8gBWI9ChnOYEi8syngngxEdpjiFOHXpQuKxO4fY7TJYI5KmqjP70NSkvrsdnrlar6FdZPG5IzGwwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U4qeZdpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF9CC4CEF1;
	Wed, 28 Jan 2026 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614598;
	bh=mEOjuoiQwgV4KtbHMonZxgGvj96FSO+j0Emc3xl6+WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4qeZdpfgiMU8XD7ihQzrxZEr0bKdmb16NxzMeIygK0Kdbfzd4nlsEZJUAcVElqhj
	 vsh7+OqxHWGFvWa9B5cWvqHb8hfPomOpeo1TuEbZ+697m4ZqMyQGos8AYRvIeIcQ3G
	 VUZlw/SG+vIq8QRsh+/HCCeweRNeO/4Ea34SY/+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.6 186/254] of: platform: Use default match table for /firmware
Date: Wed, 28 Jan 2026 16:22:42 +0100
Message-ID: <20260128145351.495631938@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212162-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,arm.com:email]
X-Rspamd-Queue-Id: D9C9BA54A4
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

commit 48e6a9c4a20870e09f85ff1a3628275d6bce31c0 upstream.

Calling of_platform_populate() without a match table will only populate
the immediate child nodes under /firmware. This is usually fine, but in
the case of something like a "simple-mfd" node such as
"raspberrypi,bcm2835-firmware", those child nodes will not be populated.
And subsequent calls won't work either because the /firmware node is
marked as processed already.

Switch the call to of_platform_default_populate() to solve this problem.
It should be a nop for existing cases.

Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Cc: stable@vger.kernel.org
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://patch.msgid.link/20260114015158.692170-2-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -616,7 +616,7 @@ static int __init of_platform_default_po
 
 		node = of_find_node_by_path("/firmware");
 		if (node) {
-			of_platform_populate(node, NULL, NULL, NULL);
+			of_platform_default_populate(node, NULL, NULL);
 			of_node_put(node);
 		}
 



