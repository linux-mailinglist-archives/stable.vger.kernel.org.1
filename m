Return-Path: <stable+bounces-249271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOEyEB4QC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:11:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4244756D5C4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 122C830C8BBD
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88EC3F7875;
	Mon, 18 May 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJTxEVV8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986D3264D4;
	Mon, 18 May 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109061; cv=none; b=BgjRMo7OoJQFX+A2avij5KvotBrY5Kz41Z4mWFgJT8qQJwno5uViB2Ir4A2rFrqckrRT77070ICzdWRPZDqhKgH1ESX8E5fZjbT6Ces9GN2jQbvthWvr6OwrMOvlzkANFo6L2Ng0SCPS6hZRV9W4jbJr+Hf2KJJfQWgSpcEwHcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109061; c=relaxed/simple;
	bh=9wHxMzuEvk44O0s7HgBkVCEYuDAVOk7eLty6WzxL3dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKTWaYcPjV7kYtvX/pp1bq/bzWPEvXCQL8xjcKpC+hqpHN78/s3egi14t8czwvhtJhdJ20dJBF3/014BTxsacfhKpYCKgXjxgyx9RvGBhY7amYbXd8WQfvWRv46y7KBCu6aHvayiPbfNaYVgWt1OCcbUKLdoenImus0I2vhPXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJTxEVV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C9CC2BCB7;
	Mon, 18 May 2026 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109061;
	bh=9wHxMzuEvk44O0s7HgBkVCEYuDAVOk7eLty6WzxL3dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AJTxEVV8ruRMuJ3OoW1IeHwMroR1H/UiEmC1hBI1mngwPFkOEUdsI1NNPH/owsIEz
	 gNJ81gOVuAP21cSJ+jNin7Sab4vLqxpMaAXUwTwU8yB1LfOtbkKte8uwlByqBncgPc
	 lwmGJQeeBoALckd83H+LoF7n22aWBKluNjdWXbDjuP//W3kVBv5gA+vFEBNmxatRDe
	 gByuAn2AHbtJzzk8DugWpLj/1h0wBKXTOUQjoR6TmdfwG/FU7w24DgHEqc4C4VdtzV
	 q4UNnogYc1qqmeT4RcnN0t50pKqE9ylB1PV7CpzM3qlPnlAHLV7SlLkitgsYKU6oN9
	 iVy5Hz2PFZDiQ==
From: Christian Brauner <brauner@kernel.org>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a16fb0cce329a320661c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ovl: keep err zero after successful ovl_cache_get()
Date: Mon, 18 May 2026 14:57:28 +0200
Message-ID: <20260518-zweibeinig-testbetrieb-4808ab85ffeb@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514144258.3068715-1-nirmoyd@nvidia.com>
References: <20260514144258.3068715-1-nirmoyd@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=brauner@kernel.org; h=from:subject:message-id; bh=9wHxMzuEvk44O0s7HgBkVCEYuDAVOk7eLty6WzxL3dI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRx8xx4p+x9b+FETjFfn6aQzxt3Wx2WT3unVCXwOUfOL KUjV9ago5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKPNzD8d5p5ncNF3UxZvtCg t1Nj7Yap69Z8ttxbu3PHpd+HTzV7xjAyzOv8nLTwniLfocwrGvLX2W5umLdp62d554oLh50ZXwW u4wUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4244756D5C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249271-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,szeredi.hu,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a16fb0cce329a320661c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 07:42:57 -0700, Nirmoy Das wrote:
> ovl_iterate_merged() stores PTR_ERR(cache) in err before checking
> IS_ERR(cache). On success err holds the truncated cache pointer and
> can be returned as a bogus non-zero error.
> 
> The syzbot reproducer reaches this through overlay-on-overlay readdir:
> 
>   getdents64
>     iterate_dir(outer overlay file)
>       ovl_iterate_merged()
>         ovl_cache_get()
>           ovl_dir_read_merged()
>             ovl_dir_read()
>               iterate_dir(inner overlay file)
>                 ovl_iterate_merged()
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] ovl: keep err zero after successful ovl_cache_get()
      https://git.kernel.org/vfs/vfs/c/1711b6ed6953

