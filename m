Return-Path: <stable+bounces-268341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l4xPIe0GPWoQwAgAu9opvQ
	(envelope-from <stable+bounces-268341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:46:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B46C4CAC
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:46:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="AnRr/Rd5";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268341-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268341-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D74310C14F
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EE3D75AD;
	Thu, 25 Jun 2026 10:42:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D213D6662;
	Thu, 25 Jun 2026 10:42:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384141; cv=none; b=LBYc43+hhbPkJrcKq2uVM6Qy9Z630agUT05Rbzm+ZIXSYSEBiRYP44dKoASqJfE2NTsgMO6RFH4vDfMe0ISGx+Pa4CzpGDWb7j9y2RLsITgTJZHBih6+ClG2gWUjJ8NEMFMnp9C4VbiQVqYLqMxJPtOC59xYWMXei6Hzkh44a8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384141; c=relaxed/simple;
	bh=+eqO1Mtwi/LEWPGcYOR45C9PwqXsrt9yRzEixp0DRg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHDsri+R3E7JdB/oqwReaURfREJ2lZspPCrqbQdrTjUkNgmMBnqY106F7qPsaOyg76SI1jSQeaXaCWBHFYEHu8+4H8Tanjun6ymHFPhLGXyMu3ybWsB+OfcEbI1p/mHc8RR6dZ2OelpIOGIEtCrCaKuk2pw2ci3G5IWGamYYKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnRr/Rd5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F021F00A3F;
	Thu, 25 Jun 2026 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384140;
	bh=+eqO1Mtwi/LEWPGcYOR45C9PwqXsrt9yRzEixp0DRg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnRr/Rd59pQkrSE/lxaziuX6mKTMn5V7F6EUCH4Ki0TPvZ1eWBpnwYwuRMclphkjS
	 G3Kq3gCY71Zra6xKGRuol9c+lAi3HajZuepmlOKrA6yOIbZqely5Ob39oRmpZv8reQ
	 nzuVETRnYD9Zauc26FytIp1UW9l4ozEGCpsjoVxCyy2YrhwxUN+kpf7rQzblK1yCuG
	 ch0XsTdLw6EprKvnrMnCPyuQRFuxiTalBtO38BumTuBjpgYyg3uHn7Mpr//rZ0/rK+
	 amoLsj58yXd9qcySQtHfR5ma9/6jxHmnsPTQzj4GFDIDNYcFohEpnT/AbZ8AHBEUUU
	 a+1zZkFOEqYMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bjoern Doebel <doebel@amazon.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5.10.y] ring-buffer: Remove ring_buffer_read_prepare_sync()
Date: Thu, 25 Jun 2026 06:41:59 -0400
Message-ID: <20260625054005.0015.ringbuf-510@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624122413.2477871-1-doebel@amazon.de>
References: <20260624122413.2477871-1-doebel@amazon.de>
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
	TAGGED_FROM(0.00)[bounces-268341-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:doebel@amazon.de,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:linux-trace-kernel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mathieu.desnoyers@efficios.com,m:dhowells@redhat.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 040B46C4CAC

> [PATCH 5.10.y] ring-buffer: Remove ring_buffer_read_prepare_sync()

Same as the 5.15 one - I had to drop this for 5.10. The
guard(raw_spinlock_irqsave) conversion triggers a new
-Wdeclaration-after-statement warning in ring_buffer_read_start() on this tree.
Please respin a warning-free version for 5.10/5.15. 6.6 and 6.1 are queued.

--
Thanks,
Sasha

