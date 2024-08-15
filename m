Return-Path: <stable+bounces-68635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC15953347
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615A01C227B2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3F1B3F31;
	Thu, 15 Aug 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zh4pLIAh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D71B3F2D;
	Thu, 15 Aug 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731189; cv=none; b=A6DY4lunKQSvddysD+BXvHen6CaGI4GihiajewykdrD8fQXF+Q+jJApxNeNszouNCLQFcK0N9mnGgUj0oJktUEYtlp0PCv6zzUStaSIvhEGja8s3a2EVbmsQGoA1ohp6VFxpSDRs6wzt56pAFVFsecrFf7ccPNnRK0T1ev0JzoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731189; c=relaxed/simple;
	bh=mpVSfIOt8J3VxkdNEmwUtsyPjeR3daoXTxlKbtK4QUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzOu+ReTXmEZmIsyM4ugxUQDT3VXNJrhDLXxccx3fC7lQ8YEE0sZ03sMO26qCswPehbwUVNHXySYVMFpS5LexRT6cjcnilROvaiR2dimQBxEX8zCfNiLLv/gd3RuGBmmESFEGIB6lPDcT1J0XIriG60q6jDUwtOshQVrx06IpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zh4pLIAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD88C32786;
	Thu, 15 Aug 2024 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731189;
	bh=mpVSfIOt8J3VxkdNEmwUtsyPjeR3daoXTxlKbtK4QUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zh4pLIAhuE0xOWrX3AOYEg2s5Ldz1J666jGpGAnrQ/yIY0IH/S7fAlfze1qz6zLTx
	 /xgVovp9ewPyYEEC8arHEafLjyI4anFMeUpCrXafveErN1J73uB6uKO2rLxMcRk6JQ
	 CZMOu2EWr40rumBKa68KMo8gdoUUMMv5k0LbkwFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jaroslav Kysela <perex@perex.cz>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Eli Billauer <eli.billauer@gmail.com>,
	Emiliano Ingrassia <ingrassia@epigenesys.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Alexander Tsoy <alexander@tsoy.me>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Jussi Laako <jussi@sonarnerd.net>,
	Nick Kossifidis <mickflemm@gmail.com>,
	Dmitry Panchenko <dmitry@d-systems.ee>,
	Chris Wulff <crwulff@gmail.com>,
	Jesus Ramos <jesus-ramos@live.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/259] USB: move snd_usb_pipe_sanity_check into the USB core
Date: Thu, 15 Aug 2024 15:23:03 +0200
Message-ID: <20240815131904.736396383@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit fcc2cc1f35613c016e1de25bb001bfdd9eaa25f9 ]

snd_usb_pipe_sanity_check() is a great function, so let's move it into
the USB core so that other parts of the kernel, including the USB core,
can call it.

