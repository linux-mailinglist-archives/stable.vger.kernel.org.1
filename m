Return-Path: <stable+bounces-191681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8A0C1D96C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 23:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F7564E24BE
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9CE19E98D;
	Wed, 29 Oct 2025 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b="i1tgKkZx"
X-Original-To: stable@vger.kernel.org
Received: from mail.waldn.net (mail.waldn.net [216.66.77.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB6E17A2EB
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.66.77.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777020; cv=none; b=dje60i+i6PNAV3Dk+UmIJHPJ3LTIFEVPZaRKc6gPzilWwjy3veNQQJ7AOls7gieJWDR+NkgsDwgDP+gGoZGQ/TuIQ+gO77WbpA/9sQxGPpFoM+dCDRWHLFLz6TJnpCk/lZT1Fi3mLo8JJZPaRBlmoWN7eZb2UkKPwC/05/1zmEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777020; c=relaxed/simple;
	bh=0rM2DhFoPCe7XAt89YERkepEX5cuBMbS5J9BrX3XXoM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LiLw+eFNzeywIbtwAF1CZiDLbSI/WXWiySf+NkKfymqn0aQaHRmOiLpmVIVtW7f3NAnkz+65dEpWcIaTTqbCAxbWKEfNn/+/+T2+oi+OmzsJzf94NcoBmbYywmvwJ813reb6R8n1Um62Xvl+kwpuyg2TXhTu23KdgBfe9JoxvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net; spf=pass smtp.mailfrom=waldn.net; dkim=pass (1024-bit key) header.d=waldn.net header.i=@waldn.net header.b=i1tgKkZx; arc=none smtp.client-ip=216.66.77.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=waldn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldn.net
Message-ID: <79b19099-3791-4690-8729-de15128d79b7@waldn.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=waldn.net; s=mail;
	t=1761776700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0rM2DhFoPCe7XAt89YERkepEX5cuBMbS5J9BrX3XXoM=;
	b=i1tgKkZxV+QhTizZmLtMLvmeO9Q4sOYMCGgDxyvxzdOvdK2d9FV/i88KzcIpHOmqNhv8Ta
	vKbeRIsEH+TfQYI06cOeXloIUvITNHpMLkmY6BFloLNHQVaw26o9P/nj458BlzSyCzmW50
	fAA+sIdzazOCIvR7P2Yj3A/n7ffR9Go=
Date: Wed, 29 Oct 2025 17:24:59 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: dimitri.ledkov@surgut.co.uk
From: Amelia Crate <acrate@waldn.net>
Subject: [PATCH 0/4] Backport CVE fixes to 6.12.y
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These patches backport the following upstream commits fixing CVEs to the Linux 6.12.y stable tree.

CVE-2025-21833 -> 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
CVE-2025-37803 -> 021ba7f1babd ("udmabuf: fix a buf size overflow issue during udmabuf creation")
CVE-2024-57995 -> 5a10971c7645 ("wifi: ath12k: fix read pointer after free in ath12k_mac_assign_vif_to_vdev()")
CVE-2025-37860 -> 8241ecec1cdc6 ("sfc: fix NULL dereferences in ef100_process_design_param()")

The following upstream commit applies cleanly to v6.12.y, please pick it up.

CVE-2024-58097 -> 16c6c35c03ea ("wifi: ath11k: fix RCU stall while reaping monitor destination ring")



