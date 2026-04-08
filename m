Return-Path: <stable+bounces-233846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKwlLtY+1mm6CggAu9opvQ
	(envelope-from <stable+bounces-233846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:41:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACD3BB622
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 943CB3037665
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57E33B6BF5;
	Wed,  8 Apr 2026 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GwiyFWZG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009643B6C0C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648336; cv=none; b=BaRznLZ6F77nEJixRNfOY4L5wWG5QCybFKCqnYDtCdkrdKcdGmrm98VamshsXatuqUhZZz4tQE8Ms676sI89ACBARdJRaBXDuMevq+hmA7gqPeptu2jkkzgMR9c4zhyor5pntur+UtijhQ8ZESU2f03RxLU/wWpTJpnTvq+aYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648336; c=relaxed/simple;
	bh=OXqAKePgHD/s4jNJYCzmJcHl/7It1tSHctdWFVdzZKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ELsbUCo4gjHp47UXdIZD94fgTH/pigcWN+tCSlMiVyEpzJnDkZ9KU9ElOMz1Kji6LBw0UBMdG9a76qscdUenIrrrtynpowVci+Rxv57eFwIawB+Lhqo3HbejQ6xdBTmFqPFMAJoVzYiBj7a9bY8k8/c9f1dFfvOF7UMsoagMhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GwiyFWZG; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488b8efed61so7986885e9.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1775648333; x=1776253133; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vae/ZdABKqGcf91t9NhJpSiPJZFMC9JV3/rNcF9ca90=;
        b=GwiyFWZGqDTyx5xWs0/WWY9ta4MVWjXQDOEX5DhD1ncAkcF2K3tW/8DGX3eRuzk8xB
         XINBiD6vLzJZNXW1gmQxajKHE7W7Ivy/SgqMykNQ6TvUT1N7JmbsKwut4fIo3EyxYvsT
         erE42rmuOdATOIdxsc3S7FLiAW8JtDAGaqv6823N1UNTEK2EQScKUesatEy1vUMmlG6e
         68nVKz50dmgst5QydwHw1YoBZBVkAlkaTnkS2FMSxlL8sRHAT+PWpcWhoB0rwk35L4aS
         N9R5WARKPPit/PZtterIJ1VWoTYdZmSvJZrGsbBSzsB0BCChWUPc6wd49FHPsVEkVMKw
         A1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775648333; x=1776253133;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vae/ZdABKqGcf91t9NhJpSiPJZFMC9JV3/rNcF9ca90=;
        b=QXdVE8dHWn0TMIrOcgi80Tm4wARpK5r0xr4f75H3BQVJjsIdCc5sNkqjh90pEfRXgv
         y3Q3jhhtlfKCy/9mctjs6I4zyoyjpoX3WMeq/mS5a9h7jyjumQO1/hJHNHuU63TWyk7F
         rSrCH8MyXkBDny+cht9D5Pw9k4FiOngIYpvoggmLk5q+7SVGS87oUTkxGYXIkTMj1M7j
         nCsoExtJ9fz6FNL57O2O0ZyQKfXJV0Sgtsz/lCOhheUzXbY0ZiLzfSnpvpeGMif1flxC
         eLWkKYyeTBLttkhXJePAPM0qYQJP1IXuh4jA3vsUnQ53ArJv2bTNh6IW5xN+sGV/hpAf
         WzCg==
X-Gm-Message-State: AOJu0Yyd2xn4Fsqgukh/160B0FhMYcJ4g1NvfNZHxWhu809C/OS1bTad
	+iA4Wut54NhnSeZFt5RU9lq3J69tfdpIes7oQFOyBL/MAu6z0rrloDp9FJGg2RL/5ybkMH2JoA0
	gO8iDR11NAtz5
X-Gm-Gg: AeBDieuGLzCp0z8pSB/RYDAGdbOIXr+CxG23+F40Ui30uIQAOkdgwfVwfJcwdGg2e0R
	4yvvMq7o0YqIQqYcR0ilR1WDBhGm61ZItlagfXgiINF8V6qUUsAQhBxAFQpjL/BSnE2a1Y/CI+B
	l7S0ekMtjFEiqi6rErYfWUS9VGOS0AxlqqFdnwDd9Wi7rbyI5MRUDsBMHpejROpDsQ2/oFsvBe0
	35SoiLAWZW0uzT/jzZSYw0VsmCwe3X/hxmR6vWGq4Dh7WMCGexSuWnuY0l/CrYCchd7wJdaJi1h
	xQgZ9DI98rqqvuFvMHD+def0KIt2Q7DVi6V85ImXXwCSi6/vJ/0shbwyFywhCH9Y9ogTBRXnAMp
	waii2azc8uibqQZHF+jr9wKmh2qgitFbjBmbiQO7+oPRx0xcK1X8AK3Zf0yE7+8N4N4vqOlNGgs
	9lizWM0X9woZ/TN0CVIWrxiy/G2w==
X-Received: by 2002:a05:600c:5289:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488994b34b4mr301002305e9.14.1775648333072;
        Wed, 08 Apr 2026 04:38:53 -0700 (PDT)
Received: from localhost ([104.28.179.125])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4888a65635fsm523341585e9.6.2026.04.08.04.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:38:52 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:38:51 +0000
From: Marek Kroemeke <mkroemeke@cloudflare.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, pmladek@suse.com, 
	kernel-team@cloudflare.com
Subject: Missing patches from kallsyms buildid series in 6.18.y and 6.19.y
Message-ID: <zw373rzoyossoqhzvodfzilvomdi2mtljnbakm6bmhv7itwer6@4jcp4l3qvyjv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spamd-Result: default: False [-8.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233846-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkroemeke@cloudflare.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:dkim]
X-Rspamd-Queue-Id: 07ACD3BB622
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Petr Mladek's series "kallsyms: Prevent invalid access when showing
module buildid" [1] was partially applied to the 6.18.y longterm and
6.19.y stable trees. Patches 3, 5, and 6 from the 7-patch series
landed:

  acfdbb4ab291 ("module: add helper function for reading module_buildid()")
  cd6735896d03 ("kallsyms/bpf: rename __bpf_address_lookup() to bpf_address_lookup()")
  e8a1e7eaa19d ("kallsyms/ftrace: set module buildid in ftrace_mod_address_lookup()")

But patches 1, 2, 4, and 7 did not:
  426295ef18c5 ("kallsyms: clean up @namebuf initialization in kallsyms_lookup_buildid()")
  fda024fb6476 ("kallsyms: clean up modname and modbuildid initialization in kallsyms_lookup_buildid()")
  8e81dac4cd54 ("kallsyms: cleanup code for appending the module buildid")
  3b07086444f8 ("kallsyms: prevent module removal when printing module name and buildid")

Without the missing patches, __sprint_symbol() can use an
uninitialized or dangling mod->build_id pointer during backtrace
printing. We hit KASAN errors and stack protector failures due to this partial application.


Could these four commits please be queued for both trees?
[1] https://lore.kernel.org/all/20251128135920.217303-1-pmladek@suse.com/

Thanks,
Marek Kroemeke

