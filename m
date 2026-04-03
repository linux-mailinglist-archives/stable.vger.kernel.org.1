Return-Path: <stable+bounces-233193-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AohOhXez2mn1QYAu9opvQ
	(envelope-from <stable+bounces-233193-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:34:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F156395CC5
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1023A300B5AE
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB023793B1;
	Fri,  3 Apr 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNtMpbAc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8EE1A3166
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230445; cv=none; b=rsqZcHD6sBcKJu+GCMu7n8Z+pBsBseJhjvooObSLhb/QioXmVxv5WRapu09dpVbWwx3pk+a65F2DySj5w2bWP0Q/VBCA0mgwGbLCr/zv+IDVNr6Wcx1Xgseliy15IUSF1orDMT+YWaCrWGCxVtP3afUFNho1GEfSUZD0mU5WfHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230445; c=relaxed/simple;
	bh=3SpeUw/IezxhhEw/OMLS4tDxYj5A4Yt7t6aUoVs9BB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=US/lNhs486ZBC6Ok+vCaDEOL5WpeYH6aNFqWPvCVDhfz4fEVMF0gVQPyBXsvfc2RJyEc2WHtYo1gEoTf4PknTFVu5YU49FA6/qVL7SdBTEI3vllMucI+tuhdWUw1aCdo2lY/Ugojsuq/5YdEViBfvxhZVt3bU4u8N5pRPljLf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNtMpbAc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso33451605e9.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230442; x=1775835242; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RHNdw2dyYsz31h4qKYc2LNjmW6JHeLmR4hJnhOhLhl4=;
        b=YNtMpbAcr7ZQFfmzbnDYTGWODR4jPfT67LwN9ZaBvnjNgSTfbNiRtoBnc27X9AnL3Y
         qRX3IkyO+HaDOyplHopjYNf1TDZ5V/iFL9F+ohGHE4vMp1KiL+o/XQ+gBq0CEA+uH5fv
         OD6PU2yfCsoqOM7euK3/bNAMsT5Kv6KRmFgTX04l738IzLYqsACLrEdQWbSAYoxoi5sr
         5fWcemoxKHBaGpLkvukQQHWKzw9Us3Zl5agerf+wLGsN35srxhd5gF4QgpQz3eWQIv/F
         xe4HVe0N/zDycny5OrwhU/f/dzWxVAUZBPFCIWMPbkwaD3whG61l4pmBSwJ4MzwKxJWk
         QQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230442; x=1775835242;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHNdw2dyYsz31h4qKYc2LNjmW6JHeLmR4hJnhOhLhl4=;
        b=gpLViQzsiTd28JNq1AOYdMcvVp35fryM2Pd/wLBrRIERqEEIrNKT+tF0zpFd2VbakS
         Yn6iT0eRtI2JZOuH9O9i6R0pCk3EVUF98dJyl7Jt0Ldth266xpeqxGEjOkUfLdYYof09
         WMw8SIXn42nzFSpouh6EE6ZeHHNSqesh7w+8vVKip/A7NqoP+Wz1p9dGeePvt+S14L2q
         2TE9n7H+FDn6U/jq8ylvQOcylrcVqggdCM3dbVu5gzD9R16fh6ljeCyRh1r/9snGvGkj
         d0/sM0/zUHjxk15Xxpd8jtO9Wv6odYw8V/cm64esUCLXJanVa+qm7wQRIlF+Eeb8uybA
         XzLw==
X-Gm-Message-State: AOJu0YyALfxWHYgQzRLreNrl4df/bQlHJNf3iaA7iY98qGGM/xouXe8n
	AOdJuUBpgV9sglf54/A8kWmnDNWy8MxQPz22xhRw8sZnngyc4UTOOv/K9EGyVjJu
X-Gm-Gg: ATEYQzyOG5cfM6TRCDh9UD00ilquBkIdOHLP3d2gNcdHHDVAFsSFPjux/1QwVUfEtlg
	SGmgeFpCXKc6vKFciLOwwMptZs+IQaRHZwQGT7RLfuXswse9mMOt7ieU69qfk736UHj6n7nF3nt
	SS9AiEPpOoi4uPdCTCWgz9jEdqTCf1DFSag9tjxegiNjM/80sbf8JE1Kcvbe1H3ljAYsNVVLi6b
	Np7YjRigsV8tQ0zmTLK1x8CN85HoUeZNvYxzBu8aWTmutFf7hc2NMk/psYUbd+Y2NCGyH59SW79
	/BjTqT+ps8yhmryahHWyGlX+28InaJsYzQo76M3fyIRYQXbM/h88mc+qGvAJCnldvIeJVeXZuRJ
	32RT98Z6jOrowGl4+nS9zQ2n+nakWDTPKQ0t+vS0ZNyKshuPFqJSz25ZLyLyPu11fXBMtNxk2P/
	wsL+bHV5ucljqOOIJBo6rvnnVREgwR/d8MKlF90oaGiGz4o7P20eKFlydU1cXCKuLpUDjBKzdIy
	ylhs5cMMZ3KdiiBLR9wnNTIdh8vumRBevexQ2zKNR2QcBUTDjQOCCJz+r2b5yjm7sSNTkmHr365
	yY1bAkkKNKhZVWBNF4iGVUliZz5igIo/fxIn7Pd3KeM=
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr51593825e9.3.1775230442049;
        Fri, 03 Apr 2026 08:34:02 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899eb50cfsm21702745e9.32.2026.04.03.08.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:34:01 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:33:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.6 0/6] bpf: Fix bounds when ranges cross sign
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,kernel.org,suse.com];
	TAGGED_FROM(0.00)[bounces-233193-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 8F156395CC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed in [1] yesterday, this series backports two sets of fixes
for BPF, with their selftests:
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


