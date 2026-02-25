Return-Path: <stable+bounces-218349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D8OL2pTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1418F82F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D08B73134245
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105C20C012;
	Wed, 25 Feb 2026 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BsObK/tf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FA18DB2A;
	Wed, 25 Feb 2026 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983158; cv=none; b=Jm4IqnfPydYcDK83qZoJeDizGqLp+3neEnqfsHVFADX5Gkg0q7ZXRJcEGGlD7G+SjNLiwtK+46a3+moIF5Zzw7XdEPAbJ29vEyHa8JuolwR9ab9YJ3py+iiI7ovuRS2crPnocg+LY2wC3j9xyHrgC9KTugKwLf8vqvvEDe5Rml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983158; c=relaxed/simple;
	bh=9aVD/rrKbEmCYhgyNp3PO8Ooqag4nFee53w+qvQKN4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEuAa26hl5pwINz+BNuUmxzeBcIrVDm84qxz7CJu5K+ekUxX8cZ1rhUR7gnnpgRk6CvWCdQSfhWmKevD3E/1X4N2ItqFUABlKMoi6Idx7BfI0Qfg+UF139DMmvp1VfRGD+uVNLNZe1z3MVF/lRNNmb+kR3Il0OpQSwJ0RIolKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BsObK/tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787F6C116D0;
	Wed, 25 Feb 2026 01:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983158;
	bh=9aVD/rrKbEmCYhgyNp3PO8Ooqag4nFee53w+qvQKN4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsObK/tfTbhIFeTnbJ2hJ6+8K1uUXlSSJpm8C6zTsthTFIVQsQLFF7i1g4S1rBGiV
	 XymMwwugrVv6esSbIf0k+Rrcy0e1cdYkKr+tIolx8x5awJbuf67qwrzZtdvr38R5ZH
	 17JST9Er3NeHkR3rKC0dV9yz+4hdT2bIIKorh2Mk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 312/781] spi: tools: Add include folder to .gitignore
Date: Tue, 24 Feb 2026 17:17:01 -0800
Message-ID: <20260225012407.355212737@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218349-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,baylibre.com:email]
X-Rspamd-Queue-Id: 54B1418F82F
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

[ Upstream commit 5af56f30c4fcbade4a92f94dadfea517d1db9703 ]

The Makefile for the SPI tools creates an include/linux/spi folder and some
symlinks inside it. After running `make -C spi/tools`, this folder shows up
as untracked in the git status.
Add the above folder to the .gitignore file.

Fixes: f325b73dc4db ("spi: tools: move to tools buildsystem")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Link: https://patch.msgid.link/20260209095001.556495-1-flavra@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/spi/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/spi/.gitignore b/tools/spi/.gitignore
index 14ddba3d21957..038261b34ed83 100644
--- a/tools/spi/.gitignore
+++ b/tools/spi/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 spidev_fdx
 spidev_test
+include/
-- 
2.51.0