Name it usb_pipe_type_check() to match the existing
usb_urb_ep_type_check() call, which now uses this function.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Emiliano Ingrassia <ingrassia@epigenesys.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Tsoy <alexander@tsoy.me>
Cc: "Geoffrey D. Bennett" <g@b4.vu>
Cc: Jussi Laako <jussi@sonarnerd.net>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Dmitry Panchenko <dmitry@d-systems.ee>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Jesus Ramos <jesus-ramos@live.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200914153756.3412156-2-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2052138b7da5 ("media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/urb.c          | 31 +++++++++++++++++++++++--------
 include/linux/usb.h             |  1 +
 sound/usb/helper.c              | 16 +---------------
 sound/usb/helper.h              |  1 -
 sound/usb/mixer_scarlett_gen2.c |  2 +-
 sound/usb/quirks.c              | 12 ++++++------
 6 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index 0045bbc3627dd..850d0fffe1c69 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -192,24 +192,39 @@ static const int pipetypes[4] = {
 };
 
 /**
- * usb_urb_ep_type_check - sanity check of endpoint in the given urb
- * @urb: urb to be checked
+ * usb_pipe_type_check - sanity check of a specific pipe for a usb device
+ * @dev: struct usb_device to be checked
+ * @pipe: pipe to check
  *
  * This performs a light-weight sanity check for the endpoint in the
- * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
- * a negative error code.
+ * given usb device.  It returns 0 if the pipe is valid for the specific usb
+ * device, otherwise a negative error code.
  */
-int usb_urb_ep_type_check(const struct urb *urb)
+int usb_pipe_type_check(struct usb_device *dev, unsigned int pipe)
 {
 	const struct usb_host_endpoint *ep;
 
-	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
+	ep = usb_pipe_endpoint(dev, pipe);
 	if (!ep)
 		return -EINVAL;
-	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(usb_pipe_type_check);
+
+/**
+ * usb_urb_ep_type_check - sanity check of endpoint in the given urb
+ * @urb: urb to be checked
+ *
+ * This performs a light-weight sanity check for the endpoint in the
+ * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
+ * a negative error code.
+ */
+int usb_urb_ep_type_check(const struct urb *urb)
+{
+	return usb_pipe_type_check(urb->dev, urb->pipe);
+}
 EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
 
 /**
@@ -474,7 +489,7 @@ int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 	 */
 
 	/* Check that the pipe's type matches the endpoint's type */
-	if (usb_urb_ep_type_check(urb))
+	if (usb_pipe_type_check(urb->dev, urb->pipe))
 		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index abcf1ce9bb068..7c0e7efbc8f20 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1763,6 +1763,7 @@ static inline int usb_urb_dir_out(struct urb *urb)
 	return (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_OUT;
 }
 
+int usb_pipe_type_check(struct usb_device *dev, unsigned int pipe);
 int usb_urb_ep_type_check(const struct urb *urb);
 
 void *usb_alloc_coherent(struct usb_device *dev, size_t size,
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index 4c12cc5b53fda..cf92d71107731 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -63,20 +63,6 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	return NULL;
 }
 
-/* check the validity of pipe and EP types */
-int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
-{
-	static const int pipetypes[4] = {
-		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
-	};
-	struct usb_host_endpoint *ep;
-
-	ep = usb_pipe_endpoint(dev, pipe);
-	if (!ep || usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
-		return -EINVAL;
-	return 0;
-}
-
 /*
  * Wrapper for usb_control_msg().
  * Allocates a temp buffer to prevent dmaing from/to the stack.
@@ -89,7 +75,7 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 	void *buf = NULL;
 	int timeout;
 
-	if (snd_usb_pipe_sanity_check(dev, pipe))
+	if (usb_pipe_type_check(dev, pipe))
 		return -EINVAL;
 
 	if (size > 0) {
diff --git a/sound/usb/helper.h b/sound/usb/helper.h
index 5e8a18b4e7b96..f5b4c6647e4df 100644
--- a/sound/usb/helper.h
+++ b/sound/usb/helper.h
@@ -7,7 +7,6 @@ unsigned int snd_usb_combine_bytes(unsigned char *bytes, int size);
 void *snd_usb_find_desc(void *descstart, int desclen, void *after, u8 dtype);
 void *snd_usb_find_csint_desc(void *descstart, int desclen, void *after, u8 dsubtype);
 
-int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe);
 int snd_usb_ctl_msg(struct usb_device *dev, unsigned int pipe,
 		    __u8 request, __u8 requesttype, __u16 value, __u16 index,
 		    void *data, __u16 size);
diff --git a/sound/usb/mixer_scarlett_gen2.c b/sound/usb/mixer_scarlett_gen2.c
index ab7abe360fcfe..6d8ef3aa99b56 100644
--- a/sound/usb/mixer_scarlett_gen2.c
+++ b/sound/usb/mixer_scarlett_gen2.c
@@ -1988,7 +1988,7 @@ static int scarlett2_mixer_status_create(struct usb_mixer_interface *mixer)
 		return 0;
 	}
 
-	if (snd_usb_pipe_sanity_check(dev, pipe))
+	if (usb_pipe_type_check(dev, pipe))
 		return -EINVAL;
 
 	mixer->urb = usb_alloc_urb(0, GFP_KERNEL);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 28489aab6821f..d7136f6f94404 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -854,7 +854,7 @@ static int snd_usb_accessmusic_boot_quirk(struct usb_device *dev)
 	static const u8 seq[] = { 0x4e, 0x73, 0x52, 0x01 };
 	void *buf;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x05)))
+	if (usb_pipe_type_check(dev, usb_sndintpipe(dev, 0x05)))
 		return -EINVAL;
 	buf = kmemdup(seq, ARRAY_SIZE(seq), GFP_KERNEL);
 	if (!buf)
@@ -883,7 +883,7 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
 		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
@@ -992,7 +992,7 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
 		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
@@ -1026,7 +1026,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
 {
 	int err, actual_length;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndintpipe(dev, 0x01)))
+	if (usb_pipe_type_check(dev, usb_sndintpipe(dev, 0x01)))
 		return -EINVAL;
 	err = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x01), buf, *length,
 				&actual_length, 1000);
@@ -1038,7 +1038,7 @@ static int snd_usb_motu_microbookii_communicate(struct usb_device *dev, u8 *buf,
 
 	memset(buf, 0, buf_size);
 
-	if (snd_usb_pipe_sanity_check(dev, usb_rcvintpipe(dev, 0x82)))
+	if (usb_pipe_type_check(dev, usb_rcvintpipe(dev, 0x82)))
 		return -EINVAL;
 	err = usb_interrupt_msg(dev, usb_rcvintpipe(dev, 0x82), buf, buf_size,
 				&actual_length, 1000);
@@ -1125,7 +1125,7 @@ static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (snd_usb_pipe_sanity_check(dev, usb_sndctrlpipe(dev, 0)))
+	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
 		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			      1, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-- 
2.43.0




