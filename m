Return-Path: <stable+bounces-254173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHJHNo5sFGoTNQcAu9opvQ
	(envelope-from <stable+bounces-254173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:36:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2B5CC5DB
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DC2304B690
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09034B192;
	Mon, 25 May 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHWYfbAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774972F3622;
	Mon, 25 May 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723206; cv=none; b=Jfqd9HkeUzoC44sSj32SHSzOTnDt92CEPChcNBBDVANrjrC4pp7ldXCwlkOU2l6Y5cXIdumpvjWR1bC5ZHPXEaVpbpFhnZJbxwoUTBfw/1IWnXXPCYaHD6wRelWEWo5ezy4mTThF5OwIt8UYBo3YnSGAPk7SKFnG0kSKpjzrv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723206; c=relaxed/simple;
	bh=aDcx+VQmOf2XdRM5Id4fujHLXW4J3bjRieGzK5YzJWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO1gzhQs+qsNuQ8ZkJAX0UCzSv6rwmO6kihe0dga2ImLtM03FOwBQQ9R/sZf/gZJJv9+I3gXbCD6gUETz7IIOs5FIiBTzKK8wh1bJVirXgwHCIK7M/Eqlj00yTsJg9q9vpPsxB4unLVmKdSsHm7w5KxyQh8csZONkM6ap6LSyhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHWYfbAf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710311F000E9;
	Mon, 25 May 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723203;
	bh=LoKP29w67YxAXncqjv5o0wt4C+gh1N3vAMniw9h2o3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UHWYfbAfRgsSgYXACmIRLtxmmW+L4HdSYVD3GkQIxmNOI1uvg/wI16Vy4+k9OT7Cf
	 BgtBx+PwUw1kq0AsYsoeUWTG0dIPuSUJKoUOddshYpuC9Rfe80P7OkYqncXhDxh7gr
	 7+SKtHD9yKzSm6jzYTBlk763JJ2mFY07TyH8CAV2uWqxfXuqbr6sZq9vWkr1fw/J1A
	 OYKSi8vn3PFfpmBKm2rgX1aL6Ijpj2q0AEIB5AbuUjTL0qA5Z+NRqCTkz6PX5mL9lY
	 WuPzlbXIc5YFdGHHKWzwkiMhnAqKvsAEKgG0j64vnnYo8esdNS3xsIZtsHD9mILkQV
	 RbbpHb7GIft/A==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y v2 0/3] ksmbd: validate owner of durable handle on reconnect
Date: Mon, 25 May 2026 11:33:09 -0400
Message-ID: <20260525152512.agent5-0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
References: <tencent_290D1FB4A935031FBD9251D6D238B830AD08@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254173-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,microsoft.com,gmail.com,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6BC2B5CC5DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 06:38:58PM +0800, Alva Lan wrote:
> This series backports three upstream commits to the 6.6.y stable branch
> to address CVE-2026-31717.
>
> Upstream commits:
> - 098c0ac3808c ("ksmbd: avoid reclaiming expired durable opens by the client")
> - 894947e0736d ("ksmbd: add durable scavenger timer")
> - 49110a8ce654 ("ksmbd: validate owner of durable handle on reconnect")

Two notes before this can be queued:

1. The short SHAs in the cover letter for patches 1 and 2 do not resolve
   in mainline. The correct upstream SHAs are 520da3c488c5 ("ksmbd:
   avoid reclaiming expired durable opens by the client") and
   d484d621d40f ("ksmbd: add durable scavenger timer"). Please fix the
   cover letter on the next spin.

2. More importantly, this series adds the durable scavenger
   (d484d621d40f) without its critical follow-up bf736184d063d ("ksmbd:
   close durable scavenger races against m_fp_list lookups", Fixes:
   d484d621d40f). That follow-up closes two KASAN-validated bugs in
   the scavenger code: an fp->node list-head reuse that corrupts
   f_ci->m_fp_list via list_add(&fp->node, &scavenger_list), and a
   refcount race between scavenger qualification under global_ft.lock
   and m_fp_list walkers that races to a UAF. Please include
   bf736184d063d in the next revision so we are not knowingly queuing
   the scavenger with these races still open.

Also, given the patches are authored by Namjae, an Acked-by from him
on the 6.6.y adaptation would be helpful before I pick this up.

-- 
Thanks,
Sasha

