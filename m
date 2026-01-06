Return-Path: <stable+bounces-205158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F0CF9D0A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A26307E262
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AA6346FC0;
	Tue,  6 Jan 2026 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rkLceOUZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3820346E6B;
	Tue,  6 Jan 2026 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719775; cv=none; b=MXftL7FonFGXZCFEyYllXdE8L4Kzd+8Dmt0GFIH0BCAsxo0dvd8vI+U5REbZFxHV1IQkl7Rh70xscR9JAEIs7oF9nzAeqG3bNfrOq+mDt+1U6FT602h39CralZ5DlknDba9KD1FwsRfeOabo65mJX2HzDPNLlA4PaaiaR+RKHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719775; c=relaxed/simple;
	bh=EAsGrYDNYs+ejpY2X8FkkhCy43ArdKGI0/1fnjMQdis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPU5f0a1x5+mC0Belql0s5vB+fABEIXr730sOEdf4b+lS2mKVKK+PrwGzkxIGy/yamADNxCzSO/3UQCXpj0pOQb6mPfdKrRxEjUOcQjwrpoaXY45ftbeUZBa/6pmYIZdYtwogvwFEiEgpWmcIg9F5Pypng63Q5+u21hsLAFkytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rkLceOUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47618C116C6;
	Tue,  6 Jan 2026 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767719775;
	bh=EAsGrYDNYs+ejpY2X8FkkhCy43ArdKGI0/1fnjMQdis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkLceOUZtxvJJd6igcVhNbEDRWIdsVyC1m6vTn2zeNtnKLsZ6RYMjyXD7QkH4DEkx
	 L1WmPdaY6S1cmvHdTmCwp9K1X5YyiiM4BkOlgxcAp4UFUHvkKYCPR7+K0C5/YZ0xnW
	 5Y6Ge8eZK/0L80I1OqtNG/fb2un7LQ4ua97wOdN4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pankaj Raghav <p.raghav@samsung.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 008/567] scripts/faddr2line: Fix "Argument list too long" error
Date: Tue,  6 Jan 2026 17:56:30 +0100
Message-ID: <20260106170451.651358612@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Pankaj Raghav <p.raghav@samsung.com>

[ Upstream commit ff5c0466486ba8d07ab2700380e8fd6d5344b4e9 ]

The run_readelf() function reads the entire output of readelf into a
single shell variable. For large object files with extensive debug
information, the size of this variable can exceed the system's
command-line argument length limit.

When this variable is subsequently passed to sed via `echo "${out}"`, it
triggers an "Argument list too long" error, causing the script to fail.

Fix this by redirecting the output of readelf to a temporary file
instead of a variable. The sed commands are then modified to read from
this file, avoiding the argument length limitation entirely.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/faddr2line | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 1fa6beef9f978..477b6d2aa3179 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -107,14 +107,19 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-	local out=$(${READELF} --file-header --section-headers --symbols --wide $objfile)
+	local tmpfile
+	tmpfile=$(mktemp)
+
+	${READELF} --file-header --section-headers --symbols --wide "$objfile" > "$tmpfile"
 
 	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
 	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
 	# line when multiple options are given, so let's also match with the "Section Headers:" line.
-	ELF_FILEHEADER=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p')
-	ELF_SECHEADERS=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
-	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
+	ELF_FILEHEADER=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p' "$tmpfile")
+	ELF_SECHEADERS=$(sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' "$tmpfile" | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
+	ELF_SYMS=$(sed -n '/Symbol table .* contains [0-9]* entries:/,$p' "$tmpfile")
+
+	rm -f -- "$tmpfile"
 }
 
 check_vmlinux() {
-- 
2.51.0




