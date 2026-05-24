Return-Path: <stable+bounces-254035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDh4CiwYE2oi7gYAu9opvQ
	(envelope-from <stable+bounces-254035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:24:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38D5C2D71
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 781663008513
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBD3932C0;
	Sun, 24 May 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/U0eU7g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22421DB95E
	for <stable@vger.kernel.org>; Sun, 24 May 2026 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779636263; cv=none; b=oE0auWxFtwcNe131si37yq5tEGxdz7ltT4gnRUPkpD3t16zDAh/KP7scO+MpvJxHbRduZizKjXBllw7gSuS9BATAeIZGgN2R3wG/nEXR5fAgTZBk67X9fkLtZwFAXsyWmhNGbqKYh9R7UwpYcqrJRRt5g6fyIC0ZYXXR/e3pwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779636263; c=relaxed/simple;
	bh=3hWhg51Daki6dTaVI1tqxhVRGPqWaBSF1UF9zmP/ZQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGVSwN9USgbDfCf3r3D6gD9FksIojxdU/7T5czYI60k7H38b+s+9IyNl5l7N+LKGTvmdmnHkJXDQNnp2/BDXLm1Ga9jBZ7/qMpNl932IHh+Z1Jg+k2WALfAy0e1vlKGadC2AOvnaYkU6O0QtZoxk4+Jsmum/KXUxOvEKETChK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/U0eU7g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051DF1F000E9;
	Sun, 24 May 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779636262;
	bh=O7e2fwDNsa2FW8fCcRmY7Rk07ATNq4dRQL/TuMZc5rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A/U0eU7gIkjfAqlMHp2quc7Zql96xm6Ijeal1TZZ8CDVTR3e5M3IEeZIk61wK2o03
	 /yd+XnmOgnO3TwhXS1ddYSz2E1IYJHc9YVXxkjIz3LqLMocoBhuj9Cthx0VxLKTtH/
	 kIWumJXhGYgwXi5c3M3GvMHw6Y7yVxiCFiwk4qIZp2qDi2IHFhaLcVCeOlPo7UWsRo
	 WVzdGJK0C4G8nDcL5ROiqx+dPFHdblHCpWa4q3BKfM143TGoj/rZcvrdThtTqYeATv
	 RKuVdyF5moqY50UFnIuPWNiXdwwvJhc4jtpqMFTZu4CtwSdHwvBnkzkVOkaj4y8KHp
	 ULLpsVwTeEzpw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Jan Ingvoldstad <frettled@gmail.com>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>
Subject: Re: Linux 5.15 bug in vdso_read_cpunode() in segment.h introduced in 2025, commit ac9c408ed19d535289ca59200dd6a44a6a2d6036
Date: Sun, 24 May 2026 11:24:15 -0400
Message-ID: <20260524150046.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524020311.GCahJcXxBMmgUUaWNv@fat_crate.local>
References: <CAEffzkxUELNHBzABxVmekE2C_MFuPyfbsvO33MXZy46pNRU7xQ@mail.gmail.com> <CAFULd4Z5vE7v37+4J5MLCttnG=cF0XX+Y_T0p1yeY36dL6i5Kw@mail.gmail.com> <DB2B5B4C-200F-4C0C-B14F-F58E0CF4078F@alien8.de> <F51A475F-F50A-4DE2-A098-871047496301@alien8.de> <2026052230-obtrusive-prowler-86c2@gregkh> <20260524020311.GCahJcXxBMmgUUaWNv@fat_crate.local>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254035-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,alien8.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8C38D5C2D71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> So please revert it from 5.15 - we don't really need to backport it to
> stable.

Reverted from 5.15 and 5.10 (the two trees where the older binutils
RDPID-mnemonic concern applies). Leaving the patch in 6.1/6.6/6.12 for now
since you only flagged a build break on 5.15; let me know if you'd like it
pulled from the newer trees as well.

-- 
Thanks,
Sasha

