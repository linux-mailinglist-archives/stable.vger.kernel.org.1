Return-Path: <stable+bounces-138474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E735AA1840
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9256117A783
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F0D252914;
	Tue, 29 Apr 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CT1H50YA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068FC24EAB2;
	Tue, 29 Apr 2025 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949367; cv=none; b=QHw8x1KF4Wdg1lbb+BOzEr5PP9kSd62FXK6mZYpbq8opxKMCv6H32dMsb4sB/84VZvgkSvS3i7JyKuUzKaTYVGrdf7nXQDeZur3zGKmz0Si9AOU4POoVwBVpKfBgbbyzfA+rIxF3cBH3SEs85TrwNsCtdWKJK9Q0zzrvhZUHc+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949367; c=relaxed/simple;
	bh=/0WzHXs5AfraOg5+PycNMmObZzQwpu3uH+9V2hwyVrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltgKfGQz8tWRdTWhO+aLD4zK+SV0J/+7B/dO3exC0LxWv6LGlC9B+HRDRP7l4b//PS85A0OXnSH4oO4dJX0zJ5JvFt7TpyTeFe7L0IRjLUlSFWbNbo9qLT+ERlQ9nMfVI5TQkjuHOW3H0/MlMvBPxKDnl8CqzViU4+doiYzbjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CT1H50YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FD7C4CEE3;
	Tue, 29 Apr 2025 17:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949366;
	bh=/0WzHXs5AfraOg5+PycNMmObZzQwpu3uH+9V2hwyVrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CT1H50YAZTLEDYUnvH6SRrB5gD7bvLFU5l8eBS3GsU10tip36nzJLOQfbqVhl+ENF
	 jgLi4+prUEjv/K38YeqcWBR+a1M6L8ftf1FwG2jswmmDTKvVbcNUzx3O2ydnzKmbo1
	 +DrtrsFjzwGFO7HOa8Fiz7DGnHzpN1CBqpHHU23I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Halil Pasic <pasic@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 5.15 297/373] virtio_console: fix missing byte order handling for cols and rows
Date: Tue, 29 Apr 2025 18:42:54 +0200
Message-ID: <20250429161135.329920774@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1614,8 +1614,8 @@ static void handle_control_message(struc
 		break;
 	case VIRTIO_CONSOLE_RESIZE: {
 		struct {
-			__u16 rows;
-			__u16 cols;
+			__virtio16 rows;
+			__virtio16 cols;
 		} size;
 
 		if (!is_console_port(port))
@@ -1623,7 +1623,8 @@ static void handle_control_message(struc
 
 		memcpy(&size, buf->buf + buf->offset + sizeof(*cpkt),
 		       sizeof(size));
-		set_console_size(port, size.rows, size.cols);
+		set_console_size(port, virtio16_to_cpu(vdev, size.rows),
+				 virtio16_to_cpu(vdev, size.cols));
 
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);



