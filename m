Return-Path: <stable+bounces-194820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA8C5F268
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 21:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7BDB35EBE1
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3E933C535;
	Fri, 14 Nov 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uplinklabs.net header.i=@uplinklabs.net header.b="GjGFvtB+"
X-Original-To: stable@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E602D542A;
	Fri, 14 Nov 2025 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150280; cv=none; b=FXdxYlLDYLUvt/4DuuCAGlTgV190eN/RGuciLTPIX3T4BtrHKsVmMqw87M/Gph/fwQvxkVl0KqT6RiII4BUioBLoiIWAmXy/+E99qZzFZ5jJ047yyLSOWn2eVBBYCv45cddzx+Ase0+oFfvBA0LH2i7+08ySe/6FudRRY/auyUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150280; c=relaxed/simple;
	bh=YZpvOvIaRoG2VbsOpZ/hBT2WNTP+fwEmaV09gOCcRsY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5X3JWJKfB40H52XeGyOZlXWszpYMnIL799KNGFFGacNJe5jQ194wFoMa/bWU2l8ZhrwJqMgG+EVSXAzU79AJYiFGiI+bhtrBKzY+N/Ae5wj3GX3kZ0Cl8/oMMKNy6y/irXgg9J1grZoZenhgSfcbSfOHHVOtGcJx9y3hEERKsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uplinklabs.net; spf=pass smtp.mailfrom=uplinklabs.net; dkim=pass (2048-bit key) header.d=uplinklabs.net header.i=@uplinklabs.net header.b=GjGFvtB+; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uplinklabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uplinklabs.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uplinklabs.net;
	s=protonmail3; t=1763150269; x=1763409469;
	bh=gKjBE/opp7htoI0A6FZ4co7nMjCsAKiaY5t3wY2KfA0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GjGFvtB+rwptCWXYQEZKtZNKkJ4bUsooZKTPpD8DVF00oAil+ffr4guH7pcAK5sVo
	 LQyqeZkZN8vl8+ZFSWIebUkQfciAg76GYiIGKEaCZle8XeHjVqGjrcQBlsTCriud7W
	 MA14/jfqpy9ybVtl2ZK8vCMaFg5zU4bSTRuVuIzmm2AUpWngjpkkjLtRsR5BQPiS0T
	 lspCQplxTnG48I9YscWaSXrL6mimr6eEmtm7MKyQWEE6S9IUL4ALp1VpFAiHSLbmvs
	 ZMogNhADie9arbftummtG7jnSA31GXQaKh6P5ysvRnRQ2JPAS/f+aSh3zgYj2o0m8J
	 UbteeTrQCS05w==
Date: Fri, 14 Nov 2025 19:57:46 +0000
To: linux-kernel@vger.kernel.org
From: Steven Noonan <steven@uplinklabs.net>
Cc: Steven Noonan <steven@uplinklabs.net>, Ariadne Conill <ariadne@ariadne.space>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/2] x86/amd_node: fix null pointer dereference if amd_smn_init failed
Message-ID: <20251114195730.1503879-2-steven@uplinklabs.net>
In-Reply-To: <20251114195730.1503879-1-steven@uplinklabs.net>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
Feedback-ID: 10620438:user:proton
X-Pm-Message-ID: 4ce134941e1c04b6cfdd934a01e92ebf35d39dbc
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------b860d8d3929df4788b24d1c2f6cc23a6945ff2b629896963a4fe728aeba2dc51"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------b860d8d3929df4788b24d1c2f6cc23a6945ff2b629896963a4fe728aeba2dc51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Steven Noonan <steven@uplinklabs.net>
To: linux-kernel@vger.kernel.org
Cc: Steven Noonan <steven@uplinklabs.net>,
	Ariadne Conill <ariadne@ariadne.space>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] x86/amd_node: fix null pointer dereference if amd_smn_init failed
Date: Fri, 14 Nov 2025 11:57:30 -0800
Message-ID: <20251114195730.1503879-2-steven@uplinklabs.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114195730.1503879-1-steven@uplinklabs.net>
References: <20251114195730.1503879-1-steven@uplinklabs.net>
MIME-Version: 1.0

We should be checking the `smn_exclusive` flag before anything else,
because that indicates whether we got through `amd_smn_init`
successfully.

Without this change, we dereference `amd_roots` even though it may not
be allocated.

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
CC: Yazen Ghannam <yazen.ghannam@amd.com>
CC: x86@vger.kernel.org
CC: stable@vger.kernel.org
---
 arch/x86/kernel/amd_node.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
index cdc6ba224d4ad..919932339f4a2 100644
--- a/arch/x86/kernel/amd_node.c
+++ b/arch/x86/kernel/amd_node.c
@@ -88,6 +88,9 @@ static int __amd_smn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	struct pci_dev *root;
 	int err = -ENODEV;
 
+	if (!smn_exclusive)
+		return err;
+
 	if (node >= amd_num_nodes())
 		return err;
 
@@ -95,9 +98,6 @@ static int __amd_s
mn_rw(u8 i_off, u8 d_off, u16 node, u32 address, u32 *value, b
 	if (!root)
 		return err;
 
-	if (!smn_exclusive)
-		return err;
-
 	guard(mutex)(&smn_mutex);
 
 	err = pci_write_config_dword(root, i_off, address);
-- 
2.51.2


--------b860d8d3929df4788b24d1c2f6cc23a6945ff2b629896963a4fe728aeba2dc51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmkXibgJkAi2TYeeRSZQNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmetXWq8vXpwqRN5F0juWzitFiEE707zOy6TKdat
SeTPCLZNh55FJlAAAM5VAQCwv18vBPocSAbwTyIvL7sOjCA+lnb7QEUXcGvm
0WTTsQEA1MvjItRUYaoxnNnlfwLJAIWiaRvD495wgX7h+14avwA=
=6UF3
-----END PGP SIGNATURE-----


--------b860d8d3929df4788b24d1c2f6cc23a6945ff2b629896963a4fe728aeba2dc51--


