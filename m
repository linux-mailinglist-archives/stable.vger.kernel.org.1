Return-Path: <stable+bounces-242224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNrSMYD582lo9QEAu9opvQ
	(envelope-from <stable+bounces-242224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:53:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F092F4A962E
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2648F300E691
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0727E1A1;
	Fri,  1 May 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvErAkrR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F89267B07;
	Fri,  1 May 2026 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596788; cv=none; b=XIjmREvc5PLP9J2ORPeXKuPibElDKLEK1scy1K7koGue0D/dN4/7l+JtbuDPT5XrDIIGD7JkgLOGHDzxu3TCA6rAW6W0adNozqLGkFQ7s7Zdjn0z6an7LZtezbnQrPV+Zzh4dLyOJjUf3QUiIhLTg8M+Vy5kxezOVUS3GacftUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596788; c=relaxed/simple;
	bh=d0XT4/t91RskoEJQxzzKgFJMNLW9IouAU7J8aDIYAmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It2HLOkSCuL71ubSJ02ibBPLWro+z7KIYNBm1ZWDTPR8LzX+Ho81raU42+MDDqh6m7moptUz7qvPixSwf/beJgooZ8020alvuphNGounm7EmOS32iwDAXYBUnmOPWHLS5Mcigjvj8zqQyGhYpt0FBmWT0Abs4JLgE+XgO0egjB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvErAkrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F26C2BCB3;
	Fri,  1 May 2026 00:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596787;
	bh=d0XT4/t91RskoEJQxzzKgFJMNLW9IouAU7J8aDIYAmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OvErAkrReBqj9eyP4ir2aJOVzvOro/O1nq6Kgsz4yExaOJxK5Llu+zOelrVvOwbHN
	 c7L3hx7EPsZ8NAYdqaJu2IzaNdf1diLw+GXrJGe2nQfrF9XqUTBsZiKcRx51Y5L8Ge
	 r1DLtt67IZYqxTrX42O626oImVgWzpafNz0zfnCze2uRFaNcFZ8NKS6tHTKYyJ491T
	 r4MZPaT+bkFpoT78G56dG7B0rdumxAzbCwFDAH9m8/s5H+9fTAcxuMyCWFU5kHjclR
	 75DHavrk4gF8/7PMyalAEHEcrZZRh8cwzDw7uv8jxfhQBjgQO8skWa99+jAcfJmaVj
	 8qQXNQapYWNVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Tung Nguyen <tung.q.nguyen@dektech.com.au>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Robert Garcia <rob_garcia@163.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y] tipc: fix kernel warning when sending SYN message
Date: Thu, 30 Apr 2026 20:53:05 -0400
Message-ID: <20260430160000.item003-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429075033.234885-1-rob_garcia@163.com>
References: <20260429075033.234885-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F092F4A962E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242224-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,davemloft.net,163.com,zeniv.linux.org.uk,vger.kernel.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 03:50:33PM +0800, Robert Garcia wrote:
> From: Tung Nguyen <tung.q.nguyen@dektech.com.au>
>
> [ Upstream commit 11a4d6f67cf55883dc78e31c247d1903ed7feccc ]
>
> When sending a SYN message, this kernel stack trace is observed:
[...]
> It is because commit a41dad905e5a ("iov_iter: saner checks for attempt
> to copy to/from iterator") has introduced sanity check for copying
> from/to iov iterator. Lacking of copy direction from the iterator
> viewpoint would lead to kernel stack trace like above.

Thanks for the submission, but I don't think we need this in 5.15.y.

The WARN this fix silences was added by a41dad905e5a ("iov_iter: saner
checks for attempt to copy to/from iterator"), which landed in v6.1 and
has never been backported to 5.15.y. Without that prerequisite the WARN
isn't reachable in 5.15 — the SYN/ACK sends call copy_from_iter_full()
with dsz=0 on a zero-initialized msghdr, and 5.15's _copy_from_iter()
only WARNs for ITER_PIPE iters, not on data_source.

Your ITER_SOURCE -> WRITE adaptation is correct, but since the bug is
absent in 5.15 the patch isn't needed there.

--
Thanks,
Sasha

