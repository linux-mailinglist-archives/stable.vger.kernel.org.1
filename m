Return-Path: <stable+bounces-211264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCpeJMZfcmnbjAAAu9opvQ
	(envelope-from <stable+bounces-211264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:35:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA2F6B6B1
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF36C300D338
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6463A7027;
	Thu, 22 Jan 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PD+wxz/F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6D39F331
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101673; cv=none; b=ZCya23VVbkf247AFxVs5lEUMUZ3VRLYAL2OxQZMp3o0ossvfdTwxP0NA50LWhPU0lBp3x6JQrHOlfRPJB4Mw4uGkWhndYPpv1KiZQwcunA5O3eCnZGqv1/XSi/iykOHAVxO7YaEJOF1TiCTOAKSn+RAnuBYpAUTtcikwQahNJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101673; c=relaxed/simple;
	bh=jtDu7HoLkMUkmSfIE30u10ByOinBxuIY0QqQ+Y/+KQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INpze11dFupIlSo6D1tID+YrTJ4sWyZ2BDs7VI/9v03IZQIXubjqin9gBjWflYeQ8shG29ovvgiTByXsTXwxLnwBp0kkap7SEmLAITKgWisIOWtXt9ms4Hmp9dsJsDZnCIn80hghzX6QzsKw9IyJFV4cx3NrRJZAAtTchO9t9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PD+wxz/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDACFC116C6;
	Thu, 22 Jan 2026 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769101672;
	bh=jtDu7HoLkMUkmSfIE30u10ByOinBxuIY0QqQ+Y/+KQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PD+wxz/Fv8e/FybfFSdIkjuqd6+WM2EgqOr/HihrgnduL6PPJ1RutfkDO+5q8uJSa
	 6xOInB7wTNhOrql70gpxMLORpoh52ySnS/JbGTYCqLss69KW15mb9L3V65rDUPhYf5
	 Qrbi+kyWGqW69VHaKYw5NHqJ6vtgSYTi8+8Dh8w0=
Date: Thu, 22 Jan 2026 18:07:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Voegtle <tv@lio96.de>
Cc: Leo Yan <leo.yan@arm.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: Re: Building perf is broken in linux-6.6.y
Message-ID: <2026012214-bobbed-shorthand-da8e@gregkh>
References: <3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211264-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BAA2F6B6B1
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:55:04PM +0100, Thomas Voegtle wrote:
> 
> Hello,
> 
> building perf is broken for me since Linux 6.6.119.
> 
> 
> linux-stable-rc/tools/perf# make perf NO_JEVENTS=1 NO_LIBTRACEEVENT=1
>   BUILD:   Doing 'make -j12' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
> ...
> ...
>   CC      tests/sample-parsing.o
>   CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
>   CC      util/perf-regs-arch/perf_regs_csky.o
>   CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
>   CC      util/perf-regs-arch/perf_regs_loongarch.o
> In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
>                  from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
> /local/git/linux-stable-rc/tools/include/linux/bitfield.h: In function
> ‘le16_encode_bits’:
> /local/git/linux-stable-rc/tools/include/linux/bitfield.h:166:31: error:
> implicit declaration of
> function ‘cpu_to_le16’; did you mean ‘htole16’?
> [-Werror=implicit-function-declaration]
>   ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
>                                ^~~~~~~~~
> /local/git/linux-stable-rc/tools/include/linux/bitfield.h:149:9: note: in
> definition of macro
> ‘____MAKE_OP’
>   return to((v & field_mask(field)) * field_multiplier(field)); \
>          ^~
> /local/git/linux-stable-rc/tools/include/linux/bitfield.h:170:1: note: in
> expansion of macro
> ‘__MAKE_OP’
>  __MAKE_OP(16)
> ...
> 
> 
> Quick bisect showed this:
> 
> linux-stable-rc/tools/perf# git bisect bad
> 64378caea949d24f479bc809f9890cba683bb131 is the first bad commit
> commit 64378caea949d24f479bc809f9890cba683bb131 (HEAD)
> Author: Leo Yan <leo.yan@arm.com>
> Date:   Tue Mar 4 11:12:35 2025 +0000
> 
>     perf arm-spe: Extend branch operations
> 
>     [ Upstream commit 64d86c03e1441742216b6332bdfabfb6ede31662 ]
> 
>     In Arm ARM (ARM DDI 0487, L.a), the section "D18.2.7 Operation Type
>     packet", the branch subclass is extended for Call Return (CR), Guarded
>     control stack data access (GCS).
> 
>     This commit adds support CR and GCS operations.  The IND (indirect)
>     operation is defined only in bit [1], its macro is updated accordingly.
> 
>     Move the COND (Conditional) macro into the same group with other
>     operations for better maintenance.
> 
>     Reviewed-by: Ian Rogers <irogers@google.com>
>     Reviewed-by: James Clark <james.clark@linaro.org>
>     Signed-off-by: Leo Yan <leo.yan@arm.com>
>     Link: https://lore.kernel.org/r/20250304111240.3378214-8-leo.yan@arm.com
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>     Stable-dep-of: 33e1fffea492 ("perf arm_spe: Fix memset subclass in
> operation")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 12 +++++++++---
>  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 11 ++++++++---
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> 
> Is that already known? Am I missing something here?

No idea, sorry, I'm usually not ever able to build perf for any older
kernels :)

If that commit is reverted, does it fix the issue?  If so, can you send
a revert?

thanks,

greg k-h

