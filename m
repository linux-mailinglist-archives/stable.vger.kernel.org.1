Return-Path: <stable+bounces-228552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ91EN1OwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:31:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DB92F4AC8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2AF4A307E0E7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB563AE1A8;
	Mon, 23 Mar 2026 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YqFLjDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8C2C181;
	Mon, 23 Mar 2026 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275433; cv=none; b=F0Erg2lpyW+ai5TmrQ3bVE6RJG87wTWmfGlVd5IE2cZhAMCF6HFYBo4T4fIkeifjdmG/GzLbm28z1NuqPQmxLZPziPbZUgAFAAcBp827Ej8Qvzh5OQ0obS9idv4VF0mUIfmjjiWrY4o6qfCVBsOvrxbFocC0CkFYEAIXJoEM1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275433; c=relaxed/simple;
	bh=dZeNsB/SVKAeJZioJek9SECj3aLCpAlesQOzKAw4QVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfFY+KuMXjZ+SMN+84izLLWPAziZKTryswWkO0Gek8rfFYbnOfdWPIZTRAzdYcSWnklDGvXaTtgQEn9xqvvQ/zNR5P+LUZob1B7nEUBbDbN+atb9K2JTnDG7bE7No9SHdr3tsxNTN3ZJ+E19mE9Oaa3MzVifzL8TtsTkp1gtI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YqFLjDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85818C4CEF7;
	Mon, 23 Mar 2026 14:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275432;
	bh=dZeNsB/SVKAeJZioJek9SECj3aLCpAlesQOzKAw4QVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2YqFLjDyWA/zMF5W1zkrbD45sIESzMC5igickNKtXHkFB/swNPBzCT5wYZDPujq8O
	 E9BdO5SbmqtJKhrWvuIZYLXpYDvHZQaPH31dlLXXQ/eeiMG62Z8MB+hCPOH/ynOcUr
	 SU1zTXttiAMVdmhex52DA+Vcmyt20L5dU3jTV9pA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Heng <zhangheng@kylinos.cn>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 096/460] ASoC: amd: yc: Add DMI quirk for ASUS EXPERTBOOK PM1503CDA
Date: Mon, 23 Mar 2026 14:41:32 +0100
Message-ID: <20260323134529.017314062@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228552-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D8DB92F4AC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Heng <zhangheng@kylinos.cn>

commit 325291b20f8a6f14b9c82edbf5d12e4e71f6adaa upstream.

Add a DMI quirk for the ASUS EXPERTBOOK PM1503CDA fixing the
issue where the internal microphone was not detected.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221070
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260304063255.139331-1-zhangheng@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -703,6 +703,13 @@ static const struct dmi_system_id yc_acp
 			DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK BM1503CDA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "PM1503CDA"),
+		}
+	},
 	{}
 };
 



