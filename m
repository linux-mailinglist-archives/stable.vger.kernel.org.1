Return-Path: <stable+bounces-236717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDdRFE4h3Wn5aAkAu9opvQ
	(envelope-from <stable+bounces-236717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB4D3F0803
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DD903230321
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA3F24DCF6;
	Mon, 13 Apr 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZEvTZMPz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE7830B50F;
	Mon, 13 Apr 2026 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097612; cv=none; b=Tw6sUr/OAHRdURgWaxWAP4mfpGlMf3VlCuGGPzR1wuHMCYv/qHdnEGPeRJsEpba8zss8y/rFKiDd9ZH0xK5AeMW63QXZG5q5JBcc8wNdHkDWCtPRHDPlA/RLa41cbNYg4E4GIAYcSSN2SB5glyG3+RPHlwCZmRAfGg7YGU0bLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097612; c=relaxed/simple;
	bh=AIirs4pV/Szt59K7mCodyy0Wo1C6Qyad9O5bfoFeMKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWnycz2nXnRfH0RDjG0oyMhHcZVVQP4AZUdqoLoTNQXjK8sa9Sh5aQ1plgI1gyaqOACm4a6bRFVvK0CczY765KJxglmp9skvb+mD+3rM17AqdGnfv/HOlw1puQ2DU9x319Qnmz9xCCgeEZB+llhxO3tEhG+p4sR3sbLB2FnSMV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZEvTZMPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448F2C2BCAF;
	Mon, 13 Apr 2026 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097612;
	bh=AIirs4pV/Szt59K7mCodyy0Wo1C6Qyad9O5bfoFeMKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEvTZMPziweV4opMZGZVlOhw0ktqJ6wOWmzrDyIfvJlejUKf+NIYIDm/bkEDfZ3OF
	 Uhau63xtS2zWBx5qHmZatm0XPPZlM02s3evd+3Ixg3L5dfUN3pVTMNYkcCcHjoENqQ
	 Mza2wMBHcbXiZx1cMfWL+4XDePJRZe8aNqGOgZQw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olivier Sobrie <olivier@sobrie.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.15 205/570] mtd: rawnand: pl353: make sure optimal timings are applied
Date: Mon, 13 Apr 2026 17:55:36 +0200
Message-ID: <20260413155838.137941868@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-236717-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sobrie.be:email]
X-Rspamd-Queue-Id: AEB4D3F0803
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olivier Sobrie <olivier@sobrie.be>

commit b9465b04de4b90228de03db9a1e0d56b00814366 upstream.

Timings of the nand are adjusted by pl35x_nfc_setup_interface() but
actually applied by the pl35x_nand_select_target() function.
If there is only one nand chip, the pl35x_nand_select_target() will only
apply the timings once since the test at its beginning will always be true
after the first call to this function. As a result, the hardware will
keep using the default timings set at boot to detect the nand chip, not
the optimal ones.

With this patch, we program directly the new timings when
pl35x_nfc_setup_interface() is called.

Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -864,6 +864,9 @@ static int pl35x_nfc_setup_interface(str
 			  PL35X_SMC_NAND_TAR_CYCLES(tmgs.t_ar) |
 			  PL35X_SMC_NAND_TRR_CYCLES(tmgs.t_rr);
 
+	writel(plnand->timings, nfc->conf_regs + PL35X_SMC_CYCLES);
+	pl35x_smc_update_regs(nfc);
+
 	return 0;
 }
 



