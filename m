Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389417BF4AD
	for <lists+stable@lfdr.de>; Tue, 10 Oct 2023 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442552AbjJJHqn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442419AbjJJHqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 03:46:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A64A4
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 00:46:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C3D9368B05; Tue, 10 Oct 2023 09:46:34 +0200 (CEST)
Date:   Tue, 10 Oct 2023 09:46:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com, cpgs@samsung.com,
        stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v3] nvme: fix memory corruption for passthrough metadata
Message-ID: <20231010074634.GA6514@lst.de>
References: <CGME20231006135322epcas5p1c9acf38b04f35017181c715c706281dc@epcas5p1.samsung.com> <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891546521.01696823881551.JavaMail.epsvc@epcpadp4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Oct 06, 2023 at 07:17:06PM +0530, Kanchan Joshi wrote:
> Same issue is possible for extended-lba case also. When user specifies a
> short unaligned buffer, the kernel makes a copy and uses that for DMA.

I fail to understand the extent LBA case, and also from looking at the
code mixing it up with validation of the metadata_len seems very
confusion.  Can you try to clearly explain it and maybe split it into a
separate patch?

> Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device")

Is this really io_uring specific?  I think we also had the same issue
before and this should go back to adding metadata support to the
general passthrough ioctl?

> +static inline bool nvme_nlb_in_cdw12(u8 opcode)
> +{
> +	switch (opcode) {
> +	case nvme_cmd_read:
> +	case nvme_cmd_write:
> +	case nvme_cmd_compare:
> +	case nvme_cmd_zone_append:
> +		return true;
> +	}
> +	return false;
> +}

Nitpick: I find it nicer to read to have a switch that catches
everything with a default statement instead of falling out of it
for checks like this.  It's not making any different in practice
but just reads a little nicer.

> +	/* Exclude commands that do not have nlb in cdw12 */
> +	if (!nvme_nlb_in_cdw12(c->common.opcode))
> +		return true;

So we can still get exactly the same corruption for all commands that
are not known?  That's not a very safe way to deal with the issue..

> +	control = upper_16_bits(le32_to_cpu(c->common.cdw12));
> +	/* Exclude when meta transfer from/to host is not done */
> +	if (control & NVME_RW_PRINFO_PRACT && ns->ms == ns->pi_size)
> +		return true;
> +
> +	nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));

I'd use the rw field of the union and the typed control and length
fields to clean this up a bit.

>  	if (bdev && meta_buffer && meta_len) {
> +		if (!nvme_validate_passthru_meta(ns, nvme_req(req)->cmd,
> +					meta_len, bufflen)) {
> +			ret = -EINVAL;
> +			goto out_unmap;
> +		}
> +
>  		meta = nvme_add_user_metadata(req, meta_buffer, meta_len,

I'd move the check into nvme_add_user_metadata to keep it out of the
hot path.

FYI: here is what I'd do for the external metadata only case:

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f21d..bf22c7953856f5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -96,6 +96,71 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+static inline bool nvme_nlb_in_cdw12(u8 opcode)
+{
+	switch (opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+	case nvme_cmd_compare:
+	case nvme_cmd_zone_append:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * NVMe has no separate field to encode the metadata length expected
+ * (except when using SGLs).
+ *
+ * Because of that we can't allow to transfer arbitrary metadata, as
+ * a metadata buffer that is shorted than what the device expects for
+ * the command will lead to arbitrary kernel (if bounce buffering) or
+ * userspace (if not) memory corruption.
+ *
+ * Check that external metadata is only specified for the few commands
+ * where we know the length based of other fields, and that it fits
+ * the actual data transfer from/to the device.
+ */
+static bool nvme_validate_metadata_len(struct request *req, unsigned meta_len)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_command *c = nvme_req(req)->cmd;
+	u32 len_by_nlb;
+	
+	/* Exclude commands that do not have nlb in cdw12 */
+	if (!nvme_nlb_in_cdw12(c->common.opcode)) {
+		dev_err(ns->ctrl->device,
+			"unknown metadata command %c (%s).\n",
+			c->common.opcode, current->comm);
+		return false;
+	}
+
+	/*
+	 * Skip the check when PI is inserted or stripped and not transferred.
+	 */
+	if (ns->ms == ns->pi_size &&
+	    (c->rw.control & cpu_to_le16(NVME_RW_PRINFO_PRACT)))
+		return true;
+
+	if (ns->features & NVME_NS_EXT_LBAS) {
+		dev_err(ns->ctrl->device,
+			"requires extended LBAs for metadata (%s).\n",
+			current->comm);
+		return false;
+	}
+
+	len_by_nlb = (le16_to_cpu(c->rw.length) + 1) * ns->ms;
+	if (meta_len < len_by_nlb) {
+		dev_err(ns->ctrl->device,
+			"metadata length (%u instad of %u) is too small (%s).\n",
+			meta_len, len_by_nlb, current->comm);
+		return false;
+	}
+
+	return true;
+}
+
 static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 		unsigned len, u32 seed)
 {
@@ -104,6 +169,9 @@ static void *nvme_add_user_metadata(struct request *req, void __user *ubuf,
 	void *buf;
 	struct bio *bio = req->bio;
 
+	if (!nvme_validate_metadata_len(req, len))
+		return ERR_PTR(-EINVAL);
+
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto out;
