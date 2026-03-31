Return-Path: <stable+bounces-231662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECrvIcX6y2lsNAYAu9opvQ
	(envelope-from <stable+bounces-231662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06336D26B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18A9630FA350
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1273E3C40;
	Tue, 31 Mar 2026 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXZxLoDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E03FADEE;
	Tue, 31 Mar 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974744; cv=none; b=mXxCzhSDcfALSzwi7a2oAGP1Ewasuo4iB/ChWQTwh9OI7W+JC9A3sIMvK2avCTG/Li4Vm/yyQ0ivW36iNQsqv5mtQM5pxrpncZy4l+hNA+arMkY9e3iCbKgo7/IeBGBEe555VoVvo82t22ALdIOp/VHZaaA7UD5mdSwwXSH7Wfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974744; c=relaxed/simple;
	bh=52yuQQrIU0O0pWXioa22aUKMvJLdq0GWGIrNKCxSHDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDm9dAVLQw2G7JWTAqAq1lmnFhIBM+mOcT4geclBAxxEQ1CmF3n0czmOCyUcarUfFy4QMYhsZE6ye7MaX0G3b4nSrp8K5VrVKj2wQDU4DOhlzbfV0Lknt1csrNJzGaR5xERnv7EeLSiH1PuAFVd/mbB/APNmQd2CdDanZsyUaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXZxLoDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69293C19424;
	Tue, 31 Mar 2026 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974744;
	bh=52yuQQrIU0O0pWXioa22aUKMvJLdq0GWGIrNKCxSHDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXZxLoDk/B+EHJPanKNbXGveGsqQzgM+RSj534StvjTyaZh5KSPIrn6izpWRMXA37
	 jjGBFflsZT7kvGbfVbyDn1GfdWcbeLfWdge7NTvRmXkQnVbqzIq1ws6HFsHBHNElDd
	 HQtdfVEZqH8noucVXbmsx09KcjBjhPmbHBd/7gME=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leif Skunberg <diamondback@cohunt.app>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 028/342] platform/x86: intel-hid: Enable 5-button array on ThinkPad X1 Fold 16 Gen 1
Date: Tue, 31 Mar 2026 18:17:41 +0200
Message-ID: <20260331161759.944879834@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231662-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,intel.com:email,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6E06336D26B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leif Skunberg <diamondback@cohunt.app>

[ Upstream commit b38d478dad79e61e8a65931021bdfd7a71741212 ]

The Lenovo ThinkPad X1 Fold 16 Gen 1 has physical volume up/down
buttons that are handled through the intel-hid 5-button array
interface. The firmware does not advertise 5-button array support via
HEBC, so the driver relies on a DMI allowlist to enable it.

Add the ThinkPad X1 Fold 16 Gen 1 to the button_array_table so the
volume buttons work out of the box.

Signed-off-by: Leif Skunberg <diamondback@cohunt.app>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260210085625.34380-1-diamondback@cohunt.app
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 5b475a09645a3..f2b309f6e458a 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -135,6 +135,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Tablet Gen 2"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad X1 Fold 16 Gen 1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X1 Fold 16 Gen 1"),
+		},
+	},
 	{
 		.ident = "Microsoft Surface Go 3",
 		.matches = {
-- 
2.51.0




