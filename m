Return-Path: <stable+bounces-194795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AECC5D777
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51F4534BDA4
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA431D362;
	Fri, 14 Nov 2025 14:00:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61E31B830;
	Fri, 14 Nov 2025 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128806; cv=none; b=rzRNUaVgf/B/j3jZuoldQ2bk9GtyFBewjg1FTN3UlS+fvQZTXBHrdrz34/GWlgz73AkBQ9sCJbtgoF7EEKvRuih7xnsra0RMK+xR6JGZDbItKQg0XN3/QYivsiK15dWOJPQ4uRUSTWYZGsXRJOk6vrEWebaGeWZh/neGJ7MMxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128806; c=relaxed/simple;
	bh=wfZMD4/54vvvUIDmOjB+PNWNba8+3tUz237bGm1Nlz0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NtrP3tA+DNXDYQADrmfgDoQmso9JIK36heokxVyUMzTNwVCuRLJqgluWfBqgcSezjo8a3zduWAoxdZJ/hQcDbn/WdNu5FKInmwAJ79s6AwzcP1PpqE2kuYHLiIwb9L5Yr4pkDzNV1mmYyCiiAi1EFaXcxpMU15hKdmxDUmdvlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 10373604E7; Fri, 14 Nov 2025 15:00:02 +0100 (CET)
Date: Fri, 14 Nov 2025 15:00:03 +0100
From: Florian Westphal <fw@strlen.de>
To: stable@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Subject: [6.17 stable request] netfilter: nft_ct: add seqadj extension for
 natted connections
Message-ID: <aRc14x3YHACREzS5@strlen.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Greg, hello Sasha,

Could you please queue up
90918e3b6404 ("netfilter: nft_ct: add seqadj extension for natted connections")

for 6.17?

As-is some more esoteric configurations may not work and provide warning
splat:
 Missing nfct_seqadj_ext_add() setup call
 WARNING: .. at net/netfilter/nf_conntrack_seqadj.c:41 ... [nf_conntrack]

etc.

I don't think this fix has risks and I'm not aware of any dependencies.

Thanks for maintaining the stable trees!

