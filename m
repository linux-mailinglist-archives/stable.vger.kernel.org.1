Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD97C9F51
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 08:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJPGL7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjJPGL6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 02:11:58 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A9D9
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 23:11:55 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231016061153epoutp0365f8a649b24194cdf56333f17c49c859~OgbKs54bA3179331793epoutp03E
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 06:11:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231016061153epoutp0365f8a649b24194cdf56333f17c49c859~OgbKs54bA3179331793epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697436714;
        bh=9urHlYDLJPNOi/GhUPedMjv2TSoSstnDLQ7L4dbXiqM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aeKXEJZuSMIPvqpOXUEs1b8BNWCxRjwlWPi9lFD5eCToHcIfq2PlGTyThhsYB0DVT
         4yOBMNjpzOZGyqCKmBF/G1vd4BdPvL02ex2VHPBV33mKg3gJ1zkIbKE+t1Z7AAkNi6
         uYOJkt6ROOZlDsgHcr/nVQMD34xoYfpfJx1sxp44=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231016061153epcas5p104972687b1fc3defb362dcac9484488a~OgbKNDLfq3069730697epcas5p1C;
        Mon, 16 Oct 2023 06:11:53 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4S86Fg4LW3z4x9Q2; Mon, 16 Oct
        2023 06:11:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.F9.09672.724DC256; Mon, 16 Oct 2023 15:11:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231016061151epcas5p1a0e18162b362ffbea754157e99f88995~OgbICIur41921719217epcas5p1S;
        Mon, 16 Oct 2023 06:11:51 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231016061151epsmtrp110080ff2c4fc6c95f932f6d8455510e5~OgbIBYAJj1931219312epsmtrp1g;
        Mon, 16 Oct 2023 06:11:51 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-dd-652cd4271f41
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.BC.18939.624DC256; Mon, 16 Oct 2023 15:11:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231016061149epsmtip1749e994c813372e8a66f7b70d0b075ea~OgbGmGzx11861518615epsmtip1C;
        Mon, 16 Oct 2023 06:11:49 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, gost.dev@samsung.com,
        vincentfu@gmail.com, Kanchan Joshi <joshi.k@samsung.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] nvme: remove unprivileged passthrough support
Date:   Mon, 16 Oct 2023 11:35:19 +0530
Message-Id: <20231016060519.231880-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTXVf9ik6qwZ4TChar7/azWdw8sJPJ
        YuXqo0wWR/+/ZbOYdOgao8X8ZU/ZLda9fs9isWDjI0aLDW2CDpweO2fdZfc4f28ji8fls6Ue
        m1Z1snlsXlLvsftmA5tH35ZVjB6fN8kFcERl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY
        6hpaWpgrKeQl5qbaKrn4BOi6ZeYAHaekUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJ
        KTAp0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7om9PJXrAkr2LKxjUsDYxdUV2MnBwSAiYS7Ycn
        M4LYQgK7GSUO9Fp1MXIB2Z8YJc59v8gKkQBy5i7Lhmn4uuo0K0TRTkaJH7v+MkM4nxklrk97
        BORwcLAJaEpcmFwK0iAi4CLR8O8NI0gNs0Afo0Rj0zywqcICjhL9vxvZQWwWAVWJjdMnMIHY
        vAKWEk83nmOD2CYvMfPSd3aIuKDEyZlPWEBsZqB489bZYIslBD6ySyz/fZUJosFF4tKZHYwQ
        trDEq+Nb2CFsKYmX/W1QdrLEpZnnoOpLJB7vOQhl20u0nuoHe4AZ6IH1u/QhdvFJ9P5+wgQS
        lhDglehoE4KoVpS4N+kpK4QtLvFwxhIo20OivWkONERjJWZseMg0gVFuFpIPZiH5YBbCsgWM
        zKsYJVMLinPTU4tNC4zzUsvhUZmcn7uJEZwqtbx3MD568EHvECMTB+MhRgkOZiUR3vRgnVQh
        3pTEyqrUovz4otKc1OJDjKbAYJ3ILCWanA9M1nkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmk
        J5akZqemFqQWwfQxcXBKNTBlGC7csWfXAteUVyvMTbaF2c1O+LtY1mEZn9qchPzc848u7rH3
        7O4KVvifyjB9qmNe7omndbGJVtm+zRsKlk6bW7dsTlfxfovZt54Wum82LT2VvXifelvInsWd
        XZZ+qhe8Zoa2/S60YLxouXlW/6S7//We/jB78E+hcp6j+ez7q5s1govCDgveXZ3948n5Pfyv
        V245ceJS1UM+pt9yUbPzuhUvWH89ybCnKvynQXzUD7PV6WJt0zP+nOaPmxH6Z4Kaws1F0nun
        B5z/0bE0c8rtvB/Pjt6L7/BfnF14afruLRXl8brzrPJq+myr0o8If2debb2x4WBo38fZBhOb
        vycIr5jscUIkX+p23Btt5xOZSizFGYmGWsxFxYkAt9lsYh4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsWy7bCSnK7aFZ1Ugy3XbCxW3+1ns7h5YCeT
        xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7FYsHGR4wWG9oEHTg9ds66y+5x/t5GFo/LZ0s9
        Nq3qZPPYvKTeY/fNBjaPvi2rGD0+b5IL4IjisklJzcksSy3St0vgyuib08lesCSvYsrGNSwN
        jF1RXYycHBICJhJfV51m7WLk4hAS2M4o8fDkP1aIhLhE87Uf7BC2sMTKf8/ZIYo+Mkpc+ryW
        rYuRg4NNQFPiwuRSkBoRAS+JebMXsIDUMAtMYpTYef8QI0hCWMBRov93I9ggFgFViY3TJzCB
        2LwClhJPN55jg1ggLzHz0nd2iLigxMmZT1hAbGagePPW2cwTGPlmIUnNQpJawMi0ilE0taA4
        Nz03ucBQrzgxt7g0L10vOT93EyM4lLWCdjAuW/9X7xAjEwfjIUYJDmYlEd70YJ1UId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBqb+eqeaDAUdtbXT9ZZM
        3MG2wSLcYDLjoSifNXe+f/vN8W3WsmubrHuF7DICciZmT8+5wMM4ffNRpfknWubVFh7Yx26x
        8tKndQXPP2+4w5Tc7uLG5L5E+RZTLNO5qaaCy6w4Lz6LPl5jt815smF63ebQtwKbJLxcpD+t
        ZXj+8/PDzMnRwg5KtnkfNbfWZ7ypdVVvO6srteTM6XLOLeLF9xNy0jK8PS/ev7vu+rf4dXr7
        Qi7Wzk1nN5erzwpP2/kq1Ti9rn/2zt3PEzxXCXXfWhmzujfJxaY3/Zfax9bdX/l4+HJfcHxe
        5xHIdNH1cINvJNdGl3LGb/8kymujFk+TmMt43J6vOeHe54ClMS9Wf1ZiKc5INNRiLipOBABK
        y/I/1AIAAA==
