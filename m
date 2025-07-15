Return-Path: <stable+bounces-162580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A8B05EC8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63B5189DFF8
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0A2EACEB;
	Tue, 15 Jul 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0nF8Tvtu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41E2EA468;
	Tue, 15 Jul 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586930; cv=none; b=R8EmIez+M6QZfozffc6uKa5RC3zpxbnf1AfN5qNVVvYrXO22KcrpauvaZF6KLY5fQ647Y8Fk8RK++oM+Q/+4ehGmjOPPqXFxAb4pnP7KpXhHbCOKRLY4UB5GUaw6cwkyBvL6uRsOV5c+moIt5n9TEUrI+VqCD+ykduDG3pEbbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586930; c=relaxed/simple;
	bh=kmt/bdk/lfJa3WD0ja3CdXhyDTsSoz2sdutLw7u2lME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCYefAkvlvbzuBpDRJnXCB9yn92Dt+NbPg4KKnCg415eOaY6ahUZkrZq4bfUAdV75Pdz+i/msYLV/MdP/V+3o20Bf2ge1y9pPI4uup2apopINgBCrB+XTPk7w9u3UiODVK1Iqra3Ek960QaFHuizTpCqRORwA/w0PCjORbAtZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0nF8Tvtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBF8C4CEE3;
	Tue, 15 Jul 2025 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586930;
	bh=kmt/bdk/lfJa3WD0ja3CdXhyDTsSoz2sdutLw7u2lME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0nF8TvtuoWh2Twga2D5pX/K/W5y8pqQqQxSZ2A7bM+2MbIXJcZTVkBgVldFldtgBB
	 bt9gfOdHKL3mhvcIW9aZifJZtdB1cN+J5ueRa6Q20yNYTNNJ78J1qdkStGjnz568Ks
	 hZBwmkaMRuTUqVJq/6ecXpj3iJXotObxAgXzPhuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.15 103/192] scripts/gdb: de-reference per-CPU MCE interrupts
Date: Tue, 15 Jul 2025 15:13:18 +0200
Message-ID: <20250715130819.022815023@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <florian.fainelli@broadcom.com>

commit 50f4d2ba26d5c3a4687ae0569be3bbf1c8f0cbed upstream.

The per-CPU MCE interrupts are looked up by reference and need to be
de-referenced before printing, otherwise we print the addresses of the
variables instead of their contents:

MCE: 18379471554386948492   Machine check exceptions
MCP: 18379471554386948488   Machine check polls

The corrected output looks like this instead now:

MCE:          0   Machine check exceptions
MCP:          1   Machine check polls

Link: https://lkml.kernel.org/r/20250625021109.1057046-1-florian.fainelli@broadcom.com
Link: https://lkml.kernel.org/r/20250624030020.882472-1-florian.fainelli@broadcom.com
Fixes: b0969d7687a7 ("scripts/gdb: print interrupts")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/gdb/linux/interrupts.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/gdb/linux/interrupts.py
+++ b/scripts/gdb/linux/interrupts.py
@@ -110,7 +110,7 @@ def x86_show_mce(prec, var, pfx, desc):
     pvar = gdb.parse_and_eval(var)
     text = "%*s: " % (prec, pfx)
     for cpu in cpus.each_online_cpu():
-        text += "%10u " % (cpus.per_cpu(pvar, cpu))
+        text += "%10u " % (cpus.per_cpu(pvar, cpu).dereference())
     text += "  %s\n" % (desc)
     return text
 



