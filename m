Return-Path: <stable+bounces-238247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLlGBVtt4GnDggAAu9opvQ
	(envelope-from <stable+bounces-238247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:02:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C491640A421
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 07:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 525CB309862B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2263FCC;
	Thu, 16 Apr 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVVJtGBu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6514418DB26
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315733; cv=none; b=IYVroMF8jlRhZte1dhEUOtTbYPoZ68BVZvYgnXlswskbg5gFhJukczaswaplIQfNayJ2Tv60Y9Ve18y5kMNPzZ6xRmtKegsHN+pShSg9gXi9wEoz9QYwp+s5HbwMYdh4PeQZRgJOtw5YPhuNPzd+HdmZ6s4RywioqJwVNMbncjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315733; c=relaxed/simple;
	bh=Qw8DxF0aKSi2cgqXR2ywTjiOu/drTOFeZ5oRUKpwNNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cppc0EkGHovasMYWoQJcJ8aohMZF2yR/koMzo72McNk7iADNkLGntnddEOQtwd76bCYGO0NP2Y0H59nAUptr/NMaHkIzWUPMvuCFp2KPRmp4ARNbdNAj+AutG+fuGuzubQ1BGQUyNdxmb686/FcilkM5yWVk6ce+ZM+b47h9scM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVVJtGBu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so7603858a91.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 22:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315732; x=1776920532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8w0UFz50pwCfEEFsCgc3fUK9YMukoigInppvLm4bqWA=;
        b=VVVJtGBueEICVmb4JaStNIsW55v3ukBW7uMeL0I6M6DCJAzr4/gDrWZpu++VSUq0x8
         HWtm7eF84pP3nstLiVQcfV5zkBzuNt2c9krcKbLry7RTpROm09g2EtSeXgszRMSTfkEn
         Sz3S1/osfhmbfnJr/HrcP20PPNrKYZ7XzSTFy1qOraDTMf+nsyP4nw6L6eJ7C8MUQ3HU
         3HPFpx7y/u/uGh2J6IE8DL56HgQ6Fj++UdGVnqoTqHWGXhWLJXg+CsuZYWaRicR0v1E8
         uj9WZfoOZoGRFN3WaOvE9cRkB1MEJNHUES1g39B2rzb2cNwp/yq8ZM9YUGXYUXgLXV94
         xKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315732; x=1776920532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w0UFz50pwCfEEFsCgc3fUK9YMukoigInppvLm4bqWA=;
        b=ZBx3NJCCSITfLzl++7VdCcOTavlNQOOcJjiQiGBneKQWnn9bfmGPvkSVw2jU4j8iMh
         +gSDW02kteqODx3+fhnoPfkXusK+1WQiPADTUeT7u+fJ2coj6I7AUTj+OTi5O8/oODeI
         EV9v+ghb6GnqgyOphjcz9/AuwEHzWJlIOAe0rVuijHB0s66xLYJbBM5BtHy3RUiNpore
         HF3s5LU4S42mS0ki2L6OI2NQK8XPmLVIaGG374R+44iBMQkhDO3bYQJbvWi2CtKVuNj0
         oG1b6MT6nMFeY/4BZ4XVvbR1zzT/tPRGzlDpEKw/q+uQChDGvAs1BhoQw7c9HY/BCMPt
         p4Jg==
X-Forwarded-Encrypted: i=1; AFNElJ8JyCxYsqJegt1p3G29FNzGNXzvvPu9oI/lHPvqQE/yxcOjvrz8mvUrzf6OVnXHw5Dtmj+GjEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxhND6Xc1jnoW6DRAj1yTOvlW93v8ns2xb+2NJSrub6+Agk06s
	gkfpIR0QFm3iFOZluZh+c+F9j/FbZO19tdF4sUdRiiOsrE2+18lEl6Rr
X-Gm-Gg: AeBDietiijUUnbW4qg1EnoVyxaxej1vQeio6PdMXyajq2tzNUQRi4YP/HmBJPnB9aIT
	YDLcaTwmixwpX71xYN/I5eo6leUvIhKQG2idMzqWiM60FI0bK2A8Kb+LFR05MZ+tA13aKo+z4it
	6Mxqzw+o58Yz1yK1GbqkFNu5WYJ6XCdBs6zkyVi+5NJyIM5fmcDgtKjElN7KNyqygNN0eaRIMTY
	r70VG66NXOO9hWEWBMgDYzaJz0lfBAB47ImTm4V35/7ph0NgjOC90x1e9X62EfFyIT08JKLaBeP
	1trjXJsvNwfn9Ox3X3UZUeYFvWcqd5Kvqnj+P5k8Ib7/a+Sd1cMHlUT5TnURjFun66xh//1JVcW
	US03cHHZlyBHugkB5zVH+OXBQzgK0IVQ2xOxzSPvsHyM+UmW3wKyK02QPAPfik/Ev/wPO/nL7bt
	tnTVnzLIu2MJLmGg1AnlR0bnNKmpXoTOVfTA9N
X-Received: by 2002:a17:90b:4b86:b0:35f:b86f:6ae6 with SMTP id 98e67ed59e1d1-35fb86f6d97mr15000316a91.22.1776315731495;
        Wed, 15 Apr 2026 22:02:11 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd0aa006dsm1541309a91.14.2026.04.15.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:02:11 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:02:06 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Cc: arighi@nvidia.com, changwoo@igalia.com, chia7712@gmail.com, 
	jserv@ccns.ncku.edu.tw, sched-ext@lists.linux.dev, stable@vger.kernel.org, tj@kernel.org, 
	void@manifault.com
Subject: Re: [PATCH] sched_ext: Prevent RB-tree corruption in
 scx_bpf_task_set_dsq_vtime()
Message-ID: <xm6y76b24y4tnru4tbpm6kgcmnruduzfeqihz7hla4uotab7ul@onc572gdkyyv>
References: <20260415193459.933175-1-yphbchou0911@gmail.com>
 <7ad57375-c651-4fb0-8279-bc3423157255@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad57375-c651-4fb0-8279-bc3423157255@kylinos.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238247-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,igalia.com,gmail.com,ccns.ncku.edu.tw,lists.linux.dev,vger.kernel.org,kernel.org,manifault.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C491640A421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zhao,

On Thu, Apr 16, 2026 at 09:49:56AM +0800, Zhao Mengmeng wrote:
> Just discuss, if is better to use WARN_ON_ONCE instead of failing the
> scheduler, just like the check in the beginning of dispatch_enqueue().

I think this is more like a misused scheduler API.
dispatch_enqueue() uses scx_error() for the same category of errors:
- scx_error(sch, "attempting to dispatch to a destroyed dsq")
- scx_error(sch, "cannot use vtime ordering for built-in DSQs")

That said, I don't have a strong opinion on this. :-) 

-- 
Thanks,
Cheng-Yang

