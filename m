Return-Path: <stable+bounces-227262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDu3AzzYu2k6pAIAu9opvQ
	(envelope-from <stable+bounces-227262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:04:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B92C9FC5
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C9EA3224C65
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861C3876B1;
	Thu, 19 Mar 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7wF+H5B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0A3C5DCD;
	Thu, 19 Mar 2026 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918017; cv=none; b=H5grbvv24zBE27+VRJO/anEvDIcmvMDa7xyzocrZUM/Uwlr4j7+60nFE7PH5+T6bTa71aaWn4mceVL6eeX6mm3w286NzXkU3PkTavxCjuyPRfBa9X1bmQyVUYw/dsjix2O5W0/5sb8HJgg6brpAD/c1oVFot7Xqw+8dX6s+FgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918017; c=relaxed/simple;
	bh=MBof8FJxF37YeVM6q8qyel1Ver5Rcon2mZ9n85w9do8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RoRGoNR59UjKPfRdfi/Nso+ExQs0YN4za6+be+XyzYZs8aYI/qL3nvsI6DPderf+xvfOrKj/nDTUTvLEdlSNR5KNxYcjb5YYdfVruCZuknlK3hjbe+ADCxnYN/PkbzZNoNxW3ei1iQpBjab0U9Vw4ypM5r2pdNRf+z/PBZWDINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7wF+H5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35122C2BCAF;
	Thu, 19 Mar 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773918017;
	bh=MBof8FJxF37YeVM6q8qyel1Ver5Rcon2mZ9n85w9do8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=l7wF+H5Bo3Vh+VwVYT5cpUORpkk7ozwmt5FWizkVmeGsZnPh+gsB9UVJLKeBm0d76
	 mhM16zE7UKqSbJbVq070t6PcHbDQh40Z0gwRl+QOcCyrJq9mkxgajSLFim6PtpdJX1
	 c8RwjIRT/VNIq/MAt7k4VQFI4FggsnxWUNnxwz9jb6HSr0hengKbUIIKei41KhJHqZ
	 ZQFFgO5xXvMJ1GH6b9WeUgqnQJhPhCQ0ju1SYeh+wx/ukbwRokArXDFogd+0SX501s
	 COWFFeizdmlJ0J4o82xwEfOg4mx5WtHaXxSmdzQbfe9etUJV6xMrpG50e/3ECf7z6a
	 wfu3tPLHPeUgg==
Message-ID: <48f29e10-e9e9-4d07-8491-a4403ace5859@kernel.org>
Date: Thu, 19 Mar 2026 19:00:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: add READ_ONCE() for i_blocks in
 f2fs_update_inode()
To: Cen Zhang <zzzccc427@gmail.com>, jaegeuk@kernel.org
References: <20260318073253.3108313-1-zzzccc427@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260318073253.3108313-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227262-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lists.sourceforge.net,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D1B92C9FC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/3/18 15:32, Cen Zhang wrote:
> f2fs_update_inode() reads inode->i_blocks without holding i_lock to
> serialize it to the on-disk inode, while concurrent truncate or
> allocation paths may modify i_blocks under i_lock.  Since blkcnt_t is
> u64, this risks torn reads on 32-bit architectures.
> 
> Following the approach in ext4_inode_blocks_set(), add READ_ONCE() to prevent
> potential compiler-induced tearing.
> 
> Fixes: 19f99cee206c ("f2fs: add core inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

