Return-Path: <stable+bounces-76763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF5797CB0E
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 16:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EB392864DF
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79B19DF4C;
	Thu, 19 Sep 2024 14:36:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0345199944;
	Thu, 19 Sep 2024 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756579; cv=none; b=KpmEk7d7nvHS9IbjJYB1SaY1Y1bx0n6bE7YJZYbcbnicllEfWubMSRSKtO7aJe+3V8Uxa7aWXH1tAjG3EkmpoCCLRtlNrPDjCZkG7kxsQJUQUk7HYsQAxf/rrCXQ+QS2sO9ykvmf/T0JlmY0DQTuLvCLUip467l9bkd0/RUcRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756579; c=relaxed/simple;
	bh=cJ8n+/5e/UBLerrWtwDroIiDNnY9kQ1Z0XN3yyVPouU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tuBJZDyHlT+cXf/9Tqo4B3BxkTdDBGbZR1orEndfRbLI5wIUSvZ/lzGmPU+d6+vtysqWQsWPO5ByLamJrrqusv2rX8r7UOWdmmglW71jihduDMjWwlTyCaAw3OMjIFoZh57y894fgY6Rn0EqR7vGRfLPnnwPClQ42PVKX9YWwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 19 Sep
 2024 17:36:10 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 19 Sep
 2024 17:36:10 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Jani Nikula
	<jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	"Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
	<tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<lvc-patches@linuxtesting.org>
Subject: [PATCH 5.10/5.15 0/1] drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()
Date: Thu, 19 Sep 2024 07:36:06 -0700
Message-ID: <20240919143607.14178-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

This patch addresses issues of integer overflow and possibly erroneous
integer promotion in skl_ddi_calculate_wrpll() and
skl_ddi_hdmi_pll_dividers() in kernel versions 5.10 and 5.15.

The problem has been fixed in upstream and stable versions up to 6.1
with commit:
5b5115726601 ("drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()")

Due to changes to skl_ddi_calculate_wrpll() return value the patch had
to be slightly modified during cherry-picking, leaving the original
fix intact, and can now be cleanly applied to 5.10 and 5.15 kernels.



