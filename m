Return-Path: <stable+bounces-249564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EX5A/pRDGqmfAUAu9opvQ
	(envelope-from <stable+bounces-249564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:05:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B75F57E49D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDD87308F083
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19F633508E;
	Tue, 19 May 2026 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="OtQtKwHA"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCFA33688F;
	Tue, 19 May 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779191483; cv=none; b=O47pquLelpfI78sfiKGDquNnaPNN7CMV3aGZ6XZAdGIgCY6ZELz/FgEB1su3eMeHrHGb706TKNAs5gxQkfznmrqVw8qwXUkJVpc4POVtMRDhOy34l069ZorckplP0y4Gp2na/uVlPkaarD1Imf8up087xsyfq6dWLcHJOHH/kdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779191483; c=relaxed/simple;
	bh=VSG5rZLlA3DDgs3C/5w3joB6zj88VH1GnjSufKKYAlY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=P6CDT1/QdRLI+UBpmPWckpDEkGKwKpP+AEbSs+bfs7eOaLg3RqPKTZ/WFPZ+qE7ueyGPzYn11S9COQCmu/vHfw7g9WH8/A6PlZ7zneerHrKQLVosHOnvZTyIOcA6N1JVd1aN+HeoLAZ4RmmjQjx+4TfLlRA3OGFZKDIcgj+CVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=OtQtKwHA; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1779190907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zKrM5PeNlQhPkGpTZmJ3pPWUcImrkoOnAZH77EjREA8=;
	b=OtQtKwHAE1kevzh0YGIaggO1sx2ei9Z/Oap5fAD3s8JCjAtYSoUthQfwX20Vi24FMYjMjr
	NN6IULlfgKzCaZjqXRSOETN5rG41UVyyfUqE0AqbY3eV5TpxKiX3X+4+BxTJLxmLaapvUr
	7PmQVRg304UVGYwmcQv9qJPoRylgCpMNXJIaTT/jATMMhOpZLOgOV48CIXwO9rilu0pb1Z
	s4LbHokDmnXyxE6746iEux/alV2XWWDa9UBZTWUyi+fEr6AropjZhiEkdgRDjElsNrF+KU
	QqEV/L2p80qNqJEdNjt80CobErCAL0DOhNPW/BjvhWEukLFNxeJaqq9NGj5xIA==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Subject: [PATCH 0/2] usb: typec: ucsi: Additional checks for power role
 change handling
Date: Tue, 19 May 2026 18:41:38 +0700
Message-Id: <20260519-ucsi-fix-2-v1-0-6f1239535187@qtmlabs.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsFVFOwr0SF0q71YKEUg/j3pO
 AwzFQpn4QLTUCHzI0XO1IHGAcKxpp1RYmfQSjtlyeMdiuAmL2okY1Qg520khh5cmbv4Z/PS2gf
 s0mmVXAAAAA==
X-Change-ID: 20260519-ucsi-fix-2-1330c1695d1e
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>, stable@vger.kernel.org
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qtmlabs.xyz,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[qtmlabs.xyz:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249564-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qtmlabs.xyz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[myrrhperiwinkle@qtmlabs.xyz,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qtmlabs.xyz:email,qtmlabs.xyz:mid,qtmlabs.xyz:dkim]
X-Rspamd-Queue-Id: 7B75F57E49D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes a regression preventing system suspend on some Chromebooks.

Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
---
Myrrh Periwinkle (2):
      usb: typec: ucsi: Check if power role change actually happened before handling
      usb: typec: ucsi: Don't update power_supply on power role change if not connected

 drivers/usb/typec/ucsi/ucsi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-ucsi-fix-2-1330c1695d1e

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>


