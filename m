Return-Path: <stable+bounces-230142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GB4KVB2wmnqdAQAu9opvQ
	(envelope-from <stable+bounces-230142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:32:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2730757B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31D03075EF3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B083E867B;
	Tue, 24 Mar 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DTa2OxNK"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EC3630A4;
	Tue, 24 Mar 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774351868; cv=none; b=F/nV2ijRhqOWlvVacGEfJMApIQYCEGf9/RnzaQFBQoAWwS80EDY4TxvwnG+zTXtxR1Rjcs0S7sHox0Np5eit629oW38cYnPGjCUPW3dKdHySpUCdLNa1ghx0XeUiWW875VNNJkxyfwr3kLfFLuLLh3yXV+00lIwom8u4+NKtq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774351868; c=relaxed/simple;
	bh=rblMCGvd2iPAz2pvlqhOFvMSb8AD5H70RhuU57IZUhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hu11Bihp4qokd2ZPWZGeyMRgILDlaKt6oiztdwbAN5fjngLpRpn6jeTV18zm0HmJbHIYNCXcaIo08jQjjA3/mgyYTHHh3WCM7AzGp8ChA4cHud5hJcVZ+sh6syb5TxbWNT34CRob+9LcpUo0fHJSUD0jFEOaH88X7xn1ZLBm0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DTa2OxNK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77DBC40E01B5;
	Tue, 24 Mar 2026 11:23:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8U81itRaMNaU; Tue, 24 Mar 2026 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774351405; bh=FFYpmmv34rxKLc4i7HhqfOYLG9MsqetPZcO17O0bV2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTa2OxNKVeHVoLONO52eUQALwiIXFc9zL7pEAZYXj1cypuVSotomy1k02jCAa1tnl
	 GIKmSHE+k64zVhx+ZHqRAiBYg/60FGLdBcB3bGrRnHa0F+X7Kxwvqnfub2hjI2xIa8
	 YOycbzZxIoKx+yGRtzzAi+bLsb1WnALT6hs9y2Bz6zr35sU7GRtgGFu1WivsXm6Xnk
	 H4sdf7dpPPql7lp0hwGQBd0r6ZJT2N6lFXiCf56rHY77fHTg0rXENsFL2l8nUHztNM
	 d5YhVV86MuB2eKz4PTex6SgnNFYC9KsLYYdBuXohc4l4J0CBFLqXFLz610Gj1YVEIk
	 7wQ3zVxO33BPJd1IYm3wrJeZorJiIGyWAt/74KkyEuC2ZIeTgDku9gZFvOoawWs6oR
	 3IGOGt+uUIXDUonDpGM+GZcCce81wyYwdiFbe1ne6vlI3K2im6HRKI9qOaobpXVcjj
	 8SLiMe/d275nOmTidZAYDoUhVUMn1DNCcqepbg8Qu2Jp2/8uo/xhdn89H3ghjpNKTO
	 eIa0AgKJWQxQIF1NtoCc2i98aArr62P0CalSoGd1I0p7Up7qtrfFC3jvB6f1GofxpX
	 dQwbMH60qDFRVPHC7k/VO95HQObDQAXmVjMZrb6lwRqbtsl/0C2VH0pCc1e/+yLSGM
	 ArQlu2WO8e/ztmxB3/7UdcVg=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 304CA40E019D;
	Tue, 24 Mar 2026 11:23:19 +0000 (UTC)
Date: Tue, 24 Mar 2026 12:23:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] EDAC/versalnet: Fix device_register() error handling
 in init_one_mc()
Message-ID: <20260324112312.GKacJ0IEL2iD7JZnSk@fat_crate.local>
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131145.1684744-1-ptsm@linux.microsoft.com>
 <20260322161052.GAacAUjFGWFwPle6c9@fat_crate.local>
 <84ae7198-b755-4dde-b97c-978958d27b4b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84ae7198-b755-4dde-b97c-978958d27b4b@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230142-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:dkim]
X-Rspamd-Queue-Id: 0DF2730757B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:38:57PM +0530, Prasanna Kumar T S M wrote:
> If kzalloc(dev) is done after edac_mc_alloc(), there is no need to decide
> between kfree(dev) or put_device(dev). This simplifies the error handling
> path. This is the reason behind re-ordering and keeping put_device(dev)
> under 'if (rc) { ... }'.

I don't think you're listening to me so lemme repeat:

edac_mc_alloc() is a lot more heavy-weight than a simple k*alloc(). Pls keep
the ordering as it is.

I don't care how much it simplifies the error handling path if you have to do
all the allocations and setup edac_mc_alloc() does for *nothing*!

So let's do it another way (totally untested ofc):

---
diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index b87fe57aa842..bf17b3ff59d5 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -772,12 +772,11 @@ static void remove_one_mc(struct mc_priv *priv, int i)
 	edac_mc_free(mci);
 }
 
-static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
+static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, struct device *dev, int i)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
-	struct device *dev;
 	enum dev_type dt;
 	char *name;
 	int rc;
@@ -817,14 +816,10 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	if (!name)
 		return rc;
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		goto err_name_free;
-
 	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
-		goto err_dev_free;
+		goto err_name_free;
 	}
 
 	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
@@ -856,8 +851,6 @@ static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i
 	device_unregister(mci->pdev);
 err_mc_free:
 	edac_mc_free(mci);
-err_dev_free:
-	kfree(dev);
 err_name_free:
 	kfree(name);
 
@@ -869,15 +862,21 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 	int rc, i;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		rc = init_one_mc(priv, pdev, i);
-		if (rc) {
-			while (i--)
-				remove_one_mc(priv, i);
+		struct device *dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+		if (!dev)
+			goto free;
 
-			return rc;
-		}
+		rc = init_one_mc(priv, pdev, dev, i);
+		if (rc)
+			goto free;
 	}
 	return 0;
+
+free:
+	while (i--)
+		remove_one_mc(priv, i);
+
+	return rc;
 }
 
 static void remove_versalnet(struct mc_priv *priv)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

