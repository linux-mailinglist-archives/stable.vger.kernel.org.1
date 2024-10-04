Return-Path: <stable+bounces-80837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2733990BAC
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC71C2036E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F71E5FF2;
	Fri,  4 Oct 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPCnh/fz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2B1E5FEB;
	Fri,  4 Oct 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066019; cv=none; b=EqyKOSB1uXbuOiKWn3GR8l2GgK8LmDqW74HUahs4x8z9OekSk06jAXidXjq0Pyz0QfD2X7k3mYlx5ggmMNbY9cjnej97K1mdj13M/aS32z9qe197P4OtsjC7Qba4cYRSaZtNwzNMFMS0lPLkPRvpcoPYmNl0FEVgjlCQJl0npAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066019; c=relaxed/simple;
	bh=FEr6mMq7J4msZ4yB+YFTNrkNfNp+VgGlsUzxwil8hDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANgmEcyHymfVboH2V0Pfrt32b5ctuVnTks6yqKCZ2siXeUQGG7sfLXV4yqo4OixSYFHJK2OsLIgrDh2957HPpLrVel4y9SHgCCoyeoWCNaVwX5uNQah/30kwV+NnU0akezh2Jh4qO1Ff9v6xflqbThi1+Ax1GtATEbmxuyhSvzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPCnh/fz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98098C4CED0;
	Fri,  4 Oct 2024 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066017;
	bh=FEr6mMq7J4msZ4yB+YFTNrkNfNp+VgGlsUzxwil8hDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kPCnh/fzFYn2wEBNmTVW1TBkxARbPDBNKcZkC3/kjkJ/lUj8QqubVSI/NDKVOMGs7
	 tLYejEtmxz6tBXKLThRdqezHegVoDjzbSdT7r4qIxNATZtF6Qac7hTbozjCUlSge30
	 u8gWe5h6hWaxAY7l1/O2neSah84NA8Ks/qxYx8r+/uwsrsMnUI+YB6Wh0Wp0KjyplK
	 ZlTxPS6EPmzW3zYBUUMhzGUT6iefsvcV5gicRlY2jO2sdCybJtir/qSq21X87Qh2R5
	 hd7QMATSrAnmV93z1f4WFSElzjiKJHAQGmjM2rqZHGJyLXD7lDURCO15Y7mmQQO89q
	 FB1e83jT1VYjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>,
	Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	abbotti@mev.co.uk,
	hsweeten@visionengravers.com
Subject: [PATCH AUTOSEL 6.11 57/76] comedi: ni_routing: tools: Check when the file could not be opened
Date: Fri,  4 Oct 2024 14:17:14 -0400
Message-ID: <20241004181828.3669209-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>

[ Upstream commit 5baeb157b341b1d26a5815aeaa4d3bb9e0444fda ]

- After fopen check NULL before using the file pointer use

Signed-off-by: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
Link: https://lore.kernel.org/r/20240906203025.89588-1-RuffaloLavoisier@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index d55521b5bdcb2..892a66b2cea66 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -140,6 +140,11 @@ int main(void)
 {
 	FILE *fp = fopen("ni_values.py", "w");
 
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open file!");
+		return -1;
+	}
+
 	/* write route register values */
 	fprintf(fp, "ni_route_values = {\n");
 	for (int i = 0; ni_all_route_values[i]; ++i)
-- 
2.43.0


