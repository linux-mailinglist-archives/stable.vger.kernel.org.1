Return-Path: <stable+bounces-64275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5082941D4A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B03B244B2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF5F18A6A6;
	Tue, 30 Jul 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FkoLq8VZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43F1898E0;
	Tue, 30 Jul 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359581; cv=none; b=DeXUwtbIHoHfqeU/00ePJVn+PteKXqoXq/nv/YBVpJJ4EwNgJIvS1TYmcynOE9Z9KEbHkhXCBVaz77ZXkH+cr3ww5066z3w4Fy2cadoYtASTueRaGq2spYnBkqjxhPqnp56f+PZxiEfcUndCQLuLaxseD5R9EniPUAOX5/6TmTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359581; c=relaxed/simple;
	bh=ZYRg2wsJjih4bTdgMTxynCPaIIMdnF/DrR6Yhd5uLKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVmyBpzNkPmk2UaDPbQ9KBJXfglLT85rlASrFdrll+Yg597yvLH4E1ayznuvKqgPh8V0WPD45MKZwXRnoUTJRYH37jQdikMtxDT9/VhwXrJ7b1sG6hcvNW/r983ZS5iKkyo2xQFP+IbDrXHBCL23QIf40+t8XBO5WrGzyMFcg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FkoLq8VZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664AAC32782;
	Tue, 30 Jul 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359580;
	bh=ZYRg2wsJjih4bTdgMTxynCPaIIMdnF/DrR6Yhd5uLKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkoLq8VZMKcZQUIbaJ8EkzVIKiW8+gHzfIOvCuIWvlAB6QlYhZdVHng6NGzE6uA6W
	 L98/FZ88Le9F8XXFwIaFQagqPvQF6WcPi4FA2k57S7AwrgwZpBh3yiILLLtaML7Jbu
	 kfk37uwEkkYFkuCN2IqRIIijtoxMNZ/xvfWOLeFo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 6.6 504/568] lib/build_OID_registry: dont mention the full path of the script in output
Date: Tue, 30 Jul 2024 17:50:11 +0200
Message-ID: <20240730151659.726638765@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 5ef6dc08cfde240b8c748733759185646e654570 upstream.

This change strips the full path of the script generating
lib/oid_registry_data.c to just lib/build_OID_registry.  The motivation
for this change is Yocto emitting a build warning

	File /usr/src/debug/linux-lxatac/6.7-r0/lib/oid_registry_data.c in package linux-lxatac-src contains reference to TMPDIR [buildpaths]

So this change brings us one step closer to make the build result
reproducible independent of the build path.

Link: https://lkml.kernel.org/r/20240313211957.884561-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/build_OID_registry |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -8,6 +8,7 @@
 #
 
 use strict;
+use Cwd qw(abs_path);
 
 my @names = ();
 my @oids = ();
@@ -17,6 +18,8 @@ if ($#ARGV != 1) {
     exit(2);
 }
 
+my $abs_srctree = abs_path($ENV{'srctree'});
+
 #
 # Open the file to read from
 #
@@ -35,7 +38,7 @@ close IN_FILE || die;
 #
 open C_FILE, ">$ARGV[1]" or die;
 print C_FILE "/*\n";
-print C_FILE " * Automatically generated by ", $0, ".  Do not edit\n";
+print C_FILE " * Automatically generated by ", $0 =~ s#^\Q$abs_srctree/\E##r, ".  Do not edit\n";
 print C_FILE " */\n";
 
 #



