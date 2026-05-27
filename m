Return-Path: <stable+bounces-254632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INHNMbwcF2rw5AcAu9opvQ
	(envelope-from <stable+bounces-254632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:33:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4636A5E7CE5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B1743057D4F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B3438FE0;
	Wed, 27 May 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6JF0cbf"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D7426D0E
	for <stable@vger.kernel.org>; Wed, 27 May 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899456; cv=none; b=WxGRBHIDMnrBkwy6ngSjiPWVEVVq+fiCo/bSglq4aZUaQjYthesfqGvqqbjvP5WGQWmD7IBVsTN9kRuGFebSpmu/z+FmZY2+N5+N6EsIMR+htull5l7mFvETLWqQBLc6NPgksV4xEGI7MhHDZubsi+Tyb3wP1nKjN7jJghFj4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899456; c=relaxed/simple;
	bh=fq1RxNL89gaa1wj5IiD/KH3yhOhugHwkF3eND9ymod0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+3mWUP/lycQVkJ+gudjXRuxqfUMn827f9EvZf7LkbXjYm3XZkdLNlQlvXhNRGI8otfQ1C2qNIRNRht/U+Tr/lSoZ1GPWKZ6VEaysqehC2jPblg9H8fmZKBF2czVHiEwn9vhiWuSZr2VLlKhdAgB9+Zu+n5/x/Hj36kEWKND078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6JF0cbf; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43b7e186a0cso1595906fac.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779899453; x=1780504253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvE27vjOj0oBAYN3EfYXrsSdY9/XabQfXIQ55p1R04c=;
        b=G6JF0cbfLAGNpAknp56cYrx8d0yZ0W6+2ZRrgm2h1fhS1bEDXypNccnMEGEJBMmhAh
         /dlomDt9uU+14rdzPII/HcD78q54TvbJbxCN/hycNjwcwrzt5jaK19YNvZ6eSH3L9vXE
         z7pdzkcJ27tf65tyMWHqs/Rwu3XFbHdZ08y+NpxER1To+QbYmrh36vdXJVOkhMfUEadF
         fslmken6+zNwvMbtkWfBULBVX35BJUDiituT+1wQS6dHIEX34Ny2FMat2emQo9/Etje9
         vjABI8ymkfG2jyyNNoNfeX2yYoHJOlCeISSWNF2UUCu6ptWcTew15Wg5a5NA8ZiWd8v+
         HPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779899453; x=1780504253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvE27vjOj0oBAYN3EfYXrsSdY9/XabQfXIQ55p1R04c=;
        b=XHnf2ZUD+xP3LENL04zOhiledX/urkP3O9CKZD70azF+Q4aVvqT8F6M5SDRrlzjK94
         jXIcO8udCCg8rMoVBp3HGsu7ewJF3veXOzbFWP1OAq3VG0/y1F9RSkZs+otzVhgLoAL/
         hr/RV4ngiRpklYPg51mxlzqtDFKPE+Vr6bVGxOYmcYCe2UezwoR5Tfgw+vINS0uLFSdm
         7nT7zkE0ua54qdJXMK1NryUrXGZbOjbZ2boyQsK24g0grZOiAgW16UrmzNKHuRfza/rb
         7bQ7B1Sm5lzQhhPn9FNAfrEjFUnhl+8IrAQuzczQ7WukfVRMT8+cbTMFI1/fxu3TK+mn
         a4Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9z0FbrHht/RfIl5q88qtynFXNw3ZrdnqBwi5sCxpTxCcpLJe2GjvmMJwMeMzIVDE1UVB66bmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t4v+63kcDK/ku3ciWBKWRWLkR3RENEXx3/kAmzersvXuWVIj
	ULiwEnaLhjOQdkGU3zZ9Q9um1X1oItliuceDeGzvj+CN7lp7syFFpJDr
X-Gm-Gg: Acq92OEtDs3yo4FPtj871TzRwOF11z8Ahm3Q1ZiN5EYEN/e8W4+F3eSuUWcyzxFaFZs
	84+epqiACrzd0LveMAJ6ZQbfs9sm2ycxBzW6maaXhswZnEcPGm20vK0c3EJ3oSjJ3PkIX2Ch0ix
	78CgMb4eegOfDHWh4ueh2TlZIUNEThWaFBQism4BSZCymXBRTstDVvxdlR5pJ1+JFEkmVpbtblD
	YZLQaRAn+qgiqHjZSRg9XlWDYzg/keN4yK+QtNlZB+oTp4mXYOe3D7FAx0vU559060DG9imYPoc
	Ihx2LKzzIvw/YX0PZaeagyBcY8CGg+6SRlCguOpzHit+ocZIMjA4CKf3DJ23E896a6D1ZxEf00t
	EvjzVqVP/yHUKVMRRvpmz9qvRpF2DT+bL0MQnnVBMq/DEMdGsvYasZflen4zsLfq3fCzRkYNsne
	6UKGTui5Pq9R45svNodLZZSYTcHtedgPQo1qcez1fhXME/9gxvq2T/1FXa0chiYDAbL/Oz2GFAw
	jaSnSUZe+kDp/SNQuf3EqbfaSxpiMe41ksu4x+LFlI=
X-Received: by 2002:a05:6820:4c08:b0:69d:521d:a4fc with SMTP id 006d021491bc7-69d7ead810amr12080874eaf.8.1779899453213;
        Wed, 27 May 2026 09:30:53 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e0413sm188819356d6.31.2026.05.27.09.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:30:52 -0700 (PDT)
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
Subject: [PATCH v2 0/2] NFSv4/pNFS: fix client kernel panic from malformed GETDEVICEINFO
Date: Wed, 27 May 2026 12:30:34 -0400
Message-ID: <20260527163036.1524927-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254632-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4636A5E7CE5
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

Changes in v2:
- Carry the stripe_index provenance comment from filelayout.h to the
  new NFS4_PNFS_MAX_MULTI_CNT location in include/linux/nfs4.h, as
  Anna requested.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr
  NFSv4/flexfile,filelayout: bound multipath DS count in GETDEVICEINFO

 fs/nfs/filelayout/filelayout.h            |  2 +-
 fs/nfs/filelayout/filelayoutdev.c         |  7 +++++--
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 ++++++++--
 fs/nfs/pnfs_nfs.c                         |  4 ++--
 include/linux/nfs4.h                      |  5 +++++
 5 files changed, 21 insertions(+), 7 deletions(-)


base-commit: 0a0e44d91ce037ac5371b0d8dfbbfc5f693b27c7
--
2.53.0


