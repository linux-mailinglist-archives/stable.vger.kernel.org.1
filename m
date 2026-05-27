Return-Path: <stable+bounces-254669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FVRGvxKF2qaAAgAu9opvQ
	(envelope-from <stable+bounces-254669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD655E9ADF
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C96973075FE0
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D83F3B2FEC;
	Wed, 27 May 2026 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzeo38co"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5A3B19DB;
	Wed, 27 May 2026 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911365; cv=none; b=Ow1xmaZkgD8oS1Hnqe8k0aF9Xah43jMSyXkhb//LK08jqZxCyIoqBFfHwJp4urv2XqVwEI94Il96ATj/hubFFEJcp4IKDgqesedPca/YDL6V9HYNnRlQVDscKKenal0T1i/SIcCXH5C4fMDwC2HEaVfRJcqlx4nqetzv2kIilbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911365; c=relaxed/simple;
	bh=Jb5QGemEzr2Ow1OIBgpTeZj0Wu1VSG29ghYR1AhhT1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRdpxby32kj0G1sU1mPNhR2smJjH6HkXjFhbtviZc1dNCw4tsEav6JaKX+TMWjQ+puvTGGvCqRmuPkqgS/Q3hPYIBorg1KN7soEyIs5OefuSdhsuiO4ICCyCFZmDay2SXqzNfPSiE0sfaoxVy6l2w9i4tsGaKLHPSs8O7EohPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzeo38co; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4661F00ACF;
	Wed, 27 May 2026 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911363;
	bh=Jb5QGemEzr2Ow1OIBgpTeZj0Wu1VSG29ghYR1AhhT1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mzeo38cohRcK7fyckwGGR2eKTLeVuZOhfsYenQX832D3pQhjRz2Pai4Af2GAPGRYS
	 8KmSnp57fZ1Ohqr3r+I+A7SkbdlCubw9Ja/dwXR0m4m3m8tKA8pvxbe4Pg9TA/fLcG
	 LL+pQxFIneGiRNuu2piqmX5yxr+8AKt0nsuWhfVtq7mPoM0uSb+bLKcxRdzYXbvhrV
	 zGWnCJn9gUxYc6d6PrmlLoeZ9n9YhVKkgEnSB38NtDjmAZCZltQV0KGllbKEV/s7H0
	 dCV8Rg3ezHMaYyutbbegHc9WG+j4ZGVg2lN20WfuKnriFqmfH7oTap+awPz+rHYftZ
	 dOK/6eMt1YhHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	yangfeng@kylinos.cn,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] tracing: Fix the bug where bpf_get_stackid returns -EFAULT on the ARM64
Date: Wed, 27 May 2026 15:49:01 -0400
Message-ID: <20260527-agent5-item009-tracing@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192012.76223-1-gyokhan@amazon.de>
References: <20260526192012.76223-1-gyokhan@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254669-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1FD655E9ADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit fd2f74f8f3d3c1a524637caf5bead9757fae4332 upstream.
>
> When using bpf_program__attach_kprobe_multi_opts on ARM64 to hook a BPF program
> that contains the bpf_get_stackid function, the BPF program fails
> to obtain the stack trace and returns -EFAULT.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

