Return-Path: <stable+bounces-270058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NPKLGytCRGoargoAu9opvQ
	(envelope-from <stable+bounces-270058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCD06E8637
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 00:24:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jSy9ZMkY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270058-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270058-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28A6D30ED317
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1902F33067C;
	Tue, 30 Jun 2026 22:23:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6526330305;
	Tue, 30 Jun 2026 22:23:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858203; cv=none; b=dhemwWXlJqYOjZnkeK8E25LC75dn0on8EDXeJamnMVasmQ2n4ItODV43LJWrW+QxATO+BLgJCbx3gzloYFuelLp5wls5Ei3guMLBsn6M9GaV//3BmFTn6FENVOS8nmpbD++tRnhcA1xhvSjeg9Bbllz/UXwSXRTzzV0z+E1I9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858203; c=relaxed/simple;
	bh=gMi6GiCXi+5Y44/3AH7W97nckwBFvTYTkOkK8fpCYtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzakwXO2MLaq1oXwDGyxOfadpF0vx16eaR1vn4KNbg1wRexUHtFPY4UW/s4k58892cf3cevw2wPwUu/Fg7KWlXsAKT5NDbOAZCedDLIymbemS2/+R/uDze73rBfw0KL/FQRSyj5MMnlCzPu4Q1fvybQwlsZq65hF4COD5ukhRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSy9ZMkY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F74A1F00A3D;
	Tue, 30 Jun 2026 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782858200;
	bh=gMi6GiCXi+5Y44/3AH7W97nckwBFvTYTkOkK8fpCYtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jSy9ZMkYPkWEsBZpwhkM5S1TvNtkoLu3AsJpOyzM4SXv8U38X8TB/V3r7FyufBzZ6
	 VlJBneWvOI/mb2f0WYS/DPkkC7WNqtU1c4Kf5b5JO8e/DJnPyhRgzkRBUXzxaVKuU/
	 TFuaSpmfKaP+7sw0tsntx11J0HPNDB/jz7CFyuFeReW5g7Uc1byQNpWw6HKq7itlQB
	 Dzv+N0NK/iaSntAxU5YEpHfpSuTcMINrjlZidVu313UntbjRZHBenlUwKl//WjdWyp
	 0Ht7WmLbObPpcsHYZcrTTXtYyPZ+4IMbX+Cl1rSXkT0cv+VyJBlfO5NkpdiusIBfmF
	 72eVEmqN15Vvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	dhowells@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	doebel@amazon.de
Subject: Re: [PATCH v2 5.10.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Tue, 30 Jun 2026 18:23:11 -0400
Message-ID: <stable-reply-item003-ringbuf-510-20260630181642@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630060634.1496989-1-doebel@amazon.de>
References: <20260625054005.0015.ringbuf-510@kernel.org> <20260630060634.1496989-1-doebel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270058-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:dhowells@redhat.com,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:doebel@amazon.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazon.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFCD06E8637

> [doebel@amazon.de: move patch section using guard() macro into a
> separate block to address declaration after statement warning.]
> Signed-off-by: Bjoern Doebel <doebel@amazon.de>

Queued for 5.10, thanks.

--
Thanks,
Sasha

