Return-Path: <stable+bounces-174328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F40B3628D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C634A18870BA
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B33234166C;
	Tue, 26 Aug 2025 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVejJbnV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822834165E;
	Tue, 26 Aug 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214099; cv=none; b=bWkKzb67hWQBNXWavZ6HAc7+140J3O4hLCd+dbjX1LNFvuMOW+vLqngu3+/AsUsCiNyBqMOvYbEFOMj2035WV2v31VjAqYJ/BrUGYc+VZspBD1baN5WHGZ8iN5dX6uCwf76azqfDbZT2vlJ4sTQ162AcCyz5H4ZvbLmS3YbjZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214099; c=relaxed/simple;
	bh=fQEU9hpBqVJoXP0xKsK60iT5qKb2WWIvvwlmW8H5D30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhT+mlYjeq08wJbtbqiyyh3tF3HLwpkmp/sZm9bWkGV235MyWh14RGT6iZysz65/9H27jInBKfR4heDFuuFCCsNLn5XFlPsBwEjLe/ti3+5SGv1hen4i/2KFuawYfaTADRM/6KjeqiYupK1VRI/tpDpwCULYKC9mVTO5zmZ+fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVejJbnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE9C4CEF1;
	Tue, 26 Aug 2025 13:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214099;
	bh=fQEU9hpBqVJoXP0xKsK60iT5qKb2WWIvvwlmW8H5D30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVejJbnVQxi6J0AEcdgQn2NqqgTyO9+lFDnhdDuU8Zyf0nRnIBJm9Gl2Mw8sll/Hr
	 Jo10N5jOmV/ocbqPDwkf6lQs616fKIV1GAWafG5B3rUesGAnBQFLUdxWLR7Qp8dpF7
	 JdLE3GOwTeG953buwj8qqxFwpAkLUJcLTprcXq8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Youngjun Lee <yjjuny.lee@samsung.com>
Subject: [PATCH 6.1 003/482] ALSA: usb-audio: Validate UAC3 cluster segment descriptors
Date: Tue, 26 Aug 2025 13:04:16 +0200
Message-ID: <20250826110930.863024284@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit ecfd41166b72b67d3bdeb88d224ff445f6163869 upstream.

UAC3 class segment descriptors need to be verified whether their sizes
match with the declared lengths and whether they fit with the
allocated buffer sizes, too.  Otherwise malicious firmware may lead to
the unexpected OOB accesses.

Fixes: 11785ef53228 ("ALSA: usb-audio: Initial Power Domain support")
Reported-and-tested-by: Youngjun Lee <yjjuny.lee@samsung.com>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250814081245.8902-2-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/stream.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -341,20 +341,28 @@ snd_pcm_chmap_elem *convert_chmap_v3(str
 
 	len = le16_to_cpu(cluster->wLength);
 	c = 0;
-	p += sizeof(struct uac3_cluster_header_descriptor);
+	p += sizeof(*cluster);
+	len -= sizeof(*cluster);
 
-	while (((p - (void *)cluster) < len) && (c < channels)) {
+	while (len > 0 && (c < channels)) {
 		struct uac3_cluster_segment_descriptor *cs_desc = p;
 		u16 cs_len;
 		u8 cs_type;
 
+		if (len < sizeof(*p))
+			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
+		if (len < cs_len)
+			break;
 		cs_type = cs_desc->bSegmentType;
 
 		if (cs_type == UAC3_CHANNEL_INFORMATION) {
 			struct uac3_cluster_information_segment_descriptor *is = p;
 			unsigned char map;
 
+			if (cs_len < sizeof(*is))
+				break;
+
 			/*
 			 * TODO: this conversion is not complete, update it
 			 * after adding UAC3 values to asound.h
@@ -456,6 +464,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(str
 			chmap->map[c++] = map;
 		}
 		p += cs_len;
+		len -= cs_len;
 	}
 
 	if (channels < c)
@@ -876,7 +885,7 @@ snd_usb_get_audioformat_uac3(struct snd_
 	u64 badd_formats = 0;
 	unsigned int num_channels;
 	struct audioformat *fp;
-	u16 cluster_id, wLength;
+	u16 cluster_id, wLength, cluster_wLength;
 	int clock = 0;
 	int err;
 
@@ -1003,6 +1012,16 @@ snd_usb_get_audioformat_uac3(struct snd_
 			iface_no, altno);
 		kfree(cluster);
 		return ERR_PTR(-EIO);
+	}
+
+	cluster_wLength = le16_to_cpu(cluster->wLength);
+	if (cluster_wLength < sizeof(*cluster) ||
+	    cluster_wLength > wLength) {
+		dev_err(&dev->dev,
+			"%u:%d : invalid Cluster Descriptor size\n",
+			iface_no, altno);
+		kfree(cluster);
+		return ERR_PTR(-EIO);
 	}
 
 	num_channels = cluster->bNrChannels;



