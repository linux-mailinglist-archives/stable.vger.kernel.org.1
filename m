Return-Path: <stable+bounces-237378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOzWFh4j3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43D3F0D42
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B788F305B768
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3B3254AF;
	Mon, 13 Apr 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydXO8dpH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191531F9BA;
	Mon, 13 Apr 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099301; cv=none; b=hYL10gOgjDcBRBv3f6XPOhKDhSjauatq98KH5cAPRNh8QrBnz5iwNPetZlPjZ89GKHzUQBuIPvlupP0eLLS/dpdjGZnnaGinI//FOh/a7ETIh0caqWUTwMwdeYtjrfELM3pYJaAPBJgRaZwKtVmbziAi58+YcatmppNtfaejfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099301; c=relaxed/simple;
	bh=byZ+Zk56TJKiMjaNHzvRc5ebCkrAZz2UFBxb8VSkYSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MH2nlCZKxNHqVoi89LdTcKS8+QnY5oYOu40v42lnzSmfs+a5t9Sxxfww6Hlaf3mg7enfc5KUebJGndrldG5mdTTdGa7iC1s3Pw5nlZhDNIIko+VdeLk0uQO3BduyWmHnPeMC7jtCRkFkhU/w9iWPyuwFekNeGSwXD3DpTBlWZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydXO8dpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FA6C2BCAF;
	Mon, 13 Apr 2026 16:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099300;
	bh=byZ+Zk56TJKiMjaNHzvRc5ebCkrAZz2UFBxb8VSkYSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ydXO8dpHR9qZ7Sh0X8WXyAzoEcCEW74snnBQRNlPuPZIm7wX1eJudh+E8grrzFlXe
	 aLHG+JpYtlvwMaDPdFVIjchQvtv/cF06U0V/sQL3sm7k0r8J/H2ZOOoLpa6HrV1fTN
	 E4aLkUYtM/hm/DFLswGoO9vsHu5fwbambcShy/vY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 288/491] ACPI: EC: Fix EC address space handler unregistration
Date: Mon, 13 Apr 2026 17:58:53 +0200
Message-ID: <20260413155829.827796105@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237378-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: ED43D3F0D42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a5072078dbfaa9d70130805766dfa34bbb7bf2a7 ]

When an ECDT table is present the EC address space handler gets registered
on the root node. So to unregister it properly the unregister call also
must be done on the root node.

Store the ACPI handle used for the acpi_install_address_space_handler()
call and use te same handle for the acpi_remove_address_space_handler()
call.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: f6484cadbcaf ("ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c       | 4 +++-
 drivers/acpi/internal.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index b20206316fbe4..bf829ebc9afee 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1526,6 +1526,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
+		ec->address_space_handler_holder = ec->handle;
 	}
 
 	if (!device)
@@ -1577,7 +1578,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
 	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
-		if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
+		if (ACPI_FAILURE(acpi_remove_address_space_handler(
+					ec->address_space_handler_holder,
 					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 			pr_err("failed to remove space handler\n");
 		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index f6c929787c9e6..4edf591f8a3a5 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -169,6 +169,7 @@ static inline void acpi_early_processor_osc(void) {}
    -------------------------------------------------------------------------- */
 struct acpi_ec {
 	acpi_handle handle;
+	acpi_handle address_space_handler_holder;
 	int gpe;
 	int irq;
 	unsigned long command_addr;
-- 
2.53.0




