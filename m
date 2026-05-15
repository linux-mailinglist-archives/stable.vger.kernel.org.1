Return-Path: <stable+bounces-247534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLh/NkLcBmoxogIAu9opvQ
	(envelope-from <stable+bounces-247534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7287B54B917
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B60F30ABE10
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019C3F20F1;
	Fri, 15 May 2026 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLKCvW/u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781B3EB816
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778833880; cv=none; b=eVJulzcROqwpgNMhnWS7ydmFUEg6fZGn6qXMLLjPuBzmZa/iYxqs5OWei3HPQRE6IO7NtmQ1HBpvlZ4qfmyLJruPEnBc3gbvQvFhpX4opWJrgTATHq9/pUxkwn7MywNhMUnFT8BDqhVcBbdfNtUE4rqeS4N5PF6fiUPTkhRjSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778833880; c=relaxed/simple;
	bh=d2RfSxO6bCOpWxlknFQsIBqcvMxyT4hf/eVB3Vnc44s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DCCIDZjCCscNQ4zUTx6q+87oKCryaS6r1RWRGI8ejOGnFXtN/OKfm3l3IEWV3hi6GMWkbQjPDLCErsvPWiNvoFJMVn5sefVb/9ma1C9T9obkPv91FinQDjAt8gvR6hymoECBP0USxrapgQHCtu30s1kSm0kMyNKS5fPcyE82sfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLKCvW/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C8CC2BCB0;
	Fri, 15 May 2026 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778833880;
	bh=d2RfSxO6bCOpWxlknFQsIBqcvMxyT4hf/eVB3Vnc44s=;
	h=Subject:To:Cc:From:Date:From;
	b=xLKCvW/uvvYPxsUXpUfce0DA2KDlTzi6HjJAh5aQgbTzj0gwdYLE+A/AaWRWrJzjW
	 iULTQ2rPhfYQ2fDYfhVyZg2Ca+CtbM+kH6mbTVPomnMEiPlZ4a8/fBziCqILhNvfRg
	 xLI0aNDW8tFXTIKaXejUVjrb6+k5i9jg6mPN9Bx8=
Subject: FAILED: patch "[PATCH] spi: mxic: fix controller deregistration" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,masonccyang@mxic.com.tw
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:31:09 +0200
Message-ID: <2026051509-finite-arise-4dbd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7287B54B917
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247534-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,mxic.com.tw:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x adbc595e272052181d40ec307a4c5ba98571b0fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051509-finite-arise-4dbd@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From adbc595e272052181d40ec307a4c5ba98571b0fe Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 14 Apr 2026 15:43:16 +0200
Subject: [PATCH] spi: mxic: fix controller deregistration

Make sure to deregister the controller before disabling underlying
resources like clocks (via runtime pm) during driver unbind.

Fixes: b942d80b0a39 ("spi: Add MXIC controller driver")
Cc: stable@vger.kernel.org	# 5.0: cc53711b2191
Cc: stable@vger.kernel.org	# 5.0
Cc: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260414134319.978196-6-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f9369c69911c..b0e7fc828a50 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -832,9 +832,10 @@ static void mxic_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	mxic_spi_mem_ecc_remove(mxic);
-	spi_unregister_controller(host);
 }
 
 static const struct of_device_id mxic_spi_of_ids[] = {


