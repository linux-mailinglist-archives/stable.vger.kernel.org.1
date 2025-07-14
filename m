Return-Path: <stable+bounces-161858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96ABB0438C
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 17:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063CF169EBB
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF225F7BF;
	Mon, 14 Jul 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kvjeKv1d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745A825C80F;
	Mon, 14 Jul 2025 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506291; cv=none; b=QJoCZm60ZFJoZx8gA2iZXqd8+X94syulpSfiKGCL0VdsJiyOz09ayvkLNLYquskfCs+5kSJLVxAJK4ZCe+KTO5s621tZJUfezyBCuthz+dplcFekoCvokWfMijPQ7a9vKwgwJR5yFy5F6jZyQUNuZlSZmCjHzeGJhyhmyllWvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506291; c=relaxed/simple;
	bh=YQNJzHsd/OXWJqO4c6xt6k/KmRNCXgPXJxE60fJeFzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwiJmB+gj9xL0IifSdYipz0/HKf/S/8udrWh2oIguBsJHon1rB6F/CJgwRdQj/IWVUbyHohi8IiTRSp+yJ1lxl4gegnRQMTdYSkfQXKwtZgHWA40tI3twoQ6aJ3XKMGkAddVCtotf0xd1mkylUtIwJ4Xu9beFKKKvXaqLelPvaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kvjeKv1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6786C4CEED;
	Mon, 14 Jul 2025 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752506291;
	bh=YQNJzHsd/OXWJqO4c6xt6k/KmRNCXgPXJxE60fJeFzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvjeKv1dJQtLvVAURmKrJ9VXnp6/yNtO4++dWb5DcyogLYpwynDQWpv95evE5J71E
	 TdkCS/vDzfCc3Ty0tcRzzgOWtoFCfgXJxDJBMAiKwAl4fNmDm0G0OfvRupr8Wucoxy
	 A9dXYpLdCaELzs917AB/52dQCgkNK1ZuDgqGv6r4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.98
Date: Mon, 14 Jul 2025 17:17:59 +0200
Message-ID: <2025071446-kindly-italicize-293d@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025071445-sphinx-cleat-851e@gregkh>
References: <2025071445-sphinx-cleat-851e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 9d5c08363637..0bb5c23c6406 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 97
+SUBLEVEL = 98
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1180689a2390..f6690df70b43 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -547,6 +547,7 @@ static bool amd_check_tsa_microcode(void)
 
 	p.ext_fam	= c->x86 - 0xf;
 	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
 	p.stepping	= c->x86_stepping;
 
 	if (cpu_has(c, X86_FEATURE_ZEN3) ||

