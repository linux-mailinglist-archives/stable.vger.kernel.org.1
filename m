Return-Path: <stable+bounces-177331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E0B404DD
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2221B6585F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82653054D2;
	Tue,  2 Sep 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLD2UwIv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E223054E7;
	Tue,  2 Sep 2025 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820305; cv=none; b=Ho7B+cizphRzR+bFV+aI7QvSYLDJ6y9T8bh5YwgF9LwCexPxrfcFhqe0x/b1KbbJ4/xCu0Jtvc1Egkq2iro71u6m+LRG+fcMVNbdY/zSAbvDsLWOU+aq5xLpEHaQCVivsext/F03z+JxKSH1CvHUyCyPV6G1KNPqq0T/zDQIQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820305; c=relaxed/simple;
	bh=jAtvYkQtLBcvLdj3ROgynMPS3pS2UkqtUmiPuhKe71o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpqVI0R1+XwOBC+KKwB5bxeP8FyRznx9oN18ppgvCls654/O11guX0d8VFwTQ+K4cSFKgQZmQDhcqAdam9AxbNmbtguPTZ5TNXXBsa+TNhRZBDr45xar/GhDDIwUcKyu0h77B8P1uQOu0ZNeTIZ+Sucs1zsrSiDZk0QQmIAPWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLD2UwIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA20C4CEED;
	Tue,  2 Sep 2025 13:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820304;
	bh=jAtvYkQtLBcvLdj3ROgynMPS3pS2UkqtUmiPuhKe71o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLD2UwIvv22Gff+UpADTiMBQsjLgFdm9y9PiYgap7sZMIoE6Qb5znmW9zKy72i6na
	 JFMu11oz9WjcVgPFpuy9vjSiDjKAvcOJDuzTm7UDQwpGDC7ZcOonLSZNPyDez7zwA0
	 P4OZ2QEF53xF87/Hj9ptKnOPxgAv8clxA6qS7jOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping Cheng <ping.cheng@wacom.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.6 62/75] HID: wacom: Add a new Art Pen 2
Date: Tue,  2 Sep 2025 15:21:14 +0200
Message-ID: <20250902131937.548780156@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
References: <20250902131935.107897242@linuxfoundation.org>
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

From: Ping Cheng <pinglinux@gmail.com>

commit 9fc51941d9e7793da969b2c66e6f8213c5b1237f upstream.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -684,6 +684,7 @@ static bool wacom_is_art_pen(int tool_id
 	case 0x885:	/* Intuos3 Marker Pen */
 	case 0x804:	/* Intuos4/5 13HD/24HD Marker Pen */
 	case 0x10804:	/* Intuos4/5 13HD/24HD Art Pen */
+	case 0x204:     /* Art Pen 2 */
 		is_art_pen = true;
 		break;
 	}



