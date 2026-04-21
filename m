Return-Path: <stable+bounces-240083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP+nHBA252mg5QEAu9opvQ
	(envelope-from <stable+bounces-240083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:32:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB443832A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E88D6300AC84
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CE13A0E95;
	Tue, 21 Apr 2026 08:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSRUhvVE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816439FCBA;
	Tue, 21 Apr 2026 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760322; cv=none; b=dmrmra0ZZ+kAPSdffHNv6PzgFfV40b0oGhGe3Qmnj/xtYtKoNj5cQQA9kijBZP+cJbHv1gkkfcDX2XpCL/FSfThUu1wBH47Hoobvjt7pdYoy1MaTKTWWrR76kBB5Z345wGLmnu7vksuwfI5QnjNWSST5Nhgu2XiGe5CoSuEtuaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760322; c=relaxed/simple;
	bh=MsUqviCgwVv4hLZvpyZSFEthMC6WAOJaFGnYx96Eb/U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VfwF3LKq+UNukm54ZCmkWX3lj/a99ttnwUv0xQWT/IleDVX5T6912FnLsDkOAFErz+OoWi/dtU577MIY4N3DLkWuxCQi1AUqIw2kwzA0QyktQxMBRxRoxg21B2nCA9JCcKqStTl2Ho74pFTNAUsuaD5DwKMQaKFeUQ+YGUW6puc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSRUhvVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE92C2BCB5;
	Tue, 21 Apr 2026 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776760321;
	bh=MsUqviCgwVv4hLZvpyZSFEthMC6WAOJaFGnYx96Eb/U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=XSRUhvVEpdlQIx5/NNskYUvr5DplRdy9NpgTwtVCadTUYUlZ05VwosFR3Jdby4Mbl
	 vkjRCzK+pun3AvQj3B8rxsgq39lbjzKbUMVSdTkVkh875bKd0SU4lHnqKQCr/PUNvL
	 xSCKF4gEzzwV5scdr+q8izBUqsJlbtfyTBGJMmWJ+tiyc4X2CvQWBzHtlGbGwcOnsc
	 vwWReMr+GkAtSx/qZ8vr/avu2ebeAGECblZF/49BO4aahUkKTkHk55XDQsi9fUhKKB
	 q+xMVu9kMxNw7m2OTdRJ4POwunBq4gssvY0cekEtviXvqeYW2qsOqw7KNLOsoT5Wg5
	 p26t5stHTtbxg==
Message-ID: <4c904b6b-afe9-4ac8-a1d2-47b7c84b67db@kernel.org>
Date: Tue, 21 Apr 2026 16:32:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, LKML <linux-kernel@vger.kernel.org>,
 oliver.yang@linux.alibaba.com, Yuhao Jiang <danisjiang@gmail.com>,
 Junrui Luo <moonafterrain@outlook.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
 <20260421075952.975069-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260421075952.975069-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.alibaba.com,gmail.com,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240083-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chao@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sashiko.dev:url,alibaba.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 19EB443832A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/2026 3:59 PM, Gao Xiang wrote:
> Currently we already have boundary-checks for nameoffs, but the trailing
> dirents are special since the namelens are calculated with strnlen()
> with unchecked nameoffs.
> 
> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
> maxsize - nameoff can underflow, causing strnlen() to read past the
> directory block.
> 
> nameoff0 should also be verified to be a multiple of
> `sizeof(struct erofs_dirent)` as well [1].
> 
> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
> 
> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

