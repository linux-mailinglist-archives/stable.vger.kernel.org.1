Return-Path: <stable+bounces-118306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F35A3C498
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A510016988E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4D31FC7F6;
	Wed, 19 Feb 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M92Q+VAO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23181FDA85
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981456; cv=none; b=AUHsxvXXsqVoQ+eO/BFeNk+7W0A8pDhkYrE5tZ8G7yu9UlzLV3scDUAcvb4Lw1cu4HzftB7ngbqakrfAIn8Mr91zGxSKTlsd8Zj2sF4vqwDBqUsyFZfpk4ksxz4VExH6jcpsWKt0pQenm+KadGhGwVhgtZef1YosHv/6yReDZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981456; c=relaxed/simple;
	bh=DdatmkNVRymYrlo3Z+cJfD0mmr8TEstaf7BCtF7PXhg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVQPDdzLTsWid43jzkfJa0a8me8/WGTusmSBYINSxofCVTo3Z/cWlqcr4HOwzxbelj2yrh4SdW2qrgTE4W1d2jbAQpiavRYCPUgE95DaUNjrEyQ900mDhh16Ky7oHtuU+KPtIQEUVZuggNQvs03T9lQ/LlL9rKSGA2/2GGTKNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M92Q+VAO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFxjY9027609
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sRZVkjMhiUJu5Ulrk
	L7dc3wl/UGoVK6G5ERsguX39m8=; b=M92Q+VAOnXRd1KEvGNZxtneHviZXfhr4t
	peKYklPX81TkC9R4N9v2TsSYM8zWv9zyCCmt3CofVsTi6jPx5/IMsBGWzPTSihfH
	0Fy4dvdOvURsm99KIMaQuf0H5nkDJgnCNFHq6ZLNjyMbF1FH8jhS9/qyF3JfbS3k
	//HYw0p9UxMYJCW9cIKbQEh4x/Z7SNbuDt7HFSLAYZVtuSnQCyg+cgaIEnOBE7ZB
	PTnTA20BiGanlcNtV8fFWXV4JgrUJpTgCwzMyZ6NANnjaVK1Sv5+PbE7G2TZEy7i
	d0CrLgL2CH4Wfv1Pmn7OTCTGjl8Q1AGzEoGE2bzc9C+V5ewpdteug==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44w3ba49ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JE5SNY027103
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w0254x9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JGAngH20840726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A469B20043
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8092E20040
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 16:10:49 +0000 (GMT)
From: =?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.4.y] WIP
Date: Wed, 19 Feb 2025 17:10:49 +0100
Message-ID: <20250219161049.119877-1-hoeppner@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2023061111-tracing-shakiness-9054@gregkh>
References: <2023061111-tracing-shakiness-9054@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EGqoKG-WVeeU-17pK7KXfWR0xjsnr14N
X-Proofpoint-GUID: EGqoKG-WVeeU-17pK7KXfWR0xjsnr14N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190124

---
 arch/s390/include/asm/idals.h  |  51 ++++
 drivers/s390/char/tape.h       |   9 +-
 drivers/s390/char/tape_34xx.c  |  10 +
 drivers/s390/char/tape_char.c  | 436 +++++++++++++++++++++++++++++----
 drivers/s390/char/tape_class.c |   2 +-
 drivers/s390/char/tape_core.c  |   5 +-
 drivers/s390/char/tape_std.c   | 146 +++++------
 drivers/s390/char/tape_std.h   |   1 +
 8 files changed, 512 insertions(+), 148 deletions(-)

diff --git a/arch/s390/include/asm/idals.h b/arch/s390/include/asm/idals.h
index ac68c657b28c..3b9f4cb300b5 100644
--- a/arch/s390/include/asm/idals.h
+++ b/arch/s390/include/asm/idals.h
@@ -137,6 +137,7 @@ static inline struct idal_buffer *idal_buffer_alloc(size_t size, int page_order)
 
 	nr_ptrs = (size + IDA_BLOCK_SIZE - 1) >> IDA_SIZE_SHIFT;
 	nr_chunks = (PAGE_SIZE << page_order) >> IDA_SIZE_SHIFT;
+	pr_warn("DEBUG: ib struct_size: %lu\n", struct_size(ib, data, nr_ptrs));
 	ib = kmalloc(struct_size(ib, data, nr_ptrs), GFP_DMA | GFP_KERNEL);
 	if (!ib)
 		return ERR_PTR(-ENOMEM);
