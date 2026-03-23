Return-Path: <stable+bounces-228480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKpEEplTwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F782F553A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF0C632B2A97
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB33AF643;
	Mon, 23 Mar 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHxC/tct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7E399004;
	Mon, 23 Mar 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275245; cv=none; b=Ft5RFr/VY/Wx/H2dVOaKLSQ1pB4/ajLQdC1zOdecQ9wsJcEneI2z0kJnSFL6TzGAwnRzuDQIBC1oTLRq3c4+QnS2vFziA+B9evHxqLKma//abKq9YcIqEVIIUvufXZIGhBhQi3GGFSB8dBXdoqf65FfgLwLR7/zAaQ+RoRSsGYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275245; c=relaxed/simple;
	bh=KnFvyMxnWv8ySLbGxKUQmROxAZFozT4KvQUVXSbiUqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rk3Rg7MNESZGTlcc1brVJMOKOn0jrkTI9GUjhYV9f8gobHqgywgc3PsjbjA/Ra3BIkV8vXWcYML1m7klIe8++fP9LuIkdN4wcioWn34222LJK93/EfzBg3oqvFqKKtncpK4+8OGfD+s54rkME/fGs21YvFdOqhnk7d/gvneNNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHxC/tct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F77C4CEF7;
	Mon, 23 Mar 2026 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275245;
	bh=KnFvyMxnWv8ySLbGxKUQmROxAZFozT4KvQUVXSbiUqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHxC/tctfqwWN4u79J+bDoIegWx0CL7RX5GEKXZWsFbWyf3YCWtg20QcyGoSMNLPX
	 JtSbn5aspNNSEBdMGt2x6jgARvQe1y6XaS/LsHcPGblaDkrp7neAGZBStGPTt25kLe
	 iMs1EIVpmTzwdU2zKzJYtKXxhDmtOdPdbsEttKPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Azamat Almazbek uulu <almazbek1608@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 009/460] ASoC: amd: yc: Add ASUS EXPERTBOOK BM1503CDA to quirk table
Date: Mon, 23 Mar 2026 14:40:05 +0100
Message-ID: <20260323134526.887495185@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-228480-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B7F782F553A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index f33946fb895da..b4f38d2245ec7 100644
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




