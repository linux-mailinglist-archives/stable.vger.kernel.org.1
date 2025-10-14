Return-Path: <stable+bounces-185603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F22BD83BF
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA23424C8E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777C52D94AA;
	Tue, 14 Oct 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aproOJg5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajoRuPr1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8D189F43;
	Tue, 14 Oct 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431344; cv=none; b=brybYGXLbmbXw/qkReRWml1Q4kBGbT7ecu1nfjQDvA+aKt3Boeday/E3wPNMzT/SXLK9Reflu3oHiVcIgcCS0Z3ZUFdhkhb3jAqFE2xXLmJon+pPo6rbp5ua/3jAx2Gp67bDR4M0PccYc/PUiZL4hbP9A9xFo43bhDjjgzuokE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431344; c=relaxed/simple;
	bh=YS5XJeSWQqc+vm3Wm1SQnwAWP7yFFRbq6T6QGqvmAok=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iAWvLmtFx1xJBwbWoSDjBeoQ436nm95l+jMqrPOV7bxSdIHLeQlglHJLOY9TWVDc0ON2gIxbZljwqvJm7LGIexeuCX8dxmrlcaakxG51Ez5QiGqTT9t+bCV0/MojOmzx3cLP9rsEp3Xx0xdGV2RUuEXuglLxmkeLBP6uTKoP158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aproOJg5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ajoRuPr1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 08:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760431341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhPOfcGRAKbkRlEHJSBfosIxcIIlidJsPE2T2uStmNA=;
	b=aproOJg5BeDJBz7De5O5Yo+Q53hhSxSndj3KNMTieB9cKwVhiUHpSUfvwl0L4cvvEuXz2y
	i5Ajd67atbSLrRpCJf4iXDxXI9lqcIYpQm3b4iEmwuccF5cRgd8H93SI0sixpJCI75B0VG
	AYMhy1/rm9WLO7bPv9sJ1sup+Yv3nlFppbtXIjhLjp2OW28sFxfgz7TXLB704k1zhJyima
	mSnKxe/RCxyS375waqJN62C/iGop+Qnacm7iJLA4SMYcGj4qOZOGlANxBpejcTZpeWaUwt
	+Ma/PcEvM1k6n59YlEofvYf8iIALGl0iVe8ec+jbIZ2aRKs0am+8+zXF2P4+sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760431341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhPOfcGRAKbkRlEHJSBfosIxcIIlidJsPE2T2uStmNA=;
	b=ajoRuPr1bzTCndXlp0lr3sJtdXDW3RKx7GS4Q9zYKqc/ifSmzrau+/DzYUjdRDuiLkXBc6
	Hnj83tscmC0EmVCg==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix address filter match with backing files
Cc: Edd Barrett <edd@theunixzoo.co.uk>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Amir Goldstein <amir73il@gmail.com>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.8@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013072244.82591-2-adrian.hunter@intel.com>
References: <20251013072244.82591-2-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176043133968.709179.15062959887826741046.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ebfc8542ad62d066771e46c8aa30f5624b89cad8
Gitweb:        https://git.kernel.org/tip/ebfc8542ad62d066771e46c8aa30f5624b8=
9cad8
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 13 Oct 2025 10:22:42 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 10:38:09 +02:00

perf/core: Fix address filter match with backing files

It was reported that Intel PT address filters do not work in Docker
containers.  That relates to the use of overlayfs.

overlayfs records the backing file in struct vm_area_struct vm_file,
instead of the user file that the user mmapped.  In order for an address
filter to match, it must compare to the user file inode.  There is an
existing helper file_user_inode() for that situation.

Use file_user_inode() instead of file_inode() to get the inode for address
filter matching.

Example:

  Setup:

    # cd /root
    # mkdir test ; cd test ; mkdir lower upper work merged
    # cp `which cat` lower
    # mount -t overlay overlay -olowerdir=3Dlower,upperdir=3Dupper,workdir=3D=
work merged
    # perf record --buildid-mmap -e intel_pt//u --filter 'filter * @ /root/te=
st/merged/cat' -- /root/test/merged/cat /proc/self/maps
    ...
    55d61d246000-55d61d2e1000 r-xp 00018000 00:1a 3418                       =
/root/test/merged/cat
    ...
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.015 MB perf.data ]
    # perf buildid-cache --add /root/test/merged/cat

  Before:

    Address filter does not match so there are no control flow packets

    # perf script --itrace=3De
    # perf script --itrace=3Db | wc -l
    0
    # perf script -D | grep 'TIP.PGE' | wc -l
    0
    #

  After:

    Address filter does match so there are control flow packets

    # perf script --itrace=3De
    # perf script --itrace=3Db | wc -l
    235
    # perf script -D | grep 'TIP.PGE' | wc -l
    57
    #

With respect to stable kernels, overlayfs mmap function ovl_mmap() was
added in v4.19 but file_user_inode() was not added until v6.8 and never
back-ported to stable kernels.  FMODE_BACKING that it depends on was added
in v6.5.  This issue has gone largely unnoticed, so back-porting before
v6.8 is probably not worth it, so put 6.8 as the stable kernel prerequisite
version, although in practice the next long term kernel is 6.12.

Closes: https://lore.kernel.org/linux-perf-users/aBCwoq7w8ohBRQCh@fremen.lan
Reported-by: Edd Barrett <edd@theunixzoo.co.uk>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
Cc: stable@vger.kernel.org # 6.8
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f..cd63ec8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9492,7 +9492,7 @@ static bool perf_addr_filter_match(struct perf_addr_fil=
ter *filter,
 	if (!filter->path.dentry)
 		return false;
=20
-	if (d_inode(filter->path.dentry) !=3D file_inode(file))
+	if (d_inode(filter->path.dentry) !=3D file_user_inode(file))
 		return false;
=20
 	if (filter->offset > offset + size)