X-CMS-MailID: 20231016061151epcas5p1a0e18162b362ffbea754157e99f88995
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016061151epcas5p1a0e18162b362ffbea754157e99f88995
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Passthrough has got a hole that can be exploited to cause kernel memory
corruption. This is about making the device do larger DMA into
short meta/data buffer owned by kernel [1].

As a stopgap measure, disable the support of unprivileged passthrough.

This patch brings back coarse-granular CAP_SYS_ADMIN checks by reverting
following patches:

- 7d9d7d59d44 ("nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool")
- 313c08c72ee ("nvme: don't allow unprivileged passthrough on partitions")
- 6f99ac04c46 ("nvme: consult the CSE log page for unprivileged passthrough")
- ea43fceea41 ("nvme: allow unprivileged passthrough of Identify Controller")
- e4fbcf32c86 ("nvme: identify-namespace without CAP_SYS_ADMIN")
- 855b7717f44 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")

[1] https://lore.kernel.org/linux-nvme/20231013051458.39987-1-joshi.k@samsung.com/

CC: stable@vger.kernel.org # 6.2
Fixes: 855b7717f44b1 ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
Changes since v1:
- Fix the way "Fixes:" was written before (Greg)

 drivers/nvme/host/ioctl.c | 159 ++++++++------------------------------
 include/linux/nvme.h      |   2 -
 2 files changed, 34 insertions(+), 127 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..788b36e7915a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -10,80 +10,8 @@
 
 enum {
 	NVME_IOCTL_VEC		= (1 << 0),
-	NVME_IOCTL_PARTITION	= (1 << 1),
 };
 
