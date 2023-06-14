Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE99726EAD
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjFGUv7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbjFGUvu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:51:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D210EA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65AB263188
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A73C433EF;
        Wed,  7 Jun 2023 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171102;
        bh=xeuvBDMxI7pTqMgvT6gMsaHepX3Jf0kMwxfDe84FKEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uPoN48JnEx+nCVLxMfIruQKgWprGZ+pR7VNwGWvfBQCMpyi+fC5NWzy6qigvCdPIx
         rU7vn7oGsC5+pHb5ClTHb79Miguor9T/dZk41nGtkZ8rApiqPcFye/K9Ku+ITzUYQw
         YcrIIitgC9Ey2HdkDCGYmAl2DnSCHkx57IH/3xhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <benh@debian.org>
Subject: [PATCH 5.10 112/120] scsi: dpt_i2o: Remove broken pass-through ioctl (I2OUSERCMD)
Date:   Wed,  7 Jun 2023 22:17:08 +0200
Message-ID: <20230607200904.457128462@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ben Hutchings <benh@debian.org>

adpt_i2o_passthru() takes a user-provided message and passes it
through to the hardware with appropriate translation of addresses
and message IDs.  It has a number of bugs:

- When a message requires scatter/gather, it doesn't verify that the
  offset to the scatter/gather list is less than the message size.
- When a message requires scatter/gather, it overwrites the DMA
  addresses with the user-space virtual addresses before unmapping the
  DMA buffers.
- It reads the message from user memory multiple times.  This allows
  user-space to change the message and bypass validation.
- It assumes that the message is at least 4 words long, but doesn't
  check that.

I tried fixing these, but even the maintainer of the corresponding
user-space in Debian doesn't have the hardware any more.

Instead, remove the pass-through ioctl (I2OUSRCMD) and supporting
code.

There is no corresponding upstream commit, because this driver was
removed upstream.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 67af2b060e02 ("[SCSI] dpt_i2o: move from virt_to_bus/bus_to_virt ...")
Signed-off-by: Ben Hutchings <benh@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/dpt_i2o.c |  274 +------------------------------------------------
 drivers/scsi/dpti.h    |    1 
 2 files changed, 8 insertions(+), 267 deletions(-)

--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -582,51 +582,6 @@ static int adpt_show_info(struct seq_fil
 	return 0;
 }
 
