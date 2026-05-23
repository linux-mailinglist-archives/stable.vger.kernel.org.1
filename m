Return-Path: <stable+bounces-253868-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI+OJp4FEWp+ggYAu9opvQ
	(envelope-from <stable+bounces-253868-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:40:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1823B5BC5C8
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243363019FD2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911E271441;
	Sat, 23 May 2026 01:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkdwRd7d"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E923B62B
	for <stable@vger.kernel.org>; Sat, 23 May 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500441; cv=none; b=a948m9s2BwA50fGbY3LpS3bxqUnCFC+VBPzwj5aeRHJPJA9EyDHDrp/GHn5wfYkaWf2nCK1rJstW8g9/36Bl5+grGovTASgr0T7bJsWNq0Ogk11++Ao8YMW/nKgLPBEkNYBQqxYuQUfkHuEJAF2bQw9xbgc+i3OfgVBPn2h2Sb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500441; c=relaxed/simple;
	bh=Jrh2Ths5M2cZbexD4fdGj4nn4YBf8xzcRfAWuFjG/4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJfCgvbz7I7tGhPxFR82KClFv17NhfZTFC88loQK+1TF44DlEj0tF01DeOOGwmzROiHgupxkzgnvYSCONv7BC5/vfCMZ/ixJTwJddIqn8tD65g+DvevGjIrF6y+0Nky+Fe23iluWnTyWnTcYeDcoIVe0EMRh1fi7HLVOVShdTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkdwRd7d; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5102582e23eso61951731cf.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500439; x=1780105239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NBkz8uk++9agYLdO2eZoJHgoe4NIS1dR5QrU5vkKjfM=;
        b=FkdwRd7dMfHEmCtqhjZSX2DvsA/hhKDiVAvWLOLwiKhuSNMSAVoaNWd3AFlxM/t/rQ
         dzAxDSAqmI0xidi0ns1U9pMSktGQw6ClL86D6qAM9GrRPlAVSdvkUslUZF6IP09bFUhU
         jdoTQSHeUhMkvKOAXRWT/py8zzZ8JiWPeYTD3i/Q7SBz8MrS1VKppM+ep52ZpB6LQSF8
         J2PhoZs7F3SkGSw5Tl8KvdBNoJlLkKfHuwFjwpaGFj+lQjMBCYKxmMKH9KjA2HAB5N/0
         3IqlM85o2RaqkDtqZenQP5byD2rtemsGfkt1o0obv8rqP9FSP24mJRtF+myfUAmXLyqw
         19wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500439; x=1780105239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBkz8uk++9agYLdO2eZoJHgoe4NIS1dR5QrU5vkKjfM=;
        b=M/d7EBUfBEwykKzA/9wEqV6c46VmV9EidRafxQNMH9y0Jj7cJwYrEfus/bWbtMRoZm
         OwhTkr7Caq3VDonOtG/jrIzr0jVlMaWB6kPYzCZ58bT53OCCV8GROsF3ZBsstSW5IeJR
         Jc6hVDeYusvCWhht0DkUP3E+5awzxWj2w99TX5dXNnhshbZG+OsLhMVSMYolqojoluaK
         PrhfFQ8tu15f0Nmxq+lB+D1fK05j3TVmeHfYYSdw9Q3n6qGQJXxJVGYoK/8QRnrqxMZ5
         O9gR1j8A0efHSk8cVre7l63xuS0ho+d2Z9ANpBfzKZPFm65yE+Ku3mYTxa3EeAdUHmb8
         DFfA==
X-Forwarded-Encrypted: i=1; AFNElJ8TSEFYfyz18j7mrq/jhzqO+xt29qrnk9/VPCGJCjQY6zAO3SBnQmjuN7SwMCkaPSB5K4Qm+eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9lMWBpTMdj1BU5bMSFCjXxm1G3rB1sRRFR7K1zBJSqyGs9quc
	3Nq1EbD+SDNGzpF3T4CcQXDazCfQz2raFv6iO9eFXHc8abl+Iwwy8BSf
X-Gm-Gg: Acq92OEJ0bUokKn3WaCs4Qh0tct9akD73iPq9tmWGt8FRAjwSf1R2XiDnQh2qAU0pok
	0Ucv2bFW7xVuZAmcWr4NUw604u/+E+q6gl4BrRcSb6i2BT79m7KjOgy3rBWi5AKIClUf1VD+obY
	ql/KUd1Fq44E8bkxkEnaxjw877mAAI1TnIBKwNZE/fARnEsOfnjCrTq9t2vVkroAJCxSeQDY4TD
	zcwH9iZxNKkZkloSH274w916SEAitLuF6DQLcrWqSJghL9GgoM/PEKcvlLsLan+EGNzXgFe+Msw
	QIxBXUIxUgV9H40vXXmfhpMQ3IQ7v6WMStnGvmJkvVDphkbhxFQ2q7T247VyxsFpqUkxNVsHEII
	/Y13KiTDLrYJbBUZS2R+IudQc7gxThAAZl86DY/Bo7zybIc+tP/0g3dzNt5mHxmRfgxb0DD6Rgx
	Q3JglvU5NI/L3WjbNJbqV9vwhDPoIS0en/8gOqGOId61YCVD9FtKE97k3/JkZ8AKiUq9XhVbTQf
	z/dBQkVSrppZkN0Ew9w
X-Received: by 2002:a05:622a:6115:b0:516:51da:ae52 with SMTP id d75a77b69052e-516d43cb30amr84067831cf.33.1779500438698;
        Fri, 22 May 2026 18:40:38 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b247c4sm28559031cf.7.2026.05.22.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:40:38 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Tom Haynes <Thomas.Haynes@primarydata.com>,
	Peng Tao <tao.peng@primarydata.com>,
	Kees Cook <kees@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] NFSv4/pNFS: fix client kernel panic from malformed GETDEVICEINFO
