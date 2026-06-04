Return-Path: <stable+bounces-260220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g64zBBPDIGq07gAAu9opvQ
	(envelope-from <stable+bounces-260220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:13:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8197C63C03A
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:13:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="QwjD/ni0";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260220-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260220-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80D37309DCB0
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F82AD35;
	Thu,  4 Jun 2026 00:05:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E8AD24
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531555; cv=none; b=olekRsTNQGdkkXXQqdFIrAsc85qYgrF1482KnUORyRxAKrdUnDUiUU6/OwVqSgn3+sssKpqPgJTysqk4WEfh87YpwNeqNhyW/9KjEFcoU8DEshoHsvz40h7IbPUSMooJsgAEm50WOXnpjXHv5KSKzpKf/8wJKOkvoJFpJZNWWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531555; c=relaxed/simple;
	bh=B6epT2lQwuC++n81JPDwkb8AxwZOIA9NyqvwK6q4PdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlHSMOgcEc+VnmFrM3bXLX6bLDbzIBWXXRXh2HeqOs9JwnzPr6rzsv1tFPz6kNJ4GwuWw00ySjM3tv7evQ5RdRZyEiBe3Si5ix1qKRw9FVp6Cc0Jlo7UfP9FggkBAC9NnyqWbCvD8A0KVxhsdzrPox0W2caB8Hbtny9t0LQ87hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwjD/ni0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C4F1F00899;
	Thu,  4 Jun 2026 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531554;
	bh=AJVNEQcpf+g9Bn42mYSJGxbotg4f5LlVkQBVtMJSEdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QwjD/ni0GjaPfop3VpKjqUwgDeHPz1Gow6/PleVlw/2ZW5/16i81HEaw5+Ds3UJSb
	 pxlLGZra4ntLqVmLmafar8zO5w7Rt0cbmTQlMca6Ba+jdtII+lEjnYP2SeeaDyfdpZ
	 IeIuZO/URX3cUQEM07uy8tW7PP7Xe9imXj2cvAtg/M1/L/nlX/UDnkqPEHx/EW9aeH
	 EumEyhGnmOJH51od4uLve5HoBHiLGQ4kMzuE2O0h6byqxKdoe0RhuiGxzyBaH2xvxM
	 TTim8hPP/9VF7+sV12XG4PMbckxDUBUtyRa5kPPWDwYiO8c2xQZ440J62iboS9z+fR
	 e0Q6bmAGHJtTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to DC
Date: Wed,  3 Jun 2026 20:05:40 -0400
Message-ID: <20260603210831.item005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
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
	TAGGED_FROM(0.00)[bounces-260220-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:amd-gfx@lists.freedesktop.org,m:xry111@xry111.site,s:lists@lfdr.de];
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
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8197C63C03A

> [PATCH v7.0.y v2 0/8] drm/amd: Backport FPU Guard Move from DML to DC
> Rebased onto 7.0.11.

Thanks for the series. Unfortunately it doesn't apply to the current
7.0.y tree: patch 3/8 creates dcn42 resource files that don't exist in
this tree, and patch 5/8 depends on dml21_wrapper_fpu.c, which is not
created in 7.0.y either.

-- 
Thanks,
Sasha

