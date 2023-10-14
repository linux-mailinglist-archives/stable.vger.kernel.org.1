Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD517C93A4
	for <lists+stable@lfdr.de>; Sat, 14 Oct 2023 11:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJNJHg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 14 Oct 2023 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJHf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 14 Oct 2023 05:07:35 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156B5BF
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 02:07:32 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231014090727epoutp041810907b611e903a14cac649567b7ef9~N7h4Mgl6w1299512995epoutp04V
        for <stable@vger.kernel.org>; Sat, 14 Oct 2023 09:07:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231014090727epoutp041810907b611e903a14cac649567b7ef9~N7h4Mgl6w1299512995epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697274447;
        bh=cN2GOby8lDlEBpV9poSzMDgk7asWJxtNeyOw+cYQA64=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BIktCPBN//KUmyWMYswxjDSc5yK1tsjlTDxo4r+NTjfmRYdsr/S0BoaggOD8FcLna
         67fg/UKze3JzF0OlNxVE/1t6SKLNB7n6aT1R4YMKZmmEoFdwf9fitDYsdrMBo/oAfl
         iD0B9lCT7vgR7bHIpnffQ3WlG0IP9Kfe68fiYBZA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231014090726epcas5p4f3a1dc3e7bafab256dad3fa661e85447~N7h3mh99j0455204552epcas5p4N;
        Sat, 14 Oct 2023 09:07:26 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4S6yF94Xl9z4x9Pt; Sat, 14 Oct
        2023 09:07:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.8A.09949.D4A5A256; Sat, 14 Oct 2023 18:07:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad~N7h1Yr1yP0455204552epcas5p4J;
        Sat, 14 Oct 2023 09:07:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231014090724epsmtrp174804e18954d3a9e78e6a0157f07cb92~N7h1X-ODF2247122471epsmtrp1I;
        Sat, 14 Oct 2023 09:07:24 +0000 (GMT)
X-AuditID: b6c32a49-98bff700000026dd-26-652a5a4da822
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        42.FC.08742.C4A5A256; Sat, 14 Oct 2023 18:07:24 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231014090722epsmtip1434e79cb14dbf5a01eabd1e64ba6beb8~N7hzOE-kt2472424724epsmtip18;
        Sat, 14 Oct 2023 09:07:21 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, vincentfu@gmail.com,
        ankit.kumar@samsung.com, joshiiitr@gmail.com,
        Kanchan Joshi <joshi.k@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] nvme: remove unprivileged passthrough support
Date:   Sat, 14 Oct 2023 14:31:08 +0530
Message-Id: <20231014090108.128809-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmuq5vlFaqQdstWYs1V36zW6y+289m
        sXL1USaLo//fslmcf3uYyWLSoWuMFvOXPWW3WPf6PYvFgo2PGC02tAk6cHnsnHWX3eP8vY0s
        HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1YxenzeJBfAEZVtk5GamJJapJCal5yfkpmXbqvkHRzv
        HG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0oZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jE
        Vim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2NR0xnGgo25FQ1Tv7M2MK6J7GLk5JAQ
        MJGYuqKXvYuRi0NIYDejxNp5K1ggnE+MEhMm3YFyvjFKtLW8Z4Np+fJnLTNEYi+jxLspp5gg
        nM+MEhfn3WXsYuTgYBPQlLgwuRSkQUTARaLh3xtGkBpmgWWMEk0HNjOCJIQF7CTeHj7DBlLP
        IqAqcXCeC0iYV8BSYvqXp+wQy+QlZl76zg4RF5Q4OfMJC4jNDBRv3job7AgJgb/sElNn7WGE
        aHCRaFrWxAxhC0u8Or4FapCUxMv+Nig7WeLSzHNMEHaJxOM9B6Fse4nWU/3MIPcwA92/fpc+
        xC4+id7fT5hAwhICvBIdbUIQ1YoS9yY9ZYWwxSUezlgCZXtI7Dj8EcwWEoiV+PDoPvMERrlZ
        SD6YheSDWQjLFjAyr2KUTC0ozk1PLTYtMMxLLYfHZXJ+7iZGcNrU8tzBePfBB71DjEwcjIcY
        JTiYlUR4Z8dppArxpiRWVqUW5ccXleakFh9iNAWG6kRmKdHkfGDiziuJNzSxNDAxMzMzsTQ2
        M1QS533dOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgYnttMvJDOHV/LfNjrVz3/zde3bDqnnB0ie3
        6XRt2nb5iAxrkZTGsfjPXvNbtgY9lbrTuPa9443CKXMl3zC86+UNVcx5fpKP64THp7nfm//9
        vf9edNH5qFwF7ssGdjv7ErIeOC1KYrhTxPAkNe3PqtDb/L+mW/8sULhwY8vK6vQ1W1q27ngU
        XJDhpJX403ft8sSw6g+3cs58LX48005wwsT0wynv3n1y171rkL9l66pGljPN50OkzpiFlT1Q
        a9Pf/IKFP/PcK5OZBWI5968J7Pm3I/q7TlH2iUuqVbVfJx1lt55rs2RisvsW3z75l5kJz5+Z
        a34w3mqbvU3x0dzPYYJ1F6dXh5+o+vU4Zy+Tpcx9JZbijERDLeai4kQA7PzWWiQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWy7bCSnK5PlFaqwb1jwhZrrvxmt1h9t5/N
        YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exaLBRsfMVpsaBN04PLYOesuu8f5extZ
        PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoErY1HTGcaCjbkV
        DVO/szYwronsYuTkkBAwkfjyZy1zFyMXh5DAbkaJCycOM0MkxCWar/1gh7CFJVb+e84OUfSR
        UWLqxvksXYwcHGwCmhIXJpeC1IgIeEnMm72ABaSGWWANo8TPpytYQRLCAnYSbw+fYQOpZxFQ
        lTg4zwUkzCtgKTH9y1Oo+fISMy99Z4eIC0qcnPmEBcRmBoo3b53NPIGRbxaS1CwkqQWMTKsY
        JVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJDW0tzB+P2VR/0DjEycTAeYpTgYFYS4Z0d
        p5EqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgWm2VvLx
        gwautgknPlw4OXuCxDaPPKO+jzL85ZoPnx56/b5RpVTs6ZlrJ1IOsbFP23OD1z1V5C2TP/fq
        14uOCqT8UbLr4/TzXHw0XsiSf8oCLu+kdyol5gceJhuYscfV/FjM+XmF509tu43xNxc+YPv0
        5tcc47pl25+Ua700XPvu1tqHZhdm3La8s+e609Wd9/b/8Lzw8RXf9MlMsyaXBy2t/DnB9WlN
        +NHuY/e0NxhOruXZ0LcrpvddUlfs/L6XByYvkPzzZs6qtE2rD6YJmCo17ctJ51zxPv8Wz/+5
        ks4zXV1dfVfffLO7na96hnj+z4tLFi5fdaDG0P7Bn7sJl+M8cqSPBJT2uF7abHnMza8tToml
        OCPRUIu5qDgRACnfiAPcAgAA
X-CMS-MailID: 20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad
References: <CGME20231014090724epcas5p443807b5d724c97645a8a85fc627bf1ad@epcas5p4.samsung.com>
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
Fixes <855b7717f44b1> ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
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

