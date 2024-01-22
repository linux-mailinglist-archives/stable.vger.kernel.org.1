Return-Path: <stable+bounces-14908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D449983831E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C70F1F26D71
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BB5787B;
	Tue, 23 Jan 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="as2bneST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE850253;
	Tue, 23 Jan 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705974709; cv=none; b=WmeCCr+Qbxh64D1+yHKgjHQyAybAeOta/W1sZ5RWESZm7jzOndjCYzKXgldLleR7JxZdv49Yclteld4UwsnVLPymeFjaFZGT/CIUxEseB+i46ubVKv9xP5L3CctPXjeNU36g0FmSjc+dRNiNf2RN3n+6Ipf9WhXhd949oivZfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705974709; c=relaxed/simple;
	bh=0NqCcdcHuoDmT+uXXvLSA+l139rEWAG5YhQYamZ+Bc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8D7ZLWmN4f/xlHqPfgGyiS3klo3GiSJCWqInF67zVZ4cgl7bHv/sqX2PL2lg34is72wSg44AQyG6fE9PVuOFq7zN8jIYJp+MKr6eaowqscmFJW/Wo8ahTDsLgXvVPfWGB+WW/+fpt0kUkFc4zasW9pVgTYYeHlrMoUYKjtLy9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=as2bneST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C538BC433C7;
	Tue, 23 Jan 2024 01:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705974708;
	bh=0NqCcdcHuoDmT+uXXvLSA+l139rEWAG5YhQYamZ+Bc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=as2bneSThAVjPyzCaZnaJszX/cQf61Z2dITMJ0+sApf6KT5nOAj0nG6UGCYIDaUtC
	 XGt9fPcAC+0rI7tTOeIA6XbqwTkBokoE69jjRYCR6DQB5U7Stw/U04DRNHzxyJ4QbN
	 Uscu9ZVaOZ68/s6PdqejhbCmQ6GV4fW3uUhM29Wk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	RD Babiera <rdbabiera@google.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 5.15 261/374] Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"
Date: Mon, 22 Jan 2024 15:58:37 -0800
Message-ID: <20240122235753.839880035@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235744.598274724@linuxfoundation.org>
References: <20240122235744.598274724@linuxfoundation.org>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 9c6b789e954fae73c548f39332bcc56bdf0d4373 upstream.

This reverts commit b17b7fe6dd5c6ff74b38b0758ca799cdbb79e26e.

That commit messed up the reference counting, so it needs to
be rethought.

Fixes: b17b7fe6dd5c ("usb: typec: class: fix typec_altmode_put_partner to put plugs")
Cc:  <stable@vger.kernel.org>
Cc: RD Babiera <rdbabiera@google.com>
Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Closes: https://lore.kernel.org/lkml/CAP-bSRb3SXpgo_BEdqZB-p1K5625fMegRZ17ZkPE1J8ZYgEHDg@mail.gmail.com/
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240102091142.2136472-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/class.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -265,7 +265,7 @@ static void typec_altmode_put_partner(st
 	if (!partner)
 		return;
 
-	adev = &altmode->adev;
+	adev = &partner->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -495,8 +495,7 @@ static void typec_altmode_release(struct
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	if (!is_typec_port(dev->parent))
-		typec_altmode_put_partner(alt);
+	typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);



