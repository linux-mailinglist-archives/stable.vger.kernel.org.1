Return-Path: <stable+bounces-123428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23FA5C565
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A652C168925
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F825E805;
	Tue, 11 Mar 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KdGFhWzl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DB25D8F9;
	Tue, 11 Mar 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705927; cv=none; b=Bc3ByZF3jfvSHs6UoScUF1H5g/hnnXO5ftIvlxp/qWDmUrwR7AmofiCnTeolKYlyw4OYTO5v8C0u1vi6QP6UITzXrYFvbR8VhWEHhoMPYjOIOyTwkQmKQchTG27KVBUwKev6p8Yi3qOqQkM0VDUWhceiVlgLNteJ7/Ck3QgY5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705927; c=relaxed/simple;
	bh=kCIzE4bC5v7a9XtVebO+g0CxUSpZcODjkjzIubvAMg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbtpQqHS0syNkIshUFbppa/CjdAnR8JNI3qhqU7u83jW8UA8Zh870N5A4iymfy9WOGaIX33qb1L0GS1T13a9dhA2Rw45XZPb6ZiRch+R2jojB8m5kPpCQacXj4mEhab09pf0CTvQJHbOFhYb70v1y4lhzSAjrlTs5V6ThjJ6b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KdGFhWzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7270FC4CEF1;
	Tue, 11 Mar 2025 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705926;
	bh=kCIzE4bC5v7a9XtVebO+g0CxUSpZcODjkjzIubvAMg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdGFhWzlL0mdco7tfuy425DmApsoQDszHs7Nq9oLGdbwcZ4jdAQ47W+/TtqGFa0KT
	 bQ44PkNZRVTraVwFo0MlnlsT2SbV6DOMy07oqQoLQ7RRsbgdWspvmStiwmgCb0/vzq
	 GTn9x29Kw8T1bvF+hE0+yWYAxyyF1ur/8Oy7uc9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	John Keeping <jkeeping@inmusicbrands.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 184/328] usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
Date: Tue, 11 Mar 2025 15:59:14 +0100
Message-ID: <20250311145722.215381098@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <jkeeping@inmusicbrands.com>

commit da1668997052ed1cb00322e1f3b63702615c9429 upstream.

While the MIDI jacks are configured correctly, and the MIDIStreaming
endpoint descriptors are filled with the correct information,
bNumEmbMIDIJack and bLength are set incorrectly in these descriptors.

This does not matter when the numbers of in and out ports are equal, but
when they differ the host will receive broken descriptors with
uninitialized stack memory leaking into the descriptor for whichever
value is smaller.

The precise meaning of "in" and "out" in the port counts is not clearly
defined and can be confusing.  But elsewhere the driver consistently
uses this to match the USB meaning of IN and OUT viewed from the host,
so that "in" ports send data to the host and "out" ports receive data
from it.

Cc: stable <stable@kernel.org>
Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20250130195035.3883857-1-jkeeping@inmusicbrands.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_midi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -997,11 +997,11 @@ static int f_midi_bind(struct usb_config
 	}
 
 	/* configure the endpoint descriptors ... */
-	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
-	ms_out_desc.bNumEmbMIDIJack = midi->in_ports;
+	ms_out_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
+	ms_out_desc.bNumEmbMIDIJack = midi->out_ports;
 
-	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->out_ports);
-	ms_in_desc.bNumEmbMIDIJack = midi->out_ports;
+	ms_in_desc.bLength = USB_DT_MS_ENDPOINT_SIZE(midi->in_ports);
+	ms_in_desc.bNumEmbMIDIJack = midi->in_ports;
 
 	/* ... and add them to the list */
 	endpoint_descriptor_index = i;



