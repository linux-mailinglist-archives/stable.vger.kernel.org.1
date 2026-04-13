Return-Path: <stable+bounces-235898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II8OKT5x3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 313AF3E748C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9978B303DD50
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B6F383C7E;
	Mon, 13 Apr 2026 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7SMnm+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CCB383C60
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053640; cv=none; b=J+5CdCU7p4Zgvlnwa3hOpDZi3RYGc4nIbPybT8VjOVZc734iBU+Q8hQaGlhgVSQpk5hmOMgn5UmO9MY8Rtgw10DrgHA23olyotT7GTw46i91ihz4ek8I9FYJNGXkcS54q9ksnTXhMyqgzG8GByfj0a7tADYBkTV+bom9Zt7+9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053640; c=relaxed/simple;
	bh=IukMtQnaqlfSQ153F/pXy2LzPZT+GvFOuH3kcayBsOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvPvuG5LdoY11fMn2nxGq+97206hSTeanZO2VJAb1nFqAhgpPp4/Udc1/OM3RH3OB/sz1sniEAB/FohVtUr1DYVY7a7fIzEVdc5Fd+F2JKSazL0h2Ht15GpTOTvvLOxUAeqXn/2bDOfZ1/AbK/DasQ6//szZ3MNFDU/V8iWq5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7SMnm+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37860C116C6;
	Mon, 13 Apr 2026 04:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053639;
	bh=IukMtQnaqlfSQ153F/pXy2LzPZT+GvFOuH3kcayBsOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U7SMnm+pzSljoTh8CRXsd4UCczgn5bOch9wt1aogfsdgh+kNQIwk4JNL712tkBE5d
	 B10Pf8BesPmjRIdCipL8bzxCxgQEHDOiv6AIZQhr3fwJJX5F5yPuERQibrlSyKMW1N
	 1Whsin1KEyjc8vU6uYg5TCHVzFAGQBEwrgLf/X7W1LQPzkOwUH45oo1vOdw/MmUXaq
	 B5hotSOuzjSpvs+HdsIWr3McnbeldegMbAIsWpQ7jetOObrkHGJeS+OuKMfDUY5E22
	 6+qLKLEtFhedYXTDqx8goBftzbboP6ILCcnLgByxTJ0qY12uKoG8Q7brSO9TRnkp5t
	 Vgq/0XxMrOs8Q==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] nfc: nci: complete pending data exchange on device close
Date: Mon, 13 Apr 2026 00:13:58 -0400
Message-ID: <20260412120103.nfc-nci-close@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410082403.2384-1-681739313@139.com>
References: <20260410082403.2384-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235898-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[139.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 313AF3E748C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.12.y] nfc: nci: complete pending data exchange on device close

Queued for 6.12, thanks.