Date: Fri, 22 May 2026 21:40:31 -0400
Message-ID: <20260523014033.2459677-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253868-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1823B5BC5C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A malicious or compromised NFSv4.1+ pNFS metadata server can panic any
pNFS-flexfile client by returning a GETDEVICEINFO body with a
multipath-DS count of >= 3 and exactly one valid (netid, uaddr) pair.
The unbounded inner loop in nfs4_ff_alloc_deviceid_node() (and the
parallel site in nfs4_fl_alloc_deviceid_node() for the legacy file
layout) keeps iterating after the first netaddr is decoded, consuming
the trailing version_count / version / minor words of the body as
opaque netid + uaddr pairs.  Both come out as zero-length strings;
xdr_stream_decode_string_dup() sets *str = NULL and returns 0; the
caller in nfs4_decode_mp_ds_addr() only checks "< 0" and immediately
calls strrchr(NULL, '.').

A QEMU/KASAN reproducer is described in the second patch.  The
shortest crashing GETDEVICEINFO body is 56 bytes, the panic is 5/5
deterministic at multipath_count = 10, and it fires before any
user-level read can complete on the first pNFS file the client
touches.

Patch 1 closes the NULL dereference itself by changing the two
xdr_stream_decode_string_dup() return-value checks in
nfs4_decode_mp_ds_addr() from "< 0" to "<= 0".  Patch 2 promotes
NFS4_PNFS_MAX_MULTI_CNT to include/linux/nfs4.h so flexfile and the
legacy file layout can share it, bounds the inner mp_count loop in
both drivers against that cap, and breaks the loop on the first NULL
return from nfs4_decode_mp_ds_addr() so a hostile server cannot drive
the decoder past a single malformed entry.  Either patch alone closes
the panic; both together close the latent unbounded-decode class.

The unbound on mp_count predates the flexfile driver: the same loop
exists in the legacy file layout since 35124a0994fc ("Cleanup XDR
parsing for LAYOUTGET, GETDEVICEINFO", 2011) and was carried into
flexfile by d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout
Driver", 2014).  The NULL-deref site was introduced by 6b7f3cf96364
("nfs41: pull decode_ds_addr from file layout to generic pnfs") when
the netaddr decode was unified.  Stable backporting wanted for all
three.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr
  NFSv4/flexfile,filelayout: bound multipath DS count in GETDEVICEINFO

 fs/nfs/filelayout/filelayout.h            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
 fs/nfs/pnfs_nfs.c                         |  4 ++--
 include/linux/nfs4.h                      |  3 +++
 5 files changed, 19 insertions(+), 7 deletions(-)

--
2.47.3