-/*
- *	Turn a pointer to ioctl reply data into an u32 'context'
- */
-static u32 adpt_ioctl_to_context(adpt_hba * pHba, void *reply)
-{
-#if BITS_PER_LONG == 32
-	return (u32)(unsigned long)reply;
-#else
-	ulong flags = 0;
-	u32 nr, i;
-
-	spin_lock_irqsave(pHba->host->host_lock, flags);
-	nr = ARRAY_SIZE(pHba->ioctl_reply_context);
-	for (i = 0; i < nr; i++) {
-		if (pHba->ioctl_reply_context[i] == NULL) {
-			pHba->ioctl_reply_context[i] = reply;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(pHba->host->host_lock, flags);
-	if (i >= nr) {
-		printk(KERN_WARNING"%s: Too many outstanding "
-				"ioctl commands\n", pHba->name);
-		return (u32)-1;
-	}
-
-	return i;
-#endif
-}
-
-/*
- *	Go from an u32 'context' to a pointer to ioctl reply data.
- */
-static void *adpt_ioctl_from_context(adpt_hba *pHba, u32 context)
-{
-#if BITS_PER_LONG == 32
-	return (void *)(unsigned long)context;
-#else
-	void *p = pHba->ioctl_reply_context[context];
-	pHba->ioctl_reply_context[context] = NULL;
-
-	return p;
-#endif
-}
-
 /*===========================================================================
  * Error Handling routines
  *===========================================================================
@@ -1648,208 +1603,6 @@ static int adpt_close(struct inode *inod
 	return 0;
 }
 
-
-static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
-{
-	u32 msg[MAX_MESSAGE_SIZE];
-	u32* reply = NULL;
-	u32 size = 0;
-	u32 reply_size = 0;
-	u32 __user *user_msg = arg;
-	u32 __user * user_reply = NULL;
-	void **sg_list = NULL;
-	u32 sg_offset = 0;
-	u32 sg_count = 0;
-	int sg_index = 0;
-	u32 i = 0;
-	u32 rcode = 0;
-	void *p = NULL;
-	dma_addr_t addr;
-	ulong flags = 0;
-
-	memset(&msg, 0, MAX_MESSAGE_SIZE*4);
-	// get user msg size in u32s 
-	if(get_user(size, &user_msg[0])){
-		return -EFAULT;
-	}
-	size = size>>16;
-
-	user_reply = &user_msg[size];
-	if(size > MAX_MESSAGE_SIZE){
-		return -EFAULT;
-	}
-	size *= 4; // Convert to bytes
-
-	/* Copy in the user's I2O command */
-	if(copy_from_user(msg, user_msg, size)) {
-		return -EFAULT;
-	}
-	get_user(reply_size, &user_reply[0]);
-	reply_size = reply_size>>16;
-	if(reply_size > REPLY_FRAME_SIZE){
-		reply_size = REPLY_FRAME_SIZE;
-	}
-	reply_size *= 4;
-	reply = kzalloc(REPLY_FRAME_SIZE*4, GFP_KERNEL);
-	if(reply == NULL) {
-		printk(KERN_WARNING"%s: Could not allocate reply buffer\n",pHba->name);
-		return -ENOMEM;
-	}
-	sg_offset = (msg[0]>>4)&0xf;
-	msg[2] = 0x40000000; // IOCTL context
-	msg[3] = adpt_ioctl_to_context(pHba, reply);
-	if (msg[3] == (u32)-1) {
-		rcode = -EBUSY;
-		goto free;
-	}
-
-	sg_list = kcalloc(pHba->sg_tablesize, sizeof(*sg_list), GFP_KERNEL);
-	if (!sg_list) {
-		rcode = -ENOMEM;
-		goto free;
-	}
-	if(sg_offset) {
-		// TODO add 64 bit API
-		struct sg_simple_element *sg =  (struct sg_simple_element*) (msg+sg_offset);
-		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
-		if (sg_count > pHba->sg_tablesize){
-			printk(KERN_DEBUG"%s:IOCTL SG List too large (%u)\n", pHba->name,sg_count);
-			rcode = -EINVAL;
-			goto free;
-		}
-
-		for(i = 0; i < sg_count; i++) {
-			int sg_size;
-
-			if (!(sg[i].flag_count & 0x10000000 /*I2O_SGL_FLAGS_SIMPLE_ADDRESS_ELEMENT*/)) {
-				printk(KERN_DEBUG"%s:Bad SG element %d - not simple (%x)\n",pHba->name,i,  sg[i].flag_count);
-				rcode = -EINVAL;
-				goto cleanup;
-			}
-			sg_size = sg[i].flag_count & 0xffffff;      
-			/* Allocate memory for the transfer */
-			p = dma_alloc_coherent(&pHba->pDev->dev, sg_size, &addr, GFP_KERNEL);
-			if(!p) {
-				printk(KERN_DEBUG"%s: Could not allocate SG buffer - size = %d buffer number %d of %d\n",
-						pHba->name,sg_size,i,sg_count);
-				rcode = -ENOMEM;
-				goto cleanup;
-			}
-			sg_list[sg_index++] = p; // sglist indexed with input frame, not our internal frame.
-			/* Copy in the user's SG buffer if necessary */
-			if(sg[i].flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR*/) {
-				// sg_simple_element API is 32 bit
-				if (copy_from_user(p,(void __user *)(ulong)sg[i].addr_bus, sg_size)) {
-					printk(KERN_DEBUG"%s: Could not copy SG buf %d FROM user\n",pHba->name,i);
-					rcode = -EFAULT;
-					goto cleanup;
-				}
-			}
-			/* sg_simple_element API is 32 bit, but addr < 4GB */
-			sg[i].addr_bus = addr;
-		}
-	}
-
-	do {
-		/*
-		 * Stop any new commands from enterring the
-		 * controller while processing the ioctl
-		 */
-		if (pHba->host) {
-			scsi_block_requests(pHba->host);
-			spin_lock_irqsave(pHba->host->host_lock, flags);
-		}
-		rcode = adpt_i2o_post_wait(pHba, msg, size, FOREVER);
-		if (rcode != 0)
-			printk("adpt_i2o_passthru: post wait failed %d %p\n",
-					rcode, reply);
-		if (pHba->host) {
-			spin_unlock_irqrestore(pHba->host->host_lock, flags);
-			scsi_unblock_requests(pHba->host);
-		}
-	} while (rcode == -ETIMEDOUT);
-
-	if(rcode){
-		goto cleanup;
-	}
-
-	if(sg_offset) {
-	/* Copy back the Scatter Gather buffers back to user space */
-		u32 j;
-		// TODO add 64 bit API
-		struct sg_simple_element* sg;
-		int sg_size;
-
-		// re-acquire the original message to handle correctly the sg copy operation
-		memset(&msg, 0, MAX_MESSAGE_SIZE*4); 
-		// get user msg size in u32s 
-		if(get_user(size, &user_msg[0])){
-			rcode = -EFAULT; 
-			goto cleanup; 
-		}
-		size = size>>16;
-		size *= 4;
-		if (size > MAX_MESSAGE_SIZE) {
-			rcode = -EINVAL;
-			goto cleanup;
-		}
-		/* Copy in the user's I2O command */
-		if (copy_from_user (msg, user_msg, size)) {
-			rcode = -EFAULT;
-			goto cleanup;
-		}
-		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
-
-		// TODO add 64 bit API
-		sg 	 = (struct sg_simple_element*)(msg + sg_offset);
-		for (j = 0; j < sg_count; j++) {
-			/* Copy out the SG list to user's buffer if necessary */
-			if(! (sg[j].flag_count & 0x4000000 /*I2O_SGL_FLAGS_DIR*/)) {
-				sg_size = sg[j].flag_count & 0xffffff; 
-				// sg_simple_element API is 32 bit
-				if (copy_to_user((void __user *)(ulong)sg[j].addr_bus,sg_list[j], sg_size)) {
-					printk(KERN_WARNING"%s: Could not copy %p TO user %x\n",pHba->name, sg_list[j], sg[j].addr_bus);
-					rcode = -EFAULT;
-					goto cleanup;
-				}
-			}
-		}
-	} 
-
-	/* Copy back the reply to user space */
-	if (reply_size) {
-		// we wrote our own values for context - now restore the user supplied ones
-		if(copy_from_user(reply+2, user_msg+2, sizeof(u32)*2)) {
-			printk(KERN_WARNING"%s: Could not copy message context FROM user\n",pHba->name);
-			rcode = -EFAULT;
-		}
-		if(copy_to_user(user_reply, reply, reply_size)) {
-			printk(KERN_WARNING"%s: Could not copy reply TO user\n",pHba->name);
-			rcode = -EFAULT;
-		}
-	}
-
-
-cleanup:
-	if (rcode != -ETIME && rcode != -EINTR) {
-		struct sg_simple_element *sg =
-				(struct sg_simple_element*) (msg +sg_offset);
-		while(sg_index) {
-			if(sg_list[--sg_index]) {
-				dma_free_coherent(&pHba->pDev->dev,
-					sg[sg_index].flag_count & 0xffffff,
-					sg_list[sg_index],
-					sg[sg_index].addr_bus);
-			}
-		}
-	}
-
-free:
-	kfree(sg_list);
-	kfree(reply);
-	return rcode;
-}
-
 #if defined __ia64__ 
 static void adpt_ia64_info(sysInfo_S* si)
 {
@@ -1976,8 +1729,6 @@ static int adpt_ioctl(struct inode *inod
 			return -EFAULT;
 		}
 		break;
-	case I2OUSRCMD:
-		return adpt_i2o_passthru(pHba, argp);
 
 	case DPT_CTRLINFO:{
 		drvrHBAinfo_S HbaInfo;
@@ -2134,13 +1885,6 @@ static irqreturn_t adpt_isr(int irq, voi
 			adpt_send_nop(pHba, old_m);
 		} 
 		context = readl(reply+8);
-		if(context & 0x40000000){ // IOCTL
-			void *p = adpt_ioctl_from_context(pHba, readl(reply+12));
-			if( p != NULL) {
-				memcpy_fromio(p, reply, REPLY_FRAME_SIZE * 4);
-			}
-			// All IOCTLs will also be post wait
-		}
 		if(context & 0x80000000){ // Post wait message
 			status = readl(reply+16);
 			if(status  >> 24){
@@ -2148,16 +1892,14 @@ static irqreturn_t adpt_isr(int irq, voi
 			} else {
 				status = I2O_POST_WAIT_OK;
 			}
-			if(!(context & 0x40000000)) {
-				/*
-				 * The request tag is one less than the command tag
-				 * as the firmware might treat a 0 tag as invalid
-				 */
-				cmd = scsi_host_find_tag(pHba->host,
-							 readl(reply + 12) - 1);
-				if(cmd != NULL) {
-					printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
-				}
+			/*
+			 * The request tag is one less than the command tag
+			 * as the firmware might treat a 0 tag as invalid
+			 */
+			cmd = scsi_host_find_tag(pHba->host,
+						 readl(reply + 12) - 1);
+			if(cmd != NULL) {
+				printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
 			}
 			adpt_i2o_post_wait_complete(context, status);
 		} else { // SCSI message
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -248,7 +248,6 @@ typedef struct _adpt_hba {
 	void __iomem *FwDebugBLEDflag_P;// Virtual Addr Of FW Debug BLED
 	void __iomem *FwDebugBLEDvalue_P;// Virtual Addr Of FW Debug BLED
 	u32 FwDebugFlags;
-	u32 *ioctl_reply_context[4];
 } adpt_hba;
 
 struct sg_simple_element {


