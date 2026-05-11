Return-Path: <stable+bounces-245278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFChIaQJAmqknQEAu9opvQ
	(envelope-from <stable+bounces-245278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:53:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 000B1512B9F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09FEA315391B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19A4266AE;
	Mon, 11 May 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGCk6+Y+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BA42669C
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516488; cv=none; b=rF+C6wXG4sj5U/TAyeQCO379z5ESvAKbQb2SLEBnLtcD2tzomFRT+FzAcQ+14kCCr+5/b2At1Nc5xtiEkVSP2ofXOp3+8/xKqsocl6KLvQ/nDlc0Y5iwBXosDIfrxl/srt7ija1jSI8ng7/jZ8UAFajzO/9mh+clWg3KXgrE8Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516488; c=relaxed/simple;
	bh=VMou3et05x2Gmxi5Q0nsiaXTjc3pU1mdVLxsxyvPde8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=anPHRCeUHbyVf+LeoyxTYnaTvwQfH/R6Dpkhq7/vXX1dq7WZ2LEn9OPH182iFwqulJCt7JBm9Yd0cttwWV5XI5Vk+dORhWPv+pmIY7/+wnmKeyOU6IlYJFAn7pd37ALM/L6QgGS7erK6nW+S/pVbUNltOe1HhYYGoQmJ2l+znnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGCk6+Y+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45562c41ec7so1572204f8f.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516485; x=1779121285; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmerjSvYNeLVR7DVsVGWVSNu5uOfQjg3Co7usm7E9NI=;
        b=LGCk6+Y+XznhcjVAxHsFCwo1kfvLyyRFKRD40/ip79ZGS4tNov4pXcGXUulbUofpaZ
         wztHOub2ReT+TN7FXaDQCmm0VKENvebiM6MRImwTxSqvJ6L4XTXTnR4O5VihAM1wVDF/
         Nl1cb2lMc6DWIheCaHye1PDzJQ3oijmIaqtYNW0Bjz60xqzLWgy0RBBDB8uReks6+TIJ
         Oqqwzqx2rzIxAGNG46jEFPhNa5tCDY4dR/EADsOw7tXHFO+8hD26xeS7eo/YI0p7vB+H
         epPAU2k9xVNX0mqv3MkvCskwXLGhraO40feF5IB6SOGyTTzKXq4VhiHhppLBA9I/uAn9
         XpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516485; x=1779121285;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmerjSvYNeLVR7DVsVGWVSNu5uOfQjg3Co7usm7E9NI=;
        b=oKzIyRqGxSKFs6nSG1CTCltsnR6KlRXpi+Yfo5YOmDNo8ujYpB4nkUX8Bq6BN2aY7y
         bu0vwP3KOSqSsN1PzyZZgx6kP6dZ2965jl+A+Rc0TjjqdCRZdfDTg4sQbQHjYJyT7qWR
         QZO2BUytWQHBtqgxl+EU7cfsuBOuoXmOLEAwG93ymf1Nr/h/HcaAr3VT7pvo7yH0uGAe
         AEgHOcvJFhc7urZ1G49v8Poe1krWPDbqAnbOIMR56xr5E71OD2/tHBuv6fiBcIfEOVHN
         XAU87ABHxH/eFIgrgqhWHDo1nWDsuQWegDfCwBgXGBMq0Dhak+6zRS+yK1vN+0TECOLT
         NIhw==
X-Gm-Message-State: AOJu0YwKVFwNLDlUMxBGvUn107V1H6XmeWa+v00Hu8HPi2so+RtuW8hJ
	znFotwKbfbrqWl2ptdYbslHW45TEkOzVn0NRykgGSf3zHMZ8oIf73y/ffQ2J/Qga
X-Gm-Gg: Acq92OGQ7eUFIue5wFczhMIYU3JeqqSQj7LnHHEpanO17I4fQgPgy/qHklamH16+9Ak
	KUuQ0s0s5lHTSXOIPDg9OmUKoIYrCRnHxHDGFqWerC4K+sS/b5gViBu1YwdAuve9nebu1E2aiwJ
	wwEHgKywRWtm0Pimf8ErYLowwEmIqZoc5/WtAKMAd1sJc0SnJnx4i4RKwWWN9MALNaCiN0FpdYy
	HszYyGGosebgstLhH8Oc/BDT8zCyksMJ9lfL/rauFJiJYLpdLq4xc6gkdYIkXxsK++b1rVGKd70
	4lnjtKhJ28pbd7lJ4GGPzcS01xD8DTZ85MY0hoVtrFUKXL3t8oqHxcLx1uL2Rwe5TahEiheAOv8
	dz+LdOuAKaYZeLjM3GNPrQoCmBzG/ttPA5nClaxkvg/rqDfwpXnFyG1W0uGO2JytvvYcyXby7to
	GTDvwMtMvA/Jd4xqLGfZ6Fojep6kPHFfZvbS2TcBJa4v7oVh30IcaQ/JMHvL9nrJi0H+Cyt7wmr
	OvXfXTnDmGJDOd9k7hS0lflgWCTVB/CB7jNY1XzfVGeLVZ2bEANm+HvXXrvU5QtRGSDLjrpGXGG
	+bA9QjdHiYGXgEzTYcquVTRTAkr7XA13gMlq1uZUFAA=
X-Received: by 2002:a05:6000:2403:b0:441:2381:b630 with SMTP id ffacd0b85a97d-4515c575330mr39176076f8f.24.1778516484996;
        Mon, 11 May 2026 09:21:24 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm25932818f8f.29.2026.05.11.09.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:21:24 -0700 (PDT)
Date: Mon, 11 May 2026 18:21:22 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 00/10] bpf: fix precision backtracking instruction
 iteration
