Return-Path: <stable+bounces-55034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C4915179
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 17:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1764F1F21A05
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676B419B3EF;
	Mon, 24 Jun 2024 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6yhnEcH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400E19B3ED
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241759; cv=none; b=l9E/gsXcJwUS8TLBWJ+7fseMbQ7Iu/RrqBCOX+fnkBo3Rj7DAARY7dyf/QJkOjI1a9UVvno9yX8wJTyHIO4oih2Pqy9yfK1Vt3g66SQir1WBBjW1Qn9+m2J/F1r2fbRYy95PFaAsKLxFzj9uPJCTgswWG83mBPuBDaGrGak8hgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241759; c=relaxed/simple;
	bh=QcuAkur8EHz/khA5gyvnXGlycV8XmoiVN3eQb4MxaHE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s10XwdNekt3yisx8sCIzTzvyh718ZGf5MTTNhT3+W6C38t2BZzvNfKB0qaxREpadjZWPbdlTIkrulrgcOL9GS40y/oL+i1gzyBWjnFM98DaGUYdAZywzJzWeCFmIwJKiQQJ7ptGhVaRTepFQasSaJBBlApZ2eKiCFANK4R0X7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6yhnEcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55642C2BBFC;
	Mon, 24 Jun 2024 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719241758;
	bh=QcuAkur8EHz/khA5gyvnXGlycV8XmoiVN3eQb4MxaHE=;
	h=Subject:To:Cc:From:Date:From;
	b=z6yhnEcHswevFbFiyA1+C6fJZn9RRQpEHlaXkHjL5xBv+7JRDyBjxaNO1vTipu0s5
	 eMh3+WGQlJRUkZ5hfKTB0vucJo32PUSAUfn8fRjfpjiRpCUT9peUzYa7VCA23comQk
	 UpA04Rfi7dhiZ7+G2mXyV8Mf3ShqzlIhN0uWk0CA=
Subject: FAILED: patch "[PATCH] cifs: fix typo in module parameter enable_gcm_256" failed to apply to 5.15-stable tree
To: stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Jun 2024 17:09:12 +0200
Message-ID: <2024062411-ipad-conical-35fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8bf0287528da1992c5e49d757b99ad6bbc34b522
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024062411-ipad-conical-35fb@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bf0287528da1992c5e49d757b99ad6bbc34b522 Mon Sep 17 00:00:00 2001
From: Steve French <stfrench@microsoft.com>
Date: Wed, 19 Jun 2024 14:46:48 -0500
Subject: [PATCH] cifs: fix typo in module parameter enable_gcm_256

enable_gcm_256 (which allows the server to require the strongest
encryption) is enabled by default, but the modinfo description
incorrectly showed it disabled by default. Fix the typo.

Cc: stable@vger.kernel.org
Fixes: fee742b50289 ("smb3.1.1: enable negotiating stronger encryption by default")
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index bb86fc0641d8..6397fdefd876 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -134,7 +134,7 @@ module_param(enable_oplocks, bool, 0644);
 MODULE_PARM_DESC(enable_oplocks, "Enable or disable oplocks. Default: y/Y/1");
 
 module_param(enable_gcm_256, bool, 0644);
-MODULE_PARM_DESC(enable_gcm_256, "Enable requesting strongest (256 bit) GCM encryption. Default: n/N/0");
+MODULE_PARM_DESC(enable_gcm_256, "Enable requesting strongest (256 bit) GCM encryption. Default: y/Y/0");
 
 module_param(require_gcm_256, bool, 0644);
 MODULE_PARM_DESC(require_gcm_256, "Require strongest (256 bit) GCM encryption. Default: n/N/0");


