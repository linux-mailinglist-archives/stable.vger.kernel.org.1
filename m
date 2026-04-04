Return-Path: <stable+bounces-233266-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePxTN/XE0GmV/wYAu9opvQ
	(envelope-from <stable+bounces-233266-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 09:59:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4039A4F5
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 09:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 78CFD3015BB9
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 07:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F61396B7C;
	Sat,  4 Apr 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYHpZII9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737239478B
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289533; cv=none; b=lp0NPDaK6QIwyZttDDFrhtePW86hEmki5TWc7OQPEM1WVCSCTVtOtuXHDX1lHnrKV6HYWQAyc9TyTUKuRu1afpXE0OFfz492m9I6+r1dh5FfRR08B+NVLzl8B5Fx1qpeOrAhWqBTUnzzlrSdMo5NhGcHW50V82wOd7hMY5xfa+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289533; c=relaxed/simple;
	bh=C+vMg1YlMyfty13mqdz4qeWPls9uxbXIgpCleZAEnGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pnARMa6j6dZp5WeXrWqx+Di0d5vcDJJxOKkRnoyONuFQPP8XLbTO5JS29psEYxGTqNcCev/eQYYZBKqSt/Yyb/PxMcukrAvvEtnrP1iGIRoAV1kMfX91njX+cU2mpPM4fDQhOnMRQvt0sqKyf7IUFjGhaZi8k1x7tvpERDB2g/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYHpZII9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cf3ee0fc1so2502240f8f.1
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 00:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775289528; x=1775894328; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MreoZ10HIj2la67+33C3EG5FgMyfYV0YUsu+euJrCsg=;
        b=qYHpZII9BHChSLnbO37Api2crJbouZ6t66OsFC/wxGJX2P+RBXMzsV77nMPk0Iputr
         0qlVY+IOzGuP5swSCTLglmreEON46dMSZvFK3agy8gQzBR9cEroEeSfxUW6+G14cUc9/
         zN1Dpw20IFeJddi3WZUf+aMPOJSe44eUt4qoQLTLowlxwzd3YGxMuLkL1AK5kLRvZ1f7
         uY050LHTQozEb8fyFC5iHCozYUybgIFNxDpYvy02syEBzuXlR3rEyCkvLr3vMwrB9NVY
         ECLzUqB6GHtlanVGIjgIt1hU9RyZ7gtSzvPqVItqfyVx91zvgfAn61aR15GLCJI/WL6b
         lMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775289528; x=1775894328;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MreoZ10HIj2la67+33C3EG5FgMyfYV0YUsu+euJrCsg=;
        b=NzwOSitOXQvEYQLRfjY1PJbKwAXDHTKSWoLmMM9UlukHlERGKIiA44CWwUaqkOpC/a
         Rak+k8oucss6AMFqeQirTvg6vzkygMYSSvQ8Siv3aRWNVhpUW92NglaljpHXS6QPcNbK
         6qtFy9owISaRyR8dzj8O8nHI58REEH84s1uaSK0IjVw+2Vn6eMleb8XYPsjlCZczdEYy
         TMKWUkacLhB+IX7pBbnzf62kzeHkxtLvTtvUQP4VArSE+57ZnfNzGcbOB7enDLbgvMTB
         AsQUGrJI7DCViFQNyK9ufpU8g6WHtyRtRzFRCwZceHESuI4LVdSZVmyUR80Jekgxnt3Q
         6YSA==
X-Gm-Message-State: AOJu0YzPwzoggccZ5MHULRrIDxB02J3MjSgqdD6Ci598iz8UeH+IVdLc
	7Mnr8baqnK+wV4n4NtfpUbvvtIQkXD1HAYadSQxbXZH2QWw5JrHfZIEl921uPBht
X-Gm-Gg: AeBDietcqqVdDGdqxdRt+0lebGyngRDvgjDQeDxWzzKlu2v9vrUBIxBRHyI5DsTENmS
	I1dbEBS8I1SOJIIjuwNjQTVpDtObfFYH1cunNaZGh+t7wowIhZ9XQ9MokyNofHsic4f9ycgx8Ah
	xK/X3Tn53znIqIzvvCwLQcu2CqXAhhr5bJ059AyLRshDtzOnuqiLIfnXfrizfkVUYvYHUj5p8oI
	+C+DIs6qfdD+Dy2Gz99toBUAYg9wIO+xjlk2gAoi5uWh3DLGHBViloOrQi7r9t+rglr/blGQLL+
	xbWzq3fL2+Wrn2e4G6o8t8weOueh9hXoPyZsIclAr0kAJyhUipd6ZJbgZsDUy8ly05/3y5IoKCY
	cVdK21JzOfpEXd2kkh4vyS0DkZwuXsTsuXZlbh9Disvh1wxyqDIgzbYImVt9W1CIuNc+VMa7zB5
	hqTQo1hJXP014Pv5lMtpJsVxqPr+5B2ktEckAJ+xjBJeX9Kj8eQzLRXoh38y9BxQmZ1NZWe1/Jn
	xrLhXpsHswwtpX0ohcdLrSS7vsG1KY3StK+8vPvDmSvSNJ+Ti8lEdFnNC1ZpUV+BLsN2vujITAx
	2NhElifMlnhYWXL42d30rhtTcelZmrIH4qtQjN4EpAo=
X-Received: by 2002:a05:600c:4e42:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-4889949c0f1mr83189655e9.10.1775289528334;
        Sat, 04 Apr 2026 00:58:48 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a567bfasm412749505e9.0.2026.04.04.00.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 00:58:47 -0700 (PDT)
Date: Sat, 4 Apr 2026 09:58:46 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 0/6] bpf: Fix bounds when ranges cross sign
 boundary
Message-ID: <cover.1775206731.git.paul.chaignon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,suse.com];
	TAGGED_FROM(0.00)[bounces-233266-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D4039A4F5
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