@@ -247,6 +248,8 @@ static inline size_t idal_buffer_from_user(struct idal_buffer *ib, const void __
 	BUG_ON(count > ib->size);
 	for (i = 0; count > IDA_BLOCK_SIZE; i++) {
 		vaddr = dma64_to_virt(ib->data[i]);
+		pr_warn("DEBUG(idal_buf_from_user): count(%d): %lu idaws: %llx vaddr: %p\n",
+			i, count, ib->data[i], vaddr);
 		left = copy_from_user(vaddr, from, IDA_BLOCK_SIZE);
 		if (left)
 			return left + count - IDA_BLOCK_SIZE;
@@ -257,4 +260,52 @@ static inline size_t idal_buffer_from_user(struct idal_buffer *ib, const void __
 	return copy_from_user(vaddr, from, count);
 }
 
+static inline size_t idal_to_user(dma64_t *idaws, void __user *to, size_t count)
+{
+	size_t left;
+	void *vaddr;
+
+	/* BUG_ON(count > ib->size); */
+	while (count > IDA_BLOCK_SIZE) {
+		vaddr = dma64_to_virt(*idaws++);
+		left = copy_to_user(to, vaddr, IDA_BLOCK_SIZE);
+		pr_warn("DEBUG(idal_to_user): vaddr %p left/count: %lu/%lu\n",
+			vaddr, left, count);
+		if (left)
+			return left + count - IDA_BLOCK_SIZE;
+		to = (void __user *)to + IDA_BLOCK_SIZE;
+		count -= IDA_BLOCK_SIZE;
+	}
+	vaddr = dma64_to_virt(*idaws);
+	left = copy_to_user(to, vaddr, count);
+	pr_warn("DEBUG(idal_to_user last): vaddr %p left/count: %lu/%lu\n",
+		vaddr, left, count);
+	return left;
+	/* return copy_to_user(to, vaddr, count); */
+}
+
+static inline size_t idal_from_user(dma64_t *idaws, const void __user *from,
+				    size_t count)
+{
+	size_t left;
+	void *vaddr;
+
+	/* BUG_ON(count > ib->size); */
+	while (count > IDA_BLOCK_SIZE) {
+		vaddr = dma64_to_virt(*idaws++);
+		left = copy_from_user(vaddr, from, IDA_BLOCK_SIZE);
+		pr_warn("DEBUG(idal_from_user): vaddr %p left/count: %lu/%lu\n",
+			vaddr, left, count);
+		if (left)
+			return left + count - IDA_BLOCK_SIZE;
+		from = (void __user *)from + IDA_BLOCK_SIZE;
+		count -= IDA_BLOCK_SIZE;
+	}
+	vaddr = dma64_to_virt(*idaws);
+	left = copy_from_user(vaddr, from, count);
+	pr_warn("DEBUG(idal_from_user last): vaddr %p left/count: %lu/%lu\n",
+		vaddr, left, count);
+	return left;
+	/* return copy_from_user(vaddr, from, count); */
+}
 #endif
diff --git a/drivers/s390/char/tape.h b/drivers/s390/char/tape.h
index a4bbee0f19f4..9f00a57888cd 100644
--- a/drivers/s390/char/tape.h
+++ b/drivers/s390/char/tape.h
@@ -130,6 +130,7 @@ struct tape_request {
 	int retries;			/* retry counter for error recovery. */
 	int rescnt;			/* residual count from devstat. */
 	struct timer_list timer;	/* timer for std_assign_timeout(). */
+	struct irb irb;			/* device status */
 
 	/* Callback for delivering final status. */
 	void (*callback)(struct tape_request *, void *);
@@ -346,8 +347,9 @@ tape_ccw_repeat(struct ccw1 *ccw, __u8 cmd_code, int count)
 	return ccw;
 }
 
-static inline struct ccw1 *
-tape_ccw_ida_idal(struct ccw1 *ccw, __u8 cmd_code, struct idal_buffer *idal)
+static inline struct ccw1 *tape_ccw_ida_idal(struct ccw1 *ccw, __u8 cmd_code,
+					     dma64_t *idaws, void *vaddr,
+					     int length)
 {
 	ccw->cmd_code = cmd_code;
 	ccw->flags    = CCW_FLAG_IDA;
@@ -355,7 +357,8 @@ tape_ccw_ida_idal(struct ccw1 *ccw, __u8 cmd_code, struct idal_buffer *idal)
 	// Create IDA Words to chain entire data list
 	// idaws: cqr->data == idal buffer?! == ib->data?!
 	// dst: vaddr buffer
-	//idal_create_words(idaws, dst, blksize);
+	ccw->cda = virt_to_dma32(idaws);
+	idaws = idal_create_words(idaws, vaddr, length);
 
 	return ccw++;
 }
diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index dccae8202d2f..b1d8333550b0 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -17,6 +17,9 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 
+#include <asm/css_chars.h>
+#include <asm/ccwdev.h>
+
 #define TAPE_DBF_AREA	tape_34xx_dbf
 
 #include "tape.h"
@@ -1059,6 +1062,9 @@ tape_34xx_setup_device(struct tape_device * device)
 	struct list_head *	discdata;
 	struct tape_34xx_rdc_data *rdc_data;
 
+	int fcx_in_css;
+	unsigned int mdc;
+
 	DBF_EVENT(6, "34xx device setup\n");
 	rdc_data = kmalloc(sizeof(*rdc_data), GFP_KERNEL | GFP_DMA);
 	if (!rdc_data) {
@@ -1076,6 +1082,10 @@ tape_34xx_setup_device(struct tape_device * device)
 	pr_warn("DEBUG: max_blksize: %u opt_blksize: %u\n",
 		rdc_data->max_block_size, rdc_data->opt_block_size);
 
+	fcx_in_css = css_general_characteristics.fcx;
+	mdc = ccw_device_get_mdc(device->cdev, 0);
+	pr_warn("DEBUG: fcx: %d mdc: %u\n", fcx_in_css, mdc);
+
 	if ((rc = tape_std_assign(device)) == 0) {
 		if ((rc = tape_34xx_medium_sense(device)) != 0) {
 			DBF_LH(3, "34xx medium sense returned %d\n", rc);
diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index 57d11519c897..a10dbc0eaef3 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -33,7 +33,9 @@
  * file operation structure for tape character frontend
  */
 static ssize_t tapechar_read(struct file *, char __user *, size_t, loff_t *);
+static ssize_t tapechar_read_new(struct file *, char __user *, size_t, loff_t *);
 static ssize_t tapechar_write(struct file *, const char __user *, size_t, loff_t *);
+static ssize_t tapechar_write_new(struct file *, const char __user *, size_t, loff_t *);
 // static ssize_t tapechar_write_new(struct file *, const char __user *, size_t, loff_t *);
 static int tapechar_open(struct inode *,struct file *);
 static int tapechar_release(struct inode *,struct file *);
@@ -45,9 +47,10 @@ static long tapechar_compat_ioctl(struct file *, unsigned int, unsigned long);
 static const struct file_operations tape_fops =
 {
 	.owner = THIS_MODULE,
-	.read = tapechar_read,
-	.write = tapechar_write,
-	/* .write = tapechar_write_new, */
+	/* .read = tapechar_read, */
+	.read = tapechar_read_new,
+	/* .write = tapechar_write, */
+	.write = tapechar_write_new,
 	.unlocked_ioctl = tapechar_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = tapechar_compat_ioctl,
@@ -141,8 +144,6 @@ tapechar_read(struct file *filp, char __user *data, size_t count, loff_t *ppos)
 	struct tape_device *device;
 	struct tape_request *request;
 	size_t block_size;
-	//size_t read;
-	//int nblocks;
 	int rc;
 
 	DBF_EVENT(6, "TCHAR:read\n");
@@ -165,20 +166,16 @@ tapechar_read(struct file *filp, char __user *data, size_t count, loff_t *ppos)
 			return -EINVAL;
 		}
 		block_size = device->char_data.block_size;
-	//	nblocks = count / block_size;
 	} else {
 		block_size = count;
-	//	nblocks = 1;
 	}
 
 	rc = tapechar_check_idalbuffer(device, block_size);
 	if (rc)
 		return rc;
 
-	// read_block needs to allocate memory based on data + size
 
 	DBF_EVENT(6, "TCHAR:nbytes: %lx\n", block_size);
-	//DBF_EVENT(6, "TCHAR:nblocks: %x\n", nblocks);
 	/* Let the discipline build the ccw chain. */
 	request = device->discipline->read_block(device, block_size);
 	if (IS_ERR(request))
@@ -187,52 +184,399 @@ tapechar_read(struct file *filp, char __user *data, size_t count, loff_t *ppos)
 	rc = tape_do_io(device, request);
 	if (rc == 0) {
 		rc = block_size - request->rescnt;
+		pr_warn("DEBUG(old): count: %lu rescnt: %d block_size: %lu read(rc)): %d\n",
+			count, request->rescnt, block_size, rc);
 		DBF_EVENT(6, "TCHAR:rbytes:  %x\n", rc);
 		/* Copy data from idal buffer to user space. */
 		if (idal_buffer_to_user(device->char_data.idal_buf,
 					data, rc) != 0)
 			rc = -EFAULT;
 	}
-	//read = 0;
-	//TODO: Try to do the same thing as with writing...
-	//for (i = 0; i < nblocks; i++) {
-	//	rc = tape_do_io(device, request);
-	//	if (rc == 0) {
-	//		rc = block_size - request->rescnt;
-	//		DBF_EVENT(6, "TCHAR:rbytes:  %x\n", rc);
-	//		/* Copy data from idal buffer to user space. */
-	//		if (idal_buffer_to_user(device->char_data.idal_buf,
-	//					data, rc) != 0)
-	//			rc = -EFAULT;
-
-	//	}
-	//}
 	tape_free_request(request);
 	return rc;
 }
 
-/* static ssize_t tapechar_write_new(struct file *filp, const char __user *data,
+static size_t tapechar_get_max_count(size_t *count)
+{
+	size_t max;
+
+	max = (*count >= __MAX_SUBCHANNEL) ? __MAX_SUBCHANNEL : *count;
+	*count -= __MAX_SUBCHANNEL;
+
+	return max;
+}
+
+static ssize_t
+tapechar_read_new(struct file *filp, char __user *data, size_t count, loff_t *ppos)
+{
+	struct tape_request *request;
+	struct ccw1 *ccw, *last_ccw;
+	struct tape_device *device;
+	int rc;
+	dma64_t *idaws;
+	int nblocks = 0;
+	int cplength = 0;
+	int datasize = 0;
+	int cidaw = 0;
+	int i;
+	size_t block_size;
+	size_t read = 0;
+
+	DBF_EVENT(6, "TCHAR:read\n");
+	device = (struct tape_device *) filp->private_data;
+
+	/*
+	 * If the tape isn't terminated yet, do it now. And since we then
+	 * are at the end of the tape there wouldn't be anything to read
+	 * anyways. So we return immediately.
+	 */
+	if(device->required_tapemarks) {
+		return tape_std_terminate_write(device);
+	}
+
+	// Figure out amount of blocks based on count and MAX_BLOCKSIZE (64k per ccw)
+	if (count > __MAX_SUBCHANNEL) {
+		nblocks = (count / __MAX_SUBCHANNEL);
+		block_size = __MAX_SUBCHANNEL;
+		if (count % __MAX_SUBCHANNEL)
+			nblocks++;
+	} else {
+		nblocks = 1;
+		block_size = count;
+	}
+
+	// Calculate Channel Program Length
+	// 1 ccw for modeset + nblocks (1 block per 64k data)
+	cplength = 1 + nblocks;
+	cidaw = idal_nr_words((void __user *)data, count);
+	// Calculate Channel Program Request Data size
+	datasize = cidaw * sizeof(*idaws);
+
+	// Allocate memory for Channel Program Request
+	request = tape_alloc_request(cplength, datasize);
+	if (IS_ERR(request)) {
+		DBF_EXCEPTION(6, "xwbl fail\n");
+		return PTR_ERR(request);
+	}
+
+	pr_warn("====================================================");
+	pr_warn("DEBUG(READ): count: %lu nblocks: %d cplength: %d cidaw: %d datasize: %d ul: %lu\n",
+		count, nblocks, cplength, cidaw, datasize, sizeof(unsigned long));
+
+	ccw = request->cpaddr;
+	idaws = (dma64_t *)request->cpdata;
+
+	void *vaddr;
+	for (i = 0; i < cidaw; i++) {
+		vaddr = (void *)__get_free_page(GFP_KERNEL);
+		if (!vaddr)
+			goto out;
+		idaws[i] = virt_to_dma64(vaddr);
+	}
+
+	request->op = TO_RFO;
+	ccw = tape_ccw_cc(ccw, MODE_SET_DB, 1, device->modeset_byte);
+	// create CCW chain for up to 4 CCWs
+	for (i = 0; i < nblocks; i++) { // 1 CCW for 64k
+		pr_warn("DEBUG(READ-build): ccw(%d) %p (size: %lu) data: %p\n",
+			i + 1, ccw, sizeof(*ccw), data);
+		if (i)
+			ccw[-1].flags |= CCW_FLAG_DC;
+		ccw->count = tapechar_get_max_count(&count);
+		ccw->cda = virt_to_dma32(idaws);
+		ccw->flags = CCW_FLAG_IDA;
+		ccw->cmd_code = READ_FORWARD;
+		ccw++;
+		idaws++;
+	}
+
+	print_hex_dump_bytes("DEBUG:(after,ccw) ", DUMP_PREFIX_ADDRESS,
+		      request->cpaddr, 2 * sizeof(*ccw));
+	print_hex_dump_bytes("DEBUG:(after,data) ", DUMP_PREFIX_ADDRESS,
+		      request->cpdata, datasize);
+	/* Execute it. */
+	rc = tape_do_io(device, request);
+	if (rc == 0) {
+		DBF_EVENT(6, "TCHAR:rbytes:  %x\n", rc);
+		idaws = (dma64_t *)request->cpdata;
+		last_ccw = dma32_to_virt(request->irb.scsw.cmd.cpa);
+		ccw = request->cpaddr;
+		while (++ccw < last_ccw) {
+			if (idal_to_user(idaws, data, ccw->count) != 0) {
+				rc = -EFAULT;
+				break;
+			}
+			read += ccw->count;
+			pr_warn("DEBUG(READ-analyze): ccw: %p read: %lu count: %d idaws: %p\n",
+				ccw, read, ccw->count, idaws);
+			data += ccw->count;
+			idaws++;
+		}
+		pr_warn("DEBUG: compare last_ccw[-1]: %p request->cpaddr[1]: %p\n",
+			&last_ccw[-1], &request->cpaddr[1]);
+		if (&last_ccw[-1] == &request->cpaddr[1] &&
+		    request->rescnt == last_ccw[-1].count)
+			rc = 0;
+		else
+			rc = read;
+			/* rc = count - read; */
+		pr_warn("DEBUG: request %p count: %lu rescnt: %d read: %lu read(rc)): %d index: %lu\n",
+			request, count, request->rescnt, read, rc, last_ccw - request->cpaddr);
+		pr_warn("DEBUG: scsw dstat: %02x cstat: %02x\n",
+			request->irb.scsw.cmd.dstat, request->irb.scsw.cmd.cstat);
+		/* Copy data from idal buffer to user space. */
+		/* idaws = request->cpdata;
+		for (i = 0; i < nblocks; i++) {
+			if (idal_to_user(idaws++, data, rc) != 0) {
+				rc = -EFAULT;
+				break;
+			}
+		} */
+	}
+	pr_warn("====================================================");
+out:
+	idaws = (dma64_t *)request->cpdata;
+	for (i = 0; i < cidaw; i++) {
+		vaddr = dma64_to_virt(idaws[i]);
+		free_page((unsigned long)vaddr);
+	}
+	tape_free_request(request);
+	return rc;
+}
+
+static ssize_t tapechar_write_new(struct file *filp, const char __user *data,
 				  size_t count, loff_t *ppos)
 {
 	struct tape_request *request;
+	struct ccw1 *ccw, *last_ccw;
 	struct tape_device *device;
-	int idaws_nr = 0;
+	dma64_t *idaws;
+	size_t written = 0;
+	int nblocks = 0;
+	int cplength = 0;
+	int datasize = 0;
+	int cidaw = 0;
+	int rc = 0;
+	int i;
+	size_t block_size;
 
-	// idaws_nr -> data / blocksize
-	// datasize -> idaws_nr * ptr
+	// Get device from filp
 	device = (struct tape_device *)filp->private_data;
 
-	// rewrite write_block to work with idaws / idal lists instead
-	// of a single idal buffer
-	request = device->discipline->write_block(device, block_size);
-	if (IS_ERR(request))
+	// Figure out amount of blocks based on count and MAX_BLOCKSIZE
+	// 64kb per segment but 256k total
+	//
+	// e.g. count == 262144
+
+	if (count > __MAX_SUBCHANNEL) {
+		nblocks = count / __MAX_SUBCHANNEL;
+		block_size = __MAX_SUBCHANNEL;
+		if (count %  __MAX_SUBCHANNEL)
+			nblocks++;
+	} else {
+		nblocks = 1;
+		block_size = count;
+	}
+
+	// Calculate Channel Program Length
+	// 1 ccw for modeset + nblocks (1 block per 64k data)
+	cplength = 1 + nblocks;
+	cidaw = idal_nr_words((void __user *)data, count);
+	// Calculate Channel Program Request Data size
+	datasize = cidaw * sizeof(*idaws);
+
+	pr_warn("DEBUG: count: %lu nblocks: %d cplength: %d cidaw: %d datasize: %d ul: %lu\n",
+		count, nblocks, cplength, cidaw, datasize, sizeof(unsigned long));
+
+	// Allocate memory for Channel Program Request
+	request = tape_alloc_request(cplength, datasize);
+	if (IS_ERR(request)) {
+		DBF_EXCEPTION(6, "xwbl fail\n");
 		return PTR_ERR(request);
+	}
+	// Copy data from user (__user *data) into Request
+	//	- Split data into 64k chunks
+	//	- use idal instead of single buffer
+
+	ccw = request->cpaddr;
+	idaws = (dma64_t *)request->cpdata;
+	print_hex_dump_bytes("DEBUG:(before) ", DUMP_PREFIX_ADDRESS, request->cpdata, datasize);
+
+	void *vaddr;
+	for (i = 0; i < cidaw; i++) {
+		vaddr = (void *)__get_free_page(GFP_KERNEL);
+		if (!vaddr)
+			goto out;
+		idaws[i] = virt_to_dma64(vaddr);
+		pr_warn("DEBUG: alloc idaws: %p vaddr: %p\n", &idaws[i], vaddr);
+	}
+
+	request->op = TO_WRI;
+	ccw = tape_ccw_cc(ccw, MODE_SET_DB, 1, device->modeset_byte);
+	// create CCW chain for up to 4 CCWs
+	for (i = 0; i < nblocks; i++) { // 1 CCW for 64k
+		/* pr_warn("DEBUG(WRITE): build ccw(%d) %p (size: %lu) data: %p\n",
+			i + 1, ccw, sizeof(*ccw), data); */
+		if (i)
+			ccw[-1].flags |= CCW_FLAG_DC;
+		ccw->count = tapechar_get_max_count(&count);
+		pr_warn("DEBUG(WRITE): build ccw(%d) %p (size: %lu) idaws: %p mode: %x ccwcount: %d\n",
+			i + 1, ccw, sizeof(*ccw), idaws, *(device->modeset_byte), ccw->count);
+		ccw->cda = virt_to_dma32(idaws);
+		ccw->flags = CCW_FLAG_IDA;
+		ccw->cmd_code = WRITE_CMD;
+		/* idaws = idal_create_words(idaws, (void __user *)data, block_size); */
+		if (idal_from_user(idaws, data, ccw->count)) {
+			rc = -EFAULT;
+			goto out;
+		}
+		ccw++;
+		data += block_size;
+		idaws++;
+	}
+
+	print_hex_dump_bytes("DEBUG:(after) ", DUMP_PREFIX_ADDRESS, request->cpdata, datasize);
+
+	// Start IO with filled request
+	rc = tape_do_io(device, request);
+	if (rc) {
+		pr_warn("DEBUG: tape_do_io rc %d\n", rc);
+		goto out;
+	}
+
+	/* Check if the entire chain was processed */
+	last_ccw = dma32_to_virt(request->irb.scsw.cmd.cpa);
+	ccw = request->cpaddr;
+	while (++ccw < last_ccw)
+		written += ccw->count;
+	written -= request->rescnt;
+
+		/* pr_warn("DEBUG: written: %lu ccw: %p count: %d\n",
+			written, ccw, ccw->count); */
+	pr_warn("DEBUG: count: %lu rescnt: %d written: %lu last ccw: %p index?: %lu\n",
+		count, request->rescnt, written,
+		last_ccw, last_ccw - request->cpaddr);
+
+out:
+	idaws = (dma64_t *)request->cpdata;
+	for (i = 0; i < cidaw; i++) {
+		vaddr = dma64_to_virt(idaws[i]);
+		free_page((unsigned long)vaddr);
+	}
+	tape_free_request(request);
+
+	if (rc == -ENOSPC) {
+		/*
+		 * Ok, the device has no more space. It has NOT written
+		 * the block.
+		 */
+		if (device->discipline->process_eov)
+			device->discipline->process_eov(device);
+		if (written > 0)
+			rc = 0;
+	}
 
 	// work through request
-	return 0;
-} */
+	if (!rc)
+		device->required_tapemarks = 2;
+
+	return rc ? rc : written;
+}
 
-/*#define BLOCKSIZE_LIMIT 65535*/
+// static ssize_t tapechar_write_tcw(struct file *filp, const char __user *data,
+// 				  size_t count, loff_t *ppos)
+// {
+// 	struct tape_request *request;
+// 	struct tape_device *device;
+// 	struct ccw1 *ccw;
+// 	dma64_t *idaws;
+// 	size_t written;
+// 	int nblocks = 0;
+// 	int cplength = 0;
+// 	int datasize = 0;
+// 	int cidaw = 0;
+// 	int rc = 0;
+// 	int i;
+// 	size_t size;
+//
+// 	struct itcw *itcw;
+// 	struct tidaw *last_tidaw = NULL;
+// 	int itcw_op;
+// 	size_t itcw_size;
+// 	u8 tidaw_flags;
+//
+// 	// Get device from filp
+// 	device = (struct tape_device *)filp->private_data;
+//
+// 	// Figure out amount of blocks based on count and MAX_BLOCKSIZE
+// 	// 64kb per segment but 256k total
+// 	//
+// 	// e.g. count == 262144
+// 	/* if (count > BLOCKSIZE_LIMIT) {
+// 		nblocks = count / BLOCKSIZE_LIMIT;
+// 		size = BLOCKSIZE_LIMIT;
+// 	} else {
+// 		nblocks = 1;
+// 		size = count;
+// 	} */
+//
+// 	size = count / PAGE_SIZE;
+// 	itcw_size = itcw_calc_size(0, size, 0);
+// 	itcw_op = ITCW_OP_WRITE;
+//
+// 	// Allocate memory for Channel Program Request
+// 	request = tape_alloc_request(0, itcw_size);
+// 	if (IS_ERR(request)) {
+// 		DBF_EXCEPTION(6, "xwbl fail\n");
+// 		return PTR_ERR(request);
+// 	}
+// 	// Copy data from user (__user *data) into Request
+// 	//	- Split data into 64k chunks
+// 	//	- use idal instead of single buffer
+//
+// 	itcw = itcw_init(request->cpdata, itcw_size, ITCW_OP_WRITE, 0, size, 0);
+// 	if (IS_ERR(itcw)) {
+// 		rc = -EINVAL;
+// 		goto out;
+// 	}
+// 	request->cpaddr = itcw_get_tcw(itcw);
+//
+// 	request->op = TO_WRI;
+// 	ccw = tape_ccw_cc(ccw, MODE_SET_DB, 1, device->modeset_byte);
+// 	// Start IO with filled request
+//
+// 	for (i = 0; i < size; i++) {
+// 		last_tidaw = itcw_add_tidaw(itcw, 0, data++, PAGE_SIZE);
+// 	}
+//
+// 	last_tidaw->flags |= TIDAW_FLAGS_LAST;
+// 	itcw_finalize(itcw);
+//
+// 	rc = tape_do_io(device, request);
+// 	written = count - request->rescnt;
+// 	pr_warn("DEBUG: count: %lu rescnt: %d written: %lu\n",
+// 		count, request->rescnt, written);
+//
+// out:
+// 	tape_free_request(request);
+// 	if (rc == -ENOSPC) {
+// 		/*
+// 		 * Ok, the device has no more space. It has NOT written
+// 		 * the block.
+// 		 */
+// 		if (device->discipline->process_eov)
+// 			device->discipline->process_eov(device);
+// 		if (written > 0)
+// 			rc = 0;
+// 	}
+//
+// 	/* kfree(vaddr); */
+// 	// work through request
+// 	if (!rc)
+// 		device->required_tapemarks = 2;
+//
+// 	return rc ? rc : written;
+// }
 /*
  * Tape device write function
  */
@@ -249,15 +593,10 @@ tapechar_write(struct file *filp, const char __user *data, size_t count, loff_t
 	DBF_EVENT(6, "TCHAR:write\n");
 	device = (struct tape_device *) filp->private_data;
 	/* Find out block size and number of blocks */
-
-
-	// count == 65535 ; char_data.block_size == 0
-	pr_warn("DEBUG (tapechar_write): count: %lu cd_blksize: %d\n",
-		count, device->char_data.block_size);
 	if (device->char_data.block_size != 0) {
 		if (count < device->char_data.block_size) {
 			DBF_EVENT(3, "TCHAR:write smaller than block "
-				  "size was requested\n");
+				     "size was requested\n");
 			return -EINVAL;
 		}
 		block_size = device->char_data.block_size;
@@ -265,23 +604,14 @@ tapechar_write(struct file *filp, const char __user *data, size_t count, loff_t
 	} else {
 		block_size = count;
 		nblocks = 1;
-		//nblocks = count / BLOCKSIZE_LIMIT;
 	}
 
 	rc = tapechar_check_idalbuffer(device, block_size);
 	if (rc)
 		return rc;
 
-	int idaws_nr = idal_nr_words((void *)data, count);
-	int datasize = idaws_nr * sizeof(unsigned long);
-
-	pr_warn("DEBUG: idaws_nr: %d datasize: %d\n", idaws_nr, datasize);
-//#define MAX_BLOCKSIZE   65535
-//#define MAX_BLOCKSIZE   262144
-	
-	DBF_EVENT(6,"TCHAR:nbytes: %lx\n", block_size);
+	DBF_EVENT(6, "TCHAR:nbytes: %lx\n", block_size);
 	DBF_EVENT(6, "TCHAR:nblocks: %x\n", nblocks);
-	pr_warn("DEBUG: (tapechar_write) nbytes: %lu nblocks: %d\n", block_size, nblocks);
 	/* Let the discipline build the ccw chain. */
 	request = device->discipline->write_block(device, block_size);
 	if (IS_ERR(request))
@@ -290,12 +620,11 @@ tapechar_write(struct file *filp, const char __user *data, size_t count, loff_t
 	written = 0;
 	for (i = 0; i < nblocks; i++) {
 		/* Copy data from user space to idal buffer. */
-		if (idal_buffer_from_user(device->char_data.idal_buf,
-					  data, block_size)) {
+		if (idal_buffer_from_user(device->char_data.idal_buf, data,
+					  block_size)) {
 			rc = -EFAULT;
 			break;
 		}
-		pr_warn("DEBUG: tape_do_io...\n");
 		rc = tape_do_io(device, request);
 		if (rc)
 			break;
@@ -306,7 +635,6 @@ tapechar_write(struct file *filp, const char __user *data, size_t count, loff_t
 			break;
 		data += block_size;
 	}
-	pr_warn("DEBUG: tape_free_req...\n");
 	tape_free_request(request);
 	if (rc == -ENOSPC) {
 		/*
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index 5de3729a238a..703033875ab1 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -119,7 +119,7 @@ EXPORT_SYMBOL(unregister_tape_dev);
 
 static int __init tape_init(void)
 {
-	pr_warn("DEBUG: tape classe module reloaded... 1\n");
+	pr_warn("DEBUG: tape classe module reloaded... 2\n");
 	return class_register(&tape_class);
 }
 
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index ea63e122b169..7e03bc44d0ae 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -1098,9 +1098,10 @@ __tape_do_irq (struct ccw_device *cdev, unsigned long intparm, struct irb *irb)
 	}
 
 	/* May be an unsolicited irq */
-	if(request != NULL)
+	if(request != NULL) {
 		request->rescnt = irb->scsw.cmd.count;
-	else if ((irb->scsw.cmd.dstat == 0x85 || irb->scsw.cmd.dstat == 0x80) &&
+		memcpy(&request->irb, irb, sizeof(*irb));
+	} else if ((irb->scsw.cmd.dstat == 0x85 || irb->scsw.cmd.dstat == 0x80) &&
 		 !list_empty(&device->req_queue)) {
 		/* Not Ready to Ready after long busy ? */
 		struct tape_request *req;
diff --git a/drivers/s390/char/tape_std.c b/drivers/s390/char/tape_std.c
index 80d0513792a9..7dafa8e0b77d 100644
--- a/drivers/s390/char/tape_std.c
+++ b/drivers/s390/char/tape_std.c
@@ -24,7 +24,7 @@
 #include <asm/ebcdic.h>
 #include <asm/tape390.h>
 
-#define TAPE_DBF_AREA	tape_core_dbf
+#define TAPE_DBF_AREA tape_core_dbf
 
 #include "tape.h"
 #include "tape_std.h"
@@ -32,27 +32,27 @@
 /*
  * tape_std_assign
  */
-static void
-tape_std_assign_timeout(struct timer_list *t)
+static void tape_std_assign_timeout(struct timer_list *t)
 {
-	struct tape_request *	request = from_timer(request, t, timer);
-	struct tape_device *	device = request->device;
+	struct tape_request *request = from_timer(request, t, timer);
+	struct tape_device *device = request->device;
 	int rc;
 
 	BUG_ON(!device);
 
 	DBF_EVENT(3, "%08x: Assignment timeout. Device busy.\n",
-			device->cdev_id);
+		  device->cdev_id);
 	rc = tape_cancel_io(device, request);
-	if(rc)
-		DBF_EVENT(3, "(%08x): Assign timeout: Cancel failed with rc = "
-			  "%i\n", device->cdev_id, rc);
+	if (rc)
+		DBF_EVENT(3,
+			  "(%08x): Assign timeout: Cancel failed with rc = "
+			  "%i\n",
+			  device->cdev_id, rc);
 }
 
-int
-tape_std_assign(struct tape_device *device)
+int tape_std_assign(struct tape_device *device)
 {
-	int                  rc;
+	int rc;
 	struct tape_request *request;
 
 	request = tape_alloc_request(2, 11);
@@ -77,7 +77,7 @@ tape_std_assign(struct tape_device *device)
 
 	if (rc != 0) {
 		DBF_EVENT(3, "%08x: assign failed - device might be busy\n",
-			device->cdev_id);
+			  device->cdev_id);
 	} else {
 		DBF_EVENT(3, "%08x: Tape assigned\n", device->cdev_id);
 	}
@@ -88,15 +88,14 @@ tape_std_assign(struct tape_device *device)
 /*
  * tape_std_unassign
  */
-int
-tape_std_unassign (struct tape_device *device)
+int tape_std_unassign(struct tape_device *device)
 {
-	int                  rc;
+	int rc;
 	struct tape_request *request;
 
 	if (device->tape_state == TS_NOT_OPER) {
 		DBF_EVENT(3, "(%08x): Can't unassign device\n",
-			device->cdev_id);
+			  device->cdev_id);
 		return -EIO;
 	}
 
@@ -120,8 +119,7 @@ tape_std_unassign (struct tape_device *device)
 /*
  * TAPE390_DISPLAY: Show a string on the tape display.
  */
-int
-tape_std_display(struct tape_device *device, struct display_struct *disp)
+int tape_std_display(struct tape_device *device, struct display_struct *disp)
 {
 	struct tape_request *request;
 	int rc;
@@ -133,11 +131,11 @@ tape_std_display(struct tape_device *device, struct display_struct *disp)
 	}
 	request->op = TO_DIS;
 
-	*(unsigned char *) request->cpdata = disp->cntrl;
+	*(unsigned char *)request->cpdata = disp->cntrl;
 	DBF_EVENT(5, "TAPE: display cntrl=%04x\n", disp->cntrl);
-	memcpy(((unsigned char *) request->cpdata) + 1, disp->message1, 8);
-	memcpy(((unsigned char *) request->cpdata) + 9, disp->message2, 8);
-	ASCEBC(((unsigned char*) request->cpdata) + 1, 16);
+	memcpy(((unsigned char *)request->cpdata) + 1, disp->message1, 8);
+	memcpy(((unsigned char *)request->cpdata) + 9, disp->message2, 8);
+	ASCEBC(((unsigned char *)request->cpdata) + 1, 16);
 
 	tape_ccw_cc(request->cpaddr, LOAD_DISPLAY, 17, request->cpdata);
 	tape_ccw_end(request->cpaddr + 1, NOP, 0, NULL);
@@ -150,8 +148,7 @@ tape_std_display(struct tape_device *device, struct display_struct *disp)
 /*
  * Read block id.
  */
-int
-tape_std_read_block_id(struct tape_device *device, __u64 *id)
+int tape_std_read_block_id(struct tape_device *device, __u64 *id)
 {
 	struct tape_request *request;
 	int rc;
@@ -168,21 +165,20 @@ tape_std_read_block_id(struct tape_device *device, __u64 *id)
 	rc = tape_do_io(device, request);
 	if (rc == 0)
 		/* Get result from read buffer. */
-		*id = *(__u64 *) request->cpdata;
+		*id = *(__u64 *)request->cpdata;
 	tape_free_request(request);
 	return rc;
 }
 
-int
-tape_std_terminate_write(struct tape_device *device)
+int tape_std_terminate_write(struct tape_device *device)
 {
 	int rc;
 
-	if(device->required_tapemarks == 0)
+	if (device->required_tapemarks == 0)
 		return 0;
 
 	DBF_LH(5, "tape%d: terminate write %dxEOF\n", device->first_minor,
-		device->required_tapemarks);
+	       device->required_tapemarks);
 
 	rc = tape_mtop(device, MTWEOF, device->required_tapemarks);
 	if (rc)
@@ -197,18 +193,16 @@ tape_std_terminate_write(struct tape_device *device)
  * The default implementation just wait until the tape medium state changes
  * to MS_LOADED.
  */
-int
-tape_std_mtload(struct tape_device *device, int count)
+int tape_std_mtload(struct tape_device *device, int count)
 {
 	return wait_event_interruptible(device->state_change_wq,
-		(device->medium_state == MS_LOADED));
+					(device->medium_state == MS_LOADED));
 }
 
 /*
  * MTSETBLK: Set block size.
  */
-int
-tape_std_mtsetblk(struct tape_device *device, int count)
+int tape_std_mtsetblk(struct tape_device *device, int count)
 {
 	struct idal_buffer *new;
 
@@ -228,8 +222,8 @@ tape_std_mtsetblk(struct tape_device *device, int count)
 		return 0;
 
 	if (count > MAX_BLOCKSIZE) {
-		DBF_EVENT(3, "Invalid block size (%d > %d) given.\n",
-			count, MAX_BLOCKSIZE);
+		DBF_EVENT(3, "Invalid block size (%d > %d) given.\n", count,
+			  MAX_BLOCKSIZE);
 		return -EINVAL;
 	}
 
@@ -250,8 +244,7 @@ tape_std_mtsetblk(struct tape_device *device, int count)
 /*
  * MTRESET: Set block size to 0.
  */
-int
-tape_std_mtreset(struct tape_device *device, int count)
+int tape_std_mtreset(struct tape_device *device, int count)
 {
 	DBF_EVENT(6, "TCHAR:devreset:\n");
 	device->char_data.block_size = 0;
@@ -262,8 +255,7 @@ tape_std_mtreset(struct tape_device *device, int count)
  * MTFSF: Forward space over 'count' file marks. The tape is positioned
  * at the EOT (End of Tape) side of the file mark.
  */
-int
-tape_std_mtfsf(struct tape_device *device, int mt_count)
+int tape_std_mtfsf(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -286,8 +278,7 @@ tape_std_mtfsf(struct tape_device *device, int mt_count)
  * MTFSR: Forward space over 'count' tape blocks (blocksize is set
  * via MTSETBLK.
  */
-int
-tape_std_mtfsr(struct tape_device *device, int mt_count)
+int tape_std_mtfsr(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -318,8 +309,7 @@ tape_std_mtfsr(struct tape_device *device, int mt_count)
  * MTBSR: Backward space over 'count' tape blocks.
  * (blocksize is set via MTSETBLK.
  */
-int
-tape_std_mtbsr(struct tape_device *device, int mt_count)
+int tape_std_mtbsr(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -349,8 +339,7 @@ tape_std_mtbsr(struct tape_device *device, int mt_count)
 /*
  * MTWEOF: Write 'count' file marks at the current position.
  */
-int
-tape_std_mtweof(struct tape_device *device, int mt_count)
+int tape_std_mtweof(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -374,8 +363,7 @@ tape_std_mtweof(struct tape_device *device, int mt_count)
  * The tape is positioned at the BOT (Begin Of Tape) side of the
  * last skipped file mark.
  */
-int
-tape_std_mtbsfm(struct tape_device *device, int mt_count)
+int tape_std_mtbsfm(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -398,8 +386,7 @@ tape_std_mtbsfm(struct tape_device *device, int mt_count)
  * MTBSF: Backward space over 'count' file marks. The tape is positioned at
  * the EOT (End of Tape) side of the last skipped file mark.
  */
-int
-tape_std_mtbsf(struct tape_device *device, int mt_count)
+int tape_std_mtbsf(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -429,8 +416,7 @@ tape_std_mtbsf(struct tape_device *device, int mt_count)
  * The tape is positioned at the BOT (Begin Of Tape) side
  * of the last skipped file mark.
  */
-int
-tape_std_mtfsfm(struct tape_device *device, int mt_count)
+int tape_std_mtfsfm(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 	struct ccw1 *ccw;
@@ -459,8 +445,7 @@ tape_std_mtfsfm(struct tape_device *device, int mt_count)
 /*
  * MTREW: Rewind the tape.
  */
-int
-tape_std_mtrew(struct tape_device *device, int mt_count)
+int tape_std_mtrew(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 
@@ -469,8 +454,7 @@ tape_std_mtrew(struct tape_device *device, int mt_count)
 		return PTR_ERR(request);
 	request->op = TO_REW;
 	/* setup ccws */
-	tape_ccw_cc(request->cpaddr, MODE_SET_DB, 1,
-		    device->modeset_byte);
+	tape_ccw_cc(request->cpaddr, MODE_SET_DB, 1, device->modeset_byte);
 	tape_ccw_cc(request->cpaddr + 1, REWIND, 0, NULL);
 	tape_ccw_end(request->cpaddr + 2, NOP, 0, NULL);
 
@@ -482,8 +466,7 @@ tape_std_mtrew(struct tape_device *device, int mt_count)
  * MTOFFL: Rewind the tape and put the drive off-line.
  * Implement 'rewind unload'
  */
-int
-tape_std_mtoffl(struct tape_device *device, int mt_count)
+int tape_std_mtoffl(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 
@@ -503,8 +486,7 @@ tape_std_mtoffl(struct tape_device *device, int mt_count)
 /*
  * MTNOP: 'No operation'.
  */
-int
-tape_std_mtnop(struct tape_device *device, int mt_count)
+int tape_std_mtnop(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 
@@ -524,8 +506,7 @@ tape_std_mtnop(struct tape_device *device, int mt_count)
  * for recordind data. MTEOM positions after the last file mark, ready for
  * appending another file.
  */
-int
-tape_std_mteom(struct tape_device *device, int mt_count)
+int tape_std_mteom(struct tape_device *device, int mt_count)
 {
 	int rc;
 
@@ -554,8 +535,7 @@ tape_std_mteom(struct tape_device *device, int mt_count)
 /*
  * MTRETEN: Retension the tape, i.e. forward space to end of tape and rewind.
  */
-int
-tape_std_mtreten(struct tape_device *device, int mt_count)
+int tape_std_mtreten(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 
@@ -565,7 +545,7 @@ tape_std_mtreten(struct tape_device *device, int mt_count)
 	request->op = TO_FSF;
 	/* setup ccws */
 	tape_ccw_cc(request->cpaddr, MODE_SET_DB, 1, device->modeset_byte);
-	tape_ccw_cc(request->cpaddr + 1,FORSPACEFILE, 0, NULL);
+	tape_ccw_cc(request->cpaddr + 1, FORSPACEFILE, 0, NULL);
 	tape_ccw_cc(request->cpaddr + 2, NOP, 0, NULL);
 	tape_ccw_end(request->cpaddr + 3, CCW_CMD_TIC, 0, request->cpaddr);
 	/* execute it, MTRETEN rc gets ignored */
@@ -577,8 +557,7 @@ tape_std_mtreten(struct tape_device *device, int mt_count)
 /*
  * MTERASE: erases the tape.
  */
-int
-tape_std_mterase(struct tape_device *device, int mt_count)
+int tape_std_mterase(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 
@@ -601,8 +580,7 @@ tape_std_mterase(struct tape_device *device, int mt_count)
 /*
  * MTUNLOAD: Rewind the tape and unload it.
  */
-int
-tape_std_mtunload(struct tape_device *device, int mt_count)
+int tape_std_mtunload(struct tape_device *device, int mt_count)
 {
 	return tape_mtop(device, MTOFFL, mt_count);
 }
@@ -611,8 +589,7 @@ tape_std_mtunload(struct tape_device *device, int mt_count)
  * MTCOMPRESSION: used to enable compression.
  * Sets the IDRC on/off.
  */
-int
-tape_std_mtcompression(struct tape_device *device, int mt_count)
+int tape_std_mtcompression(struct tape_device *device, int mt_count)
 {
 	struct tape_request *request;
 
@@ -638,8 +615,8 @@ tape_std_mtcompression(struct tape_device *device, int mt_count)
 /*
  * Read Block
  */
-struct tape_request *
-tape_std_read_block(struct tape_device *device, size_t count)
+struct tape_request *tape_std_read_block(struct tape_device *device,
+					 size_t count)
 {
 	struct tape_request *request;
 
@@ -663,8 +640,8 @@ tape_std_read_block(struct tape_device *device, size_t count)
 /*
  * Read Block backward transformation function.
  */
-void
-tape_std_read_backward(struct tape_device *device, struct tape_request *request)
+void tape_std_read_backward(struct tape_device *device,
+			    struct tape_request *request)
 {
 	/*
 	 * We have allocated 4 ccws in tape_std_read, so we can now
@@ -677,18 +654,17 @@ tape_std_read_backward(struct tape_device *device, struct tape_request *request)
 			 device->char_data.idal_buf);
 	tape_ccw_cc(request->cpaddr + 2, FORSPACEBLOCK, 0, NULL);
 	tape_ccw_end(request->cpaddr + 3, NOP, 0, NULL);
-	DBF_EVENT(6, "xrop ccwg");}
+	DBF_EVENT(6, "xrop ccwg");
+}
 
 /*
  * Write Block
  */
-struct tape_request *
-tape_std_write_block(struct tape_device *device, size_t count)
+struct tape_request *tape_std_write_block(struct tape_device *device,
+					  size_t count)
 {
 	struct tape_request *request;
-	int i;
 
-	//request = tape_alloc_request(5, 0);
 	request = tape_alloc_request(2, 0);
 	if (IS_ERR(request)) {
 		DBF_EXCEPTION(6, "xwbl fail\n");
@@ -697,11 +673,6 @@ tape_std_write_block(struct tape_device *device, size_t count)
 	request->op = TO_WRI;
 	tape_ccw_cc(request->cpaddr, MODE_SET_DB, 1, device->modeset_byte);
 
-	//for (i = 0; i < 3; i++) {
-	//	tape_ccw_cc_idal(request->cpaddr + 1, WRITE_CMD,
-	//			 device->char_data.idal_buf);
-	//}
-
 	tape_ccw_end_idal(request->cpaddr + 1, WRITE_CMD,
 			  device->char_data.idal_buf);
 	DBF_EVENT(6, "xwbl ccwg\n");
@@ -711,8 +682,7 @@ tape_std_write_block(struct tape_device *device, size_t count)
 /*
  * This routine is called by frontend after an ENOSP on write
  */
-void
-tape_std_process_eov(struct tape_device *device)
+void tape_std_process_eov(struct tape_device *device)
 {
 	/*
 	 * End of volume: We have to backspace the last written record, then
diff --git a/drivers/s390/char/tape_std.h b/drivers/s390/char/tape_std.h
index def8e6425d49..6251547a4ae7 100644
--- a/drivers/s390/char/tape_std.h
+++ b/drivers/s390/char/tape_std.h
@@ -102,6 +102,7 @@ struct tape_request *tape_std_read_block(struct tape_device *, size_t);
 void tape_std_read_backward(struct tape_device *device,
 			    struct tape_request *request);
 struct tape_request *tape_std_write_block(struct tape_device *, size_t);
+struct tape_request *tape_std_write_block_new(struct tape_device *, const void __user *, size_t);
 
 /* Some non-mtop commands. */
 int tape_std_assign(struct tape_device *);
-- 
2.45.2


