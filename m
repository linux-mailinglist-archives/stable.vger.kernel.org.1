Return-Path: <stable+bounces-185602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C3BD83B6
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87806423331
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8F930FC28;
	Tue, 14 Oct 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ha5QqP+U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YR5sRtmW"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C31DC9B1;
	Tue, 14 Oct 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431343; cv=none; b=sML4n8/xonhxUvT+llc52mGXupI6KUOEYJ918pIHm3XbMePrfqDRu3rk3OFyECPm5h6uPxFfv+6kAcpVEA+5rgtAcGAmgg7PmVx2aQcPr71ew4bC8d50artcKRmLkTB2wkV40BasG5A5X6Kdio88XPZpeYs6QvaMZXs+XcQmphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431343; c=relaxed/simple;
	bh=jN1txmW4DYK3O77wZiYZevfMSxECwSPhBES+l7pO21U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a0G4Z7/wpgZCX/5/HXiH74klpaQFvb8PkD1uhs/Becw+BGLJ6435kzPU0GpK41S5vv8xY74/Q5xlkH/cCJ9rkb4rc7+ZoyoKzqMKfvJ4pyN211dArFnT5Z69svWy2dDi2Gyd4zwcw1aZYQ5jtUOyTGGX/Yua4S9hdh8eBXuhFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ha5QqP+U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YR5sRtmW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 08:41:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760431339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQEo0lhB2INTy8jYKZ3qg3gnU7jjerUOVngVAUS6gDg=;
	b=ha5QqP+UPEscValDjacor8vvOOq+vFUqtOPOs9Lf5WYqBiiPbUtfX9eHmAX6bNpp2nURBl
	obKgQcSVHJ627XBTiwEXAr2VQ0eelNeyOmBq4JvxpcuCQH2M8HLgZMLnsWrQ4mIeviKKpQ
	QkZBgb6UIRTG0+22trzJ7rw72KfXSBBCVHV+K5TX5bMcILtVLGHLkWjUkDg6g6C87W1pCm
	uxRMtnsGlYqTMCD9MOfjo+NTtAsBrOe/R6jZEwYULiV3xSskWGpqEDxdo0dIBQWVPEojG5
	K7kX/swxXkdi5ctWR6aPrxKNflPCimEKlNG1T5reTKY22rnei77FlJ1KKqZpag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760431339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQEo0lhB2INTy8jYKZ3qg3gnU7jjerUOVngVAUS6gDg=;
	b=YR5sRtmWVZYnq13zcFSV1zLl5I2+3muU17/CJ8U1KS0xEqN7xmB5RSt7m9TcN/EfiemU0a
	WU11J1KmiTNZD7Bg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix MMAP event path names with backing files
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Amir Goldstein <amir73il@gmail.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013072244.82591-3-adrian.hunter@intel.com>
References: <20251013072244.82591-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176043130853.709179.8229902411342716100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8818f507a9391019a3ec7c57b1a32e4b386e48a5
Gitweb:        https://git.kernel.org/tip/8818f507a9391019a3ec7c57b1a32e4b386=
e48a5
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 13 Oct 2025 10:22:43 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 10:38:09 +02:00

perf/core: Fix MMAP event path names with backing files

Some file systems like FUSE-based ones or overlayfs may record the backing
file in struct vm_area_struct vm_file, instead of the user file that the
user mmapped.

Since commit def3ae83da02f ("fs: store real path instead of fake path in
backing file f_path"), file_path() no longer returns the user file path
when applied to a backing file.  There is an existing helper
file_user_path() for that situation.

Use file_user_path() instead of file_path() to get the path for MMAP
and MMAP2 events.

Example:

  Setup:

    # cd /root
    # mkdir test ; cd test ; mkdir lower upper work merged
    # cp `which cat` lower
    # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdir=3D=
work merged
    # perf record -e intel_pt//u -- /root/test/merged/cat /proc/self/maps
    ...
    55b0ba399000-55b0ba434000 r-xp 00018000 00:1a 3419                       =
/root/test/merged/cat
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.060 MB perf.data ]
    #

  Before:

    File name is wrong (/cat), so decoding fails:

    # perf script --no-itrace --show-mmap-events
             cat     367 [016]   100.491492: PERF_RECORD_MMAP2 367/367: [0x55=
b0ba399000(0x9b000) @ 0x18000 00:02 3419 489959280]: r-xp /cat
    ...
    # perf script --itrace=3De | wc -l
    Warning:
    19 instruction trace errors
    19
    #

  After:

    File name is correct (/root/test/merged/cat), so decoding is ok:

    # perf script --no-itrace --show-mmap-events
                 cat     364 [016]    72.153006: PERF_RECORD_MMAP2 364/364: [=
0x55ce4003d000(0x9b000) @ 0x18000 00:02 3419 3132534314]: r-xp /root/test/mer=
ged/cat
    # perf script --itrace=3De
    # perf script --itrace=3De | wc -l
    0
    #

Fixes: def3ae83da02f ("fs: store real path instead of fake path in backing fi=
le f_path")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Cc: stable@vger.kernel.org
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cd63ec8..7b5c237 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9416,7 +9416,7 @@ static void perf_event_mmap_event(struct perf_mmap_even=
t *mmap_event)
 		 * need to add enough zero bytes after the string to handle
 		 * the 64bit alignment we do later.
 		 */
-		name =3D file_path(file, buf, PATH_MAX - sizeof(u64));
+		name =3D d_path(file_user_path(file), buf, PATH_MAX - sizeof(u64));
 		if (IS_ERR(name)) {
 			name =3D "//toolong";
 			goto cpy_name;

