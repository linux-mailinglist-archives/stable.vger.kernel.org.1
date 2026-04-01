Return-Path: <stable+bounces-232698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD2VHlq6zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:25:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD724375262
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1990F30137AA
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAE92E03EA;
	Wed,  1 Apr 2026 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bj2iNJpB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F732D949F
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024588; cv=none; b=qqjX+ar7sED1Or/hle/Lgo+DsZoAbGKtBGbrb973h3J4PP7P0m6H3RqpbLhyR2jU67JtT9SYDO4XSMD3ZFGvJcu8wOv+bXAeNcHkEk9m2/O1xaN9/O0KWJw92VQICDYhEaezMeRIgmDfUmRB2ghRK0GNAMx+R2UtTkG8bQQO8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024588; c=relaxed/simple;
	bh=yyj08EaIhKFqqClLafAv0Grc65mxWyxtG0STvYm6Znw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO6FiEhy1C6FJXpZl6FHG/I8yIRC/qBK5OkYGyojaHpu/xA5DFwYBH0/Jykf3RJzhMyDqeO6wcvJSuOULQkC1I+paQ1aC4FknyGpuf0BjUfixHCWkUwW+LnN8rS+OsQM3OH21PgU7oVLaUs1iqy1ZEA+Ju6Hlb+C+ZXpF4z9WCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bj2iNJpB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso55219095e9.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775024585; x=1775629385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onLR2Z+iKa7puCirK+rttnPhdv4+tlf1MEERiMaPV80=;
        b=bj2iNJpBam+tDNFOX1O4JuG/G6XcC2QETPTsIuZczOHNEeXqVbYDOFAOd7oObuUreu
         D4I4qlCmzqG0YQDcseArHWNA1w4Lo+KpX7Iar4TkwGTmvr4Rz+CxBJ3p9hJNX+k5Kkg1
         p27K9gSdAgDC0FlJtoIb+I1MtlddxeB2Pxp0/pIZeH06PjFEiTgwXxY46zgai0yO8n/n
         XBLg5Z7o10M0NVS8XQtgkNoM49CBPldbmDG0r234/Zf3zfAogD/SBrPdA1yh2PVzLX+p
         N0u+Haua7Xmdp3CoUKa/SkV0/tBZSZrBODsUVpB+4JxobUwDNPO/cu4rjj78psG2cRMC
         kNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775024585; x=1775629385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onLR2Z+iKa7puCirK+rttnPhdv4+tlf1MEERiMaPV80=;
        b=aKpOR3NwPjxcp3DZxoj+RlWXv6fhDIqaLPDV/rvMGNi+QgQhofmbymzZqm1MaqoMlG
         96EhDA/yScHZoVTXRO/2tVEONr2h7KIAIDNs5kUbuxB0kdSruNC4nXO8962wZySMpDzA
         buv04Z36u0n3xOfZyYz2IuM8VNhb1eW6EHW3k/v3sPbPVllSbmMKxMlZnBYcIXeiDz8e
         7/Be4g0oVGYdJl1+uBkueSyvwBuKVe6algBFSA4d9ITd2cKWLSVm2nV2BcG0LozU4Vqv
         AfPjGofDA2vO9NgEYqP0UHG+hFEUKmCvHLFqz3woOMWdNyxAYfl6gnv1d+SomMZSfSRl
         /0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWdkCzhihNKO+Q9KK1VFLydkP6baAHg6aEVFm7jGD6c+lo4x01MdicBYc2no60D7IFMkwyAneg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUgzMcgWBM7FaCdPbcTQ0M8/sCmz6LeLFROBTbM0c6QpJipIVI
	am2ChzJkJleiZPtHfg82EuATkUJ3gyTqtOK8Gsqt/fEKtDyGgC01QklXEzye89TU9Wc=
