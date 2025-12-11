Return-Path: <stable+bounces-200761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D7ECB4929
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 03:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA7E301B2FF
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CFB1EC018;
	Thu, 11 Dec 2025 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JuafdKBg"
X-Original-To: stable@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AFC200110
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420832; cv=none; b=PVz7/aGozxHs3UrlwB3OQRfMcOe7YJUpvsNjeaS2Hfdm6lfyrOyyj9fZumxNXU4VNe6hE1nJr/w3RsQfJwaTRtaLxbDMDYlmzNZl2bEdTcoQf6vqDsafD9wni7uQPp5uZNzP4slR5AjsR7X1/u4qW+kHermAz16ghsN19l5ck90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420832; c=relaxed/simple;
	bh=aUYaribSlS/Z9B3xgDtILj3lcfCfDXQmdU5lwEBwnoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DJNlx1IBxvjQS09HLcNwcNoze4A0vznpv2X1C8502PWsMpu6hm+5NqngpUX8WO4McLRGRzP46c1ASrWJiI1EymguUSB5CjNOM8sBO/UjvDqb0p9J1aYJgdUTQSH+6uehkp2f4rVkLdSH2x3NHnBk5uSXtmC+7iBR6QWuesKVCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JuafdKBg; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765420827; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dEv+K5zi7bIIiRcnebBBRllym99JrNh+MueU9ruxl/A=;
	b=JuafdKBg2N0vK1GKsF6cQcoaOPMkGCpF8DHlHdgGv7u77HNuM5OG3fDNHusc/A3sD19wnyMoGUv2eLfSAVphwuLHVahRSKbUmEobTunNuh7WG7KTi/s5tMJ7sO0yGzEUPDl6kMdW+8g19nZM88OzGU9jlFCS7LbSSJxxA5dymZ4=
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WuYeY5A_1765420508 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 10:35:08 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: jefflexu@linux.alibaba.com
Subject: [6.6-stable 0/2] mm: two fixes for bdi min_ratio and max_ratio knob
Date: Thu, 11 Dec 2025 10:35:05 +0800
Message-Id: <20251211023507.82177-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have no idea why stable branch missed the "fix" tag.

Jingbo Xu (2):
  mm: fix arithmetic for bdi min_ratio
  mm: fix arithmetic for max_prop_frac when setting max_ratio

 mm/page-writeback.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.19.1.6.gb485710b


