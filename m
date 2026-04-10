Return-Path: <stable+bounces-235631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HDIN6kb2Wk1mQgAu9opvQ
	(envelope-from <stable+bounces-235631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:47:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2F53D9AD8
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 231423055F40
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8C03DEAC8;
	Fri, 10 Apr 2026 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YZKOcskx"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6F3DE454
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834486; cv=none; b=OFk1pJl4FQGh3rv84odrq3VpDpKcYYqpbRMcOtziqBK275mNPpwefRjl7tQeSrcxkit4Po10ipV0CHutZB3jVdq1ub1JQ8PZeh4G28tT9jfq5adCLWF0ODXRllMArekixdTMT2my6fjwnNKrPeVPLMNISpXR8PikuCy6WNQQsUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834486; c=relaxed/simple;
	bh=xAad6Rg9r8tmoI6uN0DcOLlJLGeuxcOoVZYRaLJb4Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDDHSie3HSeLmrW0+EFipy7q8V+7+F4QfOtgxG55KNTz9j0PfMJdkNVhWWn3UBtNQjdlzJQZg+X3QkmqZ10Rl42cdO33ayYtqHlXq1CGcz0g0xnJvn68moaJEYF3MLs6FZk4FOjrlbSy6JxqGlCamAQ0A4pUALoAiHgCY9wZzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YZKOcskx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-90.bstnma.fios.verizon.net [173.48.116.90])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63AFIoTA015851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 11:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1775834333; bh=SYz4wWr52RDGSWvxm+GF80z9xD6xeY1lNx3crsmuOHM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=YZKOcskxG+RNFUL/f6U98aLr+DXzkdIZQj3OI7aC6mVofalIa8rZgSwIgZaGN1MJP
	 QjE1jEbuppKUTUqS9rssyDA+BcPMQ4nFI/G4hI8uHCjGlOAUHCo+vQnyWtawNsxpqk
	 DKTKSllqNvdiCDTfYg5r+Qg7W2bHr3xqfYOWIukdEm63we1dgqTMzEHe3rKt94cPO+
	 l1eGGW/gc87BVVbrIu96v5EHtCYr0kihnQAP8nAWzIxKvYeTp6Hi0y8/JPADjbasl2
	 zhSUF1cA5aXQiEj6rS+XWgdjVOzwbifkZATG6ZRs4z0/H5MKCbyWwNZYOoQ3KxX3sQ
	 El014pUsHpuTg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 10D792E00E2; Fri, 10 Apr 2026 11:18:48 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, skoyama.kernel@gmail.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        libaokun@linux.alibaba.com, jack@suse.cz, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, yi.zhang@huawei.com, bhupesh@igalia.com,
        Sohei Koyama <skoyama@ddn.com>, Andreas Dilger <adilger@dilger.ca>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()
Date: Fri, 10 Apr 2026 11:18:41 -0400
Message-ID: <177583430881.2758959.6209162016867491519.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406074830.8480-1-skoyama@ddn.com>
References: <20260406074830.8480-1-skoyama@ddn.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235631-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,linux.alibaba.com,suse.cz,linux.ibm.com,gmail.com,huawei.com,igalia.com,ddn.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D2F53D9AD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 06 Apr 2026 16:48:30 +0900, skoyama.kernel@gmail.com wrote:
> The commit c8e008b60492 ("ext4: ignore xattrs past end")
> introduced a refcount leak in when block_csum is false.
> 
> ext4_xattr_inode_dec_ref_all() calls ext4_get_inode_loc() to
> get iloc.bh, but never releases it with brelse().
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()
      commit: 77d059519382bd66283e6a4e83ee186e87e7708f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

