Return-Path: <stable+bounces-233682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA+VCtEs1Wli1wcAu9opvQ
	(envelope-from <stable+bounces-233682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:12:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D83B18B6
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BC5430227F4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C93CF05F;
	Tue,  7 Apr 2026 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MOdQXeAx"
X-Original-To: stable@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7633B6BF0
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577948; cv=none; b=JyQAMb87rRuAmQcfDH/D9/C9N/W2xj/3J/RvKTIFr0vyTEiqx1G678ZhCIHVjs4k3Kp3+8im0yZz2rbSOry4/p6wTG6kNt86MwPvqunfa61fUGuyGMZYxHKaD/RWfbjXL67OUBF2F7AToMpvt/w+BEZSgCbqxsyxILcMSloDz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577948; c=relaxed/simple;
	bh=6kBHhGOK4020AEojvgEcBZzqws1dMhu3vrb6nYUER7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbKT2Ai1cB6iDCOGeaRP43yoiGmMG2gted1VX0/o4mYcNVGPMnOv8EQDA5tc2ORIgfLYy0AZd7O23xKRVN9Ye+47C7zRgGOK0wT+9rCXsbFmsq3i1Rj1pZCVJ+Y0os0J6nPMD9zMszox4YItLAEEKd9iBaYwntSyFepcOiXw79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MOdQXeAx; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fqrdT0srdzlh2hS;
	Tue,  7 Apr 2026 16:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1775577925; x=1778169926; bh=OzdtxUGl+Xu0Kapkclq7wwh9T4SqcKwnmUz
	jsqh+vfY=; b=MOdQXeAxUFw3BsqDnhiqSjp7T1KkmKK6SbRrYi/ZBfZIfXIdop3
	wSp1kYypRu0S2FqTxiMF4EorYpTGWVlf/dARDd/vZTCIagEBy4TY8enaxYNK4wRH
	dOl876mHWpW5oF47IC/Tna0IRtOClPBcBnBeYJSDVq3/jG22Q/y7EzBDojnscF2l
	Hn3tZVq/KtawsXf0AfiKZ1WoQ6NWFXw73hZqWasRfMLzwSaiypWbztvgefwQO3iu
	oF78hszgmmRST4nAn0R3ibqurNuSok4zBPAqnVRtCnYxjizjz7HBBvLXzGM+i7jk
	ZVypbD6rCbKUoBOMiEzHfANRBYb/goVi/6A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ZuCtzBO1__Te; Tue,  7 Apr 2026 16:05:25 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fqrdF4s4fzlgr46;
	Tue,  7 Apr 2026 16:05:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Igor Pylypiv <ipylypiv@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] drivers: base: Set mod->async_probe_requested if needed
Date: Tue,  7 Apr 2026 09:05:11 -0700
Message-ID: <20260407160511.56289-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-233682-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,atomlin.com:email]
X-Rspamd-Queue-Id: 6B2D83B18B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If PROBE_PREFER_ASYNCHRONOUS is set for a device driver, and if loading
other kernel modules depends on probing of that device driver to
complete, e.g. because it is a storage driver, and if
mod->async_probe_requested has not been set, then the
async_synchronize_full() call in do_init_module() introduces a delay.
Fix this by setting mod->async_probe_requested if
PROBE_PREFER_ASYNCHRONOUS has been set. This patch reduces the Pixel 10
boot time by 100 ms.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: Igor Pylypiv <ipylypiv@google.com>
Cc: Chung-Kai Mei <chungkai@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/base/module.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/module.c b/drivers/base/module.c
index 218aaa096455..e58fc189d389 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -39,6 +39,9 @@ int module_add_driver(struct module *mod, const struct =
device_driver *drv)
 	if (!drv)
 		return 0;
=20
+	if (mod && drv->probe_type =3D=3D PROBE_PREFER_ASYNCHRONOUS)
+		mod->async_probe_requested =3D true;
+
 	if (mod)
 		mk =3D &mod->mkobj;
 	else if (drv->mod_name) {

