Return-Path: <stable+bounces-245165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HGQEfCgAWpKgwEAu9opvQ
	(envelope-from <stable+bounces-245165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:27:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD5A50AD8B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 11:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9167C306E2D3
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33F737C930;
	Mon, 11 May 2026 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifg8cFZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D62C3252;
	Mon, 11 May 2026 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490601; cv=none; b=BZ0qwxZcwFmAsbccRIFuFAgUA5v+Dl+3EkytIAyIGeqECyTmsJL9XTRAf9HcA/R4Z45eASo33NEv67w7e1Hmw32XJhYSnETrMVNOp2CphnUuOyM6/fZ1uGisfsKhR1HVq3AuYUsOFIHmoLUmw99vLZkoT8WmU/VKO/6oEWmE02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490601; c=relaxed/simple;
	bh=4bwXYwWvMKrxNVbxygkcM9Chw9qJHhERedGimX3TO5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrwrhMrf1FpCr2ECKjI6+xFpqaZO4E3WevUiKuDiZ1SmCjX61t0NAix3308PzpGV6Jxj2YIK/ScvL2Jbgrn2AVbZo5joYnNYNRc+2+i4Yg94yi68ubLCK5AqDycZHTuPcW7f/bjq4cr5QJ9IfNgwDcGiWGeB/agKb/rbhePlUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifg8cFZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A834C2BCB0;
	Mon, 11 May 2026 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778490601;
	bh=4bwXYwWvMKrxNVbxygkcM9Chw9qJHhERedGimX3TO5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ifg8cFZ77aXQ/+l0pvGRib5NweqhXAsaveT0uaeAoIEUV/zFC8UtktMLkLHulw1OP
	 WaqLNK0oWztErX625uV+fEWzRVBRn3nYakMhw9iQkVzG+bJynwn0ZZ60Vtz8xaUJJi
	 UUxmMDGjXc2bPz1x4BfPN9xxoCcJKKLQBRrW37oftJqrGt+ev67bbdSNOZTKoPLL2Y
	 qc4Rc0vX/xO1TujmHymrhCQ0AXaXae6oyAHTXpMZlgbMvPCSmY8yrbVWxj2ISczb76
	 bRrBrMkKLzjvjT6j+2Pdled+kg4+jk/Yd/1JXWjGx1gKqgOV5rLrmweMCfYyGVlSO9
	 7yOX2y52Wv0lA==
From: Christian Brauner <brauner@kernel.org>
To: linux-kselftest@vger.kernel.org,
	Bjoern Doebel <doebel@amazon.com>
Cc: Christian Brauner <brauner@kernel.org>,
	ptikhomirov@virtuozzo.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] selftests/pid_namespace: compute pid_max test limits dynamically
Date: Mon, 11 May 2026 11:09:51 +0200
Message-ID: <20260511-gemsen-geier-8203a30617d3@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422201151.3830506-1-doebel@amazon.com>
References: <20260422201151.3830506-1-doebel@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=brauner@kernel.org; h=from:subject:message-id; bh=4bwXYwWvMKrxNVbxygkcM9Chw9qJHhERedGimX3TO5A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxznn8Xd10qU/ZioWnC87sV2vj391nLNOuk70n2fx3d G9kxN0THaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP50MnwV7qwmf3DyqSl8+8F bTY7pZd9Z0d4r9Xylu4Tlq9DNBSW+TMyLPMRsjpta1Ii4bilxfiM7PSGnIwtnwr9DGuS51crdFx gAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACD5A50AD8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245165-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, 22 Apr 2026 20:11:51 +0000, Bjoern Doebel wrote:
> The pid_max kselftest hardcodes pid_max values of 400 and 500, but the
> kernel enforces a minimum of PIDS_PER_CPU_MIN * num_possible_cpus().
> On machines with many possible CPUs (e.g. nr_cpu_ids=128 yields a
> minimum of 1024), writing 400 or 500 to /proc/sys/kernel/pid_max
> returns EINVAL and all three tests fail.
> 
> Compute these limits the same way as the kernel does and set outer_limit
> and inner_limit dynamically based on the result. Original test semantics
> are preserved (outer < inner, nested namespace capped by parent).
> 
> [...]

Applied to the kernel-7.2.misc branch of the vfs/vfs.git tree.
Patches in the kernel-7.2.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: kernel-7.2.misc

[1/1] selftests/pid_namespace: compute pid_max test limits dynamically
      https://git.kernel.org/vfs/vfs/c/d324c5416a63

