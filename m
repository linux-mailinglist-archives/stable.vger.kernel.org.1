Return-Path: <stable+bounces-267482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2B/aFJ9/NmobAgcAu9opvQ
	(envelope-from <stable+bounces-267482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EB6A8D20
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 13:55:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Z/Vxz9vf";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267482-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267482-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 847B93006007
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 11:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC23911A9;
	Sat, 20 Jun 2026 11:55:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04489390C89
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 11:55:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956504; cv=none; b=RolWFioANjIXG0els95N79oIgHGVuUNd9niJxXVkw53khIJ1d9tiedk6fJ7uby0MM5bSpL9IYlWYp7UaURYef3vuOw9qsqH7CXQAvsB/kUo8EljM5yOMpeANbYNnSDyoizjNslSaW4xuyVztxG2DDK/Q9OpaUAmM31X70fbbbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956504; c=relaxed/simple;
	bh=EaYi1um3X+IzXwyqK3BP2XZ5W2Wln6zJSk1+9nZnhnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufwlCnEpJ/2Jd8Tt6aIdmNBxExlgyFaEUORmW9OC91PiIiaAa0jGYTbacoKinfOdRX2pnwVCFpwg+h0RHg/OLeWXQ3hdO2BpANBZhQiyRMFWgkplbPryqEcV8CNNlqPcMImOhzSi6EQZbxwRxIFPe7HJXzkxgTYb/Rr//BPUEp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/Vxz9vf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85BB1F000E9;
	Sat, 20 Jun 2026 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956503;
	bh=VtBAO3gZho7FYzOK7qMZXYfn8FMVRriFtcopUNr/VH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z/Vxz9vfAgpTUjRf+uyMn6HZqdKsi5YxGFN0fWUFpo8WPD4bSGpmNRg8NhqDy9eqj
	 D95NLw3JGZqpkEemYILaVFvZWNhKC+Qt7ZshVnvze2uhDzzSn2+31X2x/FGT8tPscY
	 GfFqnBOqxRCCa6MAvP6gRRrtsOlI3nx0UJgw01QplRh8x6/n5EjlKp9oE0Z/6HGy9P
	 mtmg693F1kM/Jb8PE49BA1zSiHQpsSTiRtHfZNSbyVH1qUSOAs7hcG3ism1db00fKR
	 Zkd51dCHYMl7a4C0QsxMKt2lUCUP0h5z/2KJO5jHWN20+StqHQKmOHtGujM592qO0D
	 7vBV+kG16pFiA==
From: Sasha Levin <sashal@kernel.org>
To: stable <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: Please backport d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.") to 6.6.y and older
Date: Sat, 20 Jun 2026 07:54:52 -0400
Message-ID: <20260619.0001.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ajODI0ViiySkNjK5@eldamar.lan>
References: <ajODI0ViiySkNjK5@eldamar.lan>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267482-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:edumazet@google.com,m:noamr@ssd-disclosure.com,m:steffen.klassert@secunet.com,m:nicolas.dichtel@6wind.com,m:kuba@kernel.org,m:ben@decadent.org.uk,m:carnil@debian.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 813EB6A8D20

> Please backport d289d5307762 ("ip6_vti: set netns_immutable on the fallback device.") to 6.6.y and older

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha

