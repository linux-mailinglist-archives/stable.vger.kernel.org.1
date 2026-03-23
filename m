Return-Path: <stable+bounces-229117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKz5HrNZwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D712F61D3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60223211372
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C77B2773EE;
	Mon, 23 Mar 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9QM+YTk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D026A1CF;
	Mon, 23 Mar 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278113; cv=none; b=MBmjmvzLTA+RRwASIwtW29741TQjwSNLj3/cqRa2piJYAFfh2jfMK5WgX7vVVtpMMiC2b10w9U4yK/cSLe6Syat2cgIwrI7vzBzWDlATPpkHMpiqC6LpV+IL9wT5ybYDRK9k009D+TFBQD9RaVYoMEU8nVsw/aefRM6VV2XxNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278113; c=relaxed/simple;
	bh=4/G9O9L/VRFVcgeZp0g2H7+aT7Gu29IZ+Yi9ACvSCs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P29JVwQBCIwCb1DST8wXxD/NgbsWYzEfEPt+33TIShzMtUHb92HE8W/toKuM5eSCHaJOUi3z+M8Hh1IV0KZYMsgJzmpgLwPZn8um/x7wS1WstZz6+QCOT0L5naEHoGP7yqSiLr3jLbwFAmRNZwxN5uGU4xuE8hcIhJtoOrxTIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9QM+YTk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968EEC4CEF7;
	Mon, 23 Mar 2026 15:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278113;
	bh=4/G9O9L/VRFVcgeZp0g2H7+aT7Gu29IZ+Yi9ACvSCs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9QM+YTkDXLtzJpGiSGSlZv6Y8NDJDaSDyX/p9JSV/Rm0WpU0DIeJ50pRQ7s2IPz4
	 GYZDiOydPnPrC26vRxIRGj6AUTKlVC6Cjshy8ac1NCj6lbcPFW/U6GudORNwQiJ0rm
	 1kAO9tWtqRVKD/fpjny4URb0k0LJiRetjlYkvd8I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Azamat Almazbek uulu <almazbek1608@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 205/567] ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table
Date: Mon, 23 Mar 2026 14:42:05 +0100
Message-ID: <20260323134538.913315939@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-229117-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F2D712F61D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Azamat Almazbek uulu <almazbek1608@gmail.com>

[ Upstream commit 32fc4168fa56f6301d858c778a3d712774e9657e ]

The ASUS ExpertBook BM1503CDA (Ryzen 5 7535U, Barcelo-R) has an
internal DMIC connected through the AMD ACP (Audio CoProcessor)
but is missing from the DMI quirk table, so the acp6x machine
driver probe returns -ENODEV and no DMIC capture device is created.

Add the DMI entry so the internal microphone works out of the box.

Signed-off-by: Azamat Almazbek uulu <almazbek1608@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20260221114813.5610-1-almazbek1608@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 5aeacbcb1f6ad..106012da7443e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -696,6 +696,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 				DMI_MATCH(DMI_PRODUCT_NAME, "Vivobook_ASUSLaptop M6501RR_M6501RR"),
 			}
 		},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK BM1503CDA"),
+		}
+	},
 	{}
 };
 
-- 
2.51.0




