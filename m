Return-Path: <stable+bounces-108129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B9A07C5E
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986893A7EC9
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4A21CA1E;
	Thu,  9 Jan 2025 15:48:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E1A21661D;
	Thu,  9 Jan 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437700; cv=none; b=R61vYsFRulP9c1nQcVPIASpjKkMyWWpk3NnGWjai6Ts8XstkP2GsZ8Tx+I3TT84/yEVf4scioLKaM11XtKCndpppvmaqhTjs2ncxwK/4HIDpoUk/Dqv7JOcuv0MLotAQCoxTRK5QQ3+RTAKy8hmapPrR1ILldNQvQEp3TrKLyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437700; c=relaxed/simple;
	bh=Y2L/9W9mQF+OS3DLscpe9tJDAJ7QTG1cFlGER4uQcEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0+re0eKUbDe0xfsqcil210fLWytiur2AN8BYZkwsDsT0TvKoTR5np8mwaJcI0rBW8UIGm6X5L2fRk/HOHS5lG0CMSOA1vGXdYYIGXxi3Egym+mhT+IVADk5IWmjNPl7MdmABj1JNCUwjBw1A65SzTvJOCuN1oTL8mpC983YrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,5.10 0/1] Netfilter fix for -stable
Date: Thu,  9 Jan 2025 16:48:13 +0100
Message-Id: <20250109154813.43869-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha,

This batch contains a backport fix for 5.10-stable.

The following list shows the backported patches, I am using original commit
IDs for reference:

1) fca05d4d61e6 ("netfilter: nft_dynset: honor stateful expressions in set definition")

without this fix, the default set expression is silently ignored when
used from dynamic sets.

Please, apply,
Thanks

Pablo Neira Ayuso (1):
  netfilter: nft_dynset: honor stateful expressions in set definition

 include/net/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c     | 23 +++++++++++++++++++++++
 net/netfilter/nft_dynset.c        |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.30.2


