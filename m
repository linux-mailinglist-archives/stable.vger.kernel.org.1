Return-Path: <stable+bounces-111024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB81A2101C
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 19:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9C8188AE7B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EB1F9437;
	Tue, 28 Jan 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbc7HU5/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435E1F9426;
	Tue, 28 Jan 2025 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086873; cv=none; b=uhbQdwOfWQy2aU8vKhGUim7ttvf861+ABS6YVU3KmCHqa9tebZ3qtX2I6DO5mM0Dbj0lcidTCUpYcyWp3No/gJWVbaoF7jYyiYT40DJbIu1ToO8SRmxnF9u9mmMogt8KnJ79+56GAqQrunosqG1EzbaBksBuVmidfSkTisCG258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086873; c=relaxed/simple;
	bh=5AJtSvii6g1sTds8r1PuMBOoBRKh45Qekfs1TmDFEVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfVyfH+jvX1AXhzYPdro7NV2f0t29xQ3yhmiK9IsmtraCuFByDUjYaknwfYApLjjh2NnXOKZRsDtXCWYrlB7hJXtetpyC7lyKsiA87ttr/f1RyUJSLpsSLTWezuwRfGaGh0HJeHOBCgu/JNsxOTYMBvBqm0fYM7rvwx8AbPYhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbc7HU5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C7EC4CEE2;
	Tue, 28 Jan 2025 17:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086873;
	bh=5AJtSvii6g1sTds8r1PuMBOoBRKh45Qekfs1TmDFEVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gbc7HU5/4CMJGgQDKEUpb18SQcxLaN3L5BXGsVW8NvrqENcfdCtXUT4z7ij8cieHa
	 5J9pWzAFxJ0YXHtCsQ5irlHFfHE2MinCG52D08ikVHIW3VfCe5j3PGkJ5nrj1wB7lq
	 puCWxfaAh4g7RfwPXTq2yAo50NAxVnTFR0J74ZbU+b4wqpy2cnUT7cJ7h3s/SDBYZY
	 pRblLvbHrgOk9/JRgionZapNevBD4yqtN5iqJoqr7ovB6Ya3hLSfWiX7B2w1vGUSyp
	 Kw/EOEXl064ENedS5BSb0gTDpH8T4dKDwCbIfmwvZcTP59Dl4xQO2DI9PAbbVszhFX
	 GZHicNKlXMdBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 11/12] PCI/DPC: Quirk PIO log size for Intel Raptor Lake-P
Date: Tue, 28 Jan 2025 12:54:13 -0500
Message-Id: <20250128175414.1197295-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175414.1197295-1-sashal@kernel.org>
References: <20250128175414.1197295-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b198499c7d2508a76243b98e7cca992f6fd2b7f7 ]

Apparently the Raptor Lake-P reference firmware configures the PIO log size
correctly, but some vendor BIOSes, including at least ASUSTeK COMPUTER INC.
Zenbook UX3402VA_UX3402VA, do not.

Apply the quirk for Raptor Lake-P.  This prevents kernel complaints like:

  DPC: RP PIO log size 0 is invalid

and also enables the DPC driver to dump the RP PIO Log registers when DPC
is triggered.

Note that the bug report also mentions 8086:a76e, which has been already
added by 627c6db20703 ("PCI/DPC: Quirk PIO log size for Intel Raptor Lake
Root Ports").

Link: https://lore.kernel.org/r/20250102164315.7562-1-tiwai@suse.de
Link: https://bugzilla.suse.com/show_bug.cgi?id=1234623
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8103bc24a54ea..11fe6869ec3ab 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6254,6 +6254,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa72f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 #endif
-- 
2.39.5


