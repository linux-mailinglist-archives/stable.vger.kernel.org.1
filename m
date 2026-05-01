Return-Path: <stable+bounces-242227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBQLEsL582lo9QEAu9opvQ
	(envelope-from <stable+bounces-242227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABED4A9667
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 02:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B901D303321F
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 00:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D6A264A9D;
	Fri,  1 May 2026 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+fLdPSo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF31D88B4;
	Fri,  1 May 2026 00:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777596804; cv=none; b=o3y/KN7GfVhDDscYisR5jjNr6H4fkevGcHBOdnD6dVMzybcl/CuW5zsrr3JqxH8VCe5+r0m0TTvvXQGN0VdJKEf90et1yyko4zT2Bd0f1X/NC5QzOoHh5VsWu9rOvKUQ1DML9sldU0+tbbxxHs6Za9Zc8a7lLq4qN/2GhNTAuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777596804; c=relaxed/simple;
	bh=nQF8Ykfj8+2QCwIYCJZ21I3zd5B77lm7Ueq+m26Y97M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncw7lC8+ROQBWDPSsm5Zi9f0bKQja1VsIi5IG1sNsHzIvPj5uIdNc1rSuIe+HXN7+DsAxyESr9ZPYmV6F4ylutJJHXPbpsvS3ftUp25nFAyGESGLgTmm57GWelVmB3DW3t/Ww2McRo+332AMBY4K9Y2NEi05C8DpFqsoOnkq3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+fLdPSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A66C2BCB3;
	Fri,  1 May 2026 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777596804;
	bh=nQF8Ykfj8+2QCwIYCJZ21I3zd5B77lm7Ueq+m26Y97M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+fLdPSoHn1ju+dGJ+phcc2I05mJOy2mbsT4Lq1ZmEwhMnDvop0Q6dim8/MZueIwY
	 OpTJBqfazrdzbbZk6WbYyv+EWo+2aJfmDNUSMXENPFwod2TQXlps6crJKWNEzA6OPJ
	 TcXY9Vs5uzTenlGnjho5P5q3YDzsnDKS9W8JaFY9fMN3f7Etmbw6jTFJ60aRdwlub2
	 4XnTJaA6Cyw123aB6YsWdRttdJYiU5x/VcAKywu7ZLszFWqyqnWRz4tyeORjQt8a2e
	 NMFCR6N8/+MlxQ0GFUQy11b3tZsOww/jM2YGkT/P5PwDEOvfHHWbqzXRXyJi7kybE8
	 ifeott33tBAZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Robert Garcia <rob_garcia@163.com>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] f2fs: fix to detect potential corrupted nid in free_nid_list
Date: Thu, 30 Apr 2026 20:53:22 -0400
Message-ID: <20260430160000.item006-6.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430055537.2105721-1-rob_garcia@163.com>
References: <20260430055537.2105721-1-rob_garcia@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CABED4A9667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242227-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,163.com,lists.sourceforge.net,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 01:55:37PM +0800, Robert Garcia wrote:
> From: Chao Yu <chao@kernel.org>
>
> [ Upstream commit 8fc6056dcf79937c46c97fa4996cda65956437a9 ]
>
> As reported, on-disk footer.ino and footer.nid is the same and
> out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
> any potential corruption in free_nid_list.

Thanks, queued for 6.1.y.

--
Thanks,
Sasha

