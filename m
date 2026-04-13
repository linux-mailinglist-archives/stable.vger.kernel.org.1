Return-Path: <stable+bounces-235892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO1yCrpv3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA03E73FC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FD11301D97E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5AC38F928;
	Mon, 13 Apr 2026 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hqs0VGN4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D575D383C63
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053628; cv=none; b=OrSg7ZSQC+FlASYFHCOxY1YO8StRzSjl7JdxiF5Xb5aKoHpbicGG+n9SGTxl2jq1B1zQLYAP3fcf/mtykhOAw4wXuC45Gtwd33l7+oItO8jYMgDSKVNkBkOZovYyculIhQhXgBOebiN7GCIb1mYJ2rcj+eTNWklX4BkIjghKexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053628; c=relaxed/simple;
	bh=scttgV0fLHooL9uR2mXjAt4527y6sgQTqcmuU1pslqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6GSkgI6Qn/fMwyyVGVTH2T8gVEy3ogUuRsyyYOFClZgyEBUNv8JQfCvyCJ/Vcji9xcYgPhTcPkGLN/Kyh/LP2kKvSdDu0B1OLojbV2n29nJNcXsXJg2ba96IM+I2irnKC56Oz1Mvoifjoas+t+GkQLsoP5zyceVMKB+0uq9fXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hqs0VGN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E564C116C6;
	Mon, 13 Apr 2026 04:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053628;
	bh=scttgV0fLHooL9uR2mXjAt4527y6sgQTqcmuU1pslqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hqs0VGN45OXoRi90d1V33bLnDX8JLBcmoqc87hF3s3iECvy/0zWgoYOM3s1hwPCX3
	 r++xLJd8J6ERkT1A6qPRe++dYnZqVYhujEM4w/Fte/BJMauqOfBsc+LyWe5C7M4lm2
	 jAYsLY7pFPpUh/IIZxiDASLpJoXXvw04nQzLmd044ck/C0CN9BCzTjfk1bVTMNeSG5
	 fVDd87+QMwJet22QufSo0rGFGjAdn+Nts2eHd1IgrNeLuT0eBbQ601r7K9UpZ8h8N8
	 aB77ZN1FETEQn7ohU0qqZKm2QK7pCNCiNkh1poctKLQff7+HMApctBrP+JiBc+6P84
	 2uz9wycD22Qqg==
From: Sasha Levin <sashal@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: FAILED: patch "MIPS: mm: Rewrite TLB uniquification for the hidden bit feature" failed to apply
Date: Mon, 13 Apr 2026 00:13:46 -0400
Message-ID: <20260412120103.mips-tlb-failed@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040730-expend-maimed-dc2a@gregkh>
References: <2026040730-expend-maimed-dc2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235892-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4BA03E73FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> FAILED: patch "MIPS: mm: Rewrite TLB uniquification for the hidden
> bit feature" failed to apply

This has been resolved for 6.19, 6.18, 6.12, 6.6, and 6.1. Maciej
submitted hand-crafted backport series and they have been queued.

The 5.15 and 5.10 series fail to build due to memblock_free() API
differences and need to be reworked.

