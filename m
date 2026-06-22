Return-Path: <stable+bounces-267695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QqZ0M3wtOWr3nwcAu9opvQ
	(envelope-from <stable+bounces-267695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:41:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0FA6AF817
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:41:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OQxsNm4s;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267695-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267695-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C78AD300B1D3
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 12:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C123AC0D4;
	Mon, 22 Jun 2026 12:41:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBC3AC0CD;
	Mon, 22 Jun 2026 12:41:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132088; cv=none; b=C0lmqNfNcShjGxSmOQIeBaI0KC8kpwThrfitNHonSUlHNz55j++UBtqb3VQ3zZTuo8Q+OvQ7c9qeAkLjJF0+HkU2VwGhX4ouum8wlGVKKCKKbsP3cssCocleoXYmKR6uwVZjl/fpyo6EbLxLNH72ZL7KCZDwU+ssvAE9Uu28MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132088; c=relaxed/simple;
	bh=FZe9L1aOihvNsi1mP/k0gXCo1sbBVdCbhaxSa68d8mY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u8H85hzLt6EEqI5t/icdqYbQxn4WRFHATG4Y1pbIFLFJIiQcvi+zVHpbVjfSp++/83iRimczRM2dooj+h1fS6d+pzoUPQhz07HtM+ayNuuTcODM/XZsvUZIQatPTxMy9hxT1M4rkmp8aAjQi7nQqvuoLaMm/JWOHsWXNhi1cjh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQxsNm4s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C7A1F000E9;
	Mon, 22 Jun 2026 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132086;
	bh=QGutXJ/UQR7Pm54Zrjalv+sNwgnUcPPhvyee6Rqu+sM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=OQxsNm4sn4VTg03ihN8zkLau945H9lhQfIBCQGlPgx9vv0cJ8bERM0oiRpjKgsZEc
	 Y+8RguJhc6DGxueH9X6BguAi3rcBeVta1LzamrGBL80SUOoQAGA0QJhMFjaTqVWrdt
	 IMtvzjTFOVEqHtJ/Ww2nfIV1oa2mzXU1t7nN3m3T1Uqdl5sm9u0iAyHs3w0tf54Qlm
	 caMYYfZNbIjsoXHkbdsZk/iI/jfbrfSM2HIk5uq5B+Rrk9F1Pny+QpuhTNXy3JEnk/
	 5y+NMCQlfsbJRDlDObp4hkrXlNwIrlndMFyEa4b4I9D9mVs/zDLWcvnpYzFQek1BaJ
	 G5HFkoSOdc3Ww==
Message-ID: <41cbc896-016c-411a-bb6e-950e8400ff41@kernel.org>
Date: Mon, 22 Jun 2026 20:41:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Yunji Kang <yunji0.kang@samsung.com>, Yeongjin Gil
 <youngjin.gil@samsung.com>, Sungjong Seo <sj1557.seo@samsung.com>
Subject: Re: [PATCH v2] f2fs: fix to round down start offset of fallocate for
 pin file
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
References: <CGME20260622052831epcas1p205548491ce904c0cfda685ed05fe7cab@epcas1p2.samsung.com>
 <20260622052817.3972188-1-s_min.jeong@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260622052817.3972188-1-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267695-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:linux-f2fs-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yunji0.kang@samsung.com,m:youngjin.gil@samsung.com,m:sj1557.seo@samsung.com,m:s_min.jeong@samsung.com,m:jaegeuk@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[chao@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C0FA6AF817

On 6/22/26 13:28, Sunmin Jeong wrote:
> Currently, the length of fallocate for pin file is section-aligned to
> keep allocated sections from being selected as victims of GC. However,
> for the case that the start offset of fallocate is not aligned in
> section, the allocated sections can't be fully utilized. It's because a
> new section is allocated by f2fs_allocate_pinning_section() after using
> blks_per_sec blocks regardless of the start offset. As a result, several
> unexpected dirty segments may be created, including blocks assigned to
> the pinned file.
> 
> To address this issue, let's round down the start offset of fallocate
> to the length of section.
> 
> The reproducing scenario is as below
> 
> chunk=$(((2<<20)+4096)) # 2MB + 4KB
> touch test
> f2fs_io pinfile set test
> f2fs_io fallocate 0 0 $chunk test
> f2fs_io fallocate 0 $chunk $chunk test
> f2fs_io fallocate 0 $((chunk*2)) $chunk test
> f2fs_io fiemap 0 $((chunk*3)) test
> 
> Fiemap: offset = 0 len = 12288
>     logical addr.    physical addr.   length           flags
> 0   0000000000000000 000000068c600000 0000000000400000 00001088
> 1   0000000000400000 000000003d400000 0000000000001000 00001088
> 2   0000000000401000 00000003eb200000 0000000000200000 00001088
> 3   0000000000601000 00000005e4200000 0000000000001000 00001088
> 4   0000000000602000 0000000605400000 0000000000200000 00001089
> 
> Cc: stable@vger.kernel.org
> Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
> Reviewed-by: Yunji Kang <yunji0.kang@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

