Return-Path: <stable+bounces-212166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CL9QAU4temnd3gEAu9opvQ
	(envelope-from <stable+bounces-212166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:37:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2343A418B
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC19630206B0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BF22DC76D;
	Wed, 28 Jan 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="wAcvOkty"
X-Original-To: stable@vger.kernel.org
Received: from smtp105.ord1d.emailsrvr.com (smtp105.ord1d.emailsrvr.com [184.106.54.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F62D77FE
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614609; cv=none; b=CGwAl/iprQwmdCMRiJVLZKmdC05MeX74J5ZtnDFMabwzRRo3DD7apdAtQN+LUbZhzKlRUVfT5qAVbZ6Ty/9s9BG6hTAqtHv4uU4wRSfm6QUHzxKbqqZZBaNBeYEc/Y7hSd5J5mZ3C8gAGQEet3g3TUKCwYqoZVbbZoDog2k/iHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614609; c=relaxed/simple;
	bh=FNu9qt9RcJv8/efnOO0fintMAsmMWSblnG6gPk5YQoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nS3H9yG1U08/IWOYFumadcvZ7Q2WUUGMLLDdChcY2HOyZplIw9IIqE3DQ5W6oY24AW5ikdIDotl6qVcVm53GPleIgXSiPWcFvrii5rLs6xiAqcDUCxrX3M1B7ux0sNjc1kHumkePDeJYo8P5Mwaplr0kjlzf7ZQbP6BSIpc8EKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=wAcvOkty; arc=none smtp.client-ip=184.106.54.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1769612424;
	bh=FNu9qt9RcJv8/efnOO0fintMAsmMWSblnG6gPk5YQoE=;
	h=From:To:Subject:Date:From;
	b=wAcvOktyogDbUaCA3h+P2qVCb4bIF1+rkP3flHg6kMZ9bGrvIa8ThaaZmEchzg/8d
	 AtlQ6lYrj934jmgLX4xs1Uh+II2m0awA6gPXJbc8dpuBcbGc2yrCbO31QtBHq0V3t/
	 GUQKOmgUguicYXMtIQBBB3C4/+0FhZ3jgvXh4nyw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp14.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 2EF414026C;
	Wed, 28 Jan 2026 10:00:23 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: ni_atmio16d: Fix invalid clean-up after failed attach
Date: Wed, 28 Jan 2026 15:00:10 +0000
Message-ID: <20260128150011.5006-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: e92fc87b-daa5-4a29-ac36-dbe57e86035b-1-1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mev.co.uk,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mev.co.uk:s=20221208-6x11dpa4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212166-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[abbotti@mev.co.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mev.co.uk:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2343A418B
X-Rspamd-Action: no action

If the driver's COMEDI "attach" handler function (`atmio16d_attach()`)
returns an error, the COMEDI core will call the driver's "detach"
handler function (`atmio16d_detach()`) to clean up.  This calls
`reset_atmio16d()` unconditionally, but depending on where the error
occurred in the attach handler, the device may not have been
sufficiently initialized to call `reset_atmio16d()`.  It uses
`dev->iobase` as the I/O port base address and `dev->private` as the
pointer to the COMEDI device's private data structure.  `dev->iobase`
may still be set to its initial value of 0, which would result in
undesired writes to low I/O port addresses.  `dev->private` may still be
`NULL`, which would result in null pointer dereferences.

Fix `atmio16d_detach()` by checking that `dev->private` is valid
(non-null) before calling `reset_atmio16d()`.  This implies that
`dev->iobase` was set correctly since that is set up before
`dev->private`.

Fixes: 2323b276308a ("Staging: comedi: add ni_at_atmio16d driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/ni_atmio16d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_atmio16d.c b/drivers/comedi/drivers/ni_atmio16d.c
index e5e7cc423c87..b057b3b3582e 100644
--- a/drivers/comedi/drivers/ni_atmio16d.c
+++ b/drivers/comedi/drivers/ni_atmio16d.c
@@ -698,7 +698,8 @@ static int atmio16d_attach(struct comedi_device *dev,
 
 static void atmio16d_detach(struct comedi_device *dev)
 {
-	reset_atmio16d(dev);
+	if (dev->private)
+		reset_atmio16d(dev);
 	comedi_legacy_detach(dev);
 }
 
-- 
2.51.0


