Return-Path: <stable+bounces-230964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHqJJq5TyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:30:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E46D352ECB
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2543018430
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73AB37F73D;
	Sun, 29 Mar 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WX20iqBR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78017225775;
	Sun, 29 Mar 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801812; cv=none; b=WXgXsSB1ZFlQsDsZNX3jWebsdaAmL/WkpuV7LL0L/5Z882i/W8X6cj3jGqEYZ2G5QtPG54j17f4AHkABFhzInxOMvGx+7S9Hil9SY+5F/bc69NjGGWZ9LdcBz6YkeolBQmUnTZP4B9V/0QZETADfo1SRBgIrPhl/H5V5QhNUVbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801812; c=relaxed/simple;
	bh=wTrqNZ6KAvxHuMYghGXn848rhimlN+yguVlRQ1ZjdNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTJKEE6CXYs+eRBUmWEzLl/Q+5G7NHu35mrVfC62TdpDgQg9egbPWnlaQmFaqr5pk3z/qoJF3WJm8io2d2PMheHSLlmoQakjLfYSBjEp3vH9x9BOdXFD9g5Z/6/b9oi5ak7CToewhKQbjcAWSNVUZC5IMEY3+u8FAd3xHAxomro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WX20iqBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED064C116C6;
	Sun, 29 Mar 2026 16:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774801812;
	bh=wTrqNZ6KAvxHuMYghGXn848rhimlN+yguVlRQ1ZjdNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WX20iqBR4LEVwbeKZmMhA9DQnisxAZuZrnqZXuwPh7EThxc4TjpnBrFFYgN/3khzc
	 wz+m3Px3nm3JFY4PYXoxfMNOquBUfSTFOlhxDj6KCm2dQppGRHlv4JNzCrrAnJooLu
	 c2kC3OdPYsRercj9mHHW4mSJMobvV2/S1lI0EhIN4g+eay8Y1uF/qjegLJntFk0vuM
	 E7j62n1i+PU4sCt/A0DXo4wW4uaYEjUE5W+jMPsShPZKfL7VseM2GFQoiWAOoFuUta
	 lzqVEGnpVBx2aXx3Dy0rkrbCoxiRlFZ95FcfvVaHdQZ+x0fsxgN8BM7wKd+6YAZp1y
	 aOsjUjgmtPPKA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Sun, 29 Mar 2026 09:30:10 -0700
Message-ID: <20260329163010.58573-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153346.46881-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230964-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 2E46D352ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 08:33:45 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260329043902.46163-1-sj@kernel.org
> 
> - [PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
>   - status: Reviewed
>   - review: ISSUES MAY FOUND
> - [PATCH 2/2] mm/damon/core: validate damos_quota_goal->nid for node_memcg_{used,free}_bp
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

TL; DR: sashiko shared good findings, but not directly related to this patch
series.  I will separately work on those.


Thanks,
SJ

[...]

