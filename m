Return-Path: <stable+bounces-262142-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fzuION1jJ2oGvwIAu9opvQ
	(envelope-from <stable+bounces-262142-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7296F65B71C
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g1CCj2tt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262142-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262142-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4FB1306EB29
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAF27B353;
	Tue,  9 Jun 2026 00:52:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B1272E56
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966330; cv=none; b=cyT8QcE5Ky4zaiLdoXEHc7mLWXdHQvF7Xk5BLh5T/KO9AQPyz+IedhftF5AY9U/pXRzYnuOwEUJdKesnxLM+9odHpuqg8GFHUTWtP7ZjH3CLIOVXDjOUVc4T9X8tfpZ5h/W5c/9zXyjdCZaByo83ai7hEI3yFYGb12ALIxEnM4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966330; c=relaxed/simple;
	bh=crSwYXviOeKV5ydXTcXL3L3beLqw5FLC2sglj/GcRus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RW/KiUT+tNw9hYGG0rBLQRCGkY9ZmiRIK2muuY7DEDhEgTXVZsRks6tzqUafW5Xs96m3ga7bgGtlj7Tgu8Jx/O7JHUeOTL6/Ih5JL6mpI2+9Ia/k0Eemgfr9rmqAuCp1+LeeSzYK93llTeQK2OlaWprcjromoKbDdkklB5MnKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1CCj2tt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576C21F00899;
	Tue,  9 Jun 2026 00:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966329;
	bh=crSwYXviOeKV5ydXTcXL3L3beLqw5FLC2sglj/GcRus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g1CCj2ttyN5nY9htFGHY+4f7rhLZ9aZVpxiq3xZYYIa0+O4s0NMwKzUasUXRJ9sKl
	 hJ6H1Ntm3mA5XYj5D3X101KuUlR7vqcpEE69CB13gwUKvLGq8f4bsHoS6A/n5hZ4Sc
	 h4iCZh5gVPe8hQ/gJvbybzVOGX3FSkfZUi42QzZ4M0BNcICEXvbyqYBHnhojBPZ/Kj
	 AZbNlIWCG3ZJLW/XLCAcdH13eLMCL+akYgUXKjrrmzQIL/SmUX4TjAwnSVNB8qaZu2
	 lc0v3tIZMOn9YN1Qb2iQH4yTfjoSAmq1h8vRxX/ONT7UaxirloQqAeGYymZNffL1rz
	 OV6LosHnyihvA==
From: Sasha Levin <sashal@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.18.y] USB: serial: mct_u232: fix memory corruption with small endpoint
Date: Mon,  8 Jun 2026 20:51:49 -0400
Message-ID: <20260608-stable-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aiZlktxkHGdTmi2y@hovoldconsulting.com>
References: <2026060400-renewal-coagulant-3a75@gregkh> <20260604121133.2771807-1-johan@kernel.org> <20260605-stable-reply-0009@kernel.org> <aiZlktxkHGdTmi2y@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262142-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7296F65B71C

> I forgot to mention it here, but this one should also apply to the older
> trees (I just verified on 5.10).

Queued for 6.12, 6.6, 6.1, 5.15 and 5.10 as well, thanks.

--
Thanks,
Sasha

