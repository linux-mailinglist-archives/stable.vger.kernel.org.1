Return-Path: <stable+bounces-38615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0628A0F8C
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03131C212B1
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D26146A72;
	Thu, 11 Apr 2024 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+JIqOqE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AFE140E3D;
	Thu, 11 Apr 2024 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831091; cv=none; b=nQ/6pwv6SruRKBE1IdLjanYdvxvAS7a75N3uJPNvPzxw5aIkhjApJKZ+3nFgdw1elx4a7T0k1zaBC8nKVU6ZsaYGNLFvupaKQ8aO1rhLuxTQfMUP24LaT8YFnqEYgsNi8yPgV1xBMQDZ5z8H8TRuSOaT9MigrFhLHmchSX5fi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831091; c=relaxed/simple;
	bh=7rrb036arbG4HXlLeM04ulNPRgH/aGWcH9SI35UzofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dq+UL9EmWYkI/PdJK2MYKX36zsh6vt9++eNaNz6zhBUvJ8XQny5EpxbaUxJphwoIwWoIGVQqFaK0nTNjn0pa1hgXttYjZ7HitblICq2L6TL5xgE9tFBHWaUaaj1bdboWuhXdq79Pa+iD02WoMJMxlCg2kZaRyxs7Vu5p6sIOmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+JIqOqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3FEC433C7;
	Thu, 11 Apr 2024 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831090;
	bh=7rrb036arbG4HXlLeM04ulNPRgH/aGWcH9SI35UzofE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+JIqOqE0SY7/h6GySLGFFihf4Top6igUE14q2NXGfMKUbdo+RwRDkyVs+BdLZf3T
	 ljgLmjoxxGPPxVhK2AeVOGeavxihKjta5EoDf2CzVZFmVjyzBj8H+JJvaq/KDYYjcK
	 smlNF0RlRhKwsAwCHKUgo0dGSaFUBzGZsZWz5gDY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Hawley <warthog9@eaglescrag.net>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 195/215] ktest: force $buildonly = 1 for make_warnings_file test type
Date: Thu, 11 Apr 2024 11:56:44 +0200
Message-ID: <20240411095430.723491111@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo B. Marliere <ricardo@marliere.net>

[ Upstream commit 07283c1873a4d0eaa0e822536881bfdaea853910 ]

The test type "make_warnings_file" should have no mandatory configuration
parameters other than the ones required by the "build" test type, because
its purpose is to create a file with build warnings that may or may not be
used by other subsequent tests. Currently, the only way to use it as a
stand-alone test is by setting POWER_CYCLE, CONSOLE, SSH_USER,
BUILD_TARGET, TARGET_IMAGE, REBOOT_TYPE and GRUB_MENU.

Link: https://lkml.kernel.org/r/20240315-ktest-v2-1-c5c20a75f6a3@marliere.net

Cc: John Hawley <warthog9@eaglescrag.net>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/ktest/ktest.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 698b99e25f980..d36612c620981 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -768,6 +768,7 @@ sub set_value {
     if ($lvalue =~ /^(TEST|BISECT|CONFIG_BISECT)_TYPE(\[.*\])?$/ &&
 	$prvalue !~ /^(config_|)bisect$/ &&
 	$prvalue !~ /^build$/ &&
+	$prvalue !~ /^make_warnings_file$/ &&
 	$buildonly) {
 
 	# Note if a test is something other than build, then we
-- 
2.43.0




