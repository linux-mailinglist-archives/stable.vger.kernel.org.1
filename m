Return-Path: <stable+bounces-208480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D5D25DF2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 174BC300CB64
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8E3A35BE;
	Thu, 15 Jan 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDwvhKJ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88C25228D;
	Thu, 15 Jan 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495969; cv=none; b=FqEbkiRY6kgRS1iIW32KeHdKpLtlTMXLHsBNUWmGiJONZxcd+v7R8emW3MR3jiXrU+cgf9SXBbHMjI5Kunro54dDIRAt9reW07vOilmyN3waDhag2bkfODHS55F/iIYfQc/ebx99VuMiVw1DXzjwqs/SFX97gAiR8H9VZ0igxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495969; c=relaxed/simple;
	bh=ylfl4EAoDx/xaRG19cbsWxFhdwafYv8klDpKwJhU4oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ez6xIrpU0RKAOqvv7Uw9X4iM4cipFHn+YCbzeiSrWFzdm8JoCG0j3OuL/+1RVpz/JDnum+o9CDAtdSJnzursWiBX2EFXimMJNoEXW6BjpwAWOV6HRuuJ4gqhDybhOb1OjFRr7fR2ZuGMNjrMvTyhXQy/9MLxUBBOXn0LeBDEzd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDwvhKJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC80FC116D0;
	Thu, 15 Jan 2026 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768495969;
	bh=ylfl4EAoDx/xaRG19cbsWxFhdwafYv8klDpKwJhU4oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDwvhKJ1rb67bkK9WdwAbM9IrcuYwgEvZpQmlbo679plICxZzfhlQcsJ/7xKHqc0J
	 GU6pUzI/bd7rFq+hk3Qfoh4Yv7GYm0AtHAi+W2okrr6nPXPXhdO70HT369XKL7Bhfy
	 qLZZGtav3ZiEFWWx3zePDCNAqU6KeZo4j2vcy+yI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 030/181] drm/radeon: Remove __counted_by from ClockInfoArray.clockInfo[]
Date: Thu, 15 Jan 2026 17:46:07 +0100
Message-ID: <20260115164203.416434671@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
References: <20260115164202.305475649@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 19158c7332468bc28572bdca428e89c7954ee1b1 upstream.

clockInfo[] is a generic uchar pointer to variable sized structures
which vary from ASIC to ASIC.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4374
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dc135aa73561b5acc74eadf776e48530996529a3)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/pptable.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/pptable.h
+++ b/drivers/gpu/drm/radeon/pptable.h
@@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
     //sizeof(ATOM_PPLIB_CLOCK_INFO)
     UCHAR ucEntrySize;
     
-    UCHAR clockInfo[] __counted_by(ucNumEntries);
+    UCHAR clockInfo[] /*__counted_by(ucNumEntries)*/;
 }ClockInfoArray;
 
 typedef struct _NonClockInfoArray{



