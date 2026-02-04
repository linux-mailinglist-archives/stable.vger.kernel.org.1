Return-Path: <stable+bounces-213444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILuPNS5cg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:48:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2010EE75FF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 411A13011F3D
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654A2773EE;
	Wed,  4 Feb 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KiE3ER3Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D5271A9A;
	Wed,  4 Feb 2026 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216359; cv=none; b=lNMFrDBuSoG5JAEhQq/vQYqP50QGlm9mFS9DmuL91q5jbTZgNRoy0YDmYQEADTeYUYwYyjR5iAoBnpR8qDDQfK1YooWsiXoDNLb9hUkI3bKNCz3lJvP+4A7JYSKzZNFtic12fh9VUhwkSvGF4ghyrX5hGuHy4s+e0sGsq1/16z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216359; c=relaxed/simple;
	bh=iLrD3K7qyyAWsqdqqmP6jyT8jW6dNIDIm5yq93tzVN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic4nWEJrXSlGXdgrMrk8+nDpcbzMDMUmhzPhejYP0GABzncm9IHpcFQ7GAdJi+h0DX/Ru7zgN85MduZV3Lt0bSV6dCx+FvpyZ4GoB6mqMhP5rniWi8uha/1/0HjI3ZVvap/UDjhfZypJ7YQC+XtSASFojlpa+YMgMBLuV1DJBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KiE3ER3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81270C4CEF7;
	Wed,  4 Feb 2026 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216358;
	bh=iLrD3K7qyyAWsqdqqmP6jyT8jW6dNIDIm5yq93tzVN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiE3ER3QIfSeZbjzIsyJhdnyhvekpa3t+4LB+/FPXXq14Sk8OfL09nzHwhplOgyz1
	 grZQiVrNGpmPmc9Yp23s6CG/Ts5Brn09i3tJdm5U3+b9Km60hjSHpgSQF98qC+iOBu
	 Ry0nDEEkvPbOIdSIb0JiKWjuabBlU2qJ9urYHRHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.10 030/161] EDAC/x38: Fix a resource leak in x38_probe1()
Date: Wed,  4 Feb 2026 15:38:13 +0100
Message-ID: <20260204143852.844965853@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213444-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 2010EE75FF
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

commit 0ff7c44106b4715fc27a2e455d9f57f1dfcfd54f upstream.

If edac_mc_alloc() fails, also unmap the window.

  [ bp: Use separate labels, turning it into the classic unwind pattern. ]

Fixes: df8bc08c192f ("edac x38: new MC driver module")
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251223124350.1496325-1-lihaoxiang@isrc.iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/x38_edac.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/edac/x38_edac.c
+++ b/drivers/edac/x38_edac.c
@@ -342,9 +342,12 @@ static int x38_probe1(struct pci_dev *pd
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = x38_channel_num;
 	layers[1].is_virt_csrow = false;
+
+
+	rc = -ENOMEM;
 	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
 	if (!mci)
-		return -ENOMEM;
+		goto unmap;
 
 	edac_dbg(3, "MC: init mci\n");
 
@@ -404,9 +407,9 @@ static int x38_probe1(struct pci_dev *pd
 	return 0;
 
 fail:
+	edac_mc_free(mci);
+unmap:
 	iounmap(window);
-	if (mci)
-		edac_mc_free(mci);
 
 	return rc;
 }



