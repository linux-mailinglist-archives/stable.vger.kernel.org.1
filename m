Return-Path: <stable+bounces-162056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E991B05B56
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06081565823
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94232E2F17;
	Tue, 15 Jul 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="doLjw0z+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BD1A5B9D;
	Tue, 15 Jul 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585556; cv=none; b=dwYjOkEQU6TwojS2JaT/b1fQXARFnPQcnVjKdRAmDp6g0+UziBDjsmF398I0O5YC56I3u8ISNGweLjA3yL9/Eb5tVislt9RkR8vOspe/1cD4e62nIuKxxZ3BsFoRPC9vMtdWPf3MvvRG2wlSSLexOsQji1XXmrOq+Qj79AGhkgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585556; c=relaxed/simple;
	bh=loVkRoNoWOnlNzh7PuGxrJGlQRmyH/Fe7WGjG2DLotw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/l8a2IAoFerA/21MG3Og+DVSzQyKxxEsIQ6GEVAtjeQHN59UvXGSovy6h4y7qzD/Gj53C29tdLjzkzMMgiBzYJVqLkCLHryGSrTSZr780YwYHcI06CK5pU+ITj65V9fxvIa7YzgjE9Eevn1ESvt2sUmb+EX5DuK/53LeLyiKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=doLjw0z+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EC9C4CEE3;
	Tue, 15 Jul 2025 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585556;
	bh=loVkRoNoWOnlNzh7PuGxrJGlQRmyH/Fe7WGjG2DLotw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doLjw0z+uDBW//nAyySrfC+NsuBs0oCKonD8sSAoQYReDMKeRSBxxuEOuZfhD9O+p
	 s/PWrslNe69iFLw8RjZd7M/AB9wFFEoNCsX+jmqKglRsKgq+1MEPUbQ488eIzJ9PHr
	 ANylwDn3gRD3G8QNwBVzC5LDTeVVuGHwViCwvzbI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aijay Adams <aijay@meta.com>,
	JP Kobryn <inwardvessel@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	stable@kernel.org
Subject: [PATCH 6.12 053/163] x86/mce: Make sure CMCI banks are cleared during shutdown on Intel
Date: Tue, 15 Jul 2025 15:12:01 +0200
Message-ID: <20250715130810.882911857@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: JP Kobryn <inwardvessel@gmail.com>

commit 30ad231a5029bfa16e46ce868497b1a5cdd3c24d upstream.

CMCI banks are not cleared during shutdown on Intel CPUs. As a side effect,
when a kexec is performed, CPUs coming back online are unable to
rediscover/claim these occupied banks which breaks MCE reporting.

Clear the CPU ownership during shutdown via cmci_clear() so the banks can
be reclaimed and MCE reporting will become functional once more.

  [ bp: Massage commit message. ]

Reported-by: Aijay Adams <aijay@meta.com>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/20250627174935.95194-1-inwardvessel@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/intel.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -477,6 +477,7 @@ void mce_intel_feature_init(struct cpuin
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
 
 bool intel_filter_mce(struct mce *m)



