Return-Path: <stable+bounces-233267-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJBZOVXI0GkMAAcAu9opvQ
	(envelope-from <stable+bounces-233267-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:14:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5099039A5AB
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99E53079087
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A2F3A4F2C;
	Sat,  4 Apr 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P20v2ivH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CFD371072
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290130; cv=none; b=kjQmKDLcjq1vqQPHdneGbwvGzmPexYvjbsVwz4k1CJ2dQbJkL1T7RQELGaTE1cqlJPvrqzl9tjYNcLwhp5P2TppPDZWGvpb8De447X9BthRNKfqSm7P0VYAJqV6nGHOuJcRZMM0TmEJHpln7DYBLTTL92EnwxC9WuVGLvbTGaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290130; c=relaxed/simple;
	bh=C+vMg1YlMyfty13mqdz4qeWPls9uxbXIgpCleZAEnGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X7BCoc/jXz7iZlH9mccr/lG/hOS5Yxk0rr3cpR5aPYDWDuEh5g1/7ijF9nu0Km292Sfgf7xNvxyOVLVkTQmgzLFBvVLuD+bXCXJgG4sVHW8S7gKnpotZHvRbOi+LNPFrkb7z7CvMK+21ImyIfNro3ypWiTaNtw3MVC3tkwho+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P20v2ivH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf906b007so1367931f8f.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290125; x=1775894925; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MreoZ10HIj2la67+33C3EG5FgMyfYV0YUsu+euJrCsg=;
        b=P20v2ivHUJGmD85fmlIcKWayjkJ76HcFz/MIWMYsUlvNIOtnXkUC712nUKGwA/IWYi
         BHn2xcof8dgE7fruR38c1Ae3xvKG2AHwPLHrhkcJOPDSTqYlX1e6ptgFJ6fc7Hz0H5tp
         a1U5hC4imXlW0PhyjL3F0wYloU2mEpwml4FLPHrujjGAK3OaczfzZcHPwSUUJs2uXyT+
         FNRzMqRZiYTO6pQLc/t1GP5ryzNHvXG/KpEZ36nJH5PTQKVi3CNN4KSRAJbIAC4xosQJ
         KOmtiOM6i6Rk5m0NaG/OEsEFGXqt9YqmxTS622JU8oSlI8sEzUDbcaPps8iTUHON6797
         SXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290125; x=1775894925;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MreoZ10HIj2la67+33C3EG5FgMyfYV0YUsu+euJrCsg=;
        b=ph27Dz0R36rPJHKuneufZFOaSH3xDUSQMli9tKBIvddmDasEi9GIIC7e9psMb8PhWn
         gRHWAhUEjgCE9DdgcfGaEmCZdTT0GEAFWh6LYydGj+zhrOglZXQachlIbP0SE+WvFOeo
         mxraRJB5m2W++pmCSgqSuc0vuOnt3KAbWv99X6eEDMrEZEfj8U2ZY/XPHHqrwKZC6Zbs
         UU+7liqaALdN9vSft/BoRMKU4+HF7bA2fM19yqG4UkQJ0kZIAlw8JAWDRHVIDkaPHHsy
         rFXE69H2BuWRJd1yTo9RdWQbbhuljSn0xGvYtTJ65AFF/2329n92Ku9x16PE76lFul4o
         Oj/g==
X-Gm-Message-State: AOJu0YwtB4YHmKzaKV0CD4ihHUo0ANZpadRtwj/wwy4lLqLsKAtXM5Vv
	NWXAL2OLhYvot73xSQMiUCmWMwKCgMlEeTc0v/XhjgeiLDDXPm+C4Cm2nMvFCRWs
X-Gm-Gg: AeBDievqJn5zuV0Ad6rWxp8IYPRyd4f1vztEf+cUdBpBsmCrnqqEJ/YDQ5Tu6rR9TSM
	0MA26cRK9Ak00IojPgrt7dY6ulgrBbifQUKLaDFjicq8DvjnRZfqc4LAZc8EvU6ZILCojaSUoo/
	iXW2iz3yHLAZsfO+7MDa6kv5WYM/8HlMJ3RVIkObtq/teShEr/EgocsT66i4UWp/mnkjUuBV4P1
	/p9FWTg5FsLnbjlsYaOj046oHCPXXN52OLwIXLw6ZicwwpJVvJG/2QhTvbfRhEztwApLso4EwC9
	qK9tcKHobFJci6gVSv6GO8z0x7xuOlrb41TMo9AoVWr6G51McRS5pH7mjhWDua5G7nSpem7N8/w
	hub7hmJtpfUhNI/3NeMOWQkDBS4bX8/SYwVJjGBLOCWVtYepVZu11O0M0eSh0ufV+/S0PawMQyQ
	gE/zlNMN5M/J2fw5yX+9H+sN7h3118AhzNzzMziDW4yDs5J7j90GYQfq8Pv+klRP4W49Hv8dFWr
	C5v7X9mZZQS4ZXvVE1jvGUbtTYf/VHp9U8+v1kshfuhbQhS9FFwN+mqMTL/OpEUPIt8Ga0kGxtS
	EyxV0Es2nBmkzynu5DlBaREn8o8ZlqeJi1S3gp+DUHk=
X-Received: by 2002:a05:6000:2913:b0:439:a958:4342 with SMTP id ffacd0b85a97d-43d292d64dfmr8707102f8f.34.1775290124720;
        Sat, 04 Apr 2026 01:08:44 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d2971sm22587398f8f.22.2026.04.04.01.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:08:44 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:08:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 0/6] bpf: Fix bounds when ranges cross sign
 boundary
Message-ID: <cover.1775289842.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233267-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5099039A5AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed in [1], this series backports two sets of fixes for BPF,
with their selftests:
- 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary")
- 26e5e346a52c ("selftests/bpf: Test cross-sign 64bits range
  refinement")
- f96841bbf4a1 ("selftests/bpf: Test invariants on JSLT crossing sign")
- 5dbb19b16ac4 ("bpf: Add third round of bounds deduction")
- fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross min/max
  boundary")
- f81fdfd16771 ("selftests/bpf: test refining u32/s32 bounds when
  ranges cross min/max boundary")

Using Shung-Hsi's stable CI repo [2], I verified the BPF selftests pass
with these commits applied on top of v6.12.

1: https://lore.kernel.org/stable/2026040240-friday-gurgling-7088@gregkh/
2: https://github.com/pchaigno/stable-bpf-ci/actions/runs/23940850516/job/69826632354

Eduard Zingerman (2):
  bpf: Fix u32/s32 bounds when ranges cross min/max boundary
  selftests/bpf: test refining u32/s32 bounds when ranges cross min/max
    boundary

Paul Chaignon (4):
  bpf: Improve bounds when s64 crosses sign boundary
  selftests/bpf: Test cross-sign 64bits range refinement
  selftests/bpf: Test invariants on JSLT crossing sign
  bpf: Add third round of bounds deduction

 kernel/bpf/verifier.c                         |  77 +++++++++
 .../selftests/bpf/prog_tests/reg_bounds.c     |  62 ++++++-
 .../selftests/bpf/progs/verifier_bounds.c     | 159 +++++++++++++++++-
 3 files changed, 292 insertions(+), 6 deletions(-)

-- 
2.43.0


