Return-Path: <stable+bounces-254672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLR6EDVLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A55E9B29
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3244E305DB45
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5354C3B3BF4;
	Wed, 27 May 2026 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+09WYla"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F13B38B0;
	Wed, 27 May 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911370; cv=none; b=UVNKvl+IDoxeoo8m8/lp3Jde6A9bjCJsRsOTgZl8zqlVA5me2Rs2HJ2myncii6dW73W7iG2h9alamW2EC3KDkb0/ZNoa2KiX9LemQaV0biiC2bubY3VPU5RPzLIU6QzdfkE8+TOfGO36veU5LL5Dbo+cr5udDDBFb9xaxkUsNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911370; c=relaxed/simple;
	bh=iWRnW7c/D4D42UN4Vjjhqv7xCegANtRBrS8sQcvdO/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnCNWNSqtGMIda8ed6syhCR01oJnSlojiTGVkXfALChUd/k1m742LSkKsS4cNL6z7ZVgHAbFndo2BxdIJabyQMZsuleIYK6TxaRjE0PV6fDGTmJ/fRbnL3UtjQksHH+2wc/DZjCO+TMn2tcMDtze3FicHog4QY9YL3kjSfCLuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+09WYla; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C681F00A3D;
	Wed, 27 May 2026 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911368;
	bh=iWRnW7c/D4D42UN4Vjjhqv7xCegANtRBrS8sQcvdO/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+09WYlaSBgJHHHGdns7T/JDeiqCrnLeqJFdAPLR7FLDs1QmmUvhTAH4JWQbD5Y3f
	 ZazmNipojH5Nj18z5v00qzw86HapRRz9cJNqJg4XWiaA/TzdJAPjjm3KMyAnZKQ3oy
	 A+tcYesn6olW0tF6MPxnCJenH5nD6vLu8BCid0kuxrZwZSj7+4BUfpbrfoYZ3PSJ4i
	 PKRkMhID8IJ+X78iKQUFQP2J82bjM3jZvqi6zrPPTXHTEkVqTH1uPBW3WdRaHrc0w4
	 u5+mf8YlyHlRPkVsZ9fYHNd5nHu3vOJWe1MIK7NAnt4sjLD1Sm+580IkgEGMvbmMnp
	 OpXixWGU4M9IA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] x86/fgraph: Fix return_to_handler regs.rsp value
Date: Wed, 27 May 2026 15:49:04 -0400
Message-ID: <20260527-agent5-item012-x86fgraph@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192324.79459-1-gyokhan@amazon.de>
References: <20260526192324.79459-1-gyokhan@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254672-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C27A55E9B29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit 8bc11700e0d23d4fdb7d8d5a73b2e95de427cabc upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

