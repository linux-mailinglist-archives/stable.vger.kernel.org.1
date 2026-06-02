Return-Path: <stable+bounces-259879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8rGADjIgH2r9hAAAu9opvQ
	(envelope-from <stable+bounces-259879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AB6310DF
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=g3oKUrVA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259879-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-259879-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6158305D5CE
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C853914E1;
	Tue,  2 Jun 2026 18:21:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B53396591
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424518; cv=none; b=ei9tT1VD+nIQ+BIque2AYqI4q+qJTlhFJFFGBh5V7fwLL0dkO0Cz7jjAvntxEhKcg15cPrxyLlWS4pvXwV65g8FZADklIYqorsgD+OiochuPvvLCIpenDMI7T7diEo9xkU+tVKSgAg69exB8KuCVEwHbJPSu051gkOUP93yQfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424518; c=relaxed/simple;
	bh=baXEPQjezCDzpC0P/8AFVrtXwhk1wdGOYlrPF1rAmr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7XB02T3so5S+jtB9gpO3IaFKspWFz1nFEBwPBRTEmTEcZDuc2uQo8Fv1dD1RnmQZWqrh64i4xlki1SHieJclWzwo3wDPTmtGm5UISbpahGYOh7e/4HAFuVMxvaJ+ZA621ej8AVNlY9CU/a8PXd7ue3p/CPFSlQYuDtkUccq/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3oKUrVA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08281F00898;
	Tue,  2 Jun 2026 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424516;
	bh=baXEPQjezCDzpC0P/8AFVrtXwhk1wdGOYlrPF1rAmr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3oKUrVAAuSS37Mk8slUfKKGgiN3hhIoDiNoH39+0TSqeAalo6cZPtIb2Awdn7her
	 rwoqgGkJi0NBE+dihhyLQ+gFaldar1mcaULbOaY4L91qyiLhnJ26By9EUcdscTQJqQ
	 hbYuarqNTP3+HTBnIKg5EfzezJom3cKhQmljSb9N954b9oFmN8ywUJ+NqT35qz4fX+
	 C6c6oYuLrQyKmVTQmjQHbm6jbUeXs6m0po0+6lrgnUpu4GAzyVzbNG8Fo2GI2m0wSl
	 1tT4eWt1Zz9fdcZQAJ08fVA4QSoT7mC0OtpruYJaY3PlWcJALdNbzU0IKPpslN89jT
	 rKliXc4VsG6MA==
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.12-stable v2 00/15] Backport: arm64: debug: remove hook registration, split exception entry
Date: Tue,  2 Jun 2026 14:21:32 -0400
Message-ID: <20260602180900.arm64-debug-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601102554.233076-1-bigeasy@linutronix.de>
References: <20260601102554.233076-1-bigeasy@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259879-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD8AB6310DF

On Mon, Jun 01, 2026 at 12:25:39PM +0200, Sebastian Andrzej Siewior wrote:
> [PATCH v6.12-stable v2 00/15] Backport: arm64: debug: remove hook registration, split exception entry

Thanks, all 15 patches now applied to 6.12.y.

--
Thanks,
Sasha

