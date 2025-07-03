Return-Path: <stable+bounces-159765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD8AF7A61
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA273189AF8B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA612E7649;
	Thu,  3 Jul 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1q91qaHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5B15442C;
	Thu,  3 Jul 2025 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555276; cv=none; b=l1QhwDEUCHkfhEyOzcMKf6fdD70zzHI39M5YD4yDtei27cD4qUX5hYF7uVQ8QTq6/b7+ZZBJQx1Sc9gy5HJ+ASrkeQ3lAiv4ilUPJ2d+Tr6RDfr4K+zCajPjdB5Tm9I5uTGtYXvtRR9feSfoPrjpe5DLHOABDnv4xHtgOfDG8Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555276; c=relaxed/simple;
	bh=8RM3dYbanw0/aaLRvv2qquAqjfFLXm6VE5emir9CXlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVQHsb+ttHgZ++EfZUYHJC2dYZubvvTZIyg6Fxz7SEgME2zmzKvjFqFgKv8gNmZNtRrRScFUiJa43kerkhFvAPctToyqFVFR/53ExsucwRCTTNnW8ti2d5107voc5+3hRWrveVA5Q4qc27qcD22eO2/gHxWWWy9CAoQr7PDfyWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1q91qaHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F0CC4CEE3;
	Thu,  3 Jul 2025 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555276;
	bh=8RM3dYbanw0/aaLRvv2qquAqjfFLXm6VE5emir9CXlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1q91qaHougwUkACt60WxlThHKfIlEcdv3Ms3hGjK1zFag/enCY8p1m5LLMbDTyUtM
	 fwWqLNL9JM08PHHhMxxIjetU2IXx2qoTP9fARObrWk6Er+KN0ZeKwtZBNtPPN+2iEs
	 oB2ve4sWk5ygTBXD4S3QGlfmKVTW7k47vJvKlAhQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping Cheng <ping.cheng@wacom.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.15 197/263] HID: wacom: fix kobject reference count leak
Date: Thu,  3 Jul 2025 16:41:57 +0200
Message-ID: <20250703144012.258766440@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qasim Ijaz <qasdev00@gmail.com>

commit 85a720f4337f0ddf1603c8b75a8f1ffbbe022ef9 upstream.

When sysfs_create_files() fails in wacom_initialize_remotes() the error
is returned and the cleanup action will not have been registered yet.

As a result the kobject???s refcount is never dropped, so the
kobject can never be freed leading to a reference leak.

Fix this by calling kobject_put() before returning.

Fixes: 83e6b40e2de6 ("HID: wacom: EKR: have the wacom resources dynamically allocated")
Acked-by: Ping Cheng <ping.cheng@wacom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_sys.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2059,6 +2059,7 @@ static int wacom_initialize_remotes(stru
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
 		kfifo_free(&remote->remote_fifo);
+		kobject_put(remote->remote_dir);
 		return error;
 	}
 



