Return-Path: <stable+bounces-194821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC6C5F262
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 20:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D2A2324285
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D434572F;
	Fri, 14 Nov 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uplinklabs.net header.i=@uplinklabs.net header.b="lXUCAC78"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DA315776;
	Fri, 14 Nov 2025 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150280; cv=none; b=RFFc8LtocIwbe9V5j+y/6flqe/1vdTkT6NhjDy5CKBKWDsKqlWlUeCZW4qPmfbsSeGsh1bJvQR20fcsbABXeSrd80ExSCnt27VNo2RZVNRSpH6q1IWlk72A/liiv7xFw4EUPmIyLT4lYJ/ceCMytJDhCIjlHOx1oDXCOukf0FlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150280; c=relaxed/simple;
	bh=WNnWAeUiDv3iZ6cb0knq4NA8z1hypZSDQ/VWBcS4XRs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rlMy8r8kTpAbi1rH+tERtJswDvZDw5w0GYxgxG9gr2AcPjjuH3NJrj1YkyrV0865KdRMeMdtfLxqzMS4qerngoq6a0Q53/eIGoRzJ5dFAmI0UHALkgb950NGG2xMT2G5KYarT5hyWDUb1v4VlriWPuaw+pleJHINJ/e/uNqlT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uplinklabs.net; spf=pass smtp.mailfrom=uplinklabs.net; dkim=pass (2048-bit key) header.d=uplinklabs.net header.i=@uplinklabs.net header.b=lXUCAC78; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uplinklabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uplinklabs.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uplinklabs.net;
	s=protonmail3; t=1763150261; x=1763409461;
	bh=JZqd4l70Aqy9I/uY/F8JAuee0mHeOD6CHLL+aIXOcvc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lXUCAC78ncjbMev+wmqLdhEt91yXcDCVxhuhNjI8Fyq263Dy6dOq1f+KEoCmer5iB
	 e1XtHdiN2G6PhO/Fw1/blRFlptHI6yplfBorqQQ8rbKx6Nj6q+P3tZfaZ8dctOQi26
	 BA7elyC6uuDww1VxusDIs7e+rdnXyI7pmrO1xjcWTGhpHh9YpKWWJrUjXVlppOp+t9
	 Zs/oJ98TwMgghXkBzx1wpeNtYwxoTQkJUO14K/FXl7ksn/77eWCXysSgz14IgUKPya
	 1TjYPPAullfZDIyEk9450IxqUYcCZkA1n07mFOTI4l4v0tWKcA1z0pr2U473mmLFrZ
	 X1YtdE2WHST7w==
Date: Fri, 14 Nov 2025 19:57:35 +0000
To: linux-kernel@vger.kernel.org
From: Steven Noonan <steven@uplinklabs.net>
Cc: Steven Noonan <steven@uplinklabs.net>, Ariadne Conill <ariadne@ariadne.space>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Message-ID: <20251114195730.1503879-1-steven@uplinklabs.net>
Feedback-ID: 10620438:user:proton
X-Pm-Message-ID: 7479414bc0c38f45f1e4228c67b462709b0505a4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6c34b6191a5b63f9f7b157ab4479ec6343c00927dbc8f14bf3983e51a8bdee42"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6c34b6191a5b63f9f7b157ab4479ec6343c00927dbc8f14bf3983e51a8bdee42
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Steven Noonan <steven@uplinklabs.net>
To: linux-kernel@vger.kernel.org
Cc: Steven Noonan <steven@uplinklabs.net>,
	Ariadne Conill <ariadne@ariadne.space>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Date: Fri, 14 Nov 2025 11:57:29 -0800
Message-ID: <20251114195730.1503879-1-steven@uplinklabs.net>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0

On a Xen dom0 boot, this feature does not behave, and we end up
calculating:

    num_roots = 1
    num_nodes = 2
    roots_per_node = 0

This causes a divide-by-zero in the modulus inside the loop.

This change adds a couple of guards for invalid states where we might
get a divide-by-zero.

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
CC: Yazen Ghannam <yazen.ghannam@amd.com>
CC: x86@vger.kernel.org
CC: stable@vger.kernel.org
---
 arch/x86/kernel/amd_node.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index 3d0a4768d603c..cdc6ba224d4ad 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -282,6 +282,17 @@ static int __init amd_smn_init(void)
 		return -ENODEV;
 
 	num_nodes = amd_num_nodes();
+
+	if (!num_nodes)
+		return -ENODEV;
+
+	/* Possibly a virtualized environment (e.g. Xen) where we wi
ll get
+	 * roots_per_node=0 if the number of roots is fewer than number of
+	 * nodes
+	 */
+	if (num_roots < num_nodes)
+		return -ENODEV;
+
 	amd_roots = kcalloc(num_nodes, sizeof(*amd_roots), GFP_KERNEL);
 	if (!amd_roots)
 		return -ENOMEM;
-- 
2.51.2


--------6c34b6191a5b63f9f7b157ab4479ec6343c00927dbc8f14bf3983e51a8bdee42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmkXia0JkAi2TYeeRSZQNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeHO5izQtchRvtsX3QLMz5tFiEE707zOy6TKdat
SeTPCLZNh55FJlAAAFzPAP45nm9Z5VpxBaa64nf6/jW1IeN7EurvbmHNpw+t
SGZ9SwEAtIWcg2os2V6SWAfrwE60b1bXW9AbQ8apZ06CH7nvqgk=
=hlTl
-----END PGP SIGNATURE-----


--------6c34b6191a5b63f9f7b157ab4479ec6343c00927dbc8f14bf3983e51a8bdee42--


