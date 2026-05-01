Return-Path: <stable+bounces-242524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBneI+0W9Wl8IQIAu9opvQ
	(envelope-from <stable+bounces-242524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:11:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE65C4AFBAA
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 23:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1EB33008CAB
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 21:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381BA3D6693;
	Fri,  1 May 2026 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HE1gDgix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE19316197;
	Fri,  1 May 2026 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777669864; cv=none; b=gf4ew6O/OoDf3vNY9MkzUkSGjERSPc3hQlkBkrGO2bbrTfLGz0oMZv+1LVhxC7R9GcfW4XYeqeTDXoFrG8KLCWCP0zW8N9399uKvCYBOxCUB5U4RPXsVFX2u7IKvdRkC2AaI55ZVX6oPmy4BZorLKKX0Qy6J9MHjMHCifJ/KmB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777669864; c=relaxed/simple;
	bh=pwK0cKnbrke4wl7ygUciECKQPNSG1oPGsGcCARLHQOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHNIi76HOCqpYS8D01MnbDk4hLwnTBxCbNP4QbzXX3HqN79kN5mwxhrSDSql39/RbHghrVPAYSeP9gG9gHBcOceQ4Co6wG3obnNLamXZEjsdj6UVxNPeD6WDtWXNKk7phIk/gv66VI3ukk75RlbY11eKhBwCZdrvDHqrbTNNlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HE1gDgix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6C3C2BCB4;
	Fri,  1 May 2026 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777669863;
	bh=pwK0cKnbrke4wl7ygUciECKQPNSG1oPGsGcCARLHQOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HE1gDgixaTJAPQMMRfjOGc/LY2Jj07Qs9uhRZrbJXn48ZlTT9TLG27AGeeLoxzzlF
	 y3iuOIRilQ2XrWGoBSQOKA7MKIoxjjVe3Vev01jMFWpeeCj8BuVTiG9YxWt1wyRSfb
	 dKtdN3Dt4ECu5rX9rFX7a43vpBETrWhmu1ZhmEJIVqJQqBk1zNbYr4AM8l8HF8v4k2
	 joY8zpHI8WwgEUBgUg7b/SuZHdXmI+O/I25v1AiX0DaFzhKMhi26C2CFn14pp3Gf+2
	 0RBTC28cCGUpeuvV3WyqhkMeNZiI0PktgHHQv7HVFrenYhcIamNspVzgqzQXkPjqNS
	 8hLkmiX4yZoBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rong Bao <rong.bao@csmantle.top>,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 6.18.y] perf annotate: Use jump__delete when freeing LoongArch jumps
Date: Fri,  1 May 2026 17:10:59 -0400
Message-ID: <20260501200000.item004-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501122205.4089260-1-rong.bao@csmantle.top>
References: <20260501122205.4089260-1-rong.bao@csmantle.top>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE65C4AFBAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242524-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]

On Fri, 01 May 2026 20:22:05 +0800, Rong Bao wrote:
> [ Upstream commit a355eefc36c4481188249b067832b40a2c45fa5c ]
>
> The forward-declaration of jump__delete() is added because the older
> stable layout still has jump__delete static-only and the header export
> from upstream c2addca77320 is not present.

Thanks, queued for 6.18.y.

--
Thanks,
Sasha

