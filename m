Return-Path: <stable+bounces-115346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A79A343D8
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FC613B0D6A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A45139566;
	Thu, 13 Feb 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bF1R8bop"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959C281375;
	Thu, 13 Feb 2025 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457731; cv=none; b=NAO4bqFHkFfPSts4m23l/fSjS5LdPdpQ9mzuSiHoigItGjwY2RQ8IU9CL6FmcCeV2la+z+5d3/1tncLgRvQlGb0ZGHKuddUACdE9vNMXx8S0/bGwjvU3b1YSYnE/D/AATISo4BuciBDj7qCnTwyxBrnNcX673GfNe3Tg45HgGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457731; c=relaxed/simple;
	bh=LHzH0im+gJybeH3fQ5HkVW3nYMxRyiA3AVm8hq/e2Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMXsM4Wsg+0RkUisYXhLTozb8suKaeljUpjcy1BMQHPQgYpN3OixpXbm8gWg77jqxcXgEgTKz90wO2pj1E6/386NXcI5ytDeFhUI0tk5jVsBFvvpefZ9F2xhSpTU5SkpVALbARrRBKPFpEw4fiQb+SBxNn4/W6YbFeRlAGAoFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bF1R8bop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD802C4CED1;
	Thu, 13 Feb 2025 14:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739457731;
	bh=LHzH0im+gJybeH3fQ5HkVW3nYMxRyiA3AVm8hq/e2Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF1R8bopdl8Udu3wzjIYWp90MHllA63eRbvmx5tkXHe0IctE4gUzAxzfUczsYtkm7
	 xYYyslHyh1rqmq4JPcFhFWXA/tLNnoeX5AlPk7MyXuDFA3QRMgN4CG8yr8+tp+i2ky
	 cwQ8/L7BnAImX9lso4/ikvu/hLuxqBSepb25C+mw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Harrison <John.C.Harrison@Intel.com>,
	Julia Filipchuk <julia.filipchuk@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.12 165/422] drm/xe/devcoredump: Move exec queue snapshot to Contexts section
Date: Thu, 13 Feb 2025 15:25:14 +0100
Message-ID: <20250213142442.911350256@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit 042c48b73699c47d84b6ace73036e5a31a0d4cfc upstream.

Having the exec queue snapshot inside a "GuC CT" section was always
wrong.  Commit c28fd6c358db ("drm/xe/devcoredump: Improve section
headings and add tile info") tried to fix that bug, but with that also
broke the mesa tool that parses the devcoredump, hence it was reverted
in commit a53da2fb25a3 ("drm/xe: Revert some changes that break a mesa
debug tool").

With the mesa tool also fixed, this can propagate as a fix on both
kernel and userspace side to avoid unnecessary headache for a debug
feature.

Cc: John Harrison <John.C.Harrison@Intel.com>
Cc: Julia Filipchuk <julia.filipchuk@intel.com>
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: stable@vger.kernel.org
Fixes: a53da2fb25a3 ("drm/xe: Revert some changes that break a mesa debug tool")
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250123051112.1938193-2-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit a37934ea75d331fafa7fe80b6180642ba5193422)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_devcoredump.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/gpu/drm/xe/xe_devcoredump.c
+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
@@ -104,11 +104,7 @@ static ssize_t __xe_devcoredump_read(cha
 	drm_puts(&p, "\n**** GuC CT ****\n");
 	xe_guc_ct_snapshot_print(ss->ct, &p);
 
-	/*
-	 * Don't add a new section header here because the mesa debug decoder
-	 * tool expects the context information to be in the 'GuC CT' section.
-	 */
-	/* drm_puts(&p, "\n**** Contexts ****\n"); */
+	drm_puts(&p, "\n**** Contexts ****\n");
 	xe_guc_exec_queue_snapshot_print(ss->ge, &p);
 
 	drm_puts(&p, "\n**** Job ****\n");



