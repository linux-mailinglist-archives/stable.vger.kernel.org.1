Return-Path: <stable+bounces-233154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OR8Ll98z2kKwwYAu9opvQ
	(envelope-from <stable+bounces-233154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 10:37:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986A392304
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 10:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E22304E0F7
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 08:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53464;
	Fri,  3 Apr 2026 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5orOPlG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0482E1F06
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205087; cv=none; b=IZmByk75xrtoyRXSC5JUAtpLCaLwX2ZnwG2Zpna28IT1Ml5WzIQiaYYXb/bHtnllB31cTe6XRjyhMISqLSG816t7kRhpjjeOVJQYY/oSo4Fep6Fs4nrRJy6N1CS2Ob6jgvN3qGoV04kszWhv+FBKPVhggufQjzJSxvhQH8OT3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205087; c=relaxed/simple;
	bh=GIYhFPGcWs1WBugRAJoUDfnh3yIu0fFeanjo8LRgJTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWgtVvGmqb32wy0I/Tctzd6VyELm/NMavmSY1l07Tw8MeJE2I4WewsjPV1aDnnqWTE0BuYSBlVSjernpTkXuWP8JcXMPyRRZNNZ0Unrb15peteop0QwAwB0m//SZGv87cIeBPBnan4Pq9XPPxt1Hv3MjSJnA8qMEC+w7zpndOcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5orOPlG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so15234615ad.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775205086; x=1775809886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPHnX95L4zARAb9iKb7/VH3eLKj/XM5UcYBpATOx7fI=;
        b=C5orOPlGYsahPbArsgy8ugIB47MFfj6EXAwwwpA6DtcdIdG/wVNYjE6yUxnzA0Qwol
         4b50DZHszXPHQBVC/W5ztPTfOgg4/agaIMrkbgJrwXbWkJEGjlOWLqHKqpMjdsQJ4+EJ
         gpv70PYf8JUqarSB80gG8FX/h5ldf0CZs4zNVsQhgKZe2m2KRMq4Yp3t7LIyZqBIzA7f
         hu093agxTFB/0M9wcWpchUd+/8myDapKCLHGueP6mELdKdqY0pvchuUrxL+htDNcjAME
         Y4Cv0PjkNx+7Q1huaJryxQaACZADOHzHSVuWm0JIDPEvojiQ8LVgaXOiHOiB7RTdHXM3
         QiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775205086; x=1775809886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPHnX95L4zARAb9iKb7/VH3eLKj/XM5UcYBpATOx7fI=;
        b=ZNupORfJ/zJZ4icHGek8h6iO2rUAf+YC+2/hxiXphgKg9P0k8heuAXP9JKhfBY9Wnd
         VzdoR27307OEwcCYASbMUHLwlKS/dPd1sXECoGpoO29dFN9C1e61rYBZTK1cdbTfFxjf
         jTbjy102NUYtmnGapGKLiPcBxNNFnlxNy5iZSJZo1jZJO7adbPJh8WTb8Pp/RdAGbVAy
         zappUz0266XqxsA3rpf/MqTMkoM1E278t91/svejJibUQP8CXPytpVLjpvE0ucbdyNpF
         +YQRk9l1FkIYpL+11uKsIJKLcB7d3wf8fo0GyLJUmpiRNOPaxPVHZpFW6fDvy+cMC29S
         tOIA==
X-Forwarded-Encrypted: i=1; AJvYcCWWHwciF2Zwh5ZfSavfpsL07i2mReeQE0pWTKWKTSnWHRLE27eVnKJug7kYH3q2WTSXFRoKwq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK6RvvLLsBFLlZ8fQrqmzwn52zDQS8EiJ/6xHiQDhualO7rv8
	nEBn4GFunO0P/TsKCdS9h8/7XSAhVk30d+Q03V4rieFX/OMloseJ+Ocf
X-Gm-Gg: AeBDieug57uWK83pqDMQZAKWTk3smc/5ZWvTHFw+JuKXmZ5P1ehoWaiSiCxyzmEsnx4
	UuF4ZM3J+Hf+KgjpLPJ8FwnJn0wToceqZuo6nWqpapyHikLm+hd0xOxJrikmfLh0vv9Ou/fXtAC
	tP6RQ1LPo4T98bxyneNbmwd71M1GIMrZCI4obvFtB3WxLVhNIG26XeO/OMy8rtPkgIO8MNyj403
	q6GDxQhY9qMg7QTXXH1Px6Ydg7mMEI/ZiszkXKOz45OxQRgQK7AXB4MANaLMqePihggdkgnZxkX
	r6zel/d2SVID1otEojgRJA/VHMwMdB4S/l+tBkgQWyj4kBHg1WLDG45eeNqfFOQ13zmf9pBZo+Z
	teH79oEVVTGcLHrNZq3PphVF2mk5HY+528hZrp3EDI6Z+MVID/zYAsidWBrnHBtq5Zh8V/iIyZw
	6QQpXUoldyPO4cxbAUe69shbrl8+2GnuVdmER74OZSg1iutuCw6mc=
X-Received: by 2002:a17:903:4b07:b0:2b2:51ed:4522 with SMTP id d9443c01a7336-2b281833d68mr24607425ad.47.1775205086057;
        Fri, 03 Apr 2026 01:31:26 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d280sm54193015ad.17.2026.04.03.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:31:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	stable@vger.kernel.org,
	yanquanmin1@huawei.com
Subject: Re: (sashiko review) [PATCH v3 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  3 Apr 2026 16:31:25 +0800
Message-ID: <20260403083125.5654-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403052837.58063-2-aethernet65535@gmail.com>
References: <20260403052837.58063-2-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-233154-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aethernet65535@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1986A392304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260403052837.58063-2-aethernet65535@gmail.com
# start of sashiko.dev inline review
commit 525a0116b6d91612e679b30ae84e489a7540edbf
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/lru_sort: validate min_region_size to be power of 2

This commit adds an early check in damon_lru_sort_apply_parameters() to
ensure min_region_sz is a power of 2. This prevents kdamond from unexpectedly
terminating when given an invalid addr_unit.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 554559d729760..3fd176ef9d9c1 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
>  	param_ctx->addr_unit = addr_unit;
>  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
>  
> +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +

Instead of adding this early check here, could this be resolved by fixing
the stateless validation in damon_commit_ctx() directly?

Looking at damon_commit_ctx(), it currently sets dst->maybe_corrupted = true
before checking if src->min_region_sz is a power of 2:

int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
{
	int err;

	dst->maybe_corrupted = true;
	if (!is_power_of_2(src->min_region_sz))
		return -EINVAL;
...
}

When this validation fails, it leaves the active context marked as corrupted
without making any state changes, which causes the kdamond thread to terminate
permanently. Moving the stateless is_power_of_2() check above
dst->maybe_corrupted = true would resolve the regression for all current and
future callers without requiring duplicated validation logic at every
call site.

Does this missing validation also affect mm/damon/sysfs.c?

When a user starts DAMON via state_store() -> damon_sysfs_turn_damon_on(),
the code calls damon_sysfs_build_ctx(). This calculates min_region_sz and
then directly calls damon_start(), bypassing damon_commit_ctx() entirely.

Because this bypasses the is_power_of_2() checks, kdamond can actively run
with a non-power-of-2 min_region_sz. Core DAMON operations like
damon_set_regions() use ALIGN() and ALIGN_DOWN() with min_region_sz, which
perform bitwise masking that requires the alignment parameter to be a
power of 2.

Could this allow userspace to trigger incorrect address boundaries, massive
unsigned underflows, or infinite loops during region splitting?

>  	if (!damon_lru_sort_mon_attrs.sample_interval) {
>  		err = -EINVAL;
>  		goto out;


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260403052837.58063-2-aethernet65535@gmail.com
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260403052837.58063-2-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail

