Return-Path: <stable+bounces-66436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B694EAA8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50AE21F22659
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 10:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAA116EBFE;
	Mon, 12 Aug 2024 10:22:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BA16EB76;
	Mon, 12 Aug 2024 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458134; cv=none; b=IXlLNCuPczcuiIYyH0NOqmFzvTjwtCSgtpNzLPqRMyetIblPcqiqLDFsLxsPYTECr/9V5dVnGd7Mu/m7orCOLtqdejpLp+qvkvUo9Ade1JaxhFPhnkGolgabSICrYnzeT2Pgi8LG+T5S11fb+CeXEmi62k4hKUG+Lbj16G/y5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458134; c=relaxed/simple;
	bh=Yls2oguChm5WEcf10Y8JYO1txSwGLMX82C9U66gn36w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pV1vhmoTlrTzVC2UO+JKmhMYqy/OI53Ma0SfqgpZW5Eq1CUwmMI0jlw1BMPtxFWCVZoJ2y1EaPSR9ed5mQCjOULXSp4KwLh9Whp+zcyMGpd4zcavxH8RzMQBMcUdVz/ON16c11UKdNbiSDsS8B/bqN/8420XlZ5erkFGcBhq23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,6.6.x 0/1] Netfilter fixes for -stable
Date: Mon, 12 Aug 2024 12:21:58 +0200
Message-Id: <20240812102159.350058-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

This batch contains a backport for recent fixes already upstream for 6.6.x.

The following list shows the backported patch, I am using original commit
IDs for reference:

1) cff3bd012a95 ("netfilter: nf_tables: prefer nft_chain_validate")

Only one patch for this -stable branch.

Please, apply,
Thanks.

Florian Westphal (1):
  netfilter: nf_tables: prefer nft_chain_validate

 net/netfilter/nf_tables_api.c | 154 +++-------------------------------
 1 file changed, 13 insertions(+), 141 deletions(-)

-- 
2.30.2


