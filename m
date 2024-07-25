Return-Path: <stable+bounces-61735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C3993C5B7
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1A228185A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7019D88F;
	Thu, 25 Jul 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aVrVykZr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895D319D88A;
	Thu, 25 Jul 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919273; cv=none; b=lcCx6TIY7KLfPsNczSCPfy5ZD73+TLs2J96kX7IRJBDRjfj0K+tn4Q61zRaR1Nm2LJT8O4j/rovgQfSZoTioa9h70lVC8OV+7IeAzN4eYSfYpl/BdgTTnTP9JQ/dBTHqseMcR1qqb5CjqQNY91k8Elw1LCtMjyMLjSUFk0cBPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919273; c=relaxed/simple;
	bh=PsRRiYbeSmm2DqW92L/rq3OxLrG3TMaFI+v/Sztag1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPHM3a1IhJNfbPIO9c3nm0UZvgXOUbFlnku3WjXdaHv5GEfSHFsQd0hwHL+/uR/GcM013D4Wvdvo0jYFItwqj4slavJ8ZkjU5MBpaQuGBINQMQLM281VGKuPbd6Ja6TkZ3r938neZdZg6sLs0GOmkZO+0qgTSxlwgA6zuTiggno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aVrVykZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8748DC116B1;
	Thu, 25 Jul 2024 14:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721919273;
	bh=PsRRiYbeSmm2DqW92L/rq3OxLrG3TMaFI+v/Sztag1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVrVykZr90nMVF3aBGDmUJl4qaBJ0Ty3gGxSjVQtrEln1tQO1uH8Vqk+vnlxfDsqE
	 +p+nfF2yeT6WmgMI0QXX+Y3xIfHTIoamxd0/nHi1X65QD15V7PYxufXJyQ/L5ZYwFf
	 dXjygI1y/OacXjRTm6JcZ6QtFIIEz0h0TSrESizQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 77/87] Add gitignore file for samples/fanotify/ subdirectory
Date: Thu, 25 Jul 2024 16:37:50 +0200
Message-ID: <20240725142741.343975788@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725142738.422724252@linuxfoundation.org>
References: <20240725142738.422724252@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit c107fb9b4f8338375b3e865c3d2c1d98ccb3a95a ]

Commit 5451093081db ("samples: Add fs error monitoring example") added a
new sample program, but didn't teach git to ignore the new generated
files, causing unnecessary noise from 'git status' after a full build.

Add the 'fs-monitor' sample executable to the .gitignore for this
subdirectory to silence it all again.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/fanotify/.gitignore |    1 +
 1 file changed, 1 insertion(+)
 create mode 100644 samples/fanotify/.gitignore

--- /dev/null
+++ b/samples/fanotify/.gitignore
@@ -0,0 +1 @@
+fs-monitor



