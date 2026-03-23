Return-Path: <stable+bounces-228624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LULOvRMwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279462F45DD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26CD43013722
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044C91F91F6;
	Mon, 23 Mar 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PZdgVZZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC11C2C181;
	Mon, 23 Mar 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275637; cv=none; b=GsdLjg6qloQDIsf90JoME0YIuUcoF10CF7sq0p7u+/W5/++sWkH8ZVpgfdmlCuxtmgz+dRMCP9RQqRMyYFJtp+LNDFll0+fzo4kbpGqZZM6k9DhfoQH5dq5KLp8i5vjO2+rwy698pLjV0xmqV4itTYkNF0CtSSm4WNcT+FtMvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275637; c=relaxed/simple;
	bh=TXYAR186E10hyYBQePB1mzORwv36ZLM3f2jRgrJef+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjfIeNGarRyRF6D09i/0yhS+SVe6EGRymn2DGJyRI7hKL23UtGXkVvZMWmyGW7fUAqUcxkcEC5vL8lvc3wdUOmC4W9C6LzGpQlJR+BFbs0sm1nuOpFgGJSMRYxDIrXl4++9TfbOzLANotFgp0LKfd8WVzH6oGi04KhtI282irXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PZdgVZZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E0EC4CEF7;
	Mon, 23 Mar 2026 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275637;
	bh=TXYAR186E10hyYBQePB1mzORwv36ZLM3f2jRgrJef+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZdgVZZwoG/uqAIMQlZ8vCDHYdwdT1wqP2y0O+ZXLoC4xC0+vlw8VUwG357fZOOLC
	 8qCa3UJfLlU+1gRspLNvMZqdXwdzPhCYBqqa+t8EApG5LtYldfvxKtuuSaFD9jLmgc
	 GsVeif0vLG4APSNtj3TLq2Yg7U2xrXyu2FA5cs6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>,
	Maximilian Pezzullo <maximilianpezzullo@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 6.12 168/460] ata: libata-core: Disable LPM on ST1000DM010-2EP102
Date: Mon, 23 Mar 2026 14:42:44 +0100
Message-ID: <20260323134530.676048368@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bugzilla.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-228624-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 279462F45DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

commit b3b1d3ae1d87bc9398fb715c945968bf4c75a09a upstream.

According to a user report, the ST1000DM010-2EP102 has problems with LPM,
causing random system freezes. The drive belongs to the same BarraCuda
family as the ST2000DM008-2FR102 which has the same issue.

Cc: stable@vger.kernel.org
Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
Reported-by: Filippo Baiamonte <filippo.ba03@bugzilla.kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221163
Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4102,6 +4102,7 @@ static const struct ata_dev_quirks_entry
 						ATA_QUIRK_FIRMWARE_WARN },
 
 	/* Seagate disks with LPM issues */
+	{ "ST1000DM010-2EP102",	NULL,		ATA_QUIRK_NOLPM },
 	{ "ST2000DM008-2FR102",	NULL,		ATA_QUIRK_NOLPM },
 
 	/* drives which fail FPDMA_AA activation (some may freeze afterwards)



