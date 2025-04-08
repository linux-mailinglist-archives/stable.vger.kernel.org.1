Return-Path: <stable+bounces-129665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6053A800B1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24D81888E2A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97C3268FE5;
	Tue,  8 Apr 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smxVv0D1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AC9267F65;
	Tue,  8 Apr 2025 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111652; cv=none; b=K4AnCADpDtE3BYL8Fxzvl3W1nBvn42dt0+mvFjOBXYH4PSHAmDozT8PWsgakg/+cFNHGFXT5j4FCEL6bEfpALdetLMWvmwzukCZ91U04IOEL30adak3cVjbVSbtzOSiZRAU9WKT9psGvppV4v38aU3ssbLZKiXg1Z7Kz2G53PWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111652; c=relaxed/simple;
	bh=O6K/vQLIyU7g0e0FWCrR6jYFew9AAvx95OGynDYTEnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD7jl2oPoRs3hVSux9IT0IFwYPOE+H3onptKWkjVhYT76J4Z93bPN70xwMpZNVl5XRZceVvCHnbhH5M+vAxdMRnK8imxqWtlr8XZaXibGANpwRGDfknZHg+vvV0eethFJ3eF5tSl4ci33Ep8SBDbK8Sst//+Npe1PDlwrmbLnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smxVv0D1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B598EC4CEEE;
	Tue,  8 Apr 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111652;
	bh=O6K/vQLIyU7g0e0FWCrR6jYFew9AAvx95OGynDYTEnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smxVv0D1cHzjcnoEthej+3UORa/2fc22dAflG/ISIHWm25PVn84Tc3A3Defo3TOqK
	 JEbIJEHJAA0Wo5xISGgTM2My81DN9g0yaQOTGiM96M3ClWpMwiWc1+ZrPmzEgXmgk+
	 E1mvczMaqPFQ0SEn0EKAto333uDvvBTmRJQOGhhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 469/731] perf build: Fix in-tree build due to symbolic link
Date: Tue,  8 Apr 2025 12:46:06 +0200
Message-ID: <20250408104925.187914198@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit 75100d848ef4b8ca39bb6dd3a21181e37dea27e2 ]

Building perf in-tree is broken after commit 890a1961c812 ("perf tools:
Create source symlink in perf object dir") which added a 'source' symlink
in the output dir pointing to the source dir.

With in-tree builds, the added 'SOURCE = ...' line is executed multiple
times (I observed 2 during the build plus 2 during installation). This is a
minor inefficiency, in theory not harmful because symlink creation is
assumed to be idempotent. But it is not.

Considering with in-tree builds:

  srctree=/absolute/path/to/linux
   OUTPUT=/absolute/path/to/linux/tools/perf

here's what happens:

 1. ln -sf $(srctree)/tools/perf $(OUTPUT)/source
    -> creates /absolute/path/to/linux/tools/perf/source
       link to /absolute/path/to/linux/tools/perf
    => OK, that's what was intended
 2. ln -sf $(srctree)/tools/perf $(OUTPUT)/source   # same command as 1
    -> creates /absolute/path/to/linux/tools/perf/perf
       link to /absolute/path/to/linux/tools/perf
    => Not what was intended, not idempotent
 3. Now the build _should_ create the 'perf' executable, but it fails

The reason is the tricky 'ln' command line. At the first invocation 'ln'
uses the 1st form:

       ln [OPTION]... [-T] TARGET LINK_NAME

and creates a link to TARGET *called LINK_NAME*.

At the second invocation $(OUTPUT)/source exists, so 'ln' uses the 3rd
form:

       ln [OPTION]... TARGET... DIRECTORY

and creates a link to TARGET *called TARGET* inside DIRECTORY.

Fix by adding -n/--no-dereference to "treat LINK_NAME as a normal file
if it is a symbolic link to a directory", as the manpage says.

Closes: https://lore.kernel.org/all/20241125182506.38af9907@booty/
Fixes: 890a1961c812 ("perf tools: Create source symlink in perf object dir")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Link: https://lore.kernel.org/r/20250124-perf-fix-intree-build-v1-1-485dd7a855e4@bootlin.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 05c083bb11220..eea8877c7cba3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -158,7 +158,7 @@ ifneq ($(OUTPUT),)
 VPATH += $(OUTPUT)
 export VPATH
 # create symlink to the original source
-SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
+SOURCE := $(shell ln -sfn $(srctree)/tools/perf $(OUTPUT)/source)
 endif
 
 # Do not use make's built-in rules
-- 
2.39.5




