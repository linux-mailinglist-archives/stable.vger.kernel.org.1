Return-Path: <stable+bounces-138821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D04AA19DD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F2116ED10
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900C188A0E;
	Tue, 29 Apr 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q/8jBxuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E71CA5A;
	Tue, 29 Apr 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950456; cv=none; b=T6TtIc+WTckHKgCNFgwnrLjno6FdGpsGapWOWkrGpA5XqVWUbtq/o+J7WvYHSsrOnHQrSwNQMkltyCn81cYt38UJUZygVhUhBU3YHUk5xjwp12w0O497oJl05p6QCf9oOYx27n76E7IAH7KDZ7z2NrsS+JGq6Oe514sQUcX+wdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950456; c=relaxed/simple;
	bh=AQx/Og7OBvzO+I4PHRoXGNk7Pg7Jz18SXcg85st2mhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsT5fAhNEhhM1fjHeZzXL/Zz0caHblpfQr4Clc+hAWefgvwjo2tJC5qbj48mirL/Y+7/HmEoZBl52+YKr+lfzJ9eWyZXyN/LvtTulLHSm9a1yqg4FD7r+atHiwpOw5abRkYHOUfUQpJlD5J7sNLmqxxE1YbkKc4cHGgXggIvP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q/8jBxuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20992C4CEE3;
	Tue, 29 Apr 2025 18:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745950456;
	bh=AQx/Og7OBvzO+I4PHRoXGNk7Pg7Jz18SXcg85st2mhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/8jBxuRFE9v3YfjQZ8bhqzkBuIysqbZjqN0JS0TUFSC2YzGw1SQ0LP1GgMRe/HA4
	 NKe8hPISURp2WzJti4YKpLzJB9Ce4JsFRWBFxlhRB+uxge/+CykTwFIqbjaw1OujLy
	 RtKYpU9DyfLEtA9jITC4g1uXgu4vu31CNND2SGvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Halil Pasic <pasic@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6.6 072/204] virtio_console: fix missing byte order handling for cols and rows
Date: Tue, 29 Apr 2025 18:42:40 +0200
Message-ID: <20250429161102.371122018@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
References: <20250429161059.396852607@linuxfoundation.org>
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

From: Halil Pasic <pasic@linux.ibm.com>

commit fbd3039a64b01b769040677c4fc68badeca8e3b2 upstream.

As per virtio spec the fields cols and rows are specified as little
endian. Although there is no legacy interface requirement that would
state that cols and rows need to be handled as native endian when legacy
interface is used, unlike for the fields of the adjacent struct
virtio_console_control, I decided to err on the side of caution based
on some non-conclusive virtio spec repo archaeology and opt for using
virtio16_to_cpu() much like for virtio_console_control.event. Strictly
by the letter of the spec virtio_le_to_cpu() would have been sufficient.
But when the legacy interface is not used, it boils down to the same.

And when using the legacy interface, the device formatting these as
little endian when the guest is big endian would surprise me more than
it using guest native byte order (which would make it compatible with
the current implementation). Nevertheless somebody trying to implement
the spec following it to the letter could end up forcing little endian
byte order when the legacy interface is in use. So IMHO this ultimately
needs a judgement call by the maintainers.

Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along with resize control message")
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Cc: stable@vger.kernel.org # v2.6.35+
Message-Id: <20250322002954.3129282-1-pasic@linux.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/virtio_console.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1612,8 +1612,8 @@ static void handle_control_message(struc
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
-			__u16 cols;
+			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
@@ -1621,7 +1621,8 @@ static void handle_control_message(struc
 
 		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
 		       sizeof(size));
-		set_console_size(port, size.rows, size.cols);
+		set_console_size(port, virtio16_to_cpu(vdev, size.rows),
+				 virtio16_to_cpu(vdev, size.cols));
 
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);