-static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
-		unsigned int flags, bool open_for_write)
-{
-	u32 effects;
-
-	if (capable(CAP_SYS_ADMIN))
-		return true;
-
-	/*
-	 * Do not allow unprivileged passthrough on partitions, as that allows an
-	 * escape from the containment of the partition.
-	 */
-	if (flags & NVME_IOCTL_PARTITION)
-		return false;
-
-	/*
-	 * Do not allow unprivileged processes to send vendor specific or fabrics
-	 * commands as we can't be sure about their effects.
-	 */
-	if (c->common.opcode >= nvme_cmd_vendor_start ||
-	    c->common.opcode == nvme_fabrics_command)
-		return false;
-
-	/*
-	 * Do not allow unprivileged passthrough of admin commands except
-	 * for a subset of identify commands that contain information required
-	 * to form proper I/O commands in userspace and do not expose any
-	 * potentially sensitive information.
-	 */
-	if (!ns) {
-		if (c->common.opcode == nvme_admin_identify) {
-			switch (c->identify.cns) {
-			case NVME_ID_CNS_NS:
-			case NVME_ID_CNS_CS_NS:
-			case NVME_ID_CNS_NS_CS_INDEP:
-			case NVME_ID_CNS_CS_CTRL:
-			case NVME_ID_CNS_CTRL:
-				return true;
-			}
-		}
-		return false;
-	}
-
-	/*
-	 * Check if the controller provides a Commands Supported and Effects log
-	 * and marks this command as supported.  If not reject unprivileged
-	 * passthrough.
-	 */
-	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
-	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
-		return false;
-
-	/*
-	 * Don't allow passthrough for command that have intrusive (or unknown)
-	 * effects.
-	 */
-	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
-			NVME_CMD_EFFECTS_UUID_SEL |
-			NVME_CMD_EFFECTS_SCOPE_MASK))
-		return false;
-
-	/*
-	 * Only allow I/O commands that transfer data to the controller or that
-	 * change the logical block contents if the file descriptor is open for
-	 * writing.
-	 */
-	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
-		return open_for_write;
-	return true;
-}
-
 /*
  * Convert integer values from ioctl structures to user pointers, silently
  * ignoring the upper bits in the compat case to match behaviour of 32-bit
@@ -335,8 +263,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
-		bool open_for_write)
+			struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -344,6 +271,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	u64 result;
 	int status;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -364,9 +293,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
-		return -EACCES;
-
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -383,14 +309,16 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 }
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
-		bool open_for_write)
+			struct nvme_passthru_cmd64 __user *ucmd,
+			unsigned int flags)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
 	int status;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
 	if (cmd.flags)
@@ -411,9 +339,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
-		return -EACCES;
-
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
@@ -563,6 +488,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	void *meta = NULL;
 	int ret;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	c.common.opcode = READ_ONCE(cmd->opcode);
 	c.common.flags = READ_ONCE(cmd->flags);
 	if (c.common.flags)
@@ -584,9 +512,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
-		return -EACCES;
-
 	d.metadata = READ_ONCE(cmd->metadata);
 	d.addr = READ_ONCE(cmd->addr);
 	d.data_len = READ_ONCE(cmd->data_len);
@@ -643,13 +568,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 }
 
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp, bool open_for_write)
+		void __user *argp)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -674,14 +599,16 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
 
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, unsigned int flags, bool open_for_write)
+		void __user *argp)
 {
+	unsigned int flags = 0;
+
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write);
+		return nvme_user_cmd(ns->ctrl, ns, argp);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -696,39 +623,32 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		flags |= NVME_IOCTL_VEC;
 		fallthrough;
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, flags,
-				       open_for_write);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, flags);
 	default:
 		return -ENOTTY;
 	}
 }
 
-int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
+int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
-	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
-	unsigned int flags = 0;
-
-	if (bdev_is_partition(bdev))
-		flags |= NVME_IOCTL_PARTITION;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
-	return nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	return nvme_ns_ioctl(ns, cmd, argp);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
-	bool open_for_write = file->f_mode & FMODE_WRITE;
 	void __user *argp = (void __user *)arg;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
-	return nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
+	return nvme_ns_ioctl(ns, cmd, argp);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -792,8 +712,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 }
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
-		bool open_for_write)
+		void __user *argp, struct nvme_ns_head *head, int srcu_idx)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -801,7 +720,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -811,14 +730,9 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
-	unsigned int flags = 0;
-
-	if (bdev_is_partition(bdev))
-		flags |= NVME_IOCTL_PARTITION;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
@@ -831,10 +745,9 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-					       open_for_write);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
+	ret = nvme_ns_ioctl(ns, cmd, argp);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -843,7 +756,6 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
-	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =
 		container_of(cdev, struct nvme_ns_head, cdev);
@@ -857,10 +769,9 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		goto out_unlock;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-				open_for_write);
+		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
+	ret = nvme_ns_ioctl(ns, cmd, argp);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -909,8 +820,7 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return ret;
 }
 
-static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
-		bool open_for_write)
+static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -934,7 +844,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
+	ret = nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -946,17 +856,16 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
-	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct nvme_ctrl *ctrl = file->private_data;
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd(ctrl, NULL, argp);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
+		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..df3e2c619448 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -642,7 +642,6 @@ enum {
 	NVME_CMD_EFFECTS_CCC		= 1 << 4,
 	NVME_CMD_EFFECTS_CSE_MASK	= GENMASK(18, 16),
 	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
-	NVME_CMD_EFFECTS_SCOPE_MASK	= GENMASK(31, 20),
 };
 
 struct nvme_effects_log {
@@ -834,7 +833,6 @@ enum nvme_opcode {
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
-	nvme_cmd_vendor_start	= 0x80,
 };
 
 #define nvme_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.25.1

