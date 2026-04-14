Return-Path: <stable+bounces-237696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9MYWNbmb3Wk1ggkAu9opvQ
	(envelope-from <stable+bounces-237696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE53F4D3F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F5EF3034DFF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE2282F3F;
	Tue, 14 Apr 2026 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="dupXwnHV"
X-Original-To: stable@vger.kernel.org
Received: from mail-108-mta238.mxroute.com (mail-108-mta238.mxroute.com [136.175.108.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAA18A6CF
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776130451; cv=none; b=qj2WiLI+TLAjnONHbokrROpKe+fzNpF4wFjxMEztrd4xMMICIBrSxvla6x7VtweHisnsAFZjrLn2K19DMc1qzL2oVAWyJl1tZVyUPr39FM6m2FWfi384VqBsYBF2HOvMTFL9GtHTym56k6qEcniWey7vHvXQW0TRsvQP1WZOmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776130451; c=relaxed/simple;
	bh=65wyp3E473q3cPWKhu0d8QdZ1vasYZilIoTTRWFWu2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RpbSuNcMJJXqEou04EViyGqZwFmRTNuXws+JnHfLpSfkIT5rl37oF7w9mFQear8vFp6gXuEBch4nbMCTePHxatuDsuEXD5yJcuHf+YHhbe11b42kIeCuCBrgZMq4BuDLCQSLehqXJ6PJHYfxPS3RvvU7d2Jc+bt7I1nG8i6ldM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=dupXwnHV; arc=none smtp.client-ip=136.175.108.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta238.mxroute.com (ZoneMTA) with ESMTPSA id 19d899b1e7a00032bf.007
 for <stable@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 14 Apr 2026 01:28:57 +0000
X-Zone-Loop: 67d596c5fe9af7c7c812f96f96b459a90fb5e9c6f260
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:
	Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=bwKl389HggphIjcNcM0l3ZnumC07Nc1a7tFYVzaVGD4=; b=dupXwnHVPDfUgYYKtZExWs/t+M
	x8XdqKgQld1eaqbj9iu0tFsdQxlZgdl3sHfj+QV9HhCQ6ieVdWM8YOPJP3zw/l+YFubTmv6U9SMJ5
	L4KnsUdo8LCIIcs52KS+081V2G1Vv8o1tUCp/6z2htNdC3/uKyDdKGITEqXFZBo2qjnBJS3n9ZXyb
	Z5h2WdYif6twu44J/KvIa/FKdyGuBKQohFWcl2lA0ZjNLhSPsPHqxVuOLsovyTV6xdrmyDC9q/gfv
	esU7BbHkSIy0su5lsq5UfVB2aQBWrSjUEh+HeFnExiibC0SvO3nXn8OysU8I27VDb50+hcQHe2zyL
	9rbLitjw==;
From: Su Yue <l@damenly.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Song Liu <song@kernel.org>,  Yu Kuai <yukuai@fnnas.com>,  Greg
 Kroah-Hartman <gregkh@suse.de>,  linux-raid@vger.kernel.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v2] md: fix kobject reference leak in md_import_device()
In-Reply-To: <20260413141759.2970973-1-lgs201920130244@gmail.com> (Guangshuo
	Li's message of "Mon, 13 Apr 2026 22:17:59 +0800")
References: <20260413141759.2970973-1-lgs201920130244@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 14 Apr 2026 09:28:48 +0800
Message-ID: <fr4y8h4f.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[damenly.org:mid];
	R_DKIM_REJECT(1.00)[damenly.org:s=x];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237696-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[damenly.org];
	FREEMAIL_TO(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[damenly.org:-];
	NEURAL_SPAM(0.00)[0.142];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l@damenly.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[damenly.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28DE53F4D3F
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

On Mon 13 Apr 2026 at 22:17, Guangshuo Li 
<lgs201920130244@gmail.com> wrote:

> md_import_device() initializes rdev->kobj with kobject_init() 
> before
> checking the device size and loading the superblock.
>
> When one of the later checks fails, the error path still frees 
> rdev
> directly with kfree(). This bypasses the kobject release path 
> and leaves
> the kobject reference unbalanced.
>
> The issue was identified by a static analysis tool I developed 
> and
> confirmed by manual review.
>
> After kobject_init(), release rdev through kobject_put() instead 
> of
> kfree().
>
> Fixes: f9cb074bff8e ("Kobject: rename kobject_init_ng() to 
> kobject_init()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - note that the issue was identified by my static analysis 
>   tool
>   - and confirmed by manual review
>
>  drivers/md/md.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6d73f6e196a9..4ce7512dc834 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -3871,6 +3871,9 @@ static struct md_rdev 
> *md_import_device(dev_t newdev, int super_format, int supe
>
>  out_blkdev_put:
>  	fput(rdev->bdev_file);
> +	md_rdev_clear(rdev);
> +	kobject_put(&rdev->kobj);
> +	return ERR_PTR(err);
>
Why not just:

out_blkdev_put:
	kobject_put(&rdev->kobj);
	fput(rdev->bdev_file);
out_clear_rdev:
	md_rdev_clear(rdev);
out_free_rdev:
	kfree(rdev);
	return ERR_PTR(err);

--
Su

