Return-Path: <stable+bounces-60171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD4932DB3
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C881C20C3E
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD019B3EE;
	Tue, 16 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tPoeL9Ph"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8D1DDCE;
	Tue, 16 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146098; cv=none; b=qJBulj6aOzV+SYOIEuu1YXSCByonTuHUHY8Vcf3JSjJcG+xaYoh3v/mv8d22xyVlLP1C8sR+2RrqTDS2hQUjsbuGNd3ag3zXUGnQbQvOP/Y7XyfJU/pH+o0URKcS1LWxluyOePZV2gLBV2tPl2ytWLU8Hcf7mjk7cGY6hSCFkE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146098; c=relaxed/simple;
	bh=Nkc46YFb6uoiBU2Q/iJEnwEp0Ya+RvXjMzvg9I4rJg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oyg/YabgHF+1FJQYD6MDGV+2WwpE3GFKgATaqTaJ+X1i+7i2qQHEX9UbL786jBw6uc6akxclMCkVw+jNfEser/IXfVVP+bDoFPTHR5/gIK5tFkhhjS3OqHwvV43wI1M9owVvdg0EMSxtZrj1sKOdKGj/um77VKQYP3KcOTty4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tPoeL9Ph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF46C116B1;
	Tue, 16 Jul 2024 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146098;
	bh=Nkc46YFb6uoiBU2Q/iJEnwEp0Ya+RvXjMzvg9I4rJg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tPoeL9Phn4JQ0F5VW3qa2i6HyOg2CzgnaLlC0pwQ3cGrx2OC0BGV9mAlVYiEpErb5
	 g5wRfrjYkx6k5WgJgsSwxKuEZ9I9j72eBEDB52VX1JKRt5VCWSc9rjBR7uLlawNLb8
	 4ExEXj94xxYMdm8Ze2yz6VO471zTJRKrFcbxjKgU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 5.15 054/144] fsnotify: Do not generate events for O_PATH file descriptors
Date: Tue, 16 Jul 2024 17:32:03 +0200
Message-ID: <20240716152754.625090294@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 702eb71fd6501b3566283f8c96d7ccc6ddd662e9 upstream.

Currently we will not generate FS_OPEN events for O_PATH file
descriptors but we will generate FS_CLOSE events for them. This is
asymmetry is confusing. Arguably no fsnotify events should be generated
for O_PATH file descriptors as they cannot be used to access or modify
file content, they are just convenient handles to file objects like
paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
file descriptors.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240617162303.1596-1-jack@suse.cz
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/fsnotify.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -93,7 +93,13 @@ static inline int fsnotify_file(struct f
 {
 	const struct path *path = &file->f_path;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);



