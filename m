Return-Path: <stable+bounces-211938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBYwFerQeWk0zwEAu9opvQ
	(envelope-from <stable+bounces-211938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 10:03:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1F9E9B5
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 10:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DDB0300722A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01933C515;
	Wed, 28 Jan 2026 09:02:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974033CE83
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590954; cv=none; b=QFzmVRAmsLjHbqfVjBHhpWn5zd2ikZYH5HV3soQLr7Q0brXZKvFi6y/zxHTiuuFkrF2fYX5uZNRX56U8zAz0rrvyu/sTPL6tCQMtu9O5S/Tu9DPAR3Q0C1YVsveHwAlzhQanwgxkWkowfSG0PuklDxCdvpvB1C97sKep9OsEN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590954; c=relaxed/simple;
	bh=EZz+pGtBTRFMUHeN7JwNEPsyWIh/kR7Xa0eLxtxIZw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auOJLBhNddzKo0RWa0cF6vPLQw195pGcFeXaQD02VE3jrX4yWnti2S3R9CqlXAqOESQazUc7HVe/x1iIfbfp2HzPgVe3gw5UtuwdPpD5GwAkjL9mp/HCA0bHDEoGORcUODkDAXkDJd5pMKGQ5Ku1yLyxPMueD2N3b7X9HTrkDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD3951515;
	Wed, 28 Jan 2026 01:02:19 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6F673F73F;
	Wed, 28 Jan 2026 01:02:25 -0800 (PST)
Date: Wed, 28 Jan 2026 09:02:23 +0000
From: Leo Yan <leo.yan@arm.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: gregkh@linuxfoundation.org, irogers@google.com, james.clark@linaro.org,
	namhyung@kernel.org, patches@lists.linux.dev, sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.6 176/737] perf arm-spe: Extend branch operations
Message-ID: <20260128090223.GD1339236@e132581.arm.com>
References: <20260109112140.649989422@linuxfoundation.org>
 <20260127183832.458213-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127183832.458213-1-hamzamahfooz@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-211938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leo.yan@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,e132581.arm.com:mid]
X-Rspamd-Queue-Id: 71E1F9E9B5
X-Rspamd-Action: no action

Hi,

[ + Arnaldo ]

On Tue, Jan 27, 2026 at 10:38:30AM -0800, Hamza Mahfooz wrote:

> Hi,
> 
> It appears that this patch broke the build, see:
> 
> In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
>                  from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
> linux/tools/include/linux/bitfield.h: In function ‘le16_encode_bits’:
> linux/tools/include/linux/bitfield.h:166:38: error: implicit declaration of function ‘cpu_to_le16’ [-Wimplicit-function-declaration]
>   166 |         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>       |                                      ^~~~~~~~~
> linux/tools/include/linux/bitfield.h:149:16: note: in definition of macro ‘____MAKE_OP’
>   149 |         return to((v & field_mask(field)) * field_multiplier(field));   \
>       |                ^~
> linux/tools/include/linux/bitfield.h:170:1: note: in expansion of macro ‘__MAKE_OP’
>   170 | __MAKE_OP(16)
>       | ^~~~~~~~~

FYI, the fix has been sent out:
https://lore.kernel.org/linux-perf-users/20260123-perf_fix_bitfield-h-v2-1-cc8f8752607c@arm.com/

Thanks,
Leo

