Return-Path: <stable+bounces-149150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C4ACB140
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0FB402A71
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0EB225A39;
	Mon,  2 Jun 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c7Asjady"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE8224245;
	Mon,  2 Jun 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873055; cv=none; b=fKLmSNDLXmQheblJimXmbunloL9UUGHz0EOsV4P/3BXz5u8S4WpgRtPtjUDlSzX05MDPoglZ8qKww7ZIgEuiGUy1Occj8gEcr8iIeUCYA3xUOSTzYr+0tV7DQEgPTaJnrHZgtUGVIjDM49ggGr1ebmkdCplVhzCB56DI34SxTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873055; c=relaxed/simple;
	bh=rVtvfIhubt+kIEkdh5Mig83puKJfLZXQa0v3LPMJz1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCeSZfk1XrhZsvLkGpeQ+KWm4PETQ8q7Q96zTHTVOI+PII+4e+/bc06LRMBIv1ZA8Tzmy72xAJucbMTQcdJU9wPAxBvlWmclkYRDEDQko/X0fnQRiUxsdov8R8Fwi+0xmaQRltl9xgohdHcy5FaRt+kYUYr9RVtkHG3WdlUr8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c7Asjady; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD8DC4CEEB;
	Mon,  2 Jun 2025 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873055;
	bh=rVtvfIhubt+kIEkdh5Mig83puKJfLZXQa0v3LPMJz1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c7AsjadyfkJdlgx9jwdQYTIwG2SgllPyBmBkEVbdLFf6rJdFKIcwmlfmiIYJx27j0
	 VdJT0kO826p27gPjkA88xA9TIibgb43floCT5GapFeXNardzQNZHj1Za9K7GSagvGp
	 SkN/vQvEhnmaLSnSwQ+g22jckK6CuPbYaUX4Rmu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 024/444] vhost_task: fix vhost_task_create() documentation
Date: Mon,  2 Jun 2025 15:41:28 +0200
Message-ID: <20250602134341.897528821@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit fec0abf52609c20279243699d08b660c142ce0aa ]

Commit cb380909ae3b ("vhost: return task creation error instead of NULL")
changed the return value of vhost_task_create(), but did not update the
documentation.

Reflect the change in the documentation: on an error, vhost_task_create()
returns an ERR_PTR() and no longer NULL.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20250327124435.142831-1-sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/vhost_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 8800f5acc0071..0e4455742190c 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -111,7 +111,7 @@ EXPORT_SYMBOL_GPL(vhost_task_stop);
  * @arg: data to be passed to fn and handled_kill
  * @name: the thread's name
  *
- * This returns a specialized task for use by the vhost layer or NULL on
+ * This returns a specialized task for use by the vhost layer or ERR_PTR() on
  * failure. The returned task is inactive, and the caller must fire it up
  * through vhost_task_start().
  */
-- 
2.39.5