X-Gm-Gg: ATEYQzwEtjhjb9c/IDtaTP9gXbpQTD4BZlvLioYYoXLldU7rKpdEov6gusj2rbI31M1
	AK5KaefdEWlSa2DM3/0KNmdgQc4B2PN3MhxOicbqCzNMcBbWcoTVf7qpbzi7jYNmgEbT2jzKnuV
	LAp1+WHamruebcEjncc21pK/sYK0vP+kMjaB2t2WRwZfOCSxljTjhVRBbudURvv7SAgPTpyvTpV
	S+ZZDHXDrq5dUHmJGxHm2qpXNCmYPeIjq0uw/arBeKxvNmqwkdDePyBFWRGh8IhshJler9dlO4k
	bNZtnEiolrGIeegsqSuDim2qGTLqvH6/i3YLHfDTPq477mrE8qUPeL96N9A7U1PLDm7fcGonAvq
	/WUp+Gy9KL2diX7r7SXm5veuTW4MbvSm3tl9QThe7+b58IIiXUgla0eelmX1PeQFc5hI3P6zzV0
	zDxaVpT7NeqEQrO/+BhRNUFn1tz9YZKiQaa5gpuBrStn9Zydy4
X-Received: by 2002:a05:600c:1d16:b0:486:fe46:b647 with SMTP id 5b1f17b1804b1-488835633cemr35519025e9.10.1775024585404;
        Tue, 31 Mar 2026 23:23:05 -0700 (PDT)
Received: from u94a (114-140-80-217.adsl.fetnet.net. [114.140.80.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76b5b9f153sm4093110a12.18.2026.03.31.23.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:23:04 -0700 (PDT)
Date: Wed, 1 Apr 2026 14:22:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, stable@vger.kernel.org, patches@lists.linux.dev, 
	Andrea Righi <arighi@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 034/244] bpf: Fix u32/s32 bounds when ranges cross
 min/max boundary
Message-ID: <i4c753x3y67ek3r7dp774pcmaaaid3gvxcsvdssosdingre4in@od45qzitwtrf>
References: <20260331161741.651718120@linuxfoundation.org>
 <20260331161742.960922011@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331161742.960922011@linuxfoundation.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,nvidia.com,etsalapatis.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232698-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD724375262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Cc Eduard and Paul since they know this change better.

On Tue, Mar 31, 2026 at 06:19:44PM +0200, Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eduard Zingerman <eddyz87@gmail.com>
> 
> [ Upstream commit fbc7aef517d8765e4c425d2792409bb9bf2e1f13 ]
> 
> Same as in __reg64_deduce_bounds(), refine s32/u32 ranges
> in __reg32_deduce_bounds() in the following situations:
...

Hi Greg,

This patch is causing the following BPF selftests to fail

  #222 reg_bounds_crafted
  #222/27 reg_bounds_crafted/(u64)[0x7fffffffffffffff; 0xffffffff00000000] (s64)<op> 0
  #222/28 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffffffffffff; 0xffffffff00000000]
  #222/29 reg_bounds_crafted/(u64)[0x7fffffff00000001; 0xffffffff00000000] (s64)<op> 0
  #222/30 reg_bounds_crafted/(u64)0 (s64)<op> [0x7fffffff00000001; 0xffffffff00000000]
  #222/59 reg_bounds_crafted/(s64)[0xffffffff00000001; 0] (u64)<op> 0xffffffff00000000
  #222/60 reg_bounds_crafted/(s64)0xffffffff00000000 (u64)<op> [0xffffffff00000001; 0]
  #222/79 reg_bounds_crafted/(s64)[S64_MIN; 0] (u64)<op> 0
  #222/80 reg_bounds_crafted/(s64)0 (u64)<op> [S64_MIN; 0]
  #262 reg_bounds_rand_consts_s64_u64

The failure is caused by the selftests' expectation not aligning to the
stable 6.12 behavior. I believe the easier way out is to drop this, then
wait for [1] to land and pick it up in stable (or I'll try to backport
and send). That should address the root cause of what this patch is
trying to workaround.

1: https://lore.kernel.org/bpf/d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com/