Message-ID: <cover.1778516196.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 000B1512B9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The first patch in this patchset was already backported before, as
commit ecc2aeeaa08a, to address CVE-2023-52920 [1]. That backport was
however later reverted in commit 199f04528737 because it reduced the
efficiency of the BPF verifier, to the point that it rejected some
previously-accepted programs.

This patchset backports commit 41f6f64e6999 ("bpf: support non-r10
register spill/fill to/from stack in precision tracking") again, but
this time with the subsequent commits that improved the efficiency of
the verifier. In addition, the last two commits fix and test a
regression that was later found in commit 41f6f64e6999.

It took us a while with Shung-Hsi to come back to this because we felt
we didn't have enough test coverage to backport this. That changed with
the stable BPF CI Shung-Hsi built for v6.6, which successfully
validated this patchset [2]. In addition, I tested the impact of this
patchset on the verifier's efficiency with Cilium's BPF programs [3]:
it significantly improves, reducing the number of instructions the
verifier has to analyze by up to 87% in some cases!

1: https://lore.kernel.org/linux-cve-announce/2024110518-CVE-2023-52920-17f6@gregkh/
2: https://github.com/pchaigno/stable-bpf-ci/actions/runs/25671397661/job/75357317078
3: https://pchaigno.github.io/test-verifier-complexity.html

Andrii Nakryiko (10):
  bpf: support non-r10 register spill/fill to/from stack in precision
    tracking
  selftests/bpf: add stack access precision test
  bpf: preserve STACK_ZERO slots on partial reg spills
  selftests/bpf: validate STACK_ZERO is preserved on subreg spill
  bpf: preserve constant zero when doing partial register restore
  selftests/bpf: validate zero preservation for sub-slot loads
  bpf: track aligned STACK_ZERO cases as imprecise spilled registers
  selftests/bpf: validate precision logic in
    partial_stack_load_preserves_zeros
  bpf: handle fake register spill to stack with BPF_ST_MEM instruction
  selftests/bpf: validate fake register spill/fill precision
    backtracking logic

 include/linux/bpf_verifier.h                  |  31 +-
 kernel/bpf/verifier.c                         | 233 +++++++++------
 .../selftests/bpf/progs/verifier_spill_fill.c | 281 ++++++++++++++++++
 .../bpf/progs/verifier_subprog_precision.c    |  87 +++++-
 .../testing/selftests/bpf/verifier/precise.c  |  38 ++-
 5 files changed, 557 insertions(+), 113 deletions(-)

-- 
2.43.0


