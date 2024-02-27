Return-Path: <stable+bounces-24806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B90869657
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7BA1F2DCAD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF4313DBBC;
	Tue, 27 Feb 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fd9vlmcZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C413A259;
	Tue, 27 Feb 2024 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043041; cv=none; b=iCxUL3e7C3V7cnBVfn7RHZ1lxT70Wa0ejR3WOin2NEHor3MTyiIIruG6FosWamtQ7lK86OCSzOJzNr2nBbSnr14OWuUdv08M8TzMJ80dD4VqMG3pW3j4tlOCw0AynYAV3DKDURt7Vh8oSxG6kQ5pihW5iBfpBtG8yaADarJdRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043041; c=relaxed/simple;
	bh=DnFm7sG8yeP/dEiGSbdKuPU4B9pZCanc7//RfIc3h/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDlJXe4Kt4K4f9xcBly2zc8mgIIt9STrPkAa3DYFc107rm5UFuRtyOSno9Jy0tbAjDPYAfFQc/prY89lkLC+mKJmr7f2+g2fmrOVsd8DOkpxIorhCpTmB5ECbdWenoRRtgXyx/767TrYvXfl/oVRg7qxwnZZug3yhyY2lS4PZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fd9vlmcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205D0C433C7;
	Tue, 27 Feb 2024 14:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043041;
	bh=DnFm7sG8yeP/dEiGSbdKuPU4B9pZCanc7//RfIc3h/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fd9vlmcZrT8C7KZL6Q2B6gbN1VDl9JIxxxYNhAPX2FP6aZ9OzoB2Njs6NOfKu2S71
	 Zjwi88wkvCV84Is+hJAkeOaOrZW+xBxjstH90T4GaakcTF6n/XoD5cPA5BD3nEaWh5
	 Is5313N56c/9TUrboqQL3GuHho+hMjrf/aOlLsEg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gianmarco Lusvardi <glusvardi@posteo.net>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <quentin@isovalent.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 211/245] bpf, scripts: Correct GPL license name
Date: Tue, 27 Feb 2024 14:26:39 +0100
Message-ID: <20240227131622.063195323@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131615.098467438@linuxfoundation.org>
References: <20240227131615.098467438@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gianmarco Lusvardi <glusvardi@posteo.net>

[ Upstream commit e37243b65d528a8a9f8b9a57a43885f8e8dfc15c ]

The bpf_doc script refers to the GPL as the "GNU Privacy License".
I strongly suspect that the author wanted to refer to the GNU General
Public License, under which the Linux kernel is released, as, to the
best of my knowledge, there is no license named "GNU Privacy License".
This patch corrects the license name in the script accordingly.

Fixes: 56a092c89505 ("bpf: add script and prepare bpf.h for new helpers documentation")
Signed-off-by: Gianmarco Lusvardi <glusvardi@posteo.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Link: https://lore.kernel.org/bpf/20240213230544.930018-3-glusvardi@posteo.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 00ac7b79cddb4..7772c6424089e 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -369,7 +369,7 @@ eBPF programs can have an associated license, passed along with the bytecode
 instructions to the kernel when the programs are loaded. The format for that
 string is identical to the one in use for kernel modules (Dual licenses, such
 as "Dual BSD/GPL", may be used). Some helper functions are only accessible to
-programs that are compatible with the GNU Privacy License (GPL).
+programs that are compatible with the GNU General Public License (GNU GPL).
 
 In order to use such helpers, the eBPF program must be loaded with the correct
 license string passed (via **attr**) to the **bpf**\ () system call, and this
-- 
2.43.0




