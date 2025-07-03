Return-Path: <stable+bounces-159937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22C0AF7BAF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662364A36B3
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE92EE5F3;
	Thu,  3 Jul 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CIgBc/0k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D02EF66C;
	Thu,  3 Jul 2025 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555841; cv=none; b=TNWqa/NmuN2gO/BOps5OoR+94EI3FmK0U/7cBOIvnwkm92AQn8cWnMuyLTyOCOzcVKbYwBRyAeq+CoFlTcf08wExFX0keSvKSV+jwUgC0ZXGiSqnj5KlQ3mPMGX4hPlKN/bulZvOHl4Dj0b9vsb1g7y7pAA/c9aDIqg1EXmRbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555841; c=relaxed/simple;
	bh=FOQgfTWBu16Y7JDXb1Kx3gO91xBkFkWJtqnpSG0LS6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBbKL4itjrM3Z6mDOSb/gQ73hr1ZjRcEtEOdw4zXi4UQxHQsLWS3G4fccBZ/is0OFhXv6uuqJghfJB8v1q6TkAp9V2by53gNVh+mx8atTQtDxZ6KkmUBslKTS6NzcEcm6kQwHIjYt5ifhUe/AfExL3ggiMEu+m4OvSk2r8qhnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CIgBc/0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9FFC4CEE3;
	Thu,  3 Jul 2025 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555840;
	bh=FOQgfTWBu16Y7JDXb1Kx3gO91xBkFkWJtqnpSG0LS6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIgBc/0kjZbw9aWupewhdLdQjOwjo3yw8EcXp4YxUTguU86EjqKG7cYlHfQv9XY1q
	 8vq3OhltLmWfu9YgDONunY1ydsKcOnE+o5LpVJxwhuyZw1AMDeRBQ8Sc6ufkT8dpU5
	 2s55PEdnkc9gW+knnl77LSZ8Cav9/47JOAExOLck=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping Cheng <ping.cheng@wacom.com>,
	Qasim Ijaz <qasdev00@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.6 106/139] HID: wacom: fix memory leak on sysfs attribute creation failure
Date: Thu,  3 Jul 2025 16:42:49 +0200
Message-ID: <20250703143945.321770322@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
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

From: Qasim Ijaz <qasdev00@gmail.com>

commit 1a19ae437ca5d5c7d9ec2678946fb339b1c706bf upstream.

When sysfs_create_files() fails during wacom_initialize_remotes() the
fifo buffer is not freed leading to a memory leak.

Fix this by calling kfifo_free() before returning.

Fixes: 83e6b40e2de6 ("HID: wacom: EKR: have the wacom resources dynamically allocated")
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_sys.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2022,6 +2022,7 @@ static int wacom_initialize_remotes(stru
 	if (error) {
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
+		kfifo_free(&remote->remote_fifo);
 		return error;
 	}
 



