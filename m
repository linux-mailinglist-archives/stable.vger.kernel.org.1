Return-Path: <stable+bounces-272407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3eeHAjffTGp4rQEAu9opvQ
	(envelope-from <stable+bounces-272407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:12:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5018171AD62
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:12:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gyMp04QI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272407-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272407-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC4793028EE8
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787D3F54CC;
	Tue,  7 Jul 2026 11:06:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9D3D812C;
	Tue,  7 Jul 2026 11:06:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422378; cv=none; b=FZgWjNWSPsnIRQVRTg59tCMJw8BgyJDXz1puEPMZ623n8Bm8te1HAzr6XXeC10TnXkGm05nOycFRsv7YEmxtve8F20NJdia/6iBoc3iokaZjAnYnPWLuEUsuL1X/rCzhb5E/QAde+c7C4FHxvu4lq2OQE867FhsG73xsPWClzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422378; c=relaxed/simple;
	bh=5oQBslVXVyGoBt+yGH7KL6hP/GNNUnSmmKKmAhRb7hc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=bn8BubqVxSqaBJsALeiUSzomb6m3MXkqxZebW0QB3A6wTDmJwH6z322IwwlhA19HzyLGTvzZ0c+IDb4WGy9I+WlUNulpBVMQQFuPkF/zoOR16e3eSlu2fWL3K63eoYp5Q7mRtm0WOwmTeJ5s2/i3+ZxYZQM8DK1TRUQGVGg6KM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyMp04QI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ACA1F000E9;
	Tue,  7 Jul 2026 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783422377;
	bh=JKxHYicutn9lHYVVegEG1F9eKWFhJlIjTLa68GjK0l8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=gyMp04QITLFRFc5jTjaImw4fF6NT0FHjfTsZpl3YhjEEX+9DzUkH/tskh23b9e6WW
	 LouAB5fIU6xJ+gd/8p8XpuLtntt+xWzybr3l5cb9jM/MxrB9bAjVkdjgn9t4ac4mwF
	 Dh899/mDheHU+6MkH9kTdbEBUj1YKv6BN7KhTP3L60xhM7LUjFLB2M/IpF13ZBGXtN
	 V8NpCTqN5KKS3aKBB+Wi/QEVQzqQCmLOb640Tyk92cE3Z26ncZmpHBdIEwH6imqUAu
	 VbHMZVrr86CCcfS0u50bf2IEcLV9W4elOrfc/ECmdvpr5JjSP5VJvAmYh7N/agUuUU
	 eiwfs3SF7GxkA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] iomap: consolidate bio submission
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
 Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
 Joanne Koong <joannelkoong@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sungjong Seo <sj1557.seo@samsung.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260702102705.GB6252@lst.de>
References: <20260629121750.3392300-2-hch@lst.de>
 <20260701-davon-kniegelenk-gedehnt-96476b242a09@brauner>
 <20260702102705.GB6252@lst.de>
Date: Tue, 07 Jul 2026 13:06:12 +0200
Message-Id: <20260707-geleast-bemerken-zollen-dbee3cf1939a@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5oQBslVXVyGoBt+yGH7KL6hP/GNNUnSmmKKmAhRb7hc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53F166Ypbtvjzjw9+WiVKHlG+m/XX6FyTmpj5sce8O
 nnTXzPzdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkdiojw6wZ5x8nJ71QqAj8
 9VjoeHBFpkEC35eNX9f8zVJvWLzkyGmGf/ZC2Sk2qmXmf45YsK/f37Z5xoTH/OtXd3wKqdp7/+l
 cXw4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272407-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5018171AD62

On 2026-07-02 12:27 +0200, Christoph Hellwig wrote:
> On Wed, Jul 01, 2026 at 03:27:40PM +0200, Christian Brauner wrote:
> > Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> > Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Hmm, both this mail and the merge commit in git reference the first
> commit instead of the cower letter.  Is there an issue with your
> automation that made it miss the cover letter?

Yes, your series aren't picked up by b4 correctly - I always take care
that your cover letter is actually used but the tooling trips over it.

I thought about telling you but then I thought it might be easier to
first try and fix the tooling. So a week ago or so I sent:

https://lore.kernel.org/tools/20260701-work-b4-naked-cover-letter-v1-0-f651c2ffb63b@kernel.org

The issue basically is that b4 expects 0/N for the cover letter whereas
you send "naked" cover letters.

Konstantin is on vacation though.


